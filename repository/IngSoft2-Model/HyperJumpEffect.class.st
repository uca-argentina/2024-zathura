Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'distances'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpEffect class >> of: collectionOfParsecs [

	^ self new initializeOf: collectionOfParsecs
]

{ #category : #'instance creation' }
HyperJumpEffect >> initializeOf: collectionOfParsecs [

	distances := collectionOfParsecs asOrderedCollection
]

{ #category : #playing }
HyperJumpEffect >> triggeredBy: aPlayer on: aBoard [

	aBoard move: aPlayer jumping: (distances at: 1).
	distances add: distances first.
	distances removeFirst.
]
