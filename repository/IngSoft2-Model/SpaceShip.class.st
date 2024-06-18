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
		'needsToThrow',
		'ally'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
SpaceShip class >> assertValidNameFor: aName [

	aName isEmpty ifTrue: [
		Error signal: 'Ship cant be created without a name' ]
]

{ #category : #'instance creation' }
SpaceShip class >> named: aName withMaxFuel: anAmount [

	self assertValidNameFor: aName.
	^ self new initialize: aName withMaxFuel:anAmount.
]

{ #category : #playing }
SpaceShip >> ally [
^ally
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
SpaceShip >> decreaseFuelBy: amountOfFuel [

	fuel:= fuel - amountOfFuel.
]

{ #category : #initialization }
SpaceShip >> fuel: amountOfFuel [

	maxFuel := amountOfFuel.
	fuel := amountOfFuel
]

{ #category : #initialization }
SpaceShip >> initialize: aName withMaxFuel: anAmount [

	name := aName.
	position := 1.
	lap := 1.
	turnsToLose := 0.
	needsToThrow := 0.
	maxFuel := anAmount .
	fuel:=anAmount .
	ally:=nil.
]

{ #category : #testing }
SpaceShip >> isAlliedWith:anotherSpaceship [

ally:=anotherSpaceship
]

{ #category : #'accessing - arguments' }
SpaceShip >> lap [

	^ lap
]

{ #category : #accessing }
SpaceShip >> losesTurns: amountOfTurns [

	turnsToLose := turnsToLose + amountOfTurns
]

{ #category : #playing }
SpaceShip >> maxFuel [
^maxFuel
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
			self ally ifNil:[	
			position := 1.
			fuel := maxFuel.
			self losesTurns: 2 ]
			ifNotNil:[
				ally decreaseFuelBy:fuel abs.
				fuel:=0.
				position := position + aNumber.
				lap := lap + quantityOfLapsToMove.
			]].
]

{ #category : #accessing }
SpaceShip >> name [

^name
]

{ #category : #'accessing - arguments' }
SpaceShip >> position [

	^ position
]

{ #category : #asserting }
SpaceShip >> rewardToMaxFuel [
	maxFuel:=maxFuel+1
]

{ #category : #accessing }
SpaceShip >> rollDiceUsing: aDiceRoller [

	| rolledNumber |
	rolledNumber := aDiceRoller roll.
	(needsToThrow = 0 or: [ rolledNumber = needsToThrow ]) ifTrue: [
		needsToThrow := 0 ].
	^ rolledNumber
]

{ #category : #playing }
SpaceShip >> skipTurn [

	self losesTurns: 1.
	fuel := maxFuel
]

{ #category : #abstract }
SpaceShip >> turnsToLose [

	^ turnsToLose
]
