Class {
	#name : #Tile,
	#superclass : #Object,
	#instVars : [
		'spaceshipsAtTile'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initializing }
Tile class >> create [

	^ self new initializeOfTiles: OrderedCollection new.
]

{ #category : #adding }
Tile >> addSpaceshipToTile: aSpaceship [
	spaceshipsAtTile add: aSpaceship
]

{ #category : #asserting }
Tile >> anySpaceship [
	^ spaceshipsAtTile isNotEmpty

	
]

{ #category : #initialization }
Tile >> initializeOfTiles: emptySpaceshipCollection [

	spaceshipsAtTile :=emptySpaceshipCollection.
]

{ #category : #asserting }
Tile >> isSpaceshipAtTile:aSpaceship [
	^ spaceshipsAtTile includes: aSpaceship
	
]

{ #category : #removing }
Tile >> removeSpaceshipFromTiles: aSpaceship [
	spaceshipsAtTile remove: aSpaceship
]
