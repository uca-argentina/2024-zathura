Class {
	#name : #WormholeTileTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
WormholeTileTest >> testIsValidWhenWormHoleHasALinkedTile [
| aWormHoleTile1 aWormHoleTile2|
aWormHoleTile1:=WormholeTile ofTiles.
aWormHoleTile2:= WormholeTile ofTiles.
aWormHoleTile1 linkATileToTheWormhole: aWormHoleTile2.
self assert:(aWormHoleTile1 tileLinkedToWormhole )equals: aWormHoleTile2.
]

{ #category : #'as yet unclassified' }
WormholeTileTest >> testIsValidWhenWormHoleIsConnected [
| aWormHoleTile1 aWormHoleTile2|
aWormHoleTile1:=WormholeTile ofTiles.
aWormHoleTile2:= WormholeTile ofTiles.
aWormHoleTile1 linkATileToTheWormhole: aWormHoleTile2.
aWormHoleTile2 linkATileToTheWormhole: aWormHoleTile1.
aWormHoleTile1 addPlayerToTile: 'Danny'.
self assert:(aWormHoleTile2 isPlayerAtTile: 'Danny').
self deny:(aWormHoleTile1 isPlayerAtTile: 'Walter').
aWormHoleTile2 removePlayerFromTiles: 'Danny'.
self deny:(aWormHoleTile2 isPlayerAtTile: 'Danny').
]
