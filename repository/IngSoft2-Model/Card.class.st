Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
Card >> uses: cardPlayResolver [

	self subclassResponsibility
]
