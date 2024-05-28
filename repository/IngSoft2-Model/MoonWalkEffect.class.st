Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'tilesToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> backwardDistance: aDistance [

	^ self new initializedWith: aDistance
]

{ #category : #initialization }
MoonWalkEffect >> initializedWith: aDistance [

	tilesToMove := 0 - aDistance
]

{ #category : #playing }
MoonWalkEffect >> triggeredBy: aPlayer on: aBoard [

	| filteredPlayers |
	filteredPlayers := aBoard players select: [ :player |
		                   player ~= aPlayer ].
	filteredPlayers do: [ :player | aBoard move: player by: tilesToMove ]
]
