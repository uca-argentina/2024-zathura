Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Card >> playedBy: aSpaceship targetting: anotherObject [

	self subclassResponsibility
]

{ #category : #delegating }
Card >> uses: cardPlayResolver [

	self subclassResponsibility
]
