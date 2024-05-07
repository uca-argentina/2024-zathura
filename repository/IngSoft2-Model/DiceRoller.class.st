Class {
	#name : #DiceRoller,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceRoller class >> hasValidNumberOfTiles: dice [

	dice ifEmpty: [
		Error signal: 'A DiceRoller must have at least one die' ]
]

{ #category : #'instance creation' }
DiceRoller class >> of: dice [

	self hasValidNumberOfTiles: dice.

	^ self new initializeOf: dice
]

{ #category : #initialization }
DiceRoller >> initializeOf: aDice [

dice:=aDice
]

{ #category : #rolling }
DiceRoller >> roll [

^dice sum:[:die|die roll]
]
