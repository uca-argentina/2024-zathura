Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
CancellationCard >> playedBy:aSpaceship targetting:aCard [
^CardPlay with:self appliedTo:aCard by:aSpaceship.

]

{ #category : #testing }
CancellationCard >> uses:cardPlayResolver [
^cardPlayResolver resolveACancellationCardPlay
]
