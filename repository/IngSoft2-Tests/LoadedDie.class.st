Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'rollSequence',
		'currentRollIndex'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LoadedDie class >> isValid: aDiceSequence [

	(aDiceSequence detect: [ :roll | roll < 1 ] ifNone: [ nil ])
		ifNotNil: [ Error signal: 'No roll can be lower than 1' ]
]

{ #category : #'instance creation' }
LoadedDie class >> of: rollValues [


	self isValid: rollValues.
	^ self new initializeOf: rollValues
]

{ #category : #initialization }
LoadedDie >> initializeOf: rollValues [

	rollSequence := rollValues.
	currentRollIndex := 0.
	^ self
]

{ #category : #accessing }
LoadedDie >> maxRoll [

	^ rollSequence max
]

{ #category : #accessing }
LoadedDie >> nextRollIndex [

	currentRollIndex := currentRollIndex < rollSequence size
		                    ifTrue: [ currentRollIndex + 1 ]
		                    ifFalse: [ 1 ].
	^ currentRollIndex
]

{ #category : #playing }
LoadedDie >> roll [

	^ rollSequence at: self nextRollIndex
]
