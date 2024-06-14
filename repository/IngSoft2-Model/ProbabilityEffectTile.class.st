Class {
	#name : #ProbabilityEffectTile,
	#superclass : #Object,
	#instVars : [
		'effect',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ProbabilityEffectTile class >> assertProbabilityIsBetweenZeroAndOne: probability [

	(probability between: 0 and: 1) ifFalse: [
		Error signal: 'Probability must be between 0 and 1!' ]
]

{ #category : #'instance creation' }
ProbabilityEffectTile class >> with: effect and: probability [

	self assertProbabilityIsBetweenZeroAndOne: probability.

	^ self new initializeWith: effect and: probability
]

{ #category : #initialization }
ProbabilityEffectTile >> effect [

	^ effect
]

{ #category : #initialization }
ProbabilityEffectTile >> initializeWith: anEffect and: aProbability [

	effect := anEffect.
	probability := aProbability
]

{ #category : #initialization }
ProbabilityEffectTile >> probability [

	^ probability
]
