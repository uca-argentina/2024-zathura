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

{ #category : #'as yet unclassified' }
Game class >> assertValidNumberOfPlayers: aPlayers [

	aPlayers isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #'as yet unclassified' }
Game class >> withBoard: aBoard diceCollection: aDiceCollection players: aPlayers [

	self assertValidNumberOfPlayers: aPlayers.
	^ self new
		  initializeWithBoard: aBoard
		  diceCollection: aDiceCollection
		  players: aPlayers
]

{ #category : #adding }
Game >> hasEnded [
^status
]

{ #category : #initialization }
Game >> initializeWithBoard: aBoard diceCollection: aDiceCollection players: aPlayers [

	board := aBoard.
	diceCollection := aDiceCollection.
	players := aPlayers.
	status := false.
	playerPositions := (players collect: [ :player |SpaceshipPosition startingOfPlayer: player ]) asOrderedCollection.
]

{ #category : #'as yet unclassified' }
Game >> positionOf: aPlayer [

^(playerPositions select:[:position|position player=aPlayer]) last
]
