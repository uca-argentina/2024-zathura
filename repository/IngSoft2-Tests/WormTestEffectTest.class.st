Class {
	#name : #WormTestEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormTestEffectTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: aErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #running }
WormTestEffectTest >> testWormholeEffectCannotBeCreatedIfThereIsOnlyOneWormhole [

	self
		should: [ WormholeEffect betweenTiles: { 2 } ]
		raise: Error
		withMessage: 'Cannot create a single wormhole'
]

{ #category : #running }
WormTestEffectTest >> testWormholeEffectMovesAShipBackwards [

	| aWormHoleTile1 aWormHoleTile2 aSpaceShip aBoard|
	aWormHoleTile1 := WormholeEffect betweenTiles: { 2. 7 }.
	aWormHoleTile2 := WormholeEffect betweenTiles: { 7. 2 }.
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
	aSpaceShip fuel:20.
	aSpaceShip movePositionBy: 6 lapBy: 0  neededFuel: 6 .
	aWormHoleTile2 triggeredBy: aSpaceShip on:aBoard.
	self assert: aSpaceShip position equals: 2
]

{ #category : #running }
WormTestEffectTest >> testWormholeEffectMovesAShipFoward [

	| aWormHoleTile1 aWormHoleTile2 aSpaceShip aBoard|
	aWormHoleTile1 := WormholeEffect betweenTiles: { 2. 5 }.
	aWormHoleTile2 := WormholeEffect betweenTiles: { 5. 2 }.
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
	aSpaceShip fuel:20.
	aSpaceShip movePositionBy: 1 lapBy: 0  neededFuel:1 .
	aWormHoleTile1 triggeredBy: aSpaceShip on:aBoard.
	self assert: aSpaceShip position equals: 5.
	self assert: aSpaceShip position equals: 5.
]
