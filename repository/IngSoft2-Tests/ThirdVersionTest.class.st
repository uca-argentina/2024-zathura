Class {
	#name : #ThirdVersionTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ThirdVersionTest >> testTV01EverySpaceshipStartsWithTwoCards [

	| aGame aBoard aDie1 someSpaceships aDeck |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 6. 4. 3. 3. 6. 6. 20 }.

	aDeck := Deck of: { 'card1'. 'card2' }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame cardsHandLengthOf: 'Danny') equals: 2.
	self assert: (aGame cardsHandLengthOf: 'Walter') equals: 2.

	aGame playNextTurn.
	aGame playNextTurn
]

{ #category : #tests }
ThirdVersionTest >> testTV02WhenSpaceshipLandsInCardGiverTileItReceivesACard [

	| aGame aBoard aDie1 someSpaceships aDeck |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          CardGiver new.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2 }.

	aDeck := Deck of: { 'card1'. 'card2' }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame cardsHandLengthOf: 'Danny') equals: 2.
	self assert: (aGame cardsHandLengthOf: 'Walter') equals: 2.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame cardsHandLengthOf: 'Danny') equals: 3.
	self assert: (aGame cardsHandLengthOf: 'Walter') equals: 2
]

{ #category : #tests }
ThirdVersionTest >> testTV03WhenSpaceshipUsesOverloadCardItReducesByTwoTheTotalRollOfAnotherSpaceship [

	| aGame aBoard aDie1 someSpaceships aDeck anOverloadCard cardPlay |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          CardGiver new.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 3. 1. 1 }.

	anOverloadCard := OverloadCard new.

	aDeck := Deck of: {
			         anOverloadCard.
			         anOverloadCard }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	cardPlay := anOverloadCard playedBy: 'Danny' targetting: 'Walter'.
	aGame apply: cardPlay.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2
]

{ #category : #tests }
ThirdVersionTest >> testTV04WhenSpaceshipRollsTheMaximumRollItsMaxFuelGoesUpOrItsFuelGoesDown [

	| aGame aBoard aDie1 someSpaceships aDeck |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 4. 4 }.


	aDeck := Deck of: { 'card1'. 'card2' }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel
		equals: 8.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank maxFuel
		equals: 8.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 8.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 8.

	aGame playNextTurn.
	aGame playNextTurn.

	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel
		equals: 8.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank maxFuel
		equals: 8.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 6.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert:
		((aGame spaceshipCalled: 'Danny') fuelTank maxFuel = 9 or:
			 (aGame spaceshipCalled: 'Danny') fuelTank currentFuel = 1).
	self assert:
		((aGame spaceshipCalled: 'Walter') fuelTank maxFuel = 9 or:
			 (aGame spaceshipCalled: 'Walter') fuelTank currentFuel = 1)
]

{ #category : #tests }
ThirdVersionTest >> testTV05HyperJumpMeasuredInLightYearsItMovesForward [

	| aGame aBoard aDie1 someSpaceships aDeck lightYears |
	someSpaceships := { 'Danny'. 'Walter' }.
	lightYears := OrderedCollection
		              with: (LightYear with: 9)
		              with: (LightYear with: 3).

	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          (HyperJump of: lightYears).
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 6).
	aDie1 := LoadedDie of: { 2. 2. 10 }.

	aDeck := Deck of: { 'card1'. 'card2' }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.


	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4
]

{ #category : #tests }
ThirdVersionTest >> testTV06HyperJumpCanBeUsedInParsecsAndLightYears [

	| aGame aBoard aDie1 someSpaceships aDeck unitsToMove |
	someSpaceships := { 'Danny'. 'Walter' }.
	unitsToMove := OrderedCollection
		               with: (LightYear with: 9)
		               with: (Parsecs with: 4)
		               with: (LightYear with: 3).

	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          (HyperJump of: unitsToMove).
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 6).
	aDie1 := LoadedDie of: { 2. 2. 10 }.

	aDeck := Deck of: { 'card1'. 'card2' }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.


	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 2
]

