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
Game >> anySpaceShipAtLastTileAndLap [

	^ spaceships anySatisfy: [ :aSpaceship |
		  board laps + 1 = aSpaceship lap and: [ 1 = aSpaceship position ] ]
]

{ #category : #'target resize' }
Game >> apply: aCardPlay [

	^ cardPlayResolver resolve: aCardPlay
]

{ #category : #asserting }
Game >> assertIsTurnOf: spaceship [

	turnHandler nextTurn = spaceship ifFalse: [
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
Game >> cardsHandLengthOf: aSpaceship [

	| spaceshipCardHandler |
	spaceshipCardHandler := cardHands detect: [ :handler |
		                        handler spaceship name = aSpaceship ].
	^ spaceshipCardHandler cardsInHand size
]

{ #category : #accessing }
Game >> cardsHandOf: aSpaceship [

	| spaceshipCardHandler |
	spaceshipCardHandler := cardHands detect: [ :handler |
		                        handler spaceship = aSpaceship ].
	^ spaceshipCardHandler
]

{ #category : #accessing }
Game >> cardsHands [

	^ cardHands
]

{ #category : #accessing }
Game >> effectManager [

	^ effectManager
]

{ #category : #asserting }
Game >> endGameIfPossible [

	self anySpaceShipAtLastTileAndLap ifTrue: [ hasEnded := true ]
]

{ #category : #playing }
Game >> giveCardFromDeckTo: aSpaceship [

	| card |
	card := deck pick.
	(self cardsHandOf: aSpaceship) addToHand: card
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

	(self cardsHandOf: (self spaceshipCalled: aSpaceShip))
		removeFromHand: aCard
]

{ #category : #playing }
Game >> rollModifierFor: aSpaceShip [

	^ (self cardsHandOf: aSpaceShip) totalEffectsOnSpaceShip
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

{ #category : #accessing }
Game >> spaceships [

	^ spaceships
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
