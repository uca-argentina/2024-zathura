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
	diceCollection := dice.
	spaceships := someSpaceShips asOrderedCollection.
	hasEnded := false
]

{ #category : #accessing }
Game >> lapOf: aSpaceship [

	^ board lapOf: aSpaceship
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
	self changeTurns.
	rollingResult := diceCollection roll.
	self move: spaceshipTurn withRollingResult: rollingResult.
	(board spaceshipInLastTileAndLap: spaceshipTurn) ifTrue: [
		hasEnded := true ]
]

{ #category : #accessing }
Game >> positionOf: aSpaceship [

	^ board positionOf: aSpaceship
]

{ #category : #asserting }
Game >> winner [

	| winner |
	self hasEnded ifFalse: [ ^ self hasEnded ].

	winner := spaceships detect: [ :aSpaceship |
		          aSpaceship position = board amountOfTiles and: [aSpaceship lap=board laps]].
	^ winner
]
