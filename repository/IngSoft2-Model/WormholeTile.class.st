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

{ #category : #adding }
WormholeTile >> addSpaceshipToTile: aPlayer [
	linkedTile travelTroughWormhole:aPlayer.
]

{ #category : #initialization }
WormholeTile >> initializeOfTiles: emptyPlayerCollection [

	spaceshipsAtTile :=emptyPlayerCollection.
]

{ #category : #accessing }
WormholeTile >> linkATileToTheWormhole: aTileToLink [
	linkedTile :=aTileToLink.
]

{ #category : #accessing }
WormholeTile >> tileLinkedToWormhole [
	^linkedTile .
]

{ #category : #playing }
WormholeTile >> travelTroughWormhole: aSpaceship [
	spaceshipsAtTile add: aSpaceship
	
]
