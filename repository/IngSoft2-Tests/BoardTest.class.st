Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardTilesSizeEqualsTilesCollectionInTestSize [

| aTile1 aTile2 tiles aBoard |
aTile1:=Tile new.
aTile2:=Tile new.
tiles:={aTile1. aTile2.}.

aBoard:=Board ofTiles: tiles.

self assert: aBoard tiles size equals: tiles size.
]

{ #category : #tests }
BoardTest >> testTileIndexIsCorrect [

| firstTile secondTile tiles board |
firstTile:=Tile new.
secondTile:=Tile new.

tiles:={firstTile. secondTile.}.

board:=Board ofTiles:tiles.

self assert:(board tileNumber:1) equals: firstTile.
self assert:(board tileNumber:2) equals:secondTile.
]

{ #category : #tests }
BoardTest >> testTileIndexIsWrong [

| firstTile secondTile tiles board |
firstTile:=Tile new.
secondTile:=Tile new.

tiles:={firstTile. secondTile.}.

board:=Board ofTiles:tiles.

self deny:(board tileNumber:1) equals: secondTile.
self deny:(board tileNumber:2) equals: firstTile.
]
