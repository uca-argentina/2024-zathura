Class {
	#name : #Null,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Null class >> create [

	^ self new initializeOf: OrderedCollection new
]

{ #category : #initialization }
Null >> initializeOf: aCollection [

	
]

{ #category : #playing }
Null >> triggeredBy: aSpaceship on: anEffectManager [

	
]
