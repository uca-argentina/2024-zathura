Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Board class >> isValid: aTileCollection [

	aTileCollection size < 2 ifTrue: [
		Error signal: 'Tiles should be 2 or more' ]
]

{ #category : #'as yet unclassified' }
Board class >> ofTiles: aTileCollection [

	self isValid: aTileCollection.
	^ self new initializeOfTiles: aTileCollection
]

{ #category : #initialization }
Board >> addPlayerToATile: aPlayer aTileNumber: aTileNumber [
	(tiles at: aTileNumber)addPlayerToTile: aPlayer.

]

{ #category : #initialization }
Board >> initializeOfTiles: aTileCollection [

tiles:=aTileCollection

]

{ #category : #accessing }
Board >> movePlayerToAnotherTile: aPlayer aTileNumber: aTileNumber [
	|beforeMovementTide afterMovementTide|
	beforeMovementTide := tiles at:(self positionOf:aPlayer).
	afterMovementTide:= tiles at:((self positionOf: aPlayer)+aTileNumber).
	beforeMovementTide removePlayerFromTiles: aPlayer. 
	afterMovementTide addPlayerToTile: aPlayer.
	
]

{ #category : #accessing }
Board >> positionOf: aPlayer [
	|tileThatHasThePlayer|
	tileThatHasThePlayer := tiles detect: [:tile | tile isPlayerAtTile: aPlayer].
	^ (tiles indexOf: tileThatHasThePlayer).
]

{ #category : #'as yet unclassified' }
Board >> tileNumber: number [
	^tiles at: number
]

{ #category : #initialization }
Board >> tiles [

^tiles

]
