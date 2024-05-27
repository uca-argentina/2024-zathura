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

	| aHyperGravityTile aDie1|
	self
		should: [ 	
		aDie1 := LoadedDie of: 4.	
		aHyperGravityTile := HyperGravityEffect needsToThrow: 6 below: aDie1 maxRoll. ]
		raise: Error
		withMessage: 	'The number needed to escape hypergravity cannot be greater than the maximum roll of the dice.'

]

{ #category : #tests }
HyperGravityEffectTest >> testAShipCannotRollANumberDifferentThanTheOneOfHyperGravityEffect [

	| aHyperGravityTile aSpaceShip aBoard aDie1 aDie2|
	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 4.	
	aHyperGravityTile := HyperGravityEffect needsToThrow: 4 below: aDie2 maxRoll.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create. }
			finishingAfter: 2
			withDistance: 10.		
	aSpaceShip := SpaceShip named: 'Danny'.
	aHyperGravityTile triggeredBy: aSpaceShip on:aBoard.
	self assert: (aSpaceShip rollDiceUsing: aDie1) equals: 0.
	self assert: (aSpaceShip rollDiceUsing: aDie2) equals: 4.
]
