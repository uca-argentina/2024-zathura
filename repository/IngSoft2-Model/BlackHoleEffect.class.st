Class {
	#name : #BlackHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
BlackHoleEffect >> triggeredBy: aPlayer on:aBoard [
|changesToPositionCollection newShipPosition advancedLaps cost|
	changesToPositionCollection:= aBoard calculatePositioToMove: aPlayer whenMoving:-4 .
	newShipPosition:= changesToPositionCollection at:1.
	advancedLaps:=changesToPositionCollection at:2.
	cost:=changesToPositionCollection at:3.
	aPlayer movePositionBy:newShipPosition lapBy:advancedLaps  neededFuel: cost.
	
]
