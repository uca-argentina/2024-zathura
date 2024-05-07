Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'status',
		'diceCollection'
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
	 players := aPlayers asOrderedCollection.
    status := false.
    aPlayers do: [ :aPlayer | aBoard addPlayerToATile: aPlayer aTileNumber: 1 ].

]

{ #category : #playing }
Game >> movePlayer: aPlayer withRollingResult: aResult [
	
	board movePlayerToAnotherTile: aPlayer aTileNumber: aResult.
	
	


]

{ #category : #accessing }
Game >> positionOf: aPlayer [

	^(board positionOf: aPlayer ).
]

{ #category : #playing }
Game >> rollDiceCup [
	| rollingResult playerTurn|
	status ifFalse:[
		playerTurn:= self turnOf.
		rollingResult:=diceCollection roll.
		self movePlayer: playerTurn withRollingResult:rollingResult.
		(self positionOf: playerTurn) >= (board tiles) size ifTrue:[status:=true].
	]
	ifTrue:[Error signal: 'Game has already ended']

	
]

{ #category : #playing }
Game >> turnOf [
		|playerTurn|
		playerTurn := players first.
		players add: playerTurn.
		players removeAt:1.
		^playerTurn 

	
]

{ #category : #asserting }
Game >> winner [
	|ganador lastTile|
	(self hasEnded) ifFalse:[^ self hasEnded ].
	lastTile := (board tiles) last.
	ganador :=  players detect: [:aPlayer|lastTile isPlayerAtTile: aPlayer].
	^ ganador
	
]
