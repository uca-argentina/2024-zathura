Class {
	#name : #DiceRoller,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceRoller class >> hasValidNumberOfDice: dice [

	dice size < 2 ifTrue: [
		Error signal: 'A DiceRoller must have more than one die' ]
]

{ #category : #'instance creation' }
DiceRoller class >> of: dice [

	self hasValidNumberOfDice: dice.

	^ self new initializeOf: dice
]

{ #category : #initialization }
DiceRoller >> initializeOf: aDice [

	dice := aDice
]

{ #category : #accessing }
DiceRoller >> maxRoll [

^dice sum: [ :die | die maxRoll ]
]

{ #category : #rolling }
DiceRoller >> roll [

	^ dice sum: [ :die | die roll ]
]
