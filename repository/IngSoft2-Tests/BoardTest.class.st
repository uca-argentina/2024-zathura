Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardCannotMoveSpaceshipOutOfIndex [

	| firstTile secondTile tiles board aSpaceShip |
	firstTile := NullEffect create.
	secondTile := NullEffect create.
	aSpaceShip := SpaceShip named: 'Walter'.
	tiles := {
		         firstTile.
		         secondTile }.

	board := Board of: tiles finishingAfter:2.
	board move: aSpaceShip by: 4.
	self assert: aSpaceShip position equals: 2
]

{ #category : #tests }
BoardTest >> testBoardTracksSpaceshipPositions [

	| firstTile secondTile tiles board spaceShip1 spaceShip2 |
	firstTile := NullEffect create.
	secondTile := NullEffect create.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	tiles := {
		         firstTile.
		         secondTile }.
	board := Board of: tiles finishingAfter: 2.
	board move: spaceShip1 by: 1.
	self assert: (board positionOf: spaceShip1) equals: 2.
	self assert: (board positionOf: spaceShip2) equals: 1
]
