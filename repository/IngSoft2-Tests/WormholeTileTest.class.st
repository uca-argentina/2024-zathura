Class {
	#name : #WormholeTileTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
WormholeTileTest >> testIsValidWhenWormHoleHasALinkedTile [
| aWormHoleTile1 aWormHoleTile2|
aWormHoleTile1:=WormholeTile create.
aWormHoleTile2:= WormholeTile create.
aWormHoleTile1 linkATileToTheWormhole: aWormHoleTile2.
self assert:(aWormHoleTile1 tileLinkedToWormhole )equals: aWormHoleTile2.
]

{ #category : #'as yet unclassified' }
WormholeTileTest >> testIsValidWhenWormHoleIsConnected [
| aWormHoleTile1 aWormHoleTile2|
aWormHoleTile1:=WormholeTile create.
aWormHoleTile2:= WormholeTile create.
aWormHoleTile1 linkATileToTheWormhole: aWormHoleTile2.
aWormHoleTile2 linkATileToTheWormhole: aWormHoleTile1.
aWormHoleTile1 addSpaceshipToTile: 'Danny'.
self assert:(aWormHoleTile2 isSpaceshipAtTile: 'Danny').
self deny:(aWormHoleTile1 isSpaceshipAtTile: 'Walter').
aWormHoleTile2 removeSpaceshipFromTiles: 'Danny'.
self deny:(aWormHoleTile2 isSpaceshipAtTile: 'Danny').
]
