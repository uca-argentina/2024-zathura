Class {
	#name : #HyperJump,
	#superclass : #Effect,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> of: collectionOfParsecs [

	^ self new initializeOf: collectionOfParsecs
]

{ #category : #'instance creation' }
HyperJump >> initializeOf: collectionOfParsecs [

	parsecs := collectionOfParsecs asOrderedCollection
]

{ #category : #playing }
HyperJump >> triggeredBy: aSpaceship on: aGame [
	|valueAsParsec|
	valueAsParsec:=((parsecs at: 1) valueAsParsecs).
	aGame move: aSpaceship jumping: valueAsParsec.
	parsecs add: parsecs first.
	parsecs removeFirst.
]
