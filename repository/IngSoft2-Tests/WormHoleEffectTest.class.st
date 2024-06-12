Class {
	#name : #WormHoleEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormHoleEffectTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: aErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #running }
WormHoleEffectTest >> testWormholeEffectCannotBeCreatedIfThereIsOnlyOneWormhole [

	self
		should: [ Wormhole betweenTiles: { 2 } ]
		raise: Error
		withMessage: 'Cannot create a single wormhole'
]

{ #category : #running }
WormHoleEffectTest >> testWormholeEffectMovesAShipBackwards [

	| aWormHoleTile1 aWormHoleTile2 aSpaceShip aBoard |
	aWormHoleTile1 := Wormhole betweenTiles: { 2. 7 }.
	aWormHoleTile2 := Wormhole betweenTiles: { 7. 2 }.
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
	aSpaceShip := SpaceShip named: 'Danny'.
	aSpaceShip fuel: 20.
	aSpaceShip movePositionBy: 6 lapBy: 0 neededFuel: 6.
	aWormHoleTile2 triggeredBy: aSpaceShip on: aBoard.
	self assert: aSpaceShip position equals: 2
]

{ #category : #running }
WormHoleEffectTest >> testWormholeEffectMovesAShipFoward [

	| aWormHoleTile1 aWormHoleTile2 aSpaceShip aBoard |
	aWormHoleTile1 := Wormhole betweenTiles: { 2. 5 }.
	aWormHoleTile2 := Wormhole betweenTiles: { 5. 2 }.
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
	aSpaceShip := SpaceShip named: 'Danny'.
	aSpaceShip fuel: 20.
	aSpaceShip movePositionBy: 1 lapBy: 0 neededFuel: 1.
	aWormHoleTile1 triggeredBy: aSpaceShip on: aBoard.
	self assert: aSpaceShip position equals: 5.
	self assert: aSpaceShip position equals: 5
]
