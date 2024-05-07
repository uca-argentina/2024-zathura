Class {
	#name : #Tile,
	#superclass : #Object,
	#instVars : [
		'spaceshipsAtTile'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Tile class >> ofTiles [

	^ self new initializeOfTiles: OrderedCollection new.
]

{ #category : #adding }
Tile >> addSpaceshipToTile: aSpaceship [
	spaceshipsAtTile add: aSpaceship
]

{ #category : #'as yet unclassified' }
Tile >> anySpaceshipAtTile [
	spaceshipsAtTile isEmpty ifTrue:[^false]
	ifFalse:[^true]
	
]

{ #category : #initialization }
Tile >> initializeOfTiles: emptySpaceshipCollection [

	spaceshipsAtTile :=emptySpaceshipCollection.
]

{ #category : #'as yet unclassified' }
Tile >> isSpaceshipAtTile:aPlayer [
	^ spaceshipsAtTile includes: aPlayer
	
]

{ #category : #removing }
Tile >> removeSpaceshipFromTiles: aPlayer [
	spaceshipsAtTile remove: aPlayer
]
