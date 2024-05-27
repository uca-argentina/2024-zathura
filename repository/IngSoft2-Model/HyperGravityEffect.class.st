Class {
	#name : #HyperGravityEffect,
	#superclass : #Object,
	#instVars : [
		'needsToThrow'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
HyperGravityEffect class >> isValid: aNumber below: maxRoll [
	aNumber > maxRoll ifTrue:[ 
		Error signal: 'The number needed to escape hypergravity cannot be greater than the maximum roll of the dice.' ]
]

{ #category : #testing }
HyperGravityEffect class >> needsToThrow: aNumber below: maxRoll [
	self isValid: aNumber below: maxRoll.
	^ self new initializedWith: aNumber below: maxRoll.
]

{ #category : #initialization }
HyperGravityEffect >> initializedWith: aNumber below: maxRoll [
	needsToThrow :=aNumber.

]

{ #category : #playing }
HyperGravityEffect >> triggeredBy: aPlayer on:aBoard [
	aPlayer changeRollingResultNeededToMove: needsToThrow.
]
