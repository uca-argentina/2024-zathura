Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RedoCard >> playedBy:aSpaceship targetting:aCard [
^CardPlay with:self appliedTo:aCard by:aSpaceship.
]

{ #category : #testing }
RedoCard >> uses:cardPlayResolver [
^cardPlayResolver resolveARedoCardPlay
]
