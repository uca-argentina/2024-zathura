Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OverloadCard >> effect [

	^ -2
]

{ #category : #'as yet unclassified' }
OverloadCard >> playedBy:aSpaceship targetting:anotherSpaceship [
^CardPlay with:self appliedTo:anotherSpaceship by:aSpaceship.
]

{ #category : #visiting }
OverloadCard >> uses:cardPlayResolver [
^cardPlayResolver resolveAnOverloadCardPlay
]
