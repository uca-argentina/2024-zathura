Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
BlackHole >> triggeredBy: aPlayer on: aBoard [

	aBoard move: aPlayer by: -4
]
