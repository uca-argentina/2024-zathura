Class {
	#name : #BlackHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
BlackHoleEffect >> triggeredBy: aPlayer on: aBoard [

	aBoard move: aPlayer by: -4
]
