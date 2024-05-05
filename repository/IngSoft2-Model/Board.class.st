Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Board class >> isValid: aTileCollection [

	aTileCollection size < 2 ifTrue: [
		Error signal: 'Tiles should be 2 or more' ]
]

{ #category : #'as yet unclassified' }
Board class >> ofTiles: aTileCollection [

	self isValid: aTileCollection.
	^ self new initializeOfTiles: aTileCollection
]

{ #category : #initialization }
Board >> initializeOfTiles: aTileCollection [

tiles:=aTileCollection

]

{ #category : #'as yet unclassified' }
Board >> tileNumber: number [
	^tiles at: number
]

{ #category : #initialization }
Board >> tiles [

^tiles

]
