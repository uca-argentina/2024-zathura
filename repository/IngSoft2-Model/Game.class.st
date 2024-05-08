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
Game class >> assertValidNumberOfSpaceships: aSpaceships [

	aSpaceships isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #'instance creation' }
Game class >> playedBy: aSpaceships on: aBoard rolling: dice [

	self assertValidNumberOfSpaceships: aSpaceships.
	^ self new
		  initializePlayedBy: aSpaceships
		  on: aBoard
		  rolling: dice
]

{ #category : #playing }
Game >> changeTurns [
		spaceships add: spaceships first.
		spaceships removeFirst.

	
]

{ #category : #testing }
Game >> hasEnded [
^hasEnded
]

{ #category : #initialization }
Game >> initializePlayedBy: aSpaceships on: aBoard rolling: dice [
    board := aBoard.
    diceCollection := dice.
	 spaceships := aSpaceships asOrderedCollection.
    hasEnded := false.
    aSpaceships do: [ :aSpaceship | aBoard addSpaceshipToATile: aSpaceship aTileNumber: 1 ].

]

{ #category : #playing }
Game >> moveSpaceship: aSpaceship withRollingResult: aResult [
	
	board moveSpaceshipToAnotherTile: aSpaceship aTileNumber: aResult.
	
	


]

{ #category : #playing }
Game >> playNextTurn [
	| rollingResult spaceshipTurn|
	hasEnded ifFalse:[
		spaceshipTurn:= self turnOf.
		self changeTurns .
		rollingResult:=diceCollection roll.
		self moveSpaceship: spaceshipTurn withRollingResult:rollingResult.
		(self positionOf: spaceshipTurn) >= (board tiles) size ifTrue:[hasEnded:=true].
	]
	ifTrue:[Error signal: 'Game has already ended']

	
]

{ #category : #accessing }
Game >> positionOf: aSpaceship [

	^(board positionOf: aSpaceship ).
]

{ #category : #playing }
Game >> turnOf [
		|spaceshipTurn|
		spaceshipTurn := spaceships first.
		^spaceshipTurn 

	
]

{ #category : #asserting }
Game >> winner [
	|winner lastTile|
	(self hasEnded) ifFalse:[^ self hasEnded ].
	lastTile := (board tiles) last.
	winner :=  spaceships detect: [:aSpaceship|lastTile isSpaceshipAtTile: aSpaceship].
	^ winner
	
]
