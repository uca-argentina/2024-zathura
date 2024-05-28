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
HyperJumpEffect >> distanceToMoveOn:aBoard [
|parsecsToMove totalTiles tilesToMove boardDistanceInParsecs |
	parsecsToMove:=distances at:1.
	totalTiles:=aBoard amountOfTiles.
	boardDistanceInParsecs:=aBoard parsecs.
	tilesToMove:=(parsecsToMove//(boardDistanceInParsecs/totalTiles)) truncated.
	distances add: distances first.
	distances removeFirst.
	^tilesToMove .
]

{ #category : #'instance creation' }
HyperJumpEffect >> initializeOf: collectionOfParsecs [ 
	 
distances:=collectionOfParsecs asOrderedCollection
]

{ #category : #playing }
HyperJumpEffect >> triggeredBy: aPlayer on:aBoard [

|tilesToMove  |
	tilesToMove := self distanceToMoveOn: aBoard.
	aBoard move: aPlayer by: tilesToMove . 

]
