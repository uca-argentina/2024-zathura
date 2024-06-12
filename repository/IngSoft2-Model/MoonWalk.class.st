Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'tilesToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> backwardDistance: anAmountOfTiles [

	^ self new initializedWith: anAmountOfTiles 
]

{ #category : #initialization }
MoonWalk >> initializedWith: anAmountOfTiles [

	tilesToMove := 0 - anAmountOfTiles 
]

{ #category : #playing }
MoonWalk >> triggeredBy: aSpaceship on: aBoard [

	| filteredShips |
	filteredShips := aBoard spaceships select: [ :spaceship |
		                 spaceship ~= aSpaceship ].
	filteredShips do: [ :spaceship |
		aBoard move: spaceship by: tilesToMove ]
]
