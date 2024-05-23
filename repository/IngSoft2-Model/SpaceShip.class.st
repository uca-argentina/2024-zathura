Class {
	#name : #SpaceShip,
	#superclass : #Object,
	#instVars : [
		'name',
		'position',
		'lap',
		'fuel',
		'maxFuel'
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

{ #category : #'as yet unclassified' }
SpaceShip >> amountOfFuel [

^fuel
]

{ #category : #initialization }
SpaceShip >> fuel:amountOfFuel [

maxFuel:=amountOfFuel.
fuel:=amountOfFuel.
]

{ #category : #testing }
SpaceShip >> hasTileNumber:newPosition and:newLap with: newAmountOfFuel [

position:=newPosition.
lap:=newLap.
fuel:=newAmountOfFuel.


]

{ #category : #initialization }
SpaceShip >> initialize: aName [

	name := aName.
	position := 1.
	lap:=1.
]

{ #category : #'accessing - arguments' }
SpaceShip >> lap [

	^ lap
]

{ #category : #accessing }
SpaceShip >> maxFuel [ 

^maxFuel
]

{ #category : #playing }
SpaceShip >> moveBy: aNumber [

	position := position + aNumber
]

{ #category : #accessing }
SpaceShip >> name [

	^ name
]

{ #category : #'accessing - arguments' }
SpaceShip >> position [

	^ position
]
