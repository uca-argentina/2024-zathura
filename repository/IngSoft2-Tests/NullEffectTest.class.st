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
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withParsecs: 10.
	aNullEffectTile := Null create.
	aSpaceShip := SpaceShip named: 'Danny'.
	aSpaceShip fuel: 20.
	aNullEffectTile triggeredBy: aSpaceShip on: aBoard.
	self assert: aSpaceShip position equals: 1
]
