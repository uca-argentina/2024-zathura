Class {
	#name : #CardPlayResolver,
	#superclass : #Object,
	#instVars : [
		'cardPlay',
		'game',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlayResolver class >> with: aGame [ 
	
	^ self new initializeWith: aGame.
]

{ #category : #initialization }
CardPlayResolver >> initializeWith: aGame [

	game := aGame.
]

{ #category : #resolving }
CardPlayResolver >> resolve:aCardPlay [

cardPlay:=aCardPlay.
^aCardPlay card uses:self
]

{ #category : #visiting }
CardPlayResolver >> resolveAnOverloadCardPlay [

| playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.
	
	(game cardsHandOf: (game spaceshipCalled:target)) addEffectOf: cardPlay card.
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]