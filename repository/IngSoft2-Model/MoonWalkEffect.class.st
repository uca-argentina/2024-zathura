Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'tilesToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalkEffect class >> backwardDistance: aDistance [

	^ self new initilizedWithADistance: aDistance.
]

{ #category : #'as yet unclassified' }
MoonWalkEffect >> initilizedWithADistance: aDistance [
	tilesToMove:= aDistance.
]

{ #category : #'as yet unclassified' }
MoonWalkEffect >> triggeredBy: aPlayer on:aBoard [
	|changesToPositionCollection newShipPosition filteredPlayers advancedLaps cost|
	filteredPlayers := aBoard players select: [:player | player ~= aPlayer].
	filteredPlayers do:[:player | changesToPositionCollection:= aBoard calculatePositioToMove: player whenMoving:tilesToMove .
	newShipPosition:= changesToPositionCollection at:1.
	advancedLaps:=changesToPositionCollection at:2.
	cost:=changesToPositionCollection at:3.
	player movePositionBy:newShipPosition lapBy:advancedLaps  neededFuel: cost. ]
	
]
