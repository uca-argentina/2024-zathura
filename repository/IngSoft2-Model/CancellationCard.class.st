Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
CancellationCard >> uses: cardPlayResolver [

	cardPlayResolver resolveACancellationCardPlay:self
]
