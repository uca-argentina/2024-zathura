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

	positionOfTheWormholes size = 2 ifFalse: [
		Error signal: 'Cannot create a single wormhole' ]
]

{ #category : #'as yet unclassified' }
WormholeEffect class >> betweenTiles: positionOfTheWormholes [

	self assertAtLeastTwoWormholes: positionOfTheWormholes.
	^ self new initialize:
		  positionOfTheWormholes last - positionOfTheWormholes first
]

{ #category : #initialization }
WormholeEffect >> initialize: aNumberOfTilesToMove [

	tilesToMove := aNumberOfTilesToMove
]

{ #category : #playing }
WormholeEffect >> triggeredBy: aPlayer on:aBoard [
	|changesToPositionCollection newShipPosition advancedLaps cost|
	changesToPositionCollection:= aBoard calculatePositioToMove: aPlayer whenMoving:tilesToMove .
	newShipPosition:= changesToPositionCollection at:1.
	advancedLaps:=changesToPositionCollection at:2.
	cost:=changesToPositionCollection at:3.
	aPlayer movePositionBy:newShipPosition lapBy:advancedLaps  neededFuel: cost.
]
