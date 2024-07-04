Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'spaceships',
		'diceCollection',
		'hasEnded',
		'turnHandler',
		'deck',
		'cardHands',
		'cardPlayResolver',
		'effectManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertValidNumberOf: someSpaceShips [

	someSpaceShips isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #'instance creation' }
Game class >> assertValidNumberOfLaps: laps [

	laps <= 0 ifTrue: [ Error signal: 'Game must have one or more laps!' ]
]

{ #category : #'instance creation' }
Game class >> createSpaceshipsUsing: spaceshipNames withMaxFuel: anAmount [

	^ spaceshipNames collect: [ :spaceship |
		  SpaceShip named: spaceship withMaxFuel: 2 * anAmount ]
]

{ #category : #'instance creation' }
Game class >> playedBy: someSpaceShips on: aBoard finishingAfter: laps rolling: dice usingCardsFrom: aDeck [

	| currentSpaceships |
	currentSpaceships := self
		                     createSpaceshipsUsing: someSpaceShips
		                     withMaxFuel: dice maxRoll.
	self assertValidNumberOf: currentSpaceships.
	self assertValidNumberOfLaps: laps.
	^ self new
		  initializePlayedBy: currentSpaceships
		  on: aBoard
		  finishingAfter: laps
		  rolling: dice
		  usingCardsFrom: aDeck
]

{ #category : #accessing }
Game >> addNewCard: aCard to:aPlayer [
	(self cardsHandOf: aPlayer)  addToHand: aCard.
]

{ #category : #accessing }
Game >> anySpaceShipAtLastTileAndLap [

	^ spaceships anySatisfy: [ :aSpaceship |
		  board laps + 1 = aSpaceship lap and: [ 1 = aSpaceship position ] ]
]

{ #category : #testing }
Game >> applyACardEffect: aCard to:aSpaceship [
	(self cardsHandOf: aSpaceship) addEffectOf: aCard.
]

{ #category : #testing }
Game >> applyToAllSpaceShips: aCardEffect [
	cardHands do: [ :cardHand |
		cardHand addEffectOf: aCardEffect ]
]

{ #category : #asserting }
Game >> assertIsTurnOf: spaceship [

	turnHandler nextTurn = (self spaceshipCalled: spaceship) ifFalse: [
		Error signal: 'It is not your turn' ]
]

{ #category : #asserting }
Game >> assignRewardForMaxRollFor: aSpaceship [

	| adjustmentDistribution randomNumber |
	adjustmentDistribution := { 1. 1. 1. 1. 1. 1. 1. 1. -1. -1 }.

	randomNumber := adjustmentDistribution atRandom.
	randomNumber = 1
		ifTrue: [ aSpaceship fuelTank increaseMaxFuelByOne ]
		ifFalse: [ aSpaceship fuelTank decreaseFuelBy: 1 ]

]

{ #category : #accessing }
Game >> cancelTheEffectOf: aPermanentCard [
	|filteredCardsHands|
	filteredCardsHands := cardHands select: [ :cardsHand |
		                      cardsHand affectsSpaceShip: aPermanentCard ].
	self validateIfIsPossibleToCancelACard: filteredCardsHands.
	filteredCardsHands do: [ :cardsHand |
		cardsHand removeEffectOf: aPermanentCard ].
]

{ #category : #accessing }
Game >> cardsHandOf: aSpaceship [

	| spaceshipCardHandler |
	spaceshipCardHandler := cardHands detect: [ :handler |
		                        handler spaceship name = aSpaceship ].
	^ spaceshipCardHandler
]

{ #category : #asserting }
Game >> endGameIfPossible [

	self anySpaceShipAtLastTileAndLap ifTrue: [ hasEnded := true ]
]

{ #category : #playing }
Game >> giveCardFromDeckTo: aSpaceship [

	| card |
	card := deck pick.
	self addNewCard:  card to: aSpaceship name.
]

{ #category : #testing }
Game >> hasEnded [

	^ hasEnded
]

{ #category : #initialization }
Game >> initializePlayedBy: someSpaceShips on: aBoard finishingAfter: laps rolling: dice usingCardsFrom: aDeck [

	board := aBoard.
	diceCollection := dice.
	spaceships := someSpaceShips.
	hasEnded := false.
	deck := aDeck.
	board finishesAfter: laps.
	cardHands := spaceships collect: [ :spaceShip |
		             CardsHand of: spaceShip using: aDeck ].
	cardPlayResolver := CardPlayResolver with: self.
	turnHandler := TurnHandler withPlayers: someSpaceShips.
	effectManager := EffectManager
		                 usedIn: self
		                 with: aBoard
		                 affecting: someSpaceShips
]

{ #category : #'target resize' }
Game >> play: aCard by:aPlayer targetting: anotherPlayer [
	self validate: aPlayer  has: aCard .
	cardPlayResolver resolve: aCard by: aPlayer  targetting: anotherPlayer.
	
]

{ #category : #playing }
Game >> playNextTurn [

	| rollingResult spaceshipTurn rollModifier |
	self hasEnded ifTrue: [ Error signal: 'Game has already ended' ].
	spaceshipTurn := turnHandler nextSpaceshipTurn.
	rollingResult := spaceshipTurn rollDiceUsing: diceCollection.
	rollingResult = diceCollection maxRoll ifTrue: [
		self assignRewardForMaxRollFor: spaceshipTurn ].
	rollModifier := self rollModifierFor: spaceshipTurn.
	board move: spaceshipTurn by: rollingResult + rollModifier.
	effectManager applyEffectOnLandingShip: spaceshipTurn.
	self endGameIfPossible
]

{ #category : #removing }
Game >> removeFromHand: aCard to: aSpaceShip [

	(self cardsHandOf:  aSpaceShip)
		removeFromHand: aCard
]

{ #category : #accessing }
Game >> repeatLastEffectAppliedOn: aSpaceshipName [
	effectManager repeatLastEffectAppliedOn: (self spaceshipCalled: aSpaceshipName).
]

{ #category : #playing }
Game >> rollModifierFor: aSpaceShip [

	^ (self cardsHandOf: aSpaceShip name) totalEffectsOnSpaceShip
]

{ #category : #'target resize' }
Game >> setAnAllianceBewtween: aSpaceShip and: anotherSpaceShip [
	|spaceship1 spaceship2|
	spaceship1 := self spaceshipCalled: aSpaceShip.
	spaceship2 := self spaceshipCalled: anotherSpaceShip.

	spaceship1 isAlliedWith: spaceship2.
	spaceship2 isAlliedWith: spaceship1.
]

{ #category : #asserting }
Game >> skipTurnFor: aSpaceship [

	aSpaceship skipTurn
]

{ #category : #accessing }
Game >> spaceShipsPositionsRanking [

	| spaceShipsPositions |
	spaceShipsPositions := spaceships.

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB |
		  spaceShipA lap - 1 * board amountOfTiles + spaceShipA position
		  >=
		  (spaceShipB lap - 1 * board amountOfTiles + spaceShipB position) ]
]

{ #category : #asserting }
Game >> spaceshipCalled: aName [

	^ spaceships detect: [ :spaceship | spaceship name = aName ]
]

{ #category : #asserting }
Game >> validate: aSpaceship has: aCard [

	| cardsHand |
	cardsHand := self cardsHandOf: aSpaceship .
	(cardsHand hasInHand: aCard) ifFalse: [
		Error signal:
			'Spaceship cannot throw this card because he does not have it' ]
]

{ #category : #asserting }
Game >> validateIfIsPossibleToCancelACard: cardsHandCollection [

	cardsHandCollection isEmpty ifTrue: [
		Error signal: 'There is no CardsHand with the card to be removed' ]
]

{ #category : #asserting }
Game >> winner [

	| winner |
	self hasEnded ifFalse: [ ^ self hasEnded ].

	winner := spaceships detect: [ :aSpaceship |
		          aSpaceship position = 1 and: [
			          aSpaceship lap = (board laps + 1) ] ].
	^ winner
]
