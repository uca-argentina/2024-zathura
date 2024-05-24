Class {
	#name : #BlackHoleEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
BlackHoleEffectTest >> testBlackHoleEffectMovesAPlayerBacward4Positions [

	| aBlachHoleTile aSpaceShip aBoard|
	aBlachHoleTile := BlackHoleEffect new.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create. }
			finishingAfter: 2.			
	aSpaceShip := SpaceShip named: 'Danny'.
	aSpaceShip fuel:20.
	aSpaceShip movePositionBy: 6 lapBy: 0  neededFuel: 6 .
	aBlachHoleTile triggeredBy: aSpaceShip on:aBoard.
	self assert: aSpaceShip position equals: 3
]
