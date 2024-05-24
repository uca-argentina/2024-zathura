Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'distances'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperJumpEffect >> distances [

^distances
]

{ #category : #'instance creation' }
HyperJumpEffect >> of:collectionOfParsecs [

distances:=collectionOfParsecs asOrderedCollection.
]

{ #category : #'as yet unclassified' }
HyperJumpEffect >> triggeredBy: aPlayer on:aBoard [

|changesToPositionCollection newShipPosition advancedLaps cost parsecsToMove totalTiles tilesToMove boardDistanceInParsecs |
	distances:=self distances.
	
	parsecsToMove:=distances at:1.
	totalTiles:=aBoard amountOfTiles.
	boardDistanceInParsecs:=10.
	tilesToMove:=(parsecsToMove//(boardDistanceInParsecs/totalTiles)).
	
	changesToPositionCollection:= aBoard calculatePositioToMove: aPlayer whenMoving:(tilesToMove).
	distances add: distances first.
	distances removeFirst.
	newShipPosition:= changesToPositionCollection at:1.
	advancedLaps:=changesToPositionCollection at:2.
	cost:=changesToPositionCollection at:3.
	aPlayer movePositionBy:newShipPosition lapBy:advancedLaps  neededFuel: cost.
]
