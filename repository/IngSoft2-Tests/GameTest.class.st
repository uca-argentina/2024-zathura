Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
GameTest >> initializeGameWithLoadedDieOf3And2PlayersAnd7NormalTiles [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter: 2
			withDistance: 10.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.
	^ aGame
]

{ #category : #playing }
GameTest >> playUntilFinished: aGame [

	[ aGame hasEnded ] whileFalse: [ aGame playNextTurn ]
]

{ #category : #tests }
GameTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
GameTest >> test01PlayersStartAtLapOne [

| aGame aBoard aDie1 spaceShip1 spaceShip2 |

	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
		          finishingAfter: 2
					 withDistance: 10.

	aDie1 := LoadedDie of: 3.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: (spaceShip1 lap) equals: 1.
	self assert: (spaceShip2 lap) equals: 1.
]

{ #category : #tests }
GameTest >> test02PlayerChangesLapAfterPassingTheLastTile [

| aGame aBoard aDie1 spaceShip1 spaceShip2|

	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create. }
		          finishingAfter: 2
					withDistance: 10.

	aDie1 := SequenceDie of:{6. 6. 2. 2.}.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.
	
	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(spaceShip1 lap) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	self assert:(spaceShip2 lap) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:7.
	self assert:(spaceShip1 lap) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:7.
	self assert:(spaceShip2 lap) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:2.
	self assert:(spaceShip1 lap) equals:2.
	self assert:(aGame positionOf:spaceShip2) equals:2.
	self assert:(spaceShip2 lap) equals:2.
]

{ #category : #tests }
GameTest >> test03PlayersWinsAfterCompletingAnAmountOfLaps [

| aGame aBoard aDie1 spaceShip1 spaceShip2|

	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create. }
		          finishingAfter: 2
					withDistance: 10.

	aDie1 := SequenceDie of: {6. 3. 6. 3.}.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.
	
	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(spaceShip1 lap) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	self assert:(spaceShip2 lap) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(spaceShip1 lap) equals:2.
	self assert:(aGame positionOf:spaceShip2) equals:4.
	self assert:(spaceShip2 lap) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(spaceShip1 lap) equals:2.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	self assert:(spaceShip2 lap) equals:2.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(spaceShip1 lap) equals:3.
	
	self assert:(aGame winner) equals:spaceShip1.
]

{ #category : #tests }
GameTest >> test04GameMustHaveOneOrMoreLaps [

self
		should: [ Board of: { NullEffect create. NullEffect create. } finishingAfter: 0 withDistance: 10.]
		raise: Error
		withMessage: 'Game must have one or more laps!'
	

]

{ #category : #tests }
GameTest >> test05EverySpaceshipStartsWithAmountOfFuelEqualToTheDoubleOfTheDiceMaxRoll [

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 3.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDiceRoller.

	self assert:(spaceShip1 amountOfFuel) equals:12.
	self assert:(spaceShip2 amountOfFuel) equals:12.
]

{ #category : #tests }
GameTest >> test06WhenASpaceshipMovesItHasLessFuel [

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 3.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDiceRoller.

	self assert:(spaceShip1 amountOfFuel) equals:12.
	self assert:(spaceShip2 amountOfFuel) equals:12.
	
	
	aGame playNextTurn.
	
	self assert:(spaceShip1 amountOfFuel) equals:6.	

]

{ #category : #tests }
GameTest >> test07WhenASpaceshipRunsOutOfFuelItGoesBackToTileOneInLapBeforeMovementAndRechargesFuel [

| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 6.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(aGame positionOf: spaceShip1) equals:1.
	self assert:(aGame positionOf: spaceShip2) equals:1.
	self assert:(spaceShip1 amountOfFuel) equals:12.
	self assert:(spaceShip2 amountOfFuel) equals:12.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf: spaceShip1) equals:7.
	self assert:(aGame positionOf: spaceShip2) equals:7.
	self assert:(spaceShip1 amountOfFuel) equals:6.
	self assert:(spaceShip2 amountOfFuel) equals:6.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf: spaceShip1) equals:1.
	self assert:(aGame positionOf: spaceShip2) equals:1.
	self assert:(spaceShip1 lap) equals:1.
	self assert:(spaceShip2 lap) equals:1.
	self assert:(spaceShip1 amountOfFuel) equals:12.
	self assert:(spaceShip2 amountOfFuel) equals:12.
	
	
]

{ #category : #tests }
GameTest >> test08WhenASpaceshipRunsOutOfFuelAlsoItLosesTwoTurns [

| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := SequenceDie of: {2. 6. 2. 6. 1. 1. 1. 1.}.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(spaceShip1 amountOfFuel) equals:12.
	self assert:(spaceShip2 amountOfFuel) equals:12.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf: spaceShip1) equals:3.
	self assert:(aGame positionOf: spaceShip2) equals:7.
	self assert:(spaceShip1 amountOfFuel) equals:10.
	self assert:(spaceShip2 amountOfFuel) equals:6.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf: spaceShip1) equals:5.
	self assert:(aGame positionOf: spaceShip2) equals:1.
	self assert:(spaceShip1 amountOfFuel) equals:8.
	self assert:(spaceShip2 amountOfFuel) equals:12.	
	
	aGame playNextTurn. 
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf: spaceShip1) equals:8.
	self assert:(aGame positionOf: spaceShip2) equals:1.
	self assert:(spaceShip1 amountOfFuel) equals:5.
	self assert:(spaceShip2 amountOfFuel) equals:12.	
	
	aGame playNextTurn.
	
	self assert:(aGame positionOf: spaceShip1) equals:8.
	self assert:(aGame positionOf: spaceShip2) equals:2.
	self assert:(spaceShip1 amountOfFuel) equals:5.
	self assert:(spaceShip2 amountOfFuel) equals:11.	
]

{ #category : #tests }
GameTest >> test09SpaceshipWantsToSkipTurnToHaveMaxFuel [


| aGame aBoard aDie1 spaceShip1 spaceShip2|
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:3
			withDistance: 10.


	aDie1 := SequenceDie of: {2. 2. 2. 3. 2. 2.}.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2.
							 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(spaceShip1 amountOfFuel) equals:6.
	self assert:(spaceShip2 amountOfFuel) equals:6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert:(aGame positionOf: spaceShip1) equals:3.
	self assert:(aGame positionOf: spaceShip2) equals:3.

	spaceShip1 wantsToSkipTurn.
	aGame playNextTurn.

	self assert:(aGame positionOf: spaceShip1) equals:3.
	self assert:(spaceShip1 amountOfFuel) equals:6.
	self assert:(aGame positionOf: spaceShip2) equals:5.

	aGame playNextTurn.

   self assert:(aGame positionOf: spaceShip1) equals:6.
]

{ #category : #tests }
GameTest >> test10LandingInAnEffectTileAfterBeingMovedByAnEffectDoesNotCauseAnotherEffect [


| aGame aBoard aDie1 spaceShip1 spaceShip2|
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          AtomicBombEffect new.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          BlackHoleEffect new.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:3
			withDistance: 10.


	aDie1 := LoadedDie of:5.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2.
							 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(aGame positionOf: spaceShip1) equals:1.
	self assert:(aGame positionOf: spaceShip2) equals:1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert:(aGame positionOf: spaceShip1) equals:2.
	self assert:(aGame positionOf: spaceShip2) equals:2.


]

{ #category : #tests }
GameTest >> test11Spaceship2IsTheFirstSpaceShipAtSpaceShipsRankingAsHisPositionIsTheClosestToTheFinish [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:4.
	self assert:(aGame positionOf:spaceShip2) equals:4.
	
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:1.

	self assert: aGame spaceShipsPositionsRanking first equals: spaceShip2.
	
	self assert: aGame spaceShipsPositionsRanking second equals: spaceShip1.
	
	

]

{ #category : #tests }
GameTest >> test12BlackHoleEffectWhenSpaceShipHasEnoughFuelItGoesFourTilesBackwards [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          BlackHoleEffect new.
			          NullEffect new.
			          NullEffect new. }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 5.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	self assert:(spaceShip1 amountOfFuel) equals:10.
	self assert:(spaceShip2 amountOfFuel) equals:10.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:2.
	self assert:(aGame positionOf:spaceShip2) equals:2.
	self assert:(spaceShip1 amountOfFuel) equals:1.
	self assert:(spaceShip2 amountOfFuel) equals:1.

	

]

{ #category : #tests }
GameTest >> test13BlackHoleEffectWhenSpaceShipRunsOutOfFuelItGoesToTheFirstTileRechargesFuelAndLosesTwoTurns [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          BlackHoleEffect new.
			          NullEffect new.
			          NullEffect new. }
			finishingAfter:2
			withDistance: 10.

	aDie1 := SequenceDie of:{1. 1. 4. 4.}.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	self assert:(spaceShip1 amountOfFuel) equals:8.
	self assert:(spaceShip2 amountOfFuel) equals:8.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:2.
	self assert:(aGame positionOf:spaceShip2) equals:2.
	self assert:(spaceShip1 amountOfFuel) equals:7.
	self assert:(spaceShip2 amountOfFuel) equals:7.

	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	self assert:(spaceShip1 amountOfFuel) equals:8.
	self assert:(spaceShip2 amountOfFuel) equals:8.
]

{ #category : #tests }
GameTest >> test14BlackHoleEffectWhenSpaceShipIsInTheFirstThreeTilesItGoesBackToThePreviousLapAndTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          NullEffect new.
				          BlackHoleEffect new.
				          NullEffect new.
				          NullEffect new.
				          NullEffect new.
				          NullEffect new. }
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 6. 6. 1. 1. }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: (spaceShip1 lap) equals:1.
	self assert: (spaceShip2 lap) equals:1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: (spaceShip1 lap) equals:2.
	self assert: (spaceShip2 lap) equals:2.
	
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 4.
	self assert: (aGame positionOf: spaceShip2) equals: 4.
	self assert: (spaceShip1 lap) equals:1.
	self assert: (spaceShip2 lap) equals:1.
	
]

{ #category : #tests }
GameTest >> test15SpaceshipEscapesOfTheHyperGravityEffectWhenItGetsACertainNumber [

	| aGame aBoard aDie1 spaceShip1 spaceShip2|
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aDie1 := SequenceDie of:{5. 5. 4. 4.}.
	aBoard := Board of: {
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          HyperGravityEffect needsToThrow: 4 below:aDie1 maxRoll.
			          NullEffect new.
			          NullEffect new. }
			finishingAfter:2
			withDistance: 10.


	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:6.
	self assert:(aGame positionOf:spaceShip2) equals:6.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:2.
	self assert:(aGame positionOf:spaceShip2) equals:2.
	

	


]

{ #category : #tests }
GameTest >> test16SpaceshipCannotEscapeFromTheHyperGravityEffectIfItDoesNotGetACertainNumber [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aDie1 := LoadedDie of: 5.
	aBoard := Board of: {
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          HyperGravityEffect needsToThrow: 4 below: aDie1 maxRoll.
			          NullEffect new.
			          NullEffect new. }
			finishingAfter:2
			withDistance: 10.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:6.
	self assert:(aGame positionOf:spaceShip2) equals:6.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:6.
	self assert:(aGame positionOf:spaceShip2) equals:6.

	

]

{ #category : #tests }
GameTest >> test17MoonWalkEffectWhenSpaceShipHasEnoughFuelItGoesNTilesBackwards [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          MoonWalkEffect backwardDistance:2.
			          NullEffect new.
			          NullEffect new. }
			finishingAfter:2
			withDistance: 10.

	aDie1 := SequenceDie of: {2. 3. 3.}.
	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:3.
	self assert:(aGame positionOf:spaceShip2) equals:4.
	spaceShip2 fuel:30.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:6.
	self assert:(aGame positionOf:spaceShip2) equals:2.

]

{ #category : #tests }
GameTest >> test18MoonWalkEffectWhenSpaceShipRunsOutOfFuelItGoesToTheFirstTileRechargesFuelAndLosesTwoTurns [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          NullEffect new.
			          MoonWalkEffect backwardDistance:4.
			          NullEffect new. }
			finishingAfter:2
			withDistance: 10.

	aDie1 := SequenceDie of: {2. 4. 4. 1. 1.}.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:3.
	self assert:(aGame positionOf:spaceShip2) equals:5.
	
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:7.
	self assert:(aGame positionOf:spaceShip2) equals:1.
]

{ #category : #tests }
GameTest >> test19MoonWalkEffectWhenSpaceShipIsInTheFirstThreeTilesItGoesBackToThePreviousLapAndTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          NullEffect new.
				          MoonWalkEffect backwardDistance:4.
				          NullEffect new.
				          NullEffect new.
				          NullEffect new.
				          NullEffect new. }
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 6. 6. 1. 1. }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: (spaceShip1 lap) equals:1.
	self assert: (spaceShip2 lap) equals:1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: (spaceShip1 lap) equals:2.
	self assert: (spaceShip2 lap) equals:2.
	
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 4.
	self assert: (spaceShip1 lap) equals:2.
	self assert: (spaceShip2 lap) equals:1.
	
]

{ #category : #tests }
GameTest >> test20HyperJumpEffectAssignsParsecsToSpaceshipAndItGoesForward [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 spaceShip3|
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	spaceShip3 := SpaceShip named: 'Joseph'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          HyperJumpEffect of:{3. 2. 1.}.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create.
			          NullEffect create. }
			finishingAfter: 2
			withDistance:10.
	aDie1 := SequenceDie of: { 3. 3. 3.}.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2.
							spaceShip3. }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: (aGame positionOf: spaceShip3) equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 6.
	self assert: (aGame positionOf: spaceShip2) equals: 5.
	self assert: (aGame positionOf: spaceShip3) equals: 4.
	
]

{ #category : #tests }
GameTest >> test21AtomicBombEffectSendsAllSpaceshipsBackToTheFirstTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2|
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          AtomicBombEffect new.
			          NullEffect create.
			          NullEffect create. }
			finishingAfter: 2
			withDistance:10.
	aDie1 := SequenceDie of: { 6. 6. 3. 3.}.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2. }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: (spaceShip1 lap) equals:1.
	self assert: (spaceShip2 lap) equals:1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: (spaceShip1 lap) equals:2.
	self assert: (spaceShip2 lap) equals:2.
	self assert: (spaceShip1 amountOfFuel) equals:6.
	self assert: (spaceShip2 amountOfFuel) equals:6.
	
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: (spaceShip1 lap) equals:2.
	self assert: (spaceShip2 lap) equals:2.
	self assert: (spaceShip1 amountOfFuel) equals:3.
	self assert: (spaceShip2 amountOfFuel) equals:3.
]

