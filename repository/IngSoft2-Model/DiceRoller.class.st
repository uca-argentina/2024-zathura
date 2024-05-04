Class {
	#name : #DiceRoller,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceRoller class >> of: dice [

^self new initializeOf: dice
]

{ #category : #'as yet unclassified' }
DiceRoller >> initializeOf: aDice [

dice:=aDice
]

{ #category : #'as yet unclassified' }
DiceRoller >> roll [

^dice sum:[:die|die throw]
]
