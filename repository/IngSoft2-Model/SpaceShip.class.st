Class {
	#name : #SpaceShip,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
SpaceShip class >> assertValidNameFor: aName [

	aName isEmpty ifTrue: [
		Error signal: 'Ship cant be created without a name' ]
]

{ #category : #'instance creation' }
SpaceShip class >> named: aName [

	self assertValidNameFor: aName.
	^ self new initialize: aName
]

{ #category : #initialization }
SpaceShip >> initialize: aName [

	name := aName.
	position := 1
]

{ #category : #'as yet unclassified' }
SpaceShip >> moveBy: aNumber [

	position := position + aNumber
]

{ #category : #'as yet unclassified' }
SpaceShip >> name [

	^ name
]

{ #category : #'accessing - arguments' }
SpaceShip >> position [

	^ position
]
