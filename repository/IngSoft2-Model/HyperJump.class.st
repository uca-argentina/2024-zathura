Class {
	#name : #HyperJump,
	#superclass : #Effect,
	#instVars : [
		'unitOfMeasurement'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> of: collectionOfParsecs [

	^ self new initializeOf: collectionOfParsecs
]

{ #category : #'instance creation' }
HyperJump >> initializeOf: collectionOfParsecs [

	unitOfMeasurement := collectionOfParsecs asOrderedCollection
]

{ #category : #playing }
HyperJump >> triggeredBy: aSpaceship on: anEffectManager [
	|valueAsParsec|
	valueAsParsec:=((unitOfMeasurement at: 1) valueAsParsecs).
	anEffectManager move: aSpaceship jumping: valueAsParsec.
	unitOfMeasurement add: unitOfMeasurement first.
	unitOfMeasurement removeFirst.
]
