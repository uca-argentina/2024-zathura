Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBombEffect >> triggeredBy: aPlayer on:aBoard [
	|changesToPositionCollection newShipPosition advancedLaps cost|
	aBoard players do:[:player | changesToPositionCollection:= aBoard calculatePositioToMove: player whenMoving:(1 - player position) .
	newShipPosition:= changesToPositionCollection at:1.
	advancedLaps:=changesToPositionCollection at:2.
	cost:=changesToPositionCollection at:3.
	player movePositionBy:newShipPosition lapBy:advancedLaps  neededFuel: 0 ]
]
