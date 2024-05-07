Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardTilesSizeEqualsTilesCollectionInTestSize [

| aTile1 aTile2 tiles aBoard |
aTile1:=Tile ofTiles.
aTile2:=Tile ofTiles.
tiles:={aTile1. aTile2.}.

aBoard:=Board ofTiles: tiles.

self assert: aBoard tiles size equals: tiles size.
]

{ #category : #tests }
BoardTest >> testIsValidWhenPlayerAtSecondTile [

| firstTile secondTile tiles board |
firstTile:=Tile ofTiles.
secondTile:=Tile ofTiles.

tiles:={firstTile. secondTile.}.
board:=Board ofTiles:tiles.
board addSpaceshipToATile: 'Danny' aTileNumber:1. 
board addSpaceshipToATile: 'Walter' aTileNumber:2. 
self assert:(board positionOf: 'Walter' ) equals: 2.
self assert:(board positionOf: 'Danny' ) equals: 1.
]

{ #category : #tests }
BoardTest >> testPlayerIsAtSecondTile [

| firstTile secondTile tiles board |
firstTile:=Tile ofTiles.
secondTile:=Tile ofTiles.

tiles:={firstTile. secondTile.}.

board:=Board ofTiles:tiles.




self assert:(board tileNumber:1) equals: firstTile.
self assert:(board tileNumber:2) equals:secondTile.
]

{ #category : #tests }
BoardTest >> testStartPlayingWithTwoPlayers [

| firstTile secondTile tiles board |
firstTile:=Tile ofTiles.
secondTile:=Tile ofTiles.

tiles:={firstTile. secondTile.}.

board:=Board ofTiles:tiles.
self deny:(firstTile anySpaceshipAtTile ).
self deny:(secondTile anySpaceshipAtTile ).
board addSpaceshipToATile: 'Danny' aTileNumber:1. 
board addSpaceshipToATile: 'Walter' aTileNumber:1. 
self assert:(firstTile anySpaceshipAtTile ).
self deny:(secondTile anySpaceshipAtTile ).
]

{ #category : #tests }
BoardTest >> testTileIndexIsCorrect [

| firstTile secondTile tiles board |
firstTile:=Tile ofTiles.
secondTile:=Tile ofTiles.

tiles:={firstTile. secondTile.}.

board:=Board ofTiles:tiles.

self assert:(board tileNumber:1) equals: firstTile.
self assert:(board tileNumber:2) equals:secondTile.
]

{ #category : #tests }
BoardTest >> testTileIndexIsWrong [

| firstTile secondTile tiles board |
firstTile:=Tile ofTiles.
secondTile:=Tile ofTiles.

tiles:={firstTile. secondTile.}.

board:=Board ofTiles:tiles.

self deny:(board tileNumber:1) equals: secondTile.
self deny:(board tileNumber:2) equals: firstTile.
]
