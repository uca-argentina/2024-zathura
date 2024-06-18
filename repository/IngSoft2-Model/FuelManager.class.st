Class {
	#name : #FuelManager,
	#superclass : #Object,
	#instVars : [
		'maxFuel',
		'currentFuel'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
FuelManager class >> withMaxFuel: anAmountOfFuel [
	^ self new initializeWithMaxFuel: anAmountOfFuel .
]

{ #category : #initialization }
FuelManager >> IncreaseMaxFuelByOne [
	maxFuel :=maxFuel +1.
]

{ #category : #initialization }
FuelManager >> currentFuel [ 
        ^currentFuel.
]

{ #category : #initialization }
FuelManager >> decreaseFuelBy: amount [ 
        currentFuel := currentFuel - amount.
]

{ #category : #initialization }
FuelManager >> fuel: anAmountOfFuel [
	currentFuel :=anAmountOfFuel.
]

{ #category : #initialization }
FuelManager >> increaseMaxFuelByOne [
	maxFuel :=maxFuel +1.
]

{ #category : #initialization }
FuelManager >> initializeWithMaxFuel: anAmountOfFuel [

	maxFuel := anAmountOfFuel.
	currentFuel := anAmountOfFuel.
]

{ #category : #initialization }
FuelManager >> isEmpty [ 
        ^currentFuel < 0.
]

{ #category : #initialization }
FuelManager >> maxFuel [
        ^maxFuel.
]

{ #category : #initialization }
FuelManager >> refuelToMax [ 
        currentFuel := maxFuel.
]
