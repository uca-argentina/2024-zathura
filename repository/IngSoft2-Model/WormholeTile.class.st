Class {
	#name : #WormholeTile,
	#superclass : #Tile,
	#instVars : [
		'linkedTile'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #adding }
WormholeTile >> addSpaceshipToTile: aSpaceship [
	linkedTile travelTroughWormhole:aSpaceship.
]

{ #category : #initialization }
WormholeTile >> initializeOfTiles: emptySpaceshipCollection [

	spaceshipsAtTile :=emptySpaceshipCollection.
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
