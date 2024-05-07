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
Game class >> assertValidNumberOfSpaceships: aSpaceships [

	aSpaceships isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #'instance creation' }
Game class >> withBoard: aBoard diceCollection: aDiceCollection spaceships: aSpaceships [

	self assertValidNumberOfSpaceships: aSpaceships.
	^ self new
		  initializeWithBoard: aBoard
		  diceCollection: aDiceCollection
		  spaceships: aSpaceships
]

{ #category : #testing }
Game >> hasEnded [
^status
]

{ #category : #initialization }
Game >> initializeWithBoard: aBoard diceCollection: aDiceCollection spaceships: aSpaceships [
    board := aBoard.
    diceCollection := aDiceCollection.
	 players := aSpaceships asOrderedCollection.
    status := false.
    aSpaceships do: [ :aPlayer | aBoard addSpaceshipToATile: aPlayer aTileNumber: 1 ].

]

{ #category : #playing }
Game >> moveSpaceship: aSpaceship withRollingResult: aResult [
	
	board moveSpaceshipToAnotherTile: aSpaceship aTileNumber: aResult.
	
	


]

{ #category : #playing }
Game >> playNextTurn [
	| rollingResult playerTurn|
	status ifFalse:[
		playerTurn:= self turnOf.
		rollingResult:=diceCollection roll.
		self moveSpaceship: playerTurn withRollingResult:rollingResult.
		(self positionOf: playerTurn) >= (board tiles) size ifTrue:[status:=true].
	]
	ifTrue:[Error signal: 'Game has already ended']

	
]

{ #category : #accessing }
Game >> positionOf: aSpaceship [

	^(board positionOf: aSpaceship ).
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
	ganador :=  players detect: [:aPlayer|lastTile isSpaceshipAtTile: aPlayer].
	^ ganador
	
]
