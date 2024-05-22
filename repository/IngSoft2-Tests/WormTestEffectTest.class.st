Class {
	#name : #WormTestEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
WormTestEffectTest >> testWormholeEffectCannotBeCreatedIfThereIsOnlyOneWormhole [

	self
		should: [ WormholeEffect create: {2}]
		raise: Error
		withMessage: 'Cannot create a single wormhole'
]

{ #category : #running }
WormTestEffectTest >> testWormholeEffectMovesAShipBackwards [
| aWormHoleTile1 aWormHoleTile2 aSpaceShip|
aWormHoleTile1:=WormholeEffect create: {2. 7}.
aWormHoleTile2:= WormholeEffect create: {7. 2}.
aSpaceShip:= SpaceShip named:'Danny'. 
aSpaceShip moveBy: 6.
aWormHoleTile2 triggeredBy: aSpaceShip .
self assert:(aSpaceShip getPosition )equals: 2.
]

{ #category : #running }
WormTestEffectTest >> testWormholeEffectMovesAShipFoward [
| aWormHoleTile1 aWormHoleTile2 aSpaceShip|
aWormHoleTile1:=WormholeEffect create: {1. 5}.
aWormHoleTile2:= WormholeEffect create: {5. 1}.
aSpaceShip:= SpaceShip named:'Danny'. 
aWormHoleTile1 triggeredBy: aSpaceShip .
self assert:(aSpaceShip getPosition )equals: 5.
]
