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
		'wormholeTile2',
		'playerTurn'
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
	playerTurn:=(players at:1)
]

{ #category : #playing }
Game >> movePlayer: aPlayer withRollingResult: aResult [
	| newPosition |
	
	newPosition:= self positionForPlayer: (self positionOf: aPlayer) whenRollingResult: aResult.
	
	self addPosition: newPosition

]

{ #category : #playing }
Game >> nextTurnOf:aPlayer [

players:=(players reject: [ :each|each=aPlayer ]),{aPlayer}.
playerTurn:=(players at:1)

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
		(self nextTurnOf: aPlayer).
		(self positionOf: aPlayer) tileNumber == wormholeTile1 ifTrue:[self movePlayer: aPlayer withRollingResult: (wormholeTile2-wormholeTile1)] ifFalse:[(self positionOf: aPlayer) tileNumber == wormholeTile2 ifTrue:[self movePlayer: aPlayer withRollingResult: (wormholeTile1-wormholeTile2)]].
	]
	ifTrue:[Error signal: 'Game has already ended']

	
]

{ #category : #'as yet unclassified' }
Game >> turnOf: aPlayer [ 
	(playerTurn = aPlayer)ifTrue: [^true]ifFalse:[^false]

{ #category : #asserting }
Game >> winner [
	|ganador|
	(self hasEnded) ifFalse:[^ self hasEnded ].
	ganador :=  players detect: [:aPlayer|((self positionOf: aPlayer)tileNumber) = board tiles size].
	^ ganador

]
