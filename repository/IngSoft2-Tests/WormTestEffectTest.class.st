Class {
	#name : #WormTestEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
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

	| aWormHoleTile1 aWormHoleTile2 aSpaceShip |
	aWormHoleTile1 := WormholeEffect betweenTiles: { 2. 7 }.
	aWormHoleTile2 := WormholeEffect betweenTiles: { 7. 2 }.
	aSpaceShip := SpaceShip named: 'Danny'.
	aSpaceShip moveBy: 6.
	aWormHoleTile2 triggeredBy: aSpaceShip.
	self assert: aSpaceShip position equals: 2
]

{ #category : #running }
WormTestEffectTest >> testWormholeEffectMovesAShipFoward [

	| aWormHoleTile1 aWormHoleTile2 aSpaceShip |
	aWormHoleTile1 := WormholeEffect betweenTiles: { 1. 5 }.
	aWormHoleTile2 := WormholeEffect betweenTiles: { 5. 1 }.
	aSpaceShip := SpaceShip named: 'Danny'.
	aWormHoleTile1 triggeredBy: aSpaceShip.
	self assert: aSpaceShip position equals: 5
]
