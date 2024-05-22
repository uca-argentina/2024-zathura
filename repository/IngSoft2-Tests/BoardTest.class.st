Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardTilesSizeEqualsTilesCollectionInTestSize [

| aTile1 aTile2 tiles aBoard |
aTile1:=Tile create.
aTile2:=Tile create.
tiles:={aTile1. aTile2.}.

aBoard:=Board of: tiles.

self assert: aBoard tiles size equals: tiles size.
]

{ #category : #tests }
BoardTest >> testIsValidWhenSpaceshipAtSecondTile [

| firstTile secondTile tiles board |
firstTile:=Tile create.
secondTile:=Tile create.

tiles:={firstTile. secondTile.}.
board:=Board of:tiles.
board add: 'Danny' to:1. 
board add: 'Walter' to:2. 
self assert:(board positionOf: 'Walter' ) equals: 2.
self assert:(board positionOf: 'Danny' ) equals: 1.
]

{ #category : #tests }
BoardTest >> testSpaceshipIsAtSecondTile [

| firstTile secondTile tiles board |
firstTile:=Tile create.
secondTile:=Tile create.

tiles:={firstTile. secondTile.}.

board:=Board of:tiles.




self assert:(board tiles at:1) equals: firstTile.
self assert:(board tiles at:2) equals:secondTile.
]

{ #category : #tests }
BoardTest >> testStartPlayingWithTwoSpaceships [

| firstTile secondTile tiles board |
firstTile:=Tile create.
secondTile:=Tile create.

tiles:={firstTile. secondTile.}.

board:=Board of:tiles.
self deny:(firstTile anySpaceship ).
self deny:(secondTile anySpaceship ).
board add: 'Danny' to:1. 
board add: 'Walter' to:1. 
self assert:(firstTile anySpaceship ).
self deny:(secondTile anySpaceship).
]

{ #category : #tests }
BoardTest >> testTileIndexIsCorrect [

| firstTile secondTile tiles board |
firstTile:=Tile create.
secondTile:=Tile create.

tiles:={firstTile. secondTile.}.

board:=Board of:tiles.

self assert:(board tiles at:1) equals: firstTile.
self assert:(board tiles at:2) equals:secondTile.
]

{ #category : #tests }
BoardTest >> testTileIndexIsWrong [

| firstTile secondTile tiles board |
firstTile:=Tile create.
secondTile:=Tile create.

tiles:={firstTile. secondTile.}.

board:=Board of:tiles.

self deny:(board tiles at:1) equals: secondTile.
self deny:(board tiles at:2) equals: firstTile.
]
