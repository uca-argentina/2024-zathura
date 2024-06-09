Class {
	#name : #HyperJump,
	#superclass : #Effect,
	#instVars : [
		'distances'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> of: collectionOfParsecs [

	^ self new initializeOf: collectionOfParsecs
]

{ #category : #'instance creation' }
HyperJump >> initializeOf: collectionOfParsecs [

	distances := collectionOfParsecs asOrderedCollection
]

{ #category : #playing }
HyperJump >> triggeredBy: aPlayer on: aBoard [

	aBoard move: aPlayer jumping: (distances at: 1).
	distances add: distances first.
	distances removeFirst.
]
