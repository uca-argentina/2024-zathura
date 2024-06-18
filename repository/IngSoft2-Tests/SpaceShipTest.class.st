Class {
	#name : #SpaceShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceShipTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCanBeCreatedWithAName [

	| aSpaceShip |
	aSpaceShip := SpaceShip named: 'Danny' withMaxFuel:10.
	self assert: aSpaceShip name equals: 'Danny'
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCanBeCreatedWithFuel [

	| aSpaceShip |
	aSpaceShip := SpaceShip named: 'Danny' withMaxFuel:10.
	self assert: aSpaceShip currentFuel equals: 10
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCanMoveBackwards [

	| aSpaceShip |
	aSpaceShip := SpaceShip named: 'Danny' withMaxFuel:10.
	aSpaceShip movePositionBy: 5 lapBy: 0 neededFuel: 0.
	aSpaceShip movePositionBy: -2 lapBy: 0 neededFuel: 0.

	self assert: aSpaceShip position equals: 4
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCannotBeCreatedWithoutAName [

	| aName |
	aName := ''.
	self
		should: [ SpaceShip named: aName withMaxFuel:10]
		raise: Error
		withMessage: 'Ship cant be created without a name'
]

{ #category : #running }
SpaceShipTest >> testASpaceshipIsMovedOnePosition [

	| aSpaceShip |
	aSpaceShip := SpaceShip named: 'Danny' withMaxFuel:10.
	aSpaceShip movePositionBy: 1 lapBy: 0 neededFuel: 1.
	self assert: aSpaceShip position equals: 2
]

{ #category : #running }
SpaceShipTest >> testLostTurnsCanBeStacked [

	| aSpaceShip |
	aSpaceShip := SpaceShip named: 'Danny' withMaxFuel:10.
	self assert: aSpaceShip turnsToLose equals: 0.
	aSpaceShip losesTurns: 2.
	self assert: aSpaceShip turnsToLose equals: 2.
	aSpaceShip losesTurns: 3.
	self assert: aSpaceShip turnsToLose equals: 5
]
