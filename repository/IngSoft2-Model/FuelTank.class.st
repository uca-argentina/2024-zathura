Class {
	#name : #FuelTank,
	#superclass : #Object,
	#instVars : [
		'maxFuel',
		'currentFuel'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FuelTank class >> withMaxFuel: anAmountOfFuel [

	^ self new initializeWithMaxFuel: anAmountOfFuel
]

{ #category : #accessing }
FuelTank >> currentFuel [

	^ currentFuel
]

{ #category : #playing }
FuelTank >> decreaseFuelBy: amount [

	currentFuel := currentFuel - amount
]

{ #category : #testing }
FuelTank >> fuel: anAmountOfFuel [

	currentFuel := anAmountOfFuel
]

{ #category : #playing }
FuelTank >> increaseMaxFuelByOne [

	maxFuel := maxFuel + 1
]

{ #category : #initialization }
FuelTank >> initializeWithMaxFuel: anAmountOfFuel [

	maxFuel := anAmountOfFuel.
	currentFuel := anAmountOfFuel
]

{ #category : #asserting }
FuelTank >> isEmpty [

	^ currentFuel < 0
]

{ #category : #accessing }
FuelTank >> maxFuel [

	^ maxFuel
]

{ #category : #playing }
FuelTank >> refuelToMax [

	currentFuel := maxFuel
]
