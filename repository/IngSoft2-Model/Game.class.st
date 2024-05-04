Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'playerPositions',
		'board',
		'dice',
		'players',
		'status',
		'diceCollection',
		'tileNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertValidNumberOfPlayers: aPlayers [

	aPlayers isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #'instance creation' }
Game class >> withBoard: aBoard diceCollection: aDiceCollection players: aPlayers [

	self assertValidNumberOfPlayers: aPlayers.
	^ self new
		  initializeWithBoard: aBoard
		  diceCollection: aDiceCollection
		  players: aPlayers
]

{ #category : #adding }
Game >> addPosition: aPlayerPosition [
	playerPositions add: aPlayerPosition

]

{ #category : #testing }
Game >> hasEnded [
^status
]

{ #category : #initialization }
Game >> initializeWithBoard: aBoard diceCollection: aDiceCollection players: aPlayers [

	board := aBoard.
	diceCollection := aDiceCollection.
	players := aPlayers.
	status := false.
	playerPositions := (players collect: [ :player |SpaceShipPosition startingOfPlayer: player ]) asOrderedCollection.
]

{ #category : #playing }
Game >> movePlayer: aPlayer withRollingResult: aResult [
	| newPosition |
	
	newPosition:= self positionForPlayer: (self positionOf: aPlayer) whenRollingResult: aResult.
	
	self addPosition: newPosition

]

{ #category : #initialization }
Game >> positionForPlayer: aPlayerPosition whenRollingResult: aResult [
	^SpaceShipPosition
		ofPlayer: aPlayerPosition player
		tileNumber: aPlayerPosition tileNumber + aResult 
]

{ #category : #accessing }
Game >> positionOf: aPlayer [

^(playerPositions select:[:position|position player=aPlayer]) last
]

{ #category : #playing }
Game >> rollDiceCupFor: aPLayer [
	| rollingResult |
	rollingResult:=diceCollection roll.
]
