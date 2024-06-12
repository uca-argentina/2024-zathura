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
MoonWalk >> triggeredBy: aPlayer on: aBoard [

	| filteredPlayers |
	filteredPlayers := aBoard players select: [ :player |
		                   player ~= aPlayer ].
	filteredPlayers do: [ :player | aBoard move: player by: tilesToMove ]
]
