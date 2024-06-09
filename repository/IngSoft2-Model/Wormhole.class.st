Class {
	#name : #Wormhole,
	#superclass : #Effect,
	#instVars : [
		'tilesToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Wormhole class >> assertAtLeastTwoWormholes: positionOfTheWormholes [

	positionOfTheWormholes size = 2 ifFalse: [
		Error signal: 'Cannot create a single wormhole' ]
]

{ #category : #'instance creation' }
Wormhole class >> betweenTiles: positionOfTheWormholes [

	self assertAtLeastTwoWormholes: positionOfTheWormholes.
	^ self new initialize:
		  positionOfTheWormholes last - positionOfTheWormholes first
]

{ #category : #initialization }
Wormhole >> initialize: aNumberOfTilesToMove [

	tilesToMove := aNumberOfTilesToMove
]

{ #category : #playing }
Wormhole >> triggeredBy: aPlayer on: aBoard [

	aBoard move: aPlayer by: tilesToMove
]
