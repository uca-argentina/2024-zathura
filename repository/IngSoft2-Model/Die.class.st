Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Die class >> isValid: anAmountOfFaces [

	anAmountOfFaces < 3 ifTrue: [
		Error signal: 'Faces should be more than 2' ]
]

{ #category : #'instance creation' }
Die class >> of: anAmountOfFaces [

	self isValid: anAmountOfFaces.

	^ self new initializeOf: anAmountOfFaces
]

{ #category : #initialization }
Die >> initializeOf: anAmountOfFaces [

	faces := anAmountOfFaces
]

{ #category : #accessing }
Die >> maxRoll [

	^ faces
]

{ #category : #playing }
Die >> roll [

	^ faces atRandom
]
