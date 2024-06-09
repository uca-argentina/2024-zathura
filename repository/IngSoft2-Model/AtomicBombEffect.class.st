Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBombEffect >> triggeredBy: aPlayer on: aBoard [

	aBoard moveAllPlayersToFirstPosition.
]
