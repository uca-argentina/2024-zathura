Class {
	#name : #HyperGravity,
	#superclass : #Effect,
	#instVars : [
		'needsToThrow'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperGravity class >> needsToThrow: aRollingResult [

	^ self new initializedWith: aRollingResult
]

{ #category : #initialization }
HyperGravity >> initializedWith: aNumber [

	needsToThrow := aNumber
]

{ #category : #playing }
HyperGravity >> triggeredBy: aSpaceship on: anEffectManager [

	aSpaceship changeRollingResultNeededToMove: needsToThrow
]
