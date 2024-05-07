Class {
	#name : #TileTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TileTest >> testCanAddAnotherPlayer [

| aTile |
aTile:= Tile ofTiles.
aTile addSpaceshipToTile: 'Danny'.
self assert:(aTile anySpaceshipAtTile)
]

{ #category : #tests }
TileTest >> testIsInavlidWhenThereAreNoPlayersAtATile [

| aTile |
aTile:= Tile ofTiles.
self deny:(aTile anySpaceshipAtTile).
]

{ #category : #tests }
TileTest >> testIsValidWhenThereIsAPlayerAtATile [
| aTile |
aTile:= Tile ofTiles.
aTile addSpaceshipToTile: 'Danny'.
self assert:(aTile isSpaceshipAtTile: 'Danny').
self deny:(aTile isSpaceshipAtTile: 'Walter').
]

{ #category : #tests }
TileTest >> testRemoveAPlayer [
| aTile |
aTile:= Tile ofTiles.
aTile addSpaceshipToTile: 'Danny'.
aTile addSpaceshipToTile: 'Walter'.
self assert:(aTile anySpaceshipAtTile).
aTile removeSpaceshipFromTiles: 'Danny'.
self assert:(aTile anySpaceshipAtTile).
aTile removeSpaceshipFromTiles: 'Walter'.
self deny:(aTile anySpaceshipAtTile).
]
