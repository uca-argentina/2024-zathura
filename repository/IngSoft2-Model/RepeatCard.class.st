Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RepeatCard >> playedBy: aSpaceship targetting: anotherSpaceship [

	^ CardPlay with: self appliedTo: anotherSpaceship by: aSpaceship
]

{ #category : #delegating }
RepeatCard >> uses: cardPlayResolver [

	^ cardPlayResolver resolveARepeatCardPlay
]
