Class {
	#name : #SpaceShip,
	#superclass : #Object,
	#instVars : [
		'name',
		'position',
		'lap',
		'fuel',
		'maxFuel',
		'turnsToLose',
		'needsToThrow'
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

{ #category : #accessing }
SpaceShip >> amountOfFuel [

	^ fuel
]

{ #category : #accessing }
SpaceShip >> changeRollingResultNeededToMove: aNumber [

	needsToThrow := aNumber
]

{ #category : #initialization }
SpaceShip >> fuel: amountOfFuel [

	maxFuel := amountOfFuel.
	fuel := amountOfFuel
]

{ #category : #initialization }
SpaceShip >> initialize: aName [

	name := aName.
	position := 1.
	lap := 1.
	turnsToLose := 0.
	needsToThrow := 0
]

{ #category : #'accessing - arguments' }
SpaceShip >> lap [

	^ lap
]

{ #category : #accessing }
SpaceShip >> losesTurns: amountOfTurns [

	turnsToLose := turnsToLose + amountOfTurns
]

{ #category : #accessing }
SpaceShip >> maxFuel [

	^ maxFuel
]

{ #category : #playing }
SpaceShip >> movePositionBy: aNumber lapBy: quantityOfLapsToMove neededFuel: aFuelAmount [

	needsToThrow = 0 ifFalse: [ ^ self ].
	fuel := fuel - aFuelAmount.
	fuel > 0
		ifTrue: [
			position := position + aNumber.
			lap := lap + quantityOfLapsToMove ]
		ifFalse: [
			position := 1.
			fuel := maxFuel.
			self losesTurns: 2 ]
]

{ #category : #accessing }
SpaceShip >> name [

	^ name
]

{ #category : #'accessing - arguments' }
SpaceShip >> position [

	^ position
]

{ #category : #accessing }
SpaceShip >> rollDiceUsing: aDiceRoller [

	| rolledNumber |
	rolledNumber := aDiceRoller roll.
	(needsToThrow = 0 or: [ rolledNumber = needsToThrow ]) ifTrue: [
		needsToThrow := 0 ].
	^ rolledNumber
]

{ #category : #abstract }
SpaceShip >> turnsToLose [

	^ turnsToLose
]

{ #category : #accessing }
SpaceShip >> wantsToSkipTurn [

	self losesTurns: 1.
	fuel := maxFuel
]
