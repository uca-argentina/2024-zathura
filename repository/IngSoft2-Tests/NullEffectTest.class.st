Class {
	#name : #NullEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
NullEffectTest >> testWhenSpaceShipsLandItDoesNothingToIt [

	| aSpaceShip aNullEffectTile aBoard |
	aBoard := Board
		          of: {
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create }
		          finishingAfter: 2
		          withDistance: 10.
	aNullEffectTile := NullEffect create.
	aSpaceShip := SpaceShip named: 'Danny'.
	aSpaceShip fuel: 20.
	aNullEffectTile triggeredBy: aSpaceShip on: aBoard.
	self assert: aSpaceShip position equals: 1
]
