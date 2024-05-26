Class {
	#name : #HyperGravityEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
HyperGravityEffectTest >> testAShipCannotRollANumberDifferentThanTheOneOfHyperGravityEffect [

	| aHyperGravityTile aSpaceShip aBoard aDie1 aDie2|
	aHyperGravityTile := HyperGravityEffect needsToThrow: 4.
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
	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 4.			
	aSpaceShip := SpaceShip named: 'Danny'.
	aHyperGravityTile triggeredBy: aSpaceShip on:aBoard.
	self assert: (aSpaceShip rollDiceUsing: aDie1) equals: 0.
	self assert: (aSpaceShip rollDiceUsing: aDie2) equals: 4.
]
