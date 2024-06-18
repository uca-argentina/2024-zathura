Class {
	#name : #FuelManager,
	#superclass : #Object,
	#instVars : [
		'maxFuel',
		'currentFuel'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FuelManager class >> withMaxFuel: anAmountOfFuel [

	^ self new initializeWithMaxFuel: anAmountOfFuel
]

{ #category : #accessing }
FuelManager >> currentFuel [

	^ currentFuel

]

{ #category : #playing }
FuelManager >> decreaseFuelBy: amount [

	currentFuel := currentFuel - amount
]

{ #category : #testing }
FuelManager >> fuel: anAmountOfFuel [

	currentFuel := anAmountOfFuel
]

{ #category : #playing }
FuelManager >> increaseMaxFuelByOne [

	maxFuel := maxFuel + 1
]

{ #category : #initialization }
FuelManager >> initializeWithMaxFuel: anAmountOfFuel [

	maxFuel := anAmountOfFuel.
	currentFuel := anAmountOfFuel
]

{ #category : #asserting }
FuelManager >> isEmpty [

	^ currentFuel < 0
]

{ #category : #accessing }
FuelManager >> maxFuel [

	^ maxFuel
]

{ #category : #playing }
FuelManager >> refuelToMax [

	currentFuel := maxFuel
]
