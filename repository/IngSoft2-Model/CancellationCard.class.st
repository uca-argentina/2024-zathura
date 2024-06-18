Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
CancellationCard >> playedBy: aSpaceship targetting: aCard [

	^ CardPlay with: self appliedTo: aCard by: aSpaceship
]

{ #category : #delegating }
CancellationCard >> uses: cardPlayResolver [

	^ cardPlayResolver resolveACancellationCardPlay
]
