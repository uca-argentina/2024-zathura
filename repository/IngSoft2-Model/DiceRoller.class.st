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

{ #category : #initialization }
DiceRoller >> initializeOf: aDice [

dice:=aDice
]

{ #category : #rolling }
DiceRoller >> roll [

^dice sum:[:die|die throw]
]
