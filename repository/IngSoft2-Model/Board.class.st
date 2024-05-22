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
	^ self new initializeOfTiles: tiles
]

{ #category : #initialization }
Board >> add: aSpaceship to: aTileNumber [
	(tiles at: aTileNumber)addSpaceshipToTile: aSpaceship.

]

{ #category : #initialization }
Board >> initializeOfTiles: aTileCollection [

tiles:=aTileCollection

]

{ #category : #accessing }
Board >> move: aSpaceship by: aTileNumber [
	|beforeMovementTide afterMovementTide afterMovementPosition|
	beforeMovementTide := tiles at:(self positionOf:aSpaceship).
	afterMovementPosition := ((self positionOf: aSpaceship) + aTileNumber) min: (self tiles size).
	afterMovementTide:= tiles at:(afterMovementPosition).
	beforeMovementTide removeSpaceshipFromTiles: aSpaceship. 
	afterMovementTide addSpaceshipToTile: aSpaceship.
	
]

{ #category : #accessing }
Board >> positionOf: aSpaceship [
	|tileThatHasTheSpaceship|
	tileThatHasTheSpaceship := tiles detect: [:tile | tile isSpaceshipAtTile: aSpaceship].
	^ (tiles indexOf: tileThatHasTheSpaceship).
]

{ #category : #initialization }
Board >> tiles [

^tiles

]
