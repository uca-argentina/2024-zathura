Class {
	#name : #Null,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #initializing }
Null class >> create [

	^ self new initializeOf: OrderedCollection new
]

{ #category : #initialization }
Null >> initializeOf: aCollection [

	
]

{ #category : #playing }
Null >> triggeredBy: aPlayer on: aBoard [

]
