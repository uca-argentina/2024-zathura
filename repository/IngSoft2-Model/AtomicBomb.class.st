Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBomb >> triggeredBy: aSpaceship on: anEffectManager [

	anEffectManager moveAllSpaceshipsToFirstPosition
]
