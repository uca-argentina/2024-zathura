Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LoadedDeck class >> assertCardsIsNotEmpty: someCards [

	someCards ifEmpty: [
		Error signal: 'Deck must have at least one card' ]
]

{ #category : #'instance creation' }
LoadedDeck class >> of: someCards [ 

	self assertCardsIsNotEmpty: someCards.
	^self new initializeOf:someCards
]

{ #category : #initialization }
LoadedDeck >> initializeOf: someCards [

cards:=someCards asOrderedCollection
]

{ #category : #initialization }
LoadedDeck >> pick [

| cardToPick |
cards isEmpty
    ifTrue: [ Error signal: 'No cards to pick' ].
cardToPick := cards first.
cards remove: cardToPick.
^ cardToPick


]
