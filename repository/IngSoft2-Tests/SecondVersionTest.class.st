Class {
	#name : #SecondVersionTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SecondVersionTest >> testSV01PlayersStartAtLapOne [

	| aGame aBoard aDie1 someSpaceships |
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

	aDie1 := LoadedDie of: {3}.
	someSpaceships := { 'Danny'. 'Walter' }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1
]

{ #category : #tests }
SecondVersionTest >> testSV02PlayerChangesLapAfterPassingTheLastTile [

	| aGame aBoard aDie1 someSpaceships |
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

	aDie1 := LoadedDie of: { 6. 6. 2. 2 }.
	someSpaceships := { 'Danny'. 'Walter' }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 2
]

{ #category : #tests }
SecondVersionTest >> testSV03PlayersWinsAfterCompletingAnAmountOfLaps [

	| aGame aBoard aDie1 someSpaceships |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 6. 3. 6. 3. 6. 3. 6. 3. 6. 15 }.
	someSpaceships := { 'Danny'. 'Walter' }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.

	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.


	self assert: aGame winner name equals: 'Danny'
]

{ #category : #tests }
SecondVersionTest >> testSV04GameMustHaveOneOrMoreLaps [

	| aBoard aDie1 someSpaceships aGame |
	self
		should: [
			aBoard := Board
				          of: {
						          Null create.
						          Null create.
						          Null create.
						          Null create.
						          Null create.
						          Null create }
				          withUnitsOfMeasurement: (Parsecs with: 10).

			aDie1 := LoadedDie of: { 6. 3. 6. 3. 6. 3. 6. 3. 6. 15 }.
			someSpaceships := { 'Danny'. 'Walter' }.
			aGame := Game
				         playedBy: someSpaceships
				         on: aBoard
				         finishingAfter: 0
				         rolling: aDie1
				         usingCardsFrom: (Deck of: { 'card1'. 'card2' }) ]
		raise: Error
		withMessage: 'Game must have one or more laps!'
]

{ #category : #tests }
SecondVersionTest >> testSV05EverySpaceshipStartsWithAmountOfFuelEqualToTheDoubleOfTheDiceMaxRoll [

	| aGame aBoard aDie1 aDie2 aDiceRoller someSpaceships |
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

	aDie1 := LoadedDie of: {3}.
	aDie2 := LoadedDie of: {3}.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDiceRoller
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 12.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 12
]

{ #category : #tests }
SecondVersionTest >> testSV06WhenASpaceshipMovesItHasLessFuel [

	| aGame aBoard aDie1 aDie2 aDiceRoller someSpaceships |
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

	aDie1 := LoadedDie of: {3}.
	aDie2 := LoadedDie of: {3}.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDiceRoller
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel.


	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		< (aGame spaceshipCalled: 'Danny') fuelTank maxFuel
]

{ #category : #tests }
SecondVersionTest >> testSV07WhenASpaceshipRunsOutOfFuelItGoesBackToTileOneInLapBeforeMovementAndRechargesFuel [

	| aGame aBoard aDie1 someSpaceships |
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

	aDie1 := LoadedDie of: { 2. 3. 2. 3. 2. 3. 4 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Walter') fuelTank maxFuel.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.


	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Walter') fuelTank maxFuel
]

{ #category : #tests }
SecondVersionTest >> testSV08WhenASpaceshipRunsOutOfFuelAlsoItLosesTwoTurns [

	| aGame aBoard aDie1 someSpaceships |
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

	aDie1 := LoadedDie of: { 2. 1. 2. 1. 2. 1. 2. 1. 1. 1. 3 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 6.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 4.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 3.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 6.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 1.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel
]

{ #category : #tests }
SecondVersionTest >> testSV09SpaceshipSkipsTheirTurnToHaveMaxFuel [

	| aGame aBoard aDie1 someSpaceships |
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


	aDie1 := LoadedDie of: { 2. 2. 2. 3. 2. 2 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 3
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 6.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.

	aGame skipTurnFor: (aGame spaceshipCalled: 'Danny').
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6
]

{ #category : #tests }
SecondVersionTest >> testSV10LandingInAnEffectTileAfterBeingMovedByAnEffectDoesNotCauseAnotherEffect [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          AtomicBomb new.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).


	aDie1 := LoadedDie of: { 5. 5. 10 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 3
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2
]

{ #category : #tests }
SecondVersionTest >> testSV11Spaceship2IsTheFirstSpaceShipAtSpaceShipsRankingAsHisPositionIsTheClosestToTheFinish [

	| aGame aBoard aDie1 someSpaceships |
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

	aDie1 := LoadedDie of: { 1. 3. 3. 3. 3. 4. 1. 1 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 3
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.

	self
		assert: aGame spaceShipsPositionsRanking first name
		equals: 'Walter'.

	self
		assert: aGame spaceShipsPositionsRanking second name
		equals: 'Danny'
]

{ #category : #tests }
SecondVersionTest >> testSV12BlackHoleEffectWhenSpaceShipHasEnoughFuelItGoesFourTilesBackwards [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          BlackHole new.
				          Null new.
				          Null new }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 5. 5. 10 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Walter') fuelTank maxFuel.


	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		< (aGame spaceshipCalled: 'Danny') fuelTank maxFuel.
	self assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		< (aGame spaceshipCalled: 'Walter') fuelTank maxFuel
]

{ #category : #tests }
SecondVersionTest >> testSV13BlackHoleEffectWhenSpaceShipRunsOutOfFuelItGoesToTheFirstTileRechargesFuelAndLosesTwoTurns [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          BlackHole new.
				          Null new.
				          Null new }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 1. 1. 4. 4 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 8.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 8.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 7.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 7.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Walter') fuelTank maxFuel
]

{ #category : #tests }
SecondVersionTest >> testSV14BlackHoleEffectWhenSpaceShipIsInTheFirstThreeTilesItGoesBackToThePreviousLapAndTile [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null new.
				          BlackHole new.
				          Null new.
				          Null new.
				          Null new.
				          Null new }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 6. 6. 1. 1. 7 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 2.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1
]

{ #category : #tests }
SecondVersionTest >> testSV15SpaceshipEscapesOfTheHyperGravityEffectWhenItGetsACertainNumber [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aDie1 := LoadedDie of: { 5. 5. 4. 4. 6 }.
	aBoard := Board
		          of: {
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          (HyperGravity needsToThrow: 4).
				          Null new.
				          Null new }
		          withUnitsOfMeasurement: (Parsecs with: 10).


	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2
]

{ #category : #tests }
SecondVersionTest >> testSV16SpaceshipCannotEscapeFromTheHyperGravityEffectIfItDoesNotGetACertainNumber [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aDie1 := LoadedDie of: {5}.
	aBoard := Board
		          of: {
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          (HyperGravity needsToThrow: 4).
				          Null new.
				          Null new }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 6
]

{ #category : #tests }
SecondVersionTest >> testSV17MoonWalkEffectWhenSpaceShipHasEnoughFuelItGoesNTilesBackwards [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          (MoonWalk backwardDistance: 2).
				          Null new.
				          Null new }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 2. 3. 3. 4. 30 }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2
]

{ #category : #tests }
SecondVersionTest >> testSV18MoonWalkEffectWhenSpaceShipRunsOutOfFuelItGoesToTheFirstTileRechargesFuelAndLosesTwoTurns [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          (MoonWalk backwardDistance: 4).
				          Null new }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 2. 3. 3. 3. 1. 4 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 7.

	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: (aGame spaceshipCalled: 'Danny') fuelTank maxFuel
]

{ #category : #tests }
SecondVersionTest >> testSV19MoonWalkEffectWhenSpaceShipIsInTheFirstThreeTilesItGoesBackToThePreviousLapAndTile [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null new.
				          (MoonWalk backwardDistance: 4).
				          Null new.
				          Null new.
				          Null new.
				          Null new }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 6. 6. 1. 1 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 2.

	aGame playNextTurn.
	aGame playNextTurn.


	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1
]

{ #category : #tests }
SecondVersionTest >> testSV20HyperJumpEffectAssignsParsecsToSpaceshipAndItGoesForward [

	| aGame aBoard aDie1 someSpaceships unitsToMove |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
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
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 3. 3. 4 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Joseph') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Joseph') position equals: 6
]

{ #category : #tests }
SecondVersionTest >> testSV21AtomicBombEffectSendsAllSpaceshipsBackToTheFirstTile [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          AtomicBomb new.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 6. 4. 3. 3. 6. 6. 20 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 34.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 36.

	aGame playNextTurn.


	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.
	self
		assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel
		equals: 31.
	self
		assert: (aGame spaceshipCalled: 'Walter') fuelTank currentFuel
		equals: 36
]

{ #category : #tests }
SecondVersionTest >> testSV22SequenceDie [

	| aGame aBoard aDie1 someSpaceships |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 4. 3. 3. 5 }.
	someSpaceships := { 'Danny'. 'Walter' }.
	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2
]

{ #category : #tests }
SecondVersionTest >> testSV23GameWithRandomBoardAndRandomDie [

	| aGame aBoard aDie1 unitsToMove someSpaceships effectDistribution randomCollection aDie2 aDiceRoller |
	aDie1 := Die of: 3.
	aDie2 := Die of: 4.
	unitsToMove := OrderedCollection
		               with: (LightYear with: 9)
		               with: (Parsecs with: 4)
		               with: (LightYear with: 3).
	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.
	effectDistribution := EffectDistribution with: {
			                      (ProbabilityEffectTile
				                       with: Null new
				                       and: 0.30).
			                      (ProbabilityEffectTile
				                       with: CardGiver new
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: BlackHole new
				                       and: 0.20).
			                      (ProbabilityEffectTile
				                       with: (HyperGravity needsToThrow: 3)
				                       and: 0.20).
			                      (ProbabilityEffectTile
				                       with: (MoonWalk backwardDistance: 3)
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: (HyperJump of: unitsToMove)
				                       and: 0.08).
			                      (ProbabilityEffectTile
				                       with: AtomicBomb new
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 5.

	aBoard := Board
		          of: randomCollection
		          withUnitsOfMeasurement: (Parsecs with: 10).

	someSpaceships := { 'Danny'. 'Walter' }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDiceRoller
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]