{ #category : #tests }
ThirdVersionTest >> testTV07WhenSpaceshipUsesAccelerationCardItAddsOneToTheTotalRollOfAllSpaceships [

	| aGame aBoard aDie1 someSpaceships aDeck anAccelerationCard cardPlay |
	someSpaceships := { 'Danny'. 'Walter' . 'Joseph'}.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 2. 1. 3.}.

	anAccelerationCard := AccelerationCard new.

	aDeck := Deck of: {
			         anAccelerationCard.
			         anAccelerationCard }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Joseph') position equals: 1.

	cardPlay := anAccelerationCard
		            playedBy: 'Danny'
		            targetting: aGame spaceships.

	aGame apply: cardPlay.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Joseph') position equals: 3.
]

{ #category : #tests }
ThirdVersionTest >> testTV08WhenSpaceshipUsesCancellationCardOnAnAccelerationCardThenItRemovesItsEffect [

	| aGame aBoard aDie1 someSpaceships aDeck anAccelerationCard cardPlay1 cardPlay2 aCancellationCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          CardGiver new.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anAccelerationCard := AccelerationCard new.
	aCancellationCard := CancellationCard new.

	aDeck := LoadedDeck of: {
			         anAccelerationCard.
			         aCancellationCard.
			         anAccelerationCard.
			         aCancellationCard }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	cardPlay1 := anAccelerationCard
		             playedBy: 'Danny'
		             targetting: aGame spaceships.

	aGame apply: cardPlay1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.

	cardPlay2 := aCancellationCard
		             playedBy: 'Danny'
		             targetting: anAccelerationCard.

	aGame apply: cardPlay2.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 6
]

{ #category : #tests }
ThirdVersionTest >> testTV09WhenSpaceshipUsesReDoCardItHasTheEffectOfTheLastPlayedCard [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 cardPlay2 anOverloadCard aRedoCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          CardGiver new.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 3. 3. 3. 6 }.

	anOverloadCard := OverloadCard new.
	aRedoCard := RedoCard new.

	aDeck := LoadedDeck of: {
			         anOverloadCard.
			         aRedoCard.
			         anOverloadCard.
			         aRedoCard.
			         aRedoCard.
			         aRedoCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	cardPlay1 := anOverloadCard playedBy: 'Danny' targetting: 'Walter'.

	aGame apply: cardPlay1.

	aGame playNextTurn.

	cardPlay2 := aRedoCard playedBy: 'Walter' targetting: 'Danny'.

	aGame apply: cardPlay2.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5
]

{ #category : #tests }
ThirdVersionTest >> testTV10WhenSpaceshipUsesRepeatCardItHasTheEffectOfTheLastPlayedTile [

	| aGame aBoard aDie1 someSpaceships aDeck aRepeatCard cardPlay |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (MoonWalk backwardDistance: 1).
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 1. 1. 6 }.

	aRepeatCard := RepeatCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.

	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.

	cardPlay := aRepeatCard playedBy: 'Danny' targetting: 'Walter'.
	aGame apply: cardPlay.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2
]

{ #category : #tests }
ThirdVersionTest >> testTV11WhenSpaceshipUsesAllyCardItSharesFuelWithAnotherSpaceship [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay anAllyCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 1. 2. 1. 2. 1. 1. 3 }.

	anAllyCard := AllyCard new.

	aDeck := LoadedDeck of: {
			         anAllyCard.
			         anAllyCard.
			         anAllyCard.
			         anAllyCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	cardPlay := anAllyCard playedBy: 'Danny' targetting: 'Walter'.
	aGame apply: cardPlay.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 0.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 3.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 8.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 0.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 2
]

{ #category : #tests }
ThirdVersionTest >> testTV12SpaceshipCannotUseAPermanentCardWhenItIsNotItsTurn [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay anAllyCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 1. 2. 1. 1 }.

	anAllyCard := AllyCard new.

	aDeck := LoadedDeck of: {
			         anAllyCard.
			         anAllyCard.
			         anAllyCard.
			         anAllyCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.

	cardPlay := anAllyCard playedBy: 'Danny' targetting: 'Walter'.

	self
		should: [ aGame apply: cardPlay ]
		raise: Error
		withMessage: 'It is not your turn'
]

{ #category : #tests }
ThirdVersionTest >> testTV13SpaceshipCannotUseACardThatIsNotInItsHand [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay anAllyCard anOverloadCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 1. 2. 1. 1 }.

	anAllyCard := AllyCard new.
	anOverloadCard := OverloadCard new.

	aDeck := LoadedDeck of: {
			         anAllyCard.
			         anAllyCard.
			         anAllyCard.
			         anAllyCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.

	cardPlay := anOverloadCard playedBy: 'Danny' targetting: 'Walter'.

	self
		should: [ aGame apply: cardPlay ]
		raise: Error
		withMessage:
		'Spaceship cannot throw this card because he does not have it'
]

{ #category : #tests }
ThirdVersionTest >> testTV14WhenSpaceshipUsesAllyCardAndNeitherOfTheHasEnoughFuelThenTheyGoToPostion1 [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay anAllyCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 1. 3. 3. 3. 3. 3. 1. 1. 4 }.

	anAllyCard := AllyCard new.

	aDeck := LoadedDeck of: {
			         anAllyCard.
			         anAllyCard.
			         anAllyCard.
			         anAllyCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	cardPlay := anAllyCard playedBy: 'Danny' targetting: 'Walter'.
	aGame apply: cardPlay.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 2.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 4.

	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 8.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1
]

{ #category : #tests }
ThirdVersionTest >> testTV15WhenSpaceshipUsesCancellationCardOnAnOverloadCardThenItRemovesItsEffect [

	| aGame aBoard aDie1 someSpaceships aDeck anOverloadCard cardPlay1 cardPlay2 aCancellationCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null new.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 6 }.

	anOverloadCard := OverloadCard new.
	aCancellationCard := CancellationCard new.

	aDeck := LoadedDeck of: {
			         anOverloadCard.
			         aCancellationCard.
			         anOverloadCard.
			         aCancellationCard.
						anOverloadCard.}.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	cardPlay1 := anOverloadCard
		             playedBy: 'Danny'
		             targetting: 'Walter'.

	aGame apply: cardPlay1.
	
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	cardPlay2 := aCancellationCard
		             playedBy: 'Danny'
		             targetting: anOverloadCard.

	aGame apply: cardPlay2.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.

	
	
]

{ #category : #tests }
ThirdVersionTest >> testTV16WhenSpaceshipUsesReDoCardAfterAnAccelerationCardItCopiesIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 cardPlay2 anAccelerationCard aRedoCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 3. 3. 3. 6 }.

	anAccelerationCard := AccelerationCard new.
	aRedoCard := RedoCard new.

	aDeck := LoadedDeck of: {
			         anAccelerationCard.
			         aRedoCard.
			         anAccelerationCard.
			         aRedoCard.
			         aRedoCard.
			         aRedoCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	cardPlay1 := anAccelerationCard
		             playedBy: 'Danny'
		             targetting: 'Walter'.

	aGame apply: cardPlay1.

	aGame playNextTurn.

	cardPlay2 := aRedoCard playedBy: 'Walter' targetting: 'Danny'.

	aGame apply: cardPlay2.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 6.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3
]

{ #category : #tests }
ThirdVersionTest >> testTV17WhenSpaceshipUsesReDoCardAfterARepeatCardItCopiesIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 cardPlay2 aRepeatCard aRedoCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 6. 5. 3. 3. 20 }.

	aRepeatCard := RepeatCard new.
	aRedoCard := RedoCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRedoCard.
			         aRepeatCard.
			         aRedoCard.
			         aRedoCard.
			         aRedoCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.


	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.	
	
	cardPlay1 := aRepeatCard playedBy: 'Walter' targetting: 'Danny'.
	aGame apply: cardPlay1.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.


	cardPlay2 := aRedoCard playedBy: 'Danny' targetting: 'Walter'.
	aGame apply: cardPlay2.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.


]

{ #category : #tests }
ThirdVersionTest >> testTV18WhenSpaceshipUsesReDoCardAfterAnAllyCardItCopiesIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 cardPlay2 anAllyCard aRedoCard |
	someSpaceships := { 'Danny'.'Anthony'. 'Walter'. 'Joseph'  }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 2. 2. 2. 20 }.

	anAllyCard := AllyCard new.
	aRedoCard := RedoCard new.

	aDeck := LoadedDeck of: {
			         anAllyCard.
			         aRedoCard.
			         anAllyCard.
			         aRedoCard.
			         anAllyCard.
			         aRedoCard.
			         anAllyCard.
			         aRedoCard.
			         anAllyCard.
			         aRedoCard.
			         anAllyCard.
			         aRedoCard.
			         aRedoCard.
			         aRedoCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	cardPlay1 := anAllyCard playedBy: 'Danny' targetting: 'Walter'.
	aGame apply: cardPlay1.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Joseph') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Anthony') position equals: 1.
	aGame playNextTurn. 
	cardPlay2 := aRedoCard  playedBy: 'Anthony' targetting: 'Joseph'.
	aGame apply: cardPlay2.

	self assert:((aGame spaceshipCalled: 'Anthony') ally) equals: (aGame spaceshipCalled: 'Joseph') .


	self assert:((aGame spaceshipCalled: 'Walter') ally) equals: (aGame spaceshipCalled: 'Danny') .
	



]

{ #category : #tests }
ThirdVersionTest >> testTV19WhenSpaceshipUsesReDoCardAfterACancelationCardItCopiesIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 cardPlay2 aCancellationCard aRedoCard anAccelerationCard anOverloadCard cardPlay3 cardPlay4 |
	someSpaceships := { 'Danny'.'Walter'.   }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 5. 2. 2. 2. 2. 2. 2. 2. 2. 20 }.

	aCancellationCard := CancellationCard  new.
	aRedoCard := RedoCard new.
	anAccelerationCard:= AccelerationCard new.
	anOverloadCard:=OverloadCard new.

	aDeck := LoadedDeck of: {
			         anAccelerationCard.
			         anOverloadCard.
			         aCancellationCard.
			         aRedoCard.
			         aCancellationCard.
			         aRedoCard. }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	cardPlay1 := anAccelerationCard playedBy: 'Danny' targetting: aGame spaceships .
	cardPlay2 := anOverloadCard playedBy: 'Danny' targetting: 'Walter'.
	aGame apply: cardPlay1.
	aGame apply: cardPlay2 .
	aGame playNextTurn .
	aGame playNextTurn .
	self assert:(aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert:(aGame spaceshipCalled: 'Walter') position equals: 5.
	aGame playNextTurn .
	self assert:(aGame spaceshipCalled: 'Danny') position equals: 7.
	cardPlay3 := aCancellationCard playedBy: 'Walter' targetting: anOverloadCard .
	aGame apply: cardPlay3.
	aGame playNextTurn .
	aGame playNextTurn .
	self assert:(aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert:(aGame spaceshipCalled: 'Danny') position equals: 3.
	cardPlay4 := aRedoCard playedBy: 'Walter' targetting: anAccelerationCard.	
	aGame apply: cardPlay4.
	aGame playNextTurn .
	aGame playNextTurn .
	self assert:(aGame spaceshipCalled: 'Walter') position equals: 3.
	self assert:(aGame spaceshipCalled: 'Danny') position equals: 5.


	



]

{ #category : #tests }
ThirdVersionTest >> testTV20WhenSpaceshipUsesRepeatCardAfterANullEffecItDoesNothong [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 aRepeatCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 6. 5. 3. 3. 20 }.

	aRepeatCard := RepeatCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.


	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 6.	

	cardPlay1 := aRepeatCard playedBy: 'Walter' targetting: 'Danny'.
	aGame apply: cardPlay1.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 6.



]

{ #category : #tests }
ThirdVersionTest >> testTV21WhenSpaceshipUsesRepeatCardAfterAnatomicBombItTriggersIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 aRepeatCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          AtomicBomb new.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 6. 5. 3. 3. 20 }.

	aRepeatCard := RepeatCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.


	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.	
	
	(aGame spaceshipCalled: 'Walter') movePositionBy: 4 lapBy:0  neededFuel:0  .
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.
	cardPlay1 := aRepeatCard playedBy: 'Walter' targetting: 'Danny'.
	aGame apply: cardPlay1.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.



]

{ #category : #tests }
ThirdVersionTest >> testTV22WhenSpaceshipUsesRepeatCardAfterABlackHoleItTriggersIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 aRepeatCard |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 6. 5. 3. 3. 20 }.

	aRepeatCard := RepeatCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.


	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.	

	cardPlay1 := aRepeatCard playedBy: 'Walter' targetting: 'Danny'.
	aGame apply: cardPlay1.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.



]

{ #category : #tests }
ThirdVersionTest >> testTV23WhenSpaceshipUsesRepeatCardAfterAHyperJumpItTriggersIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 aRepeatCard unitsToMove |
	someSpaceships := { 'Danny'. 'Walter' }.
	unitsToMove := OrderedCollection
		               with: (Parsecs with: 3)
		               with: (Parsecs with: 2).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (HyperJump of: unitsToMove).
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 5. 3. 3. 3. 20 }.

	aRepeatCard := RepeatCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.


	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 7.

	cardPlay1 := aRepeatCard playedBy: 'Walter' targetting: 'Walter'.
	aGame apply: cardPlay1.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 9.
	


]

{ #category : #tests }
ThirdVersionTest >> testTV24WhenSpaceshipUsesRepeatCardAfterAHyperGravityItTriggersIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 aRepeatCard |
	someSpaceships := { 'Danny'. 'Walter' }.

	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (HyperGravity needsToThrow: 4).
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 5. 6. 3. 4. 4. 20 }.

	aRepeatCard := RepeatCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.


	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	cardPlay1 := aRepeatCard playedBy: 'Walter' targetting: 'Walter'.
	aGame apply: cardPlay1.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 8.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 8.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.



]

{ #category : #tests }
ThirdVersionTest >> testTV25WhenSpaceshipUsesRepeatCardAfterACardGiverItTriggersIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 aRepeatCard  |
	someSpaceships := { 'Danny'. 'Walter' }.

	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          CardGiver new.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 3. 3. 3. 20 }.

	aRepeatCard := RepeatCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.


	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame cardsHandLengthOf:'Danny')   equals: 3.
	self assert: (aGame cardsHandLengthOf:'Walter')   equals: 2.

	cardPlay1 := aRepeatCard playedBy: 'Walter' targetting: 'Walter'.
	aGame apply: cardPlay1.
	self assert: (aGame cardsHandLengthOf:'Danny')   equals: 3.
	self assert: (aGame cardsHandLengthOf:'Walter')   equals: 2.
	


]

{ #category : #tests }
ThirdVersionTest >> testTV26WhenSpaceshipUsesRepeatCardAfterWormHoleItTriggersIt [

	| aGame aBoard aDie1 someSpaceships aDeck cardPlay1 aRepeatCard wormholeTile3 wormholeTile5|
	someSpaceships := { 'Danny'. 'Walter' }.
	wormholeTile3 := Wormhole betweenTiles: { 3. 5 }.
	wormholeTile5 := Wormhole betweenTiles: { 5. 3 }.

	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          wormholeTile3.
				          Null  create.
				          wormholeTile5.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 2. 3. 3. 3. 20 }.

	aRepeatCard := RepeatCard new.

	aDeck := LoadedDeck of: {
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard.
			         aRepeatCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.


	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.


	cardPlay1 := aRepeatCard playedBy: 'Walter' targetting: 'Walter'.
	aGame apply: cardPlay1.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.
	


]
