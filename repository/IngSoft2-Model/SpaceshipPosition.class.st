Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'tileNumber',
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpaceshipPosition class >> ofPlayer: aPlayer tileNumber: aTileNumber [

	^ self new initializeOfPlayer: aPlayer tileNumber: aTileNumber
]

{ #category : #'as yet unclassified' }
SpaceshipPosition class >> startingOfPlayer: aPlayer [

	^ self ofPlayer: aPlayer tileNumber: 1
]

{ #category : #initialization }
SpaceshipPosition >> initializeOfPlayer: aPlayer tileNumber: aTileNumber [

player:=aPlayer.
tileNumber:=aTileNumber.
]

{ #category : #accessing }
SpaceshipPosition >> player [ 
^player
]

{ #category : #accessing }
SpaceshipPosition >> tileNumber [ 
^tileNumber 
]
