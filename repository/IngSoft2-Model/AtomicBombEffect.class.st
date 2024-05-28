Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBombEffect >> triggeredBy: aPlayer on:aBoard [
	aBoard players do:[:player | aBoard move: player by: 1 - player position ].
]
