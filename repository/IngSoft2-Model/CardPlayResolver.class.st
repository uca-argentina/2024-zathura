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

{ #category : #'as yet unclassified' }
CardPlayResolver >> resolveACancellationCardPlay [

	| filteredCardsHands playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	filteredCardsHands := game cardsHands select: [ :cardsHand | 
		                                cardsHand affectsSpaceShip: target ].
	self validateIfIsPossibleToCancelACard: filteredCardsHands.
	filteredCardsHands do: [ :cardsHand | 
		cardsHand removeEffectOf: target ].
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #'as yet unclassified' }
CardPlayResolver >> resolveARedoCardPlay [

	| newCardPlay playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	newCardPlay := CardPlay
		               with: lastCardPlayed
		               appliedTo: target
		               by: playedBy.
	game apply: newCardPlay.
	game removeFromHand: card to: playedBy
]

{ #category : #visiting }
CardPlayResolver >> resolveARepeatCardPlay [

| playedBy card effectToApply effectManager |
	playedBy := cardPlay playedBy.
	card := cardPlay card.
	
	effectToApply:=game effectToApply.
	effectManager:=game effectManager.

	effectToApply triggeredBy: (game spaceshipCalled:playedBy) on: effectManager.
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #'as yet unclassified' }
CardPlayResolver >> resolveAnAccelerationCardPlay [

| playedBy card |
	playedBy := cardPlay playedBy.
	card := cardPlay card.
	game spaceships do: [ :aSpaceship | 
		(game cardsHandOf: aSpaceship) addEffectOf: card ].
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy

]

{ #category : #'as yet unclassified' }
CardPlayResolver >> resolveAnAllyCardPlay [

| playedBy target card spaceship1 spaceship2 |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.
	
	spaceship1:=game spaceshipCalled:playedBy.
	spaceship2:=game spaceshipCalled:target.
	
	spaceship1 isAlliedWith:spaceship2.
	spaceship2 isAlliedWith:spaceship1.
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
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

{ #category : #'as yet unclassified' }
CardPlayResolver >> validateIfIsPossibleToCancelACard: cardsHandCollection [

	cardsHandCollection isEmpty ifTrue: [ 
		Error signal: 'There is no CardsHand with the card to be removed' ]

]
