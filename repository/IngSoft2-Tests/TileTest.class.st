Class {
	#name : #TileTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TileTest >> testCanAddAnotherPlayer [

| aTile |
aTile:= Tile ofTiles.
aTile addPlayerToTile: 'Danny'.
self assert:(aTile anyPlayerAtTile)
]

{ #category : #tests }
TileTest >> testIsInavlidWhenThereAreNoPlayersAtATile [

| aTile |
aTile:= Tile ofTiles.
self deny:(aTile anyPlayerAtTile).
]

{ #category : #tests }
TileTest >> testIsValidWhenThereIsAPlayerAtATile [
| aTile |
aTile:= Tile ofTiles.
aTile addPlayerToTile: 'Danny'.
self assert:(aTile isPlayerAtTile: 'Danny').
self deny:(aTile isPlayerAtTile: 'Walter').
]

{ #category : #tests }
TileTest >> testRemoveAPlayer [
| aTile |
aTile:= Tile ofTiles.
aTile addPlayerToTile: 'Danny'.
aTile addPlayerToTile: 'Walter'.
self assert:(aTile anyPlayerAtTile).
aTile removePlayerFromTiles: 'Danny'.
self assert:(aTile anyPlayerAtTile).
aTile removePlayerFromTiles: 'Walter'.
self deny:(aTile anyPlayerAtTile).
]
