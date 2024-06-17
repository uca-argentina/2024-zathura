Class {
	#name : #CardsHand,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'cardsInHand'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardsHand class >> of:aSpaceship using:aDeck [

^self new initializeOf:aSpaceship using:aDeck.
]

{ #category : #initialization }
CardsHand >> addToHand:aCard [

cardsInHand add:aCard

]

{ #category : #accessing }
CardsHand >> cardsInHand [ 
^cardsInHand
]

{ #category : #initialization }
CardsHand >> distributeCardsFrom:aDeck [

self addToHand:aDeck pick.
self addToHand:aDeck pick.

]

{ #category : #initialization }
CardsHand >> initializeOf:aSpaceship using:aDeck [

spaceship:=aSpaceship.
cardsInHand:=OrderedCollection new.
self distributeCardsFrom:aDeck

]

{ #category : #accessing }
CardsHand >> spaceship [
^spaceship
]
