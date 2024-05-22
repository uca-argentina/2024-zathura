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

	tiles size < 2 ifTrue: [ Error signal: 'Tiles should be 2 or more' ]
]

{ #category : #'instance initialization' }
Board class >> of: tiles [

	self isValid: tiles.
	^ self new initializeOf: tiles
]

{ #category : #initialization }
Board >> amountOfTiles [

	^ tiles size
]

{ #category : #asserting }
Board >> checkIfOutOfBounds: aSpaceShip [

	| actualPosition |
	actualPosition := aSpaceShip position.
	self amountOfTiles - actualPosition < 0 ifTrue: [
		aSpaceShip moveBy: self amountOfTiles - actualPosition ]
]

{ #category : #initialization }
Board >> initializeOf: aTileCollection [

	tiles := aTileCollection
]

{ #category : #accessing }
Board >> move: aSpaceship by: diceRollerNumber [

	| effectToApply |
	aSpaceship moveBy: diceRollerNumber.
	self checkIfOutOfBounds: aSpaceship.
	effectToApply := tiles at: aSpaceship position.
	effectToApply triggeredBy: aSpaceship.
	self checkIfOutOfBounds: aSpaceship
]

{ #category : #accessing }
Board >> positionOf: aSpaceship [

	^ aSpaceship position
]
