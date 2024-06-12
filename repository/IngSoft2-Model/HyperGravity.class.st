Class {
	#name : #HyperGravity,
	#superclass : #Effect,
	#instVars : [
		'needsToThrow'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
HyperGravity class >> isValid: aNumber above: minRoll below: maxRoll [

	(aNumber between: minRoll and: maxRoll) ifFalse: [
		Error signal:
			'The number needed to escape hypergravity cannot be lower than the minimum roll of the dice or greater than the maximum roll of the dice.' ]
]

{ #category : #testing }
HyperGravity class >> needsToThrow: aNumber above: minRoll below: maxRoll [

	self isValid: aNumber above: minRoll below: maxRoll.
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
