Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> of: someCards [ 
	^self new initializeOf:someCards
]

{ #category : #initialization }
Deck >> initializeOf: someCards [

cards:=someCards
]

{ #category : #'as yet unclassified' }
Deck >> pick [

^cards atRandom
]
