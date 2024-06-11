Class {
	#name : #HyperGravityEffect,
	#superclass : #Object,
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
HyperGravityEffect >> initializedWith: aNumber [

	needsToThrow := aNumber
]

{ #category : #playing }
HyperGravityEffect >> triggeredBy: aPlayer on: aBoard [

	aPlayer changeRollingResultNeededToMove: needsToThrow
]
