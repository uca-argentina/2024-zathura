Class {
	#name : #HyperGravity,
	#superclass : #Effect,
	#instVars : [
		'needsToThrow'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }

HyperGravityEffect class >> needsToThrow: aNumber [

	^ self new initializedWith: aNumber
]

{ #category : #initialization }
HyperGravity >> initializedWith: aNumber [

	needsToThrow := aNumber
]

{ #category : #playing }
HyperGravity >> triggeredBy: aPlayer on: aBoard [

	aPlayer changeRollingResultNeededToMove: needsToThrow
]
