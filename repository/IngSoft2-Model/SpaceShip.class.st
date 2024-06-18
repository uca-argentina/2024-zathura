Class {
	#name : #SpaceShip,
	#superclass : #Object,
	#instVars : [
		'name',
		'position',
		'lap',
		'turnsToLose',
		'needsToThrow',
		'ally',
		'fuelTank'
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

	^ fuelTank currentFuel .
]

{ #category : #abstract }
SpaceShip >> applyPenaltyForEmptyFuelTank [

	position := 1.
	fuelTank refuelToMax .
	self losesTurns: 2
]

{ #category : #accessing }
SpaceShip >> changeRollingResultNeededToMove: aNumber [

	needsToThrow := aNumber
]

{ #category : #initialization }
SpaceShip >> decreaseFuelBy: amountOfFuel [

	fuelTank decreaseFuelBy: amountOfFuel .
]

{ #category : #playing }
SpaceShip >> handleAllyFuelForMovePositionBy: aNumber lapBy: quantityOfLapsToMove [
	ally amountOfFuel < self amountOfFuel abs
		ifTrue: [ 
			ally applyPenaltyForEmptyFuelTank.
			self applyPenaltyForEmptyFuelTank 
		] 
		ifFalse: [ 
			ally decreaseFuelBy: fuelTank currentFuel abs.
			fuelTank fuel:0.
			self moveToNextPositionBy: aNumber lapBy: quantityOfLapsToMove 
		].
]

{ #category : #playing }
SpaceShip >> handleEmptyFuelTankForMovePositionBy: aNumber lapBy: quantityOfLapsToMove [
	self ally ifNil: [ 
		self applyPenaltyForEmptyFuelTank 
	] ifNotNil: [ 
		self handleAllyFuelForMovePositionBy: aNumber lapBy: quantityOfLapsToMove 
	].
]

{ #category : #initialization }
SpaceShip >> initialize: aName withMaxFuel: anAmount [

	name := aName.
	position := 1.
	lap := 1.
	turnsToLose := 0.
	needsToThrow := 0.
	fuelTank:= FuelManager withMaxFuel: anAmount.
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
^fuelTank maxFuel 
]

{ #category : #playing }
SpaceShip >> movePositionBy: aNumber lapBy: quantityOfLapsToMove neededFuel: aFuelAmount [


	needsToThrow = 0 ifFalse: [ ^ self ].
	self decreaseFuelBy: aFuelAmount.
	
	fuelTank isEmpty
		ifTrue: [ 
			
			self handleEmptyFuelTankForMovePositionBy: aNumber lapBy: quantityOfLapsToMove
		] 
		ifFalse: [ 
			self moveToNextPositionBy: aNumber lapBy: quantityOfLapsToMove 
		].
]

{ #category : #playing }
SpaceShip >> moveToNextPositionBy: aNumber lapBy: quantityOfLapsToMove [
	position := position + aNumber.
	lap := lap + quantityOfLapsToMove.
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
	fuelTank increaseMaxFuelByOne.
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
	fuelTank refuelToMax.
]

{ #category : #abstract }
SpaceShip >> turnsToLose [

	^ turnsToLose
]
