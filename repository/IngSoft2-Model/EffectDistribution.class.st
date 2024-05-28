Class {
	#name : #EffectDistribution,
	#superclass : #Object,
	#instVars : [
		'effectDistributionCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
EffectDistribution class >> assertSumOfProbabilitiesEqualsToOne: probabilityTileList [

	(probabilityTileList
		 inject: 0
		 into: [ :initial :probabilityTile |
		 initial + probabilityTile probability ]) = 1 ifFalse: [
		Error signal: 'The sum of the probabilities must be equal to 1!' ]
]

{ #category : #'instance creation' }
EffectDistribution class >> with: probabilityTileList [

	self assertSumOfProbabilitiesEqualsToOne: probabilityTileList.

	^ self new initializeWith: probabilityTileList
]

{ #category : #initialization }
EffectDistribution >> initializeWith: probabilityTileList [

	effectDistributionCollection := OrderedCollection new.

	probabilityTileList do: [ :probabilityTile |
		(probabilityTile probability * 100) asInteger timesRepeat: [
			effectDistributionCollection add: probabilityTile effect ] ]
]

{ #category : #creating }
EffectDistribution >> randomCollectionWith: length [

	| randomCollection |
	randomCollection := OrderedCollection new.

	length timesRepeat: [ randomCollection add: self randomEffect ].

	^ randomCollection
]

{ #category : #accessing }
EffectDistribution >> randomEffect [

	^ effectDistributionCollection atRandom
]
