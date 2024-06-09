Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBomb >> triggeredBy: aPlayer on: aBoard [

	aBoard moveAllPlayersToFirstPosition.
]
