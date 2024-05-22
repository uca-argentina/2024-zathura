Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardCannotMoveOutOfIndex [

| firstTile secondTile tiles board aSpaceShip|
firstTile:=NullEffect create.
secondTile:=NullEffect create.
aSpaceShip:=SpaceShip named:'Walter'.
tiles:={firstTile. secondTile.}.

board:=Board of:tiles.
board move:aSpaceShip by: 4.
self assert:(aSpaceShip getPosition ) equals: 2.
]

{ #category : #tests }
BoardTest >> testBoardTilesSizeEqualsTilesCollectionInTestSize [

| aTile1 aTile2 tiles aBoard |
aTile1:=NullEffect create.
aTile2:=NullEffect create.
tiles:={aTile1. aTile2.}.

aBoard:=Board of: tiles.

self assert: aBoard tilesLenght equals: tiles size.
]

{ #category : #tests }
BoardTest >> testBoardTracksSpaceshipPositions [

| firstTile secondTile tiles board spaceShip1 spaceShip2|
firstTile:=NullEffect create.
secondTile:=NullEffect create.
spaceShip1:=SpaceShip named:'Danny'.
spaceShip2:=SpaceShip named:'Walter'.
tiles:={firstTile. secondTile.}.
board:=Board of:tiles.
board move: spaceShip1 by:1.
self assert:(board positionOf: spaceShip1 ) equals: 2.
self assert:(board positionOf: spaceShip2) equals: 1.
]

{ #category : #tests }
BoardTest >> testTileIndexIsCorrectlyAssigned [

| firstTile secondTile tiles board |
firstTile:=NullEffect create.
secondTile:=NullEffect create.

tiles:={firstTile. secondTile.}.

board:=Board of:tiles.

self assert:(board tileNumber:1) equals: firstTile.
self assert:(board tileNumber:2) equals:secondTile.
]
