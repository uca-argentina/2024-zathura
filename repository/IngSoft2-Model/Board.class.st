Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'laps',
		'players',
		'parsecs'
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
Board class >> of: tiles finishingAfter: laps withDistance:parsecs [
	self isValid: tiles.
	self assertValidNumberOfLaps: laps.
	^ self new initializeOf: tiles finishingAfter: laps withDistance:parsecs.
]

{ #category : #initialization }
Board >> amountOfTiles [

	^ tiles size
]

{ #category : #accessing }
Board >> calculatePositioToMove: aSpaceship whenMoving: aNumber [

	|tilesSinceBeginning newLap newPosition aLap lapsAdvanced finalPosition  fuelNeeded| 
	fuelNeeded:=aNumber abs.
	tilesSinceBeginning := (self positionOf: aSpaceship)
	                       + aNumber
	                       + ((aSpaceship lap - 1) * self amountOfTiles).
	
	aLap := ((tilesSinceBeginning - 1) // self amountOfTiles) + 1.
	newLap := aLap min: laps.
	newPosition := tilesSinceBeginning % self amountOfTiles.
	(newLap < 1) ifTrue:[
		newLap := newLap max:1.
		newPosition:=1.
		].
	
	(newPosition=0 or: [ aLap > laps ]) ifTrue: [
		newPosition := self amountOfTiles.
		fuelNeeded := (self amountOfTiles * newLap) - (tilesSinceBeginning-aNumber) .].
	lapsAdvanced := (newLap -aSpaceship lap).
	finalPosition:= (newPosition - aSpaceship position ).
	lapsAdvanced := newLap - aSpaceship lap.
    finalPosition := newPosition - aSpaceship position.
    ^OrderedCollection with: finalPosition with: lapsAdvanced with: fuelNeeded.
	
	

]

{ #category : #initialization }
Board >> initializeOf: aTileCollection finishingAfter: numberOfLaps withDistance:distanceInParsecs [

	tiles := aTileCollection.
	laps:= numberOfLaps.
	parsecs:=distanceInParsecs.
	
]

{ #category : #accessing }
Board >> laps [ 

^laps
]

{ #category : #accessing }
Board >> move: aSpaceship by: diceRollerNumber [

	| effectToApply  changesToPositionCollection positionToMove lapsMoved costToMove|
	changesToPositionCollection:=self calculatePositioToMove:aSpaceship  whenMoving: diceRollerNumber.
	positionToMove:= changesToPositionCollection at:1.
	lapsMoved:=changesToPositionCollection at:2.
	costToMove:=changesToPositionCollection at:3.
	aSpaceship movePositionBy: positionToMove lapBy: lapsMoved neededFuel: costToMove.
	effectToApply := tiles at: aSpaceship position.
	effectToApply triggeredBy: aSpaceship on:self.
	
]

{ #category : #accessing }
Board >> parsecs [ 

^parsecs
]

{ #category : #accessing }
Board >> players [
	^players.
	
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

{ #category : #accessing }
Board >> usedBy: somePlayers [
	players := somePlayers.
	
]
