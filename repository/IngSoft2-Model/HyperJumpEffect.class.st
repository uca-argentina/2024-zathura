Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'distances'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpEffect class >> of: collectionOfParsecs [ 

^self new initializeOf:collectionOfParsecs
]

{ #category : #'as yet unclassified' }
HyperJumpEffect >> distances [

^distances
]

{ #category : #'instance creation' }
HyperJumpEffect >> initializeOf: collectionOfParsecs [ 
	 
distances:=collectionOfParsecs asOrderedCollection
]

{ #category : #playing }
HyperJumpEffect >> triggeredBy: aPlayer on:aBoard [

|changesToPositionCollection newShipPosition advancedLaps cost parsecsToMove totalTiles tilesToMove boardDistanceInParsecs |
	distances:=self distances.
	
	parsecsToMove:=distances at:1.
	totalTiles:=aBoard amountOfTiles.
	boardDistanceInParsecs:=aBoard parsecs.
	tilesToMove:=(parsecsToMove//(boardDistanceInParsecs/totalTiles)) truncated.
	
	changesToPositionCollection:= aBoard calculatePositioToMove: aPlayer whenMoving:(tilesToMove).
	distances add: distances first.
	distances removeFirst.
	newShipPosition:= changesToPositionCollection at:1.
	advancedLaps:=changesToPositionCollection at:2.
	cost:=changesToPositionCollection at:3.
	aPlayer movePositionBy:newShipPosition lapBy:advancedLaps  neededFuel: cost.
]
