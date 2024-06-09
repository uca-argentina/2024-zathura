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

	laps <= 0 ifTrue: [ Error signal: 'Game must have one or more laps!' ]
]

{ #category : #asserting }
Board class >> assertValidQuantityOf: parsecs [

	parsecs < 0 ifTrue: [
		Error signal: 'Parsecs cannot be a negative measure' ]
]

{ #category : #'instance creation' }
Board class >> isValid: tiles [

	tiles size < 2 ifTrue: [ Error signal: 'Tiles should be 2 or more' ]
]

{ #category : #'instance creation' }
Board class >> of: tiles finishingAfter: laps withDistance: parsecs [

	self isValid: tiles.
	self assertValidNumberOfLaps: laps.
	self assertValidQuantityOf: parsecs.
	^ self new
		  initializeOf: tiles
		  finishingAfter: laps
		  withDistance: parsecs
]

{ #category : #initialization }
Board >> amountOfTiles [

	^ tiles size
]

{ #category : #accessing }
Board >> anySpaceShipOneInLastTileAndLap [

	^ players anySatisfy: [ :aSpaceship |
		  laps + 1 = aSpaceship lap and: [ 1 = aSpaceship position ] ]
]

{ #category : #accessing }
Board >> applyEffectOnLandingShip: aSpaceship [

	| effectToApply |
	effectToApply := tiles at: aSpaceship position.
	effectToApply triggeredBy: aSpaceship on: self
]

{ #category : #accessing }
Board >> calculatePositionToMove: aSpaceship whenMoving: aNumber [

	| tilesSinceBeginning newLap newPosition aLap lapsAdvanced finalPosition fuelNeeded |
	fuelNeeded := aNumber abs.
	tilesSinceBeginning := (self positionOf: aSpaceship) + aNumber
	                       + ((aSpaceship lap - 1) * self amountOfTiles).

	aLap := tilesSinceBeginning - 1 // self amountOfTiles + 1.
	newLap := aLap min: laps.
	newPosition := tilesSinceBeginning % self amountOfTiles.
	newLap < 1 ifTrue: [
		newLap := newLap max: 1.
		newPosition := 1.
		fuelNeeded := (1 - (tilesSinceBeginning - aNumber)) abs ].
	(newPosition = 0 and: [ aLap <= laps ]) ifTrue: [
		newPosition := self amountOfTiles.
		fuelNeeded := self amountOfTiles * newLap
		              - (tilesSinceBeginning - aNumber) ].
	aLap > laps ifTrue: [
		newPosition := 1.
		fuelNeeded := self amountOfTiles * laps
		              - (tilesSinceBeginning - aNumber) + 1.
		newLap := laps + 1 ].
	lapsAdvanced := newLap - aSpaceship lap.
	finalPosition := newPosition - aSpaceship position.
	lapsAdvanced := newLap - aSpaceship lap.
	^ OrderedCollection
		  with: finalPosition
		  with: lapsAdvanced
		  with: fuelNeeded
]

{ #category : #initialization }
Board >> initializeOf: aTileCollection finishingAfter: numberOfLaps withDistance: distanceInParsecs [

	tiles := aTileCollection.
	laps := numberOfLaps.
	parsecs := distanceInParsecs
]

{ #category : #accessing }
Board >> laps [

	^ laps
]

{ #category : #accessing }
Board >> move: aSpaceship by: diceRollerNumber [

	| changesToPositionCollection positionToMove lapsMoved costToMove |
	changesToPositionCollection := self
		                               calculatePositionToMove: aSpaceship
		                               whenMoving: diceRollerNumber.
	positionToMove := changesToPositionCollection at: 1.
	lapsMoved := changesToPositionCollection at: 2.
	costToMove := changesToPositionCollection at: 3.
	aSpaceship
		movePositionBy: positionToMove
		lapBy: lapsMoved
		neededFuel: costToMove
]

{ #category : #'as yet unclassified' }
Board >> moveAllPlayersToFirstPosition [
	players do:[:aPlayer | aPlayer movePositionBy: 1- aPlayer position lapBy:0  neededFuel: 0 ].
]

{ #category : #accessing }
Board >> parsecs [

	^ parsecs
]

{ #category : #accessing }
Board >> players [

	^ players
]

{ #category : #accessing }
Board >> positionOf: aSpaceship [

	^ aSpaceship position
]

{ #category : #accessing }
Board >> usedBy: somePlayers [

	players := somePlayers
]
