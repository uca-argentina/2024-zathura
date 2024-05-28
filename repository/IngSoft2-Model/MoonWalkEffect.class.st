Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'tilesToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalkEffect class >> backwardDistance: aDistance [

	^ self new initializedWith: aDistance.
]

{ #category : #'as yet unclassified' }
MoonWalkEffect >> initializedWith: aDistance [
	tilesToMove:= 0 - aDistance.
]

{ #category : #'as yet unclassified' }
MoonWalkEffect >> triggeredBy: aPlayer on:aBoard [
	|  filteredPlayers |
	filteredPlayers := aBoard players select: [:player | player ~= aPlayer].
	filteredPlayers do:[:player | aBoard move: player by: tilesToMove   ].
	
]
