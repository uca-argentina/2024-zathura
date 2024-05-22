Class {
	#name : #NullEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
NullEffectTest >> testWhenSpaceShipsLandItDoesNothingToIt [

	| aSpaceShip aNullEffectTile |
	aNullEffectTile := NullEffect create.
	aSpaceShip := SpaceShip named: 'Danny'.
	aNullEffectTile triggeredBy: aSpaceShip.
	self assert: aSpaceShip position equals: 1
]
