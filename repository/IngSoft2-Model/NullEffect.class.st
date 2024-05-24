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

{ #category : #playing }
NullEffect >> triggeredBy: aPlayer on:aBoard [

	aPlayer movePositionBy:0 lapBy:0  neededFuel: 0.
]
