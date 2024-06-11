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
Board >> anySpaceShipAtLastTileAndLap [

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
Board >> calculateLapsToAdvancedWhen: aSpaceship advances: anAmountOfTilesToMove [
	|tilesSinceBeginning|
	tilesSinceBeginning := (self positionOf: aSpaceship) + anAmountOfTilesToMove
	                       + ((aSpaceship lap - 1) * self amountOfTiles).
	^(tilesSinceBeginning - 1 // self amountOfTiles + 1).
	
	
]

{ #category : #accessing }
Board >> calculateNewPositionWhen:aSpaceship moves: anAmountOfTilesToMove withNewLap: newLap [

	| newPosition tilesSinceBeginning|
	tilesSinceBeginning := (self positionOf: aSpaceship) + anAmountOfTilesToMove
	                       + ((aSpaceship lap - 1) * self amountOfTiles).
	newPosition := tilesSinceBeginning % self amountOfTiles.
	(newLap < 1 or: newLap > self laps ) ifTrue: [
		^ (1- aSpaceship position).
	].
	(newPosition = 0 ) ifTrue: [
		^ (self amountOfTiles- aSpaceship position).].
	
	^(newPosition -  aSpaceship position).
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
Board >> move: aSpaceship by: anAmountOfTilesToMove [

	| positionToMove lapsMoved costToMove  newLap|

	newLap:= self calculateLapsToAdvancedWhen: aSpaceship  advances: anAmountOfTilesToMove.
	positionToMove :=self calculateNewPositionWhen: aSpaceship  moves: anAmountOfTilesToMove  withNewLap: newLap  .
	lapsMoved :=  (newLap min: laps+1  max:1) - aSpaceship lap  .
	costToMove := ((lapsMoved * self amountOfTiles ) + positionToMove) abs.
	aSpaceship
		movePositionBy: positionToMove
		lapBy: lapsMoved
		neededFuel: costToMove
]

{ #category : #'as yet unclassified' }
Board >> move: aPlayer jumping: aQuantityOfParsec [
	| tilesToMove |

	tilesToMove := (aQuantityOfParsec
	                // (parsecs  / self amountOfTiles  )) truncated.

	self move:  aPlayer by:  tilesToMove .
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
