Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'spaceships',
		'diceCollection',
		'hasEnded'
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

{ #category : #playing }
Game >> changeTurns [

	spaceships add: spaceships first.
	spaceships removeFirst
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
	spaceships do: [:aSpaceShip | aSpaceShip fuel: 2*(diceCollection maxRoll)].
]

{ #category : #playing }
Game >> move: aSpaceship withRollingResult: aResult [
	
	board move: aSpaceship by: aResult.
	
	


]

{ #category : #playing }
Game >> nextTurn [

	| spaceshipTurn |
	spaceshipTurn := spaceships first.	
	^ spaceshipTurn
]

{ #category : #playing }
Game >> playNextTurn [

	| rollingResult spaceshipTurn |
	self hasEnded ifTrue: [ Error signal: 'Game has already ended' ].
	spaceshipTurn := self nextTurn.
	[ spaceshipTurn turnsToLose > 0 ] whileTrue: [
		spaceshipTurn losesTurns: -1.
		self changeTurns.
		spaceshipTurn := self nextTurn ].
	self changeTurns.
	rollingResult := diceCollection roll.
	self move: spaceshipTurn withRollingResult: rollingResult.
	(board spaceshipInLastTileAndLap: spaceshipTurn) ifTrue: [
		hasEnded := true ]
]

{ #category : #accessing }
Game >> positionOf: aSpaceship [

	^ aSpaceship position
]

{ #category : #'as yet unclassified' }
Game >> spaceShipsPositionsRanking [
	| spaceShipsPositions |
	spaceShipsPositions := spaceships.

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB | 
		  spaceShipA position >= spaceShipB position]

]

{ #category : #asserting }
Game >> winner [

	| winner |
	self hasEnded ifFalse: [ ^ self hasEnded ].

	winner := spaceships detect: [ :aSpaceship |
		          aSpaceship position = board amountOfTiles and: [aSpaceship lap=board laps]].
	^ winner
]
