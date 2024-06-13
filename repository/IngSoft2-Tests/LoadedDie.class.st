Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'rollSequence',
		'currentRollIndex'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDie class >> isValid: aDiceSequence [
	(aDiceSequence isKindOf: Array)
	ifTrue: [(aDiceSequence detect: [ :roll|roll<1 ] ifNone:[nil])
		ifNotNil:[
		Error signal: 'No roll can be lower than 1' ]]
	ifFalse: [ aDiceSequence<1 
		ifTrue:[
			Error signal: 'No roll can be lower than 1' ]]
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

{ #category : #initialization }
LoadedDie >> maxRoll [

^rollSequence max.
]

{ #category : #initialization }
LoadedDie >> nextRollIndex [ 
    currentRollIndex := currentRollIndex < rollSequence size
                       ifTrue: [ currentRollIndex + 1 ]
                       ifFalse: [ 1 ].
    ^ currentRollIndex
]

{ #category : #initialization }
LoadedDie >> roll [
	(rollSequence isKindOf: Array)
		ifTrue:[^ rollSequence at: self nextRollIndex]
		ifFalse:[^rollSequence]
]
