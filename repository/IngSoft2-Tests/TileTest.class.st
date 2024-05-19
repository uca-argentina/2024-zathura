Class {
	#name : #TileTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TileTest >> testASpaceshipCanBeRemovedFromATile [
| aTile |
aTile:= Tile create.
aTile addSpaceshipToTile: 'Danny'.
aTile addSpaceshipToTile: 'Walter'.
self assert:(aTile anySpaceshipAtTile).
aTile removeSpaceshipFromTiles: 'Danny'.
self assert:(aTile anySpaceshipAtTile).
aTile removeSpaceshipFromTiles: 'Walter'.
self deny:(aTile anySpaceshipAtTile).
]

{ #category : #tests }
TileTest >> testASpaceshipIsCreatedWithoutAnyAssignedSpaceships [

| aTile |
aTile:= Tile create.
self deny:(aTile anySpaceshipAtTile).
]

{ #category : #tests }
TileTest >> testCanAssignASpaceshipToATile [

| aTile |
aTile:= Tile create.
aTile addSpaceshipToTile: 'Danny'.
self assert:(aTile anySpaceshipAtTile)
]
