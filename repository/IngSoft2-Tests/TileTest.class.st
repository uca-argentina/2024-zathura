Class {
	#name : #TileTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TileTest >> testCanAddAnotherSpaceship [

| aTile |
aTile:= Tile create.
aTile addSpaceshipToTile: 'Danny'.
self assert:(aTile anySpaceship)
]

{ #category : #tests }
TileTest >> testIsInavlidWhenThereAreNoSpaceshipsAtATile [

| aTile |
aTile:= Tile create.
self deny:(aTile anySpaceship).
]

{ #category : #tests }
TileTest >> testIsValidWhenThereIsASpaceshipAtATile [
| aTile |
aTile:= Tile create.
aTile addSpaceshipToTile: 'Danny'.
self assert:(aTile isSpaceshipAtTile: 'Danny').
self deny:(aTile isSpaceshipAtTile: 'Walter').
]

{ #category : #tests }
TileTest >> testRemoveASpaceship [
| aTile |
aTile:= Tile create.
aTile addSpaceshipToTile: 'Danny'.
aTile addSpaceshipToTile: 'Walter'.
self assert:(aTile anySpaceship).
aTile removeSpaceshipFromTiles: 'Danny'.
self assert:(aTile anySpaceship).
aTile removeSpaceshipFromTiles: 'Walter'.
self deny:(aTile anySpaceship).
]
