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
Game class >> assertValidNumberOf: someSpaceships [

	someSpaceships isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #'instance creation' }
Game class >> playedBy: someSpaceships on: aBoard rolling: dice [

	self assertValidNumberOf: someSpaceships.
	^ self new
		  initializePlayedBy: someSpaceships
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
    aSpaceships do: [ :aSpaceship | aBoard add: aSpaceship to: 1 ].

]

{ #category : #playing }
Game >> moveSpaceship: aSpaceship withRollingResult: aResult [
	
	board move: aSpaceship by: aResult.
	
	


]

{ #category : #playing }
Game >> playNextTurn [
	| rollingResult spaceshipTurn|
	self hasEnded ifTrue: [Error signal: 'Game has already ended'].
	spaceshipTurn:= self turnOf.
	self changeTurns .
	rollingResult:=diceCollection roll.
	self moveSpaceship: spaceshipTurn withRollingResult:rollingResult.
	(self positionOf: spaceshipTurn) >= (board tiles) size
ifTrue:[hasEnded:=true].


	
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
	(self hasEnded) ifFalse:[ Error signal: 'Game is still playing.' ].
	lastTile := (board tiles) last.
	winner := spaceships detect: [:aSpaceship|lastTile isSpaceshipAtTile:
	aSpaceship].
	^ winner
	
]
