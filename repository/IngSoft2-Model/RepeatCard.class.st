Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RepeatCard >> playedBy:aSpaceship targetting:anotherSpaceship [
^CardPlay with:self appliedTo:anotherSpaceship by:aSpaceship.
]

{ #category : #testing }
RepeatCard >> uses:cardPlayResolver [
^cardPlayResolver resolveARepeatCardPlay
]
