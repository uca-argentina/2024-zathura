Class {
	#name : #CardPlay,
	#superclass : #Object,
	#instVars : [
		'card',
		'target',
		'playedBy'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlay class >> with: aCard appliedTo: aTarget by: aSpaceship [

	^ self new initializeWith: aCard appliedTo: aTarget by: aSpaceship
]

{ #category : #accessing }
CardPlay >> card [

	^ card
]

{ #category : #initialization }
CardPlay >> initializeWith: aCard appliedTo: aTarget by: aSpaceship [

	card := aCard.
	target := aTarget.
	playedBy := aSpaceship
]

{ #category : #accessing }
CardPlay >> playedBy [

	^ playedBy
]

{ #category : #accessing }
CardPlay >> target [

	^ target
]
