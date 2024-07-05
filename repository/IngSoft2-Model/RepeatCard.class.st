Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
RepeatCard >> uses: cardPlayResolver [

	cardPlayResolver resolveARepeatCardPlay:self
]
