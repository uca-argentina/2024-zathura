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
	^ self new
		  initializeSpaceShip: aName
]

{ #category : #initialization }
SpaceShip >> initializeSpaceShip: aName [
	name:=aName.
	position:=1.
]

{ #category : #'as yet unclassified' }
SpaceShip >> movePosition: aNumber [
	position :=  position + aNumber.
]

{ #category : #'as yet unclassified' }
SpaceShip >> nameGetter [
	^name
]
