Class {
	#name : #ProbabilityTile,
	#superclass : #Object,
	#instVars : [
		'effectDistributionCollection',
		'effect',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ProbabilityTile class >> assertProbabilityIsBetweenZeroAndOne: probability [

	(probability  between: 0 and: 1) ifFalse: [ 
			Error signal: 'Probability must be between 0 and 1!' ].
]

{ #category : #'as yet unclassified' }
ProbabilityTile class >> with: effect and: probability [
	
	self assertProbabilityIsBetweenZeroAndOne: probability.

	^ self new initializeWith: effect and: probability
]

{ #category : #initialization }
ProbabilityTile >> effect [

^effect

]

{ #category : #initialization }
ProbabilityTile >> initializeWith: anEffect and: aProbability [

	effect := anEffect.
	probability := aProbability

]

{ #category : #initialization }
ProbabilityTile >> probability [

^probability

]
