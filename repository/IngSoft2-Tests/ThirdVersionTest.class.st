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
ThirdVersionTest >> testTV05HyperGravityMeasuredInLightYearsItMovesForward [

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
ThirdVersionTest >> testTV06HyperGravityCanBeUsedInParsecsAndLightYears [

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
	aDie1 := LoadedDie of: { 3. 3 }.

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

	cardPlay := anAccelerationCard
		            playedBy: 'Danny'
		            targetting: aGame spaceships.

	aGame apply: cardPlay.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5
]

{ #category : #tests }
ThirdVersionTest >> testTV08WhenSpaceshipUsesCancellationCardItRemovesAChosenActivePermanentCard [

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

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1
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
					finishingAfter:2
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
