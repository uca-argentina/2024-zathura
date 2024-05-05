Class {
	#name : #WormholeTile,
	#superclass : #Tile,
	#instVars : [
		'playersAtWormholeTile',
		'linkedTile'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormholeTile class >> ofTiles [

	^ self new initializeOfTiles: OrderedCollection new.
]

{ #category : #'as yet unclassified' }
WormholeTile class >> ofTiles: anotherTile [
	^ self new 
		initializeOfTiles: OrderedCollection new
		linkedTile: anotherTile
]

{ #category : #adding }
WormholeTile >> addPlayerToTile: aPlayer [
	linkedTile travelTroughWormhole:aPlayer.
]

{ #category : #initialization }
WormholeTile >> initializeOfTiles: emptyPlayerCollection [

	playersAtTile :=emptyPlayerCollection.
]

{ #category : #'as yet unclassified' }
WormholeTile >> linkATileToTheWormhole: aTileToLink [
	linkedTile :=aTileToLink.
]

{ #category : #'as yet unclassified' }
WormholeTile >> tileLinkedToWormhole [
	^linkedTile .
]

{ #category : #'as yet unclassified' }
WormholeTile >> travelTroughWormhole: aPlayer [
	playersAtTile add: aPlayer
	
]
