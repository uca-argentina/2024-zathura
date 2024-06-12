Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'tilesToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> backwardDistance: aDistance [

	^ self new initializedWith: aDistance
]

{ #category : #initialization }
MoonWalk >> initializedWith: aDistance [

	tilesToMove := 0 - aDistance
]

{ #category : #playing }
MoonWalk >> triggeredBy: aSpaceship on: aBoard [

	| filteredShips |
	filteredShips := aBoard spaceships select: [ :spaceship |
		                 spaceship ~= aSpaceship ].
	filteredShips do: [ :spaceship |
		aBoard move: spaceship by: tilesToMove ]
]
