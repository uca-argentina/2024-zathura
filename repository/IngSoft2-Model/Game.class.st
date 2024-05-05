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
		'tileNumber',
		'wormholeTile1',
		'wormholeTile2'
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

{ #category : #testing }
Game >> hasWormholeFrom: aTile to: aTile2 [ 
	wormholeTile1:=aTile.
	wormholeTile2:=aTile2.
	
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
Game >> rollDiceCupFor: aPlayer [
	| rollingResult |
	status ifFalse:[
		rollingResult:=diceCollection roll.
		self movePlayer: aPlayer withRollingResult:rollingResult.
		(self positionOf: aPlayer) tileNumber >= (board tiles) size ifTrue:[status:=true].
		(self positionOf: aPlayer) tileNumber == wormholeTile1 ifTrue:[self movePlayer: aPlayer withRollingResult: (wormholeTile2-wormholeTile1)] ifFalse:[(self positionOf: aPlayer) tileNumber == wormholeTile2 ifTrue:[self movePlayer: aPlayer withRollingResult: (wormholeTile1-wormholeTile2)]].
	]
	ifTrue:[Error signal: 'Game has already ended']

	
]
