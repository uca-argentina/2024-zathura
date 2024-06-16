Class {
	#name : #CardsHand,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'cardsInHand',
		'cardsAffecting'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardsHand class >> of:aSpaceship using:aDeck [

^self new initializeOf:aSpaceship using:aDeck.
]

{ #category : #adding }
CardsHand >> addEffectOf:aCard [

cardsAffecting add:aCard
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
cardsAffecting:=OrderedCollection new.
self distributeCardsFrom:aDeck

]

{ #category : #removing }
CardsHand >> removeFromHand: aCard [

	cardsInHand remove: aCard
]

{ #category : #accessing }
CardsHand >> spaceship [
^spaceship
]

{ #category : #accessing }
CardsHand >> totalEffectsOnSpaceShip [
	
	cardsAffecting isEmpty ifTrue: [ ^0 ].
	^ cardsAffecting sum: [ :card | card effect ]
]
