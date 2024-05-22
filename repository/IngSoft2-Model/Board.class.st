Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> isValid: tiles [

	tiles size < 2 ifTrue: [
		Error signal: 'Tiles should be 2 or more' ]
]

{ #category : #'instance initialization' }
Board class >> of: tiles [

	self isValid: tiles.
	^ self new initializeOf: tiles
]

{ #category : #'as yet unclassified' }
Board >> checkIfSpaceShipIsOutOfBoard: aSpaceShip [
	|actualPosition|
	actualPosition:= aSpaceShip getPosition.
	self tilesLenght - actualPosition < 0 ifTrue:[aSpaceShip moveBy:(self tilesLenght - actualPosition) ] 
]

{ #category : #initialization }
Board >> initializeOf: aTileCollection [

tiles:=aTileCollection

]

{ #category : #accessing }
Board >> move: aSpaceship by: diceRollerNumber [
	|effectToApply|
	aSpaceship moveBy:diceRollerNumber.
	self checkIfSpaceShipIsOutOfBoard: aSpaceship.
	effectToApply:=tiles at: aSpaceship getPosition .
	effectToApply triggeredBy: aSpaceship.
	self checkIfSpaceShipIsOutOfBoard: aSpaceship.
	
	
]

{ #category : #accessing }
Board >> positionOf: aSpaceship [
	^ aSpaceship getPosition.
]

{ #category : #accessing }
Board >> tileNumber: number [
	^tiles at: number
]

{ #category : #initialization }
Board >> tiles [

^tiles

]

{ #category : #initialization }
Board >> tilesLenght [

^tiles size

]
