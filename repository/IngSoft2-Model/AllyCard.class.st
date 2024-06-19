Class {
	#name : #AllyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
AllyCard >> playedBy: aSpaceship targetting: anotherSpaceship [

	^ CardPlay with: self appliedTo: anotherSpaceship by: aSpaceship
]

{ #category : #delegating }
AllyCard >> uses: cardPlayResolver [

	^ cardPlayResolver resolveAnAllyCardPlay
]
