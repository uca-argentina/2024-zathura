Class {
	#name : #SpaceShipPosition,
	#superclass : #Object,
	#instVars : [
		'tileNumber',
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceShipPosition class >> ofPlayer: aPlayer tileNumber: aTileNumber [

	^ self new initializeOfPlayer: aPlayer tileNumber: aTileNumber
]

{ #category : #'instance creation' }
SpaceShipPosition class >> startingOfPlayer: aPlayer [

	^ self ofPlayer: aPlayer tileNumber: 1
]

{ #category : #initialization }
SpaceShipPosition >> initializeOfPlayer: aPlayer tileNumber: aTileNumber [

player:=aPlayer.
tileNumber:=aTileNumber.
]

{ #category : #accessing }
SpaceShipPosition >> player [ 
^player
]

{ #category : #accessing }
SpaceShipPosition >> tileNumber [ 
^tileNumber 
]
