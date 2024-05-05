Class {
	#name : #Tile,
	#superclass : #Object,
	#instVars : [
		'playersAtTile'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Tile class >> ofTiles [

	^ self new initializeOfTiles: OrderedCollection new.
]

{ #category : #adding }
Tile >> addPlayerToTile: aPlayer [
	playersAtTile add: aPlayer
]

{ #category : #'as yet unclassified' }
Tile >> anyPlayerAtTile [
	playersAtTile isEmpty ifTrue:[^false]
	ifFalse:[^true]
	
]

{ #category : #initialization }
Tile >> initializeOfTiles: emptyPlayerCollection [

	playersAtTile :=emptyPlayerCollection.
]

{ #category : #'as yet unclassified' }
Tile >> isPlayerAtTile:aPlayer [
	^ playersAtTile includes: aPlayer
	
]

{ #category : #removing }
Tile >> removePlayerFromTiles: aPlayer [
	playersAtTile remove: aPlayer
]
