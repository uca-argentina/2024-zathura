Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'status',
		'diceCollection',
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
    aPlayers do: [ :aPlayer | aBoard addPlayerToATile: aPlayer aTileNumber: 1 ].
	 playerTurn:=(players at:1).

]

{ #category : #playing }
Game >> movePlayer: aPlayer withRollingResult: aResult [
	
	board movePlayerToAnotherTile: aPlayer aTileNumber: aResult.
	
	


]

{ #category : #'as yet unclassified' }
Game >> nextTurnOf:aPlayer [

players:=(players reject:[:each|each=aPlayer]),{aPlayer}.
playerTurn:=(players at:1).
]

{ #category : #accessing }
Game >> positionOf: aPlayer [

	^(board positionOf: aPlayer ).
]

{ #category : #playing }
Game >> rollDiceCupFor: aPlayer [
	| rollingResult |
	status ifFalse:[
		rollingResult:=diceCollection roll.
		self movePlayer: aPlayer withRollingResult:rollingResult.
		(self positionOf: aPlayer) >= (board tiles) size ifTrue:[status:=true].
		(self nextTurnOf: aPlayer).
	]
	ifTrue:[Error signal: 'Game has already ended']

	
]

{ #category : #'as yet unclassified' }
Game >> turnOf:aPlayer [

]

{ #category : #asserting }
Game >> winner [
	|ganador lastTile|
	(self hasEnded) ifFalse:[^ self hasEnded ].
	lastTile := (board tiles) last.
	ganador :=  players detect: [:aPlayer|lastTile isPlayerAtTile: aPlayer].
	^ ganador
	
]
