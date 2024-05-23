Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValidNumberOfLaps: laps [ 
	laps > 0 ifFalse: [ 
		Error signal: 'Game must have one or more laps!' ]
]

{ #category : #'instance creation' }
Board class >> isValid: tiles [

	tiles size < 2 ifTrue: [ Error signal: 'Tiles should be 2 or more' ]
]

{ #category : #'as yet unclassified' }
Board class >> of: tiles finishingAfter: laps [
	self isValid: tiles.
	self assertValidNumberOfLaps: laps.
	^ self new initializeOf: tiles finishingAfter: laps
]

{ #category : #initialization }
Board >> amountOfTiles [

	^ tiles size
]

{ #category : #asserting }
Board >> checkIfOutOfBounds: aSpaceShip [

	| actualPosition |
	actualPosition := aSpaceShip position.
	(self amountOfTiles - actualPosition < 0 and: aSpaceShip lap = self laps) ifTrue: [
		aSpaceShip moveBy: self amountOfTiles - actualPosition ]
]

{ #category : #initialization }
Board >> initializeOf: aTileCollection finishingAfter: numberOfLaps [

	tiles := aTileCollection.
	laps:= numberOfLaps.
]

{ #category : #accessing }
Board >> lapOf: aSpaceship [

	^ aSpaceship lap
]

{ #category : #accessing }
Board >> laps [ 

^laps
]

{ #category : #accessing }
Board >> move: aSpaceship by: diceRollerNumber [

	| effectToApply tilesSinceBeginning newLap newPosition aLap | 
	
	tilesSinceBeginning := (self positionOf: aSpaceship)
	                       + diceRollerNumber
	                       + ((aSpaceship lap - 1) * self amountOfTiles).
	
	aLap := ((tilesSinceBeginning - 1) // self amountOfTiles) + 1.
	
	newLap := aLap min: laps.
	
	newPosition := tilesSinceBeginning % self amountOfTiles.
	
	(newPosition=0 or: [ aLap > laps ]) ifTrue: [
		newPosition := self amountOfTiles. ].
	
	aSpaceship hasTileNumber: newPosition and: newLap.

	self checkIfOutOfBounds: aSpaceship.
	effectToApply := tiles at: aSpaceship position.
	effectToApply triggeredBy: aSpaceship.
	self checkIfOutOfBounds: aSpaceship.
]

{ #category : #accessing }
Board >> positionOf: aSpaceship [

	^ aSpaceship position
]

{ #category : #'as yet unclassified' }
Board >> spaceshipInLastTileAndLap: aSpaceship [

	(laps = aSpaceship lap and: [
		 self amountOfTiles = aSpaceship position ]) ifTrue: [ ^ true ].
	^ false
]
