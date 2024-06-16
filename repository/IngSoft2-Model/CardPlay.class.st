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

{ #category : #'as yet unclassified' }
CardPlay class >> with:aCard appliedTo:aTarget by:aSpaceship [

^self new initializeWith:aCard appliedTo:aTarget by:aSpaceship.
]

{ #category : #initialization }
CardPlay >> card [
^card

]

{ #category : #initialization }
CardPlay >> initializeWith:aCard appliedTo:aTarget by:aSpaceship [

card:=aCard.
target:=aTarget.
playedBy:=aSpaceship.
]

{ #category : #initialization }
CardPlay >> playedBy [
^playedBy

]

{ #category : #initialization }
CardPlay >> target [
^target

]
