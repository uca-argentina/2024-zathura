Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBomb >> triggeredBy: aSpaceship on: aGame [

	aGame moveAllSpaceshipsToFirstPosition.
]
