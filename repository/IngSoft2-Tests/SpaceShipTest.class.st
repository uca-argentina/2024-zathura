Class {
	#name : #SpaceShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
SpaceShipTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should:anErrorBlock raise:anErrorClass withExceptionDo:[:error|self assert:error messageText equals:anErrorMessage].
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCanBeCreatedWithAName [
	| aSpaceShip |
	aSpaceShip:= SpaceShip named:'Danny'.
	self assert:(aSpaceShip nameGetter) equals: 'Danny'.
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCanMoveBackwards [
	| aSpaceShip |
	aSpaceShip:= SpaceShip named:'Danny'.
	aSpaceShip moveBy: 5.
	aSpaceShip moveBy: -2.
	self assert:(aSpaceShip getPosition ) equals: 4.
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCannotBeCreatedWithoutAName [
	|aName|
	aName:=''.
	self
		should: [ SpaceShip named: aName]
		raise: Error
		withMessage: 'Ship cant be created without a name'
]

{ #category : #running }
SpaceShipTest >> testASpaceshipIsMovedOnePosition [
	| aSpaceShip |
	aSpaceShip:= SpaceShip named:'Danny'.
	aSpaceShip moveBy: 1.
	self assert:(aSpaceShip getPosition ) equals: 2.
	
]
