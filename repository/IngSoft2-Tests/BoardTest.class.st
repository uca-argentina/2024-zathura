Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithLessThan1Lap [

	self
		should: [
			Board
				of: {
						Null create.
						Null create.
						Null create }
				finishingAfter: -2
				withUnitsOfMeasurement: (Parsecs with:10) ]
		raise: Error
		withMessage: 'Game must have one or more laps!'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithNegativeParsecs [

	self
		should: [
			Board
				of: {
						Null create.
						Null create.
						Null create }
				finishingAfter: 3
				withUnitsOfMeasurement: (Parsecs with:-2) ]
		raise: Error
		withMessage: 'Parsecs cannot be a negative measure'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithOutTiles [

	self
		should: [ Board of: {  } finishingAfter: 2 withUnitsOfMeasurement: (Parsecs with:10) ]
		raise: Error
		withMessage: 'Tiles should be 2 or more'
]

{ #category : #tests }
BoardTest >> testBoardCannotMoveSpaceshipOutOfIndex [

	| firstTile secondTile tiles board aSpaceShip |
	firstTile := Null create.
	secondTile := Null create.
	aSpaceShip := SpaceShip named: 'Walter' withMaxFuel:12.
	tiles := {
		         firstTile.
		         secondTile }.

	board := Board of: tiles finishingAfter: 2 withUnitsOfMeasurement: (Parsecs with:10).
	board move: aSpaceShip by: 7.
	self assert: aSpaceShip lap equals: 3.
	self assert: aSpaceShip position equals: 1.
	self assert: aSpaceShip lap equals: 3
]

{ #category : #tests }
BoardTest >> testBoardTracksSpaceshipPositions [

	| firstTile secondTile tiles board spaceShip1 spaceShip2 |
	firstTile := Null create.
	secondTile := Null create.
	spaceShip1 := SpaceShip named: 'Danny' withMaxFuel:12.
	spaceShip2 := SpaceShip named: 'Walter' withMaxFuel:12.
	tiles := {
		         firstTile.
		         secondTile }.
	board := Board of: tiles finishingAfter: 2 withUnitsOfMeasurement: (Parsecs with:10).

	board move: spaceShip1 by: 1.
	self assert: (spaceShip1  lap )equals: 1.
	self assert: (board positionOf: spaceShip1) equals: 2.
	self assert: (board positionOf: spaceShip2) equals: 1
]
