Class {
	#name : #AtomicBombEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
AtomicBombEffectTest >> testWhenAPlayerTriggersTheEffectItMovesTheRestOfThePlayers [

	| anAtomicBombEffect aSpaceShip1 aSpaceShip2 aSpaceShip3 aBoard |
	anAtomicBombEffect := AtomicBombEffect new.
	aBoard := Board
		          of: {
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create.
				          NullEffect create }
		          finishingAfter: 2
		          withDistance: 10.

	aSpaceShip1 := SpaceShip named: 'Danny'.
	aSpaceShip2 := SpaceShip named: 'Walter'.
	aSpaceShip3 := SpaceShip named: 'Juan'.
	aBoard usedBy: {
			aSpaceShip1.
			aSpaceShip2.
			aSpaceShip3 }.
	aSpaceShip1 fuel: 20.
	aSpaceShip2 fuel: 20.
	aSpaceShip3 fuel: 20.
	aSpaceShip1 movePositionBy: 6 lapBy: 0 neededFuel: 6.
	aSpaceShip2 movePositionBy: 6 lapBy: 0 neededFuel: 6.
	aSpaceShip3 movePositionBy: 5 lapBy: 0 neededFuel: 5.
	self assert: aSpaceShip1 position equals: 7.
	self assert: aSpaceShip2 position equals: 7.
	self assert: aSpaceShip3 position equals: 6.
	anAtomicBombEffect triggeredBy: aSpaceShip1 on: aBoard.
	self assert: aSpaceShip1 position equals: 1.
	self assert: aSpaceShip2 position equals: 1.
	self assert: aSpaceShip3 position equals: 1
]
