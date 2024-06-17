Class {
	#name : #CardGiver,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
CardGiver >> triggeredBy: aSpaceship on: aGame [

aGame giveCardFromDeckTo:aSpaceship. 
]
