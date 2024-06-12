Class {
	#name : #SequenceDie,
	#superclass : #Object,
	#instVars : [
		'rollSequence',
		'currentRollIndex'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
SequenceDie class >> of: rollValues [

	^ self new initializeOf: rollValues
]

{ #category : #initialization }
SequenceDie >> initializeOf: rollValues [
    rollSequence := rollValues.
    currentRollIndex := 0.
    ^ self
]

{ #category : #initialization }
SequenceDie >> maxRoll [

^rollSequence max.
]

{ #category : #initialization }
SequenceDie >> nextRollIndex [ 
    currentRollIndex := currentRollIndex < rollSequence size
                       ifTrue: [ currentRollIndex + 1 ]
                       ifFalse: [ 1 ].
    ^ currentRollIndex
]

{ #category : #initialization }
SequenceDie >> roll [
    ^ rollSequence at: self nextRollIndex
]