{ #category : #tests }
GameTest >> test22SequenceDie [

| aGame aBoard aDie1 spaceShip1 spaceShip2|

	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create. }
		          finishingAfter: 2
					withDistance: 10.

	aDie1 := SequenceDie of:{4. 3. 3.}.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.
	
	self assert:(aGame positionOf:spaceShip1) equals:1.
	self assert:(spaceShip1 lap) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:1.
	self assert:(spaceShip2 lap) equals:1.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:5.
	self assert:(spaceShip1 lap) equals:1.
	self assert:(aGame positionOf:spaceShip2) equals:4.
	self assert:(spaceShip2 lap) equals:1.
	
	aGame playNextTurn.
	
	self assert:(aGame positionOf:spaceShip1) equals:2.
	self assert:(spaceShip1 lap) equals:2.
]

{ #category : #tests }
GameTest >> testCantRollAfterGameEnded [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter: 1
			withDistance: 10.

	aDie1 := LoadedDie of: 9.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	aGame playNextTurn.
	
	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (spaceShip1 lap) equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'Game has already ended'
]

{ #category : #tests }
GameTest >> testGameHasEndedAsOneSpaceshipReachTheEnd [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter: 2
			withDistance: 10.			

	aDie1 := LoadedDie of: 9.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame positionOf: spaceShip1) equals: 3.
	self assert: (aGame positionOf: spaceShip2) equals: 3.
	
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (spaceShip1 lap) equals: 3.

	
	
	self assert: aGame hasEnded.
]

{ #category : #tests }
GameTest >> testGameIsPlayedWithTwoDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 3.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDiceRoller.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	aGame playNextTurn.
	self deny: aGame hasEnded.
	self assert: (aGame positionOf: spaceShip1) equals: 7.
	self assert: (aGame positionOf: spaceShip2) equals: 1
]

{ #category : #tests }
GameTest >> testGameMustHaveAtLeastOnePlayer [

	| aBoard aDie1 |
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 3.


	self
		should: [ Game playedBy: {  } on: aBoard rolling: aDie1 ]
		raise: Error
		withMessage: 'Game must have at least one player'
]

{ #category : #tests }
GameTest >> testGameWithLoadedDieOfFiveFaces [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 5.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.
	self assert: (aGame positionOf: spaceShip1) equals: 1.

	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip1) equals: 6
]

{ #category : #tests }
GameTest >> testGameWithRandomDie [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := Die of: 3.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self deny: aGame hasEnded.
	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testGameWithTwoRandomDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.
	aDie1 := Die of: 3.
	aDie2 := Die of: 5.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.
	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self deny: aGame hasEnded.
	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testIsInvalidWhenTheWinnerIsNotAssignedCorrectly [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 9.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.


	self deny: aGame winner name equals: 'Walter'
]

{ #category : #tests }
GameTest >> testIsValidWhenTheWinnerIsAssignedCorrectly [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 8.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	
	self assert: aGame winner name equals: 'Danny'
]

{ #category : #tests }
GameTest >> testPlayerOneCanRollTheDiceAfterPlayerTwoTurn [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 4.
	self assert: (aGame positionOf: spaceShip2) equals: 4.
	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip1) equals: 1.

]

{ #category : #tests }
GameTest >> testSpaceshipsStartAtFirstTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1
]

{ #category : #tests }
GameTest >> testTurnsWhenThreePlayersArePLaying [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 spaceShip3 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	spaceShip3 := SpaceShip named: 'Joseph'.


	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2.
				         spaceShip3 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip1) equals: 4.

	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip2) equals: 4.

	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip3) equals: 4
]

{ #category : #tests }
GameTest >> testWormholeGoesBackwards [

	| aGame wormholeTile3 wormholeTile5 aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	wormholeTile3 := WormholeEffect betweenTiles: { 3. 5 }.
	wormholeTile5 := WormholeEffect betweenTiles: { 5. 3 }.

	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          wormholeTile3.
			          NullEffect create.
			          wormholeTile5.
			          NullEffect create.
			          NullEffect create }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 4.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 3
]

{ #category : #tests }
GameTest >> testWormholeGoesForward [

	| aGame wormholeTile8 wormholeTile12 aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	wormholeTile8 := WormholeEffect betweenTiles: { 8. 12}.
	wormholeTile12 := WormholeEffect betweenTiles: { 12. 8 }.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          wormholeTile8.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create.
			          wormholeTile12 .
						 NullEffect create.
			}
			finishingAfter:2
			withDistance: 10.
	aDie1 := LoadedDie of: 7.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 12
]

{ #category : #tests }
GameTest >> testWormholeIsNotOnANormalTile [

	| aGame wormholeTile3 wormholeTile7 aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	wormholeTile3 := WormholeEffect betweenTiles: { 3. 7 }.
	wormholeTile7 := WormholeEffect betweenTiles: { 7. 3 }.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          wormholeTile3.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          wormholeTile7 }
			finishingAfter:2
			withDistance: 10.

	aDie1 := LoadedDie of: 4.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 5
]
