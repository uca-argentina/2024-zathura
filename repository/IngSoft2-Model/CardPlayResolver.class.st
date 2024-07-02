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

	^ self new initializeWith: aGame
]

{ #category : #initialization }
CardPlayResolver >> initializeWith: aGame [

	game := aGame
]

{ #category : #resolving }
CardPlayResolver >> resolve: aCardPlay [

	cardPlay := aCardPlay.
	^ aCardPlay card uses: self
]

{ #category : #resolving }
CardPlayResolver >> resolveACancellationCardPlay [

	| filteredCardsHands playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.
	game validate: playedBy  has: card.

	filteredCardsHands := game cardsHands select: [ :cardsHand |
		                      cardsHand affectsSpaceShip: target ].
	self validateIfIsPossibleToCancelACard: filteredCardsHands.
	filteredCardsHands do: [ :cardsHand |
		cardsHand removeEffectOf: target ].
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #resolving }
CardPlayResolver >> resolveARedoCardPlay [

	| newCardPlay playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	game validate: playedBy  has: card.

	newCardPlay := CardPlay
		               with: lastCardPlayed
		               appliedTo: target
		               by: playedBy.
	game addNewCard: lastCardPlayed to:playedBy.
	game apply: newCardPlay.
	game removeFromHand: card to: playedBy
]

{ #category : #resolving }
CardPlayResolver >> resolveARepeatCardPlay [

	| playedBy card target|
	playedBy := cardPlay playedBy.
	target:=cardPlay target.
	card := cardPlay card.

	game validate: playedBy  has: card.
	
	game repeatLastEffectAppliedOn:target.

	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #resolving }
CardPlayResolver >> resolveAnAccelerationCardPlay [

	| playedBy card |
	playedBy := cardPlay playedBy.
	card := cardPlay card.

	game validate: playedBy has: card.
	game assertIsTurnOf: playedBy.
	game applyToAllSpaceShips: card.
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #resolving }
CardPlayResolver >> resolveAnAllyCardPlay [

	| playedBy target card spaceship1 spaceship2 |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	game validate: playedBy  has: card.

	game assertIsTurnOf: playedBy .

	spaceship1 := game spaceshipCalled: playedBy.
	spaceship2 := game spaceshipCalled: target.

	spaceship1 isAlliedWith: spaceship2.
	spaceship2 isAlliedWith: spaceship1.
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #resolving }
CardPlayResolver >> resolveAnOverloadCardPlay [

	| playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	game validate: playedBy  has: card.

	game assertIsTurnOf: playedBy .
	game applyACardEffect: card to: target .
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #asserting }
CardPlayResolver >> validateIfIsPossibleToCancelACard: cardsHandCollection [

	cardsHandCollection isEmpty ifTrue: [
		Error signal: 'There is no CardsHand with the card to be removed' ]
]
