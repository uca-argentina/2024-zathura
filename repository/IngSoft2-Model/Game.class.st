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
		'effectManager'
		'cardPlayResolver'

	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertValidNumberOf: someSpaceShips [

	someSpaceShips isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #asserting }
Game class >> createSpaceshipsUsing: spaceshipNames [

	^spaceshipNames collect: [ :spaceship | SpaceShip named: spaceship]
]

{ #category : #asserting }
Game class >> playedBy: someSpaceShips on: aBoard rolling: dice usingCardsFrom:aDeck [
	|currentSpaceships|
	currentSpaceships := self createSpaceshipsUsing: someSpaceShips.
	self assertValidNumberOf: currentSpaceships.
	^ self new
		  initializePlayedBy: currentSpaceships
		  on: aBoard
		  rolling: dice
		  usingCardsFrom: aDeck.
]

{ #category : #accessing }
Game >> anySpaceShipAtLastTileAndLap [

	^ spaceships anySatisfy: [ :aSpaceship |
		  board laps + 1 = aSpaceship lap and: [ 1 = aSpaceship position ] ]
]


{ #category : #'target resize' }
Game >> apply:aCardPlay [
^cardPlayResolver resolve:aCardPlay
]

{ #category : #accessing }
Game >> applyEffectOnLandingShip: aSpaceship [

	| effectToApply |
	effectToApply := board tiles at: aSpaceship position.
	effectToApply triggeredBy: aSpaceship on: self
]

{ #category : #asserting }
Game >> assignRewardForMaxRollFor: aSpaceship [

	|adjustmentDistribution randomNumber |
	adjustmentDistribution := { 1. 1. 1. 1. 1. 1. 1. 1. -1. -1 }.
	randomNumber:= adjustmentDistribution atRandom.
	aSpaceship rewardToMaxFuel: randomNumber

]

{ #category : #'as yet unclassified' }
Game >> cardsHandLengthOf: aSpaceship [

	| spaceshipCardHandler |
	spaceshipCardHandler := cardHands
		detect: [ :handler | handler spaceship name = aSpaceship].
	^ spaceshipCardHandler cardsInHand size
]

{ #category : #'as yet unclassified' }
Game >> cardsHandOf: aSpaceship [

	| spaceshipCardHandler |
	spaceshipCardHandler := cardHands
		detect: [ :handler | handler spaceship = aSpaceship].
	^ spaceshipCardHandler
]

{ #category : #asserting }
Game >> endGameIfPossible [

	self anySpaceShipAtLastTileAndLap ifTrue: [ hasEnded := true ]
]

{ #category : #'as yet unclassified' }
Game >> giveCardFromDeckTo:aSpaceship [
|card|
card:=deck pick.
(self cardsHandOf:aSpaceship)addToHand:card
]

{ #category : #testing }
Game >> hasEnded [

	^ hasEnded
]

{ #category : #initialization }
Game >> initializePlayedBy: someSpaceShips on: aBoard rolling: dice usingCardsFrom:aDeck [

	board := aBoard.
	diceCollection := dice.
	spaceships := someSpaceShips.
	hasEnded := false.
	deck:=aDeck.
	cardHands:=spaceships collect:[:spaceShip|CardsHand of:spaceShip using:aDeck].
	cardPlayResolver := CardPlayResolver with: self.
	turnHandler := TurnHandler withPlayers: someSpaceShips.
	effectManager:=EffectManager usedIn: self with:aBoard affecting: someSpaceShips. 
	spaceships do: [ :aSpaceShip |
		aSpaceShip fuel: 2 * diceCollection maxRoll ]
	
]

{ #category : #accessing }
Game >> move: aSpaceShip by: anAmountOfTiles [
	board move:aSpaceShip by:anAmountOfTiles
	"temporary method. Move logic should be in game"
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
	self
		move: spaceshipTurn
		withRollingResult: rollingResult + rollModifier.
	effectManager applyEffectOnLandingShip: spaceshipTurn..

	self endGameIfPossible
]

{ #category : #removing }
Game >> removeFromHand: aCard to: aSpaceShip [

	(self cardsHandOf: (self spaceshipCalled:aSpaceShip)) removeFromHand: aCard.
]

{ #category : #playing }
Game >> rollModifierFor: aSpaceShip [

	^ (self cardsHandOf: aSpaceShip) totalEffectsOnSpaceShip.
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
		  ((spaceShipA lap - 1) * board amountOfTiles + spaceShipA position)
		  >=
		  ((spaceShipB lap - 1) * board amountOfTiles + spaceShipB position) ]
]

{ #category : #asserting }
Game >> spaceshipCalled: aName [
^ spaceships detect: [ :spaceship | spaceship name = aName ]
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
