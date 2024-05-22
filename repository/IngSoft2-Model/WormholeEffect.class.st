Class {
	#name : #WormholeEffect,
	#superclass : #Object,
	#instVars : [
		'tilesToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
WormholeEffect class >> assertAtLeastTwoWormholes: positionOfTheWormholes [
		positionOfTheWormholes size = 2  ifFalse: [
		Error signal: 'Cannot create a single wormhole' ]
]

{ #category : #'as yet unclassified' }
WormholeEffect class >> create: positionOfTheWormholes [
	self assertAtLeastTwoWormholes: positionOfTheWormholes.
	^self new initializeNumberOfTilesToMove: (positionOfTheWormholes last) - (positionOfTheWormholes first)
]

{ #category : #initialization }
WormholeEffect >> initializeNumberOfTilesToMove: aNumberOfTilesToMove [
	tilesToMove:=aNumberOfTilesToMove.
]

{ #category : #'as yet unclassified' }
WormholeEffect >> triggeredBy: aPlayer [
	aPlayer moveBy:tilesToMove.
]
