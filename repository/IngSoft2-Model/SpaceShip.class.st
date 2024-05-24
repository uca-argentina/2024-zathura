Class {
	#name : #SpaceShip,
	#superclass : #Object,
	#instVars : [
		'name',
		'position',
		'lap',
		'fuel',
		'maxFuel',
		'turnsToLose'
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

{ #category : #initialization }
SpaceShip >> initialize: aName [

	name := aName.
	position := 1.
	lap:=1.
	turnsToLose:=0.
]

{ #category : #'accessing - arguments' }
SpaceShip >> lap [

	^ lap
]

{ #category : #'as yet unclassified' }
SpaceShip >> losesTurns:amountOfTurns [

turnsToLose:=amountOfTurns.
]

{ #category : #accessing }
SpaceShip >> maxFuel [ 

^maxFuel
]

{ #category : #playing }
SpaceShip >> moveBy: aNumber [

	position := position + aNumber
]

{ #category : #playing }
SpaceShip >> movePositionBy: aNumber lapBy:quantityOfLapsToMove neededFuel:aFuelAmount [
	fuel:=fuel-aFuelAmount.
	fuel > 0
    ifTrue: [
        position := position + aNumber.
        lap := lap + quantityOfLapsToMove.
    ]
    ifFalse: [
		position:=1 .
		lap := lap + quantityOfLapsToMove.
		fuel:=maxFuel .
		self losesTurns: 2.
    ].
	
	
]

{ #category : #accessing }
SpaceShip >> name [

	^ name
]

{ #category : #'accessing - arguments' }
SpaceShip >> position [

	^ position
]

{ #category : #'as yet unclassified' }
SpaceShip >> turnsToLose [ 

^turnsToLose.
]

{ #category : #'as yet unclassified' }
SpaceShip >> wantsToSkipTurn [

turnsToLose:=self turnsToLose+1.
fuel:=maxFuel.
]
