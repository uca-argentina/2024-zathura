Class {
	#name : #NullEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initializing }
NullEffect class >> create [

	^ self new initializeOf: OrderedCollection new.
]

{ #category : #initialization }
NullEffect >> initializeOf: aCollection [

	
]

{ #category : #'as yet unclassified' }
NullEffect >> triggeredBy: aPlayer [

	aPlayer moveBy: 0
]
