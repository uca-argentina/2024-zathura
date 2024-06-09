Class {
	#name : #HyperGravityEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
HyperGravityEffectTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
HyperGravityEffectTest >> testAHyperGravityTileRaisesAnErrorWhenAssignedABiggerNumberThanMaxRoll [

	| aHyperGravityTile aDie1 |
	self
		should: [
			aDie1 := LoadedDie of: 4.
			aHyperGravityTile := HyperGravity
				                     needsToThrow: 6
				                     above: aDie1 minRoll
				                     below: aDie1 maxRoll ]
		raise: Error
		withMessage:
		'The number needed to escape hypergravity cannot be lower than the minimum roll of the dice or greater than the maximum roll of the dice.'
]

{ #category : #tests }
HyperGravityEffectTest >> testAShipCannotMoveUntilItThrowsACertainNumber [

	| aHyperGravityTile aSpaceShip aBoard aDie1 |
	aDie1 := SequenceDie of: { 4. 3 }.
	aHyperGravityTile := HyperGravity
		                     needsToThrow: 4
		                     above: aDie1 minRoll
		                     below: aDie1 maxRoll.
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
		          withDistance: 10.
	aSpaceShip := SpaceShip named: 'Danny'.
	aSpaceShip fuel: 20.
	aHyperGravityTile triggeredBy: aSpaceShip on: aBoard.
	self assert: aSpaceShip position equals: 1.
	aSpaceShip movePositionBy: 1 lapBy: 0 neededFuel: 1.
	self assert: aSpaceShip position equals: 1.
	self assert: aSpaceShip lap equals: 1.
	aSpaceShip movePositionBy: 5 lapBy: 1 neededFuel: 1.
	self assert: aSpaceShip position equals: 1.
	self assert: aSpaceShip lap equals: 1.
	aSpaceShip rollDiceUsing: aDie1.
	aSpaceShip movePositionBy: 1 lapBy: 0 neededFuel: 1.
	self assert: aSpaceShip position equals: 2.
	self assert: aSpaceShip lap equals: 1.
	aSpaceShip movePositionBy: 5 lapBy: 1 neededFuel: 1.
	self assert: aSpaceShip position equals: 7.
	self assert: aSpaceShip lap equals: 2
]

{ #category : #tests }
HyperGravityEffectTest >> testAShipThatIsAffectedByHyperGravityEffectCannotMoveByTheResulOfOtherEffects [

	| aHyperGravityTile anAtomicBombEffect aSpaceShip1 aSpaceShip2 aSpaceShip3 aBoard aDie1 |
	aDie1 := SequenceDie of: { 3. 4 }.
	aHyperGravityTile := HyperGravity
		                     needsToThrow: 4
		                     above: aDie1 minRoll
		                     below: aDie1 maxRoll.
	anAtomicBombEffect := AtomicBomb new.
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
		          withDistance: 10.

	aSpaceShip1 := SpaceShip named: 'Danny'.
	aSpaceShip1 fuel: 20.
	aSpaceShip2 := SpaceShip named: 'Walter'.
	aSpaceShip2 fuel: 20.
	aSpaceShip3 := SpaceShip named: 'Joseph'.
	aSpaceShip3 fuel: 20.
	aBoard usedBy: {
			aSpaceShip1.
			aSpaceShip2.
			aSpaceShip3 } asOrderedCollection.
	aSpaceShip1 movePositionBy: 5 lapBy: 0 neededFuel: 5.
	aSpaceShip3 movePositionBy: 7 lapBy: 0 neededFuel: 7.
	self assert: aSpaceShip1 position equals: 6.
	self assert: aSpaceShip3 position equals: 8.
	aHyperGravityTile triggeredBy: aSpaceShip1 on: aBoard.
	anAtomicBombEffect triggeredBy: aSpaceShip2 on: aBoard.
	self assert: aSpaceShip1 position equals: 6.
	self assert: aSpaceShip3 position equals: 1
]
