Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'spaceships',
		'diceCollection',
		'hasEnded',
		'turnHandler'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertValidNumberOf: someSpaceShips [

	someSpaceShips isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #'instance creation' }
Game class >> playedBy: someSpaceShips on: aBoard rolling: dice [

	self assertValidNumberOf: someSpaceShips.
	^ self new
		  initializePlayedBy: someSpaceShips
		  on: aBoard
		  rolling: dice
]

{ #category : #asserting }
Game >> checkIfGameHasEnded [

	board anySpaceShipOneInLastTileAndLap ifTrue: [ hasEnded := true ]
]

{ #category : #testing }
Game >> hasEnded [

	^ hasEnded
]

{ #category : #initialization }
Game >> initializePlayedBy: someSpaceShips on: aBoard rolling: dice [

	board := aBoard.
	aBoard usedBy: someSpaceShips asOrderedCollection.
	diceCollection := dice.
	spaceships := someSpaceShips asOrderedCollection.
	hasEnded := false.
	turnHandler := TurnHandler withPlayers: someSpaceShips.
	spaceships do: [ :aSpaceShip |
		aSpaceShip fuel: 2 * diceCollection maxRoll ]
]

{ #category : #playing }
Game >> move: aSpaceship withRollingResult: aResult [

	board move: aSpaceship by: aResult
]

{ #category : #playing }
Game >> playNextTurn [

	| rollingResult spaceshipTurn |
	self hasEnded ifTrue: [ Error signal: 'Game has already ended' ].
	spaceshipTurn := turnHandler nextPlayerTurn.
	rollingResult := spaceshipTurn rollDiceUsing: diceCollection.
	self move: spaceshipTurn withRollingResult: rollingResult.
	board applyEffectOnLandingShip: spaceshipTurn.
	self checkIfGameHasEnded
]

{ #category : #accessing }
Game >> positionOf: aSpaceship [

	^ aSpaceship position
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
Game >> winner [

	| winner |
	self hasEnded ifFalse: [ ^ self hasEnded ].

	winner := spaceships detect: [ :aSpaceship |
		          aSpaceship position = 1 and: [
			          aSpaceship lap = (board laps + 1) ] ].
	^ winner
]
