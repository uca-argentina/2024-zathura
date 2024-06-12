Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
BlackHole >> triggeredBy: aSpaceship on: aBoard [

	aBoard move: aSpaceship by: -4
]
