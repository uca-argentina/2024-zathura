Class {
	#name : #CardPlayResolver,
	#superclass : #Object,
	#instVars : [
		'cardPlay',
		'game',
		'lastCardPlayed',
		'cardPlayer',
		'targetPlayer'
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
CardPlayResolver >> resolve: aCardPlayed by: aPlayer targetting: anotherPalyer [

	cardPlayer := aPlayer.
	targetPlayer := anotherPalyer.
	aCardPlayed uses: self
]

{ #category : #resolving }
CardPlayResolver >> resolveACancellationCardPlay: aCard [

	game cancelTheEffectOf: targetPlayer.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayResolver >> resolveARedoCardPlay: aCard [

	game addNewCard: lastCardPlayed to: cardPlayer.
	game play: lastCardPlayed by: cardPlayer targetting: targetPlayer.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayResolver >> resolveARepeatCardPlay: aCard [

	game repeatLastEffectAppliedOn: targetPlayer.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayResolver >> resolveAnAccelerationCardPlay:aCard [
	
	
	game assertIsTurnOf: cardPlayer.
	game applyToAllSpaceShips: aCard.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer.
]

{ #category : #resolving }
CardPlayResolver >> resolveAnAllyCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	game setAnAllianceBewtween: cardPlayer and: targetPlayer.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayResolver >> resolveAnOverloadCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	game applyACardEffect: aCard to: targetPlayer.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]
