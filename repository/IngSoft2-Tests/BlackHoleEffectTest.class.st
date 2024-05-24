Class {
	#name : #BlackHoleEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
BlackHoleEffectTest >> testWhenAPlayerTriggersTheEffectItMoves4Tiles [
	|  aBlackHoleEffect aSpaceShip aBoard|
	aBlackHoleEffect:= BlackHoleEffect new.
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
	aSpaceShip movePositionBy: 5 lapBy:  0neededFuel:5.
	aBlackHoleEffect triggeredBy: aSpaceShip  on: aBoard . 
	self assert: aSpaceShip position equals: 2
]
