Class {
	#name : #HyperJumpEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
HyperJumpEffectTest >> testWhenAPlayerTriggersTheEffectItMovesAnAmountOfParsecs [

	| aHyperJumpEffect aSpaceShip1 aSpaceShip2 aSpaceShip3 aBoard|
	aHyperJumpEffect:= HyperJumpEffect new.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create.
			          NullEffect create. }
			finishingAfter: 2.		

	aSpaceShip1 := SpaceShip named: 'Danny'.
	aSpaceShip2 := SpaceShip named: 'Walter'.
	aSpaceShip3 := SpaceShip named: 'Juan'.
		aBoard usedBy: 	{
				         aSpaceShip1.
				         aSpaceShip2. aSpaceShip3 }.
	aSpaceShip1 fuel:20.
	aSpaceShip2 fuel:20.
	aSpaceShip3 fuel:20.
	aSpaceShip1 movePositionBy: 6 lapBy: 0  neededFuel: 6 .
	aSpaceShip2 movePositionBy: 6 lapBy: 0  neededFuel: 6 .
	aSpaceShip3 movePositionBy: 5 lapBy: 0  neededFuel: 5 .
	self assert: aSpaceShip1 position equals: 7.
	self assert: aSpaceShip2 position equals: 7.
	self assert: aSpaceShip3 position equals: 6.
	aHyperJumpEffect of:{3. 2. 1.}.
	aHyperJumpEffect triggeredBy: aSpaceShip1  on: aBoard.
	aHyperJumpEffect triggeredBy: aSpaceShip2  on: aBoard.
	aHyperJumpEffect triggeredBy: aSpaceShip3  on: aBoard.
	self assert: aSpaceShip1 position equals: 9.
	self assert: aSpaceShip2 position equals: 8.
	self assert: aSpaceShip3 position equals: 6.
]