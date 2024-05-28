Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'spaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
TurnHandler class >> assertValidNumberOf: someSpaceShips [

	someSpaceShips isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #'as yet unclassified' }
TurnHandler class >> withPlayers: someSpaceShips [

	self assertValidNumberOf: someSpaceShips.
	^ self new
		  initializeWithPlayers: someSpaceShips.
]

{ #category : #playing }
TurnHandler >> changeTurns [

	spaceships add: spaceships first.
	spaceships removeFirst
]

{ #category : #initialization }
TurnHandler >> initializeWithPlayers: someSpaceShips [

	spaceships := someSpaceShips asOrderedCollection.

]

{ #category : #playing }
TurnHandler >> nextPlayerTurn [
	|spaceshipTurn|
	spaceshipTurn := self nextTurn.
	[ spaceshipTurn turnsToLose > 0 ] whileTrue: [
		spaceshipTurn losesTurns: -1.
		self changeTurns.
		spaceshipTurn := self nextTurn ].
	self changeTurns.
	^spaceshipTurn.
]

{ #category : #playing }
TurnHandler >> nextTurn [

	| spaceshipTurn |
	spaceshipTurn := spaceships first.	
	^ spaceshipTurn
]

{ #category : #initialization }
TurnHandler >> players [ 
	^spaceships 

]