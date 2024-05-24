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
	aSpaceShip := SpaceShip named: 'Danny'.
	self assert: aSpaceShip name equals: 'Danny'
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCanMoveBackwards [

	| aSpaceShip |
	aSpaceShip := SpaceShip named: 'Danny'.
	aSpaceShip fuel:10.
	aSpaceShip movePositionBy: 5 lapBy: 0 neededFuel:0. 
	aSpaceShip movePositionBy: -2 lapBy: 0 neededFuel:0.
	
	self assert: aSpaceShip position equals: 4
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCannotBeCreatedWithoutAName [

	| aName |
	aName := ''.
	self
		should: [ SpaceShip named: aName ]
		raise: Error
		withMessage: 'Ship cant be created without a name'
]

{ #category : #running }
SpaceShipTest >> testASpaceshipIsMovedOnePosition [

	| aSpaceShip |
	aSpaceShip := SpaceShip named: 'Danny'.
	aSpaceShip fuel:10.
	aSpaceShip movePositionBy: 1 lapBy: 0 neededFuel:1. 
	self assert: aSpaceShip position equals: 2
]
