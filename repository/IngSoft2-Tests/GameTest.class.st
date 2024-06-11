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
			          Null create.
			          Null create.
			          Null create.
			          Null create.
			          Null create.
			          Null create.
			          Null create }
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
GameTest >> testFV01GameMustHaveAtLeastOnePlayer [

	| aBoard aDie1 |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := LoadedDie of: 3.


	self
		should: [ Game playedBy: {  } on: aBoard rolling: aDie1 ]
		raise: Error
		withMessage: 'Game must have at least one player'
]

{ #category : #tests }
GameTest >> testFV02SpaceshipsStartAtFirstTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
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
GameTest >> testFV03GameHasEndedAsOneSpaceshipReachTheEnd [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
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
	self assert: spaceShip1 lap equals: 3.



	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testFV04CantRollAfterGameEnded [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
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
	self assert: spaceShip1 lap equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'Game has already ended'
]

{ #category : #tests }
GameTest >> testFV05IsValidWhenTheWinnerIsAssignedCorrectly [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
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
GameTest >> testFV06GameIsPlayedWithTwoDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 2
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
GameTest >> testFV07GameWithRandomDie [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
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
GameTest >> testFV08GameWithTwoRandomDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
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
GameTest >> testFV09PlayerOneCanRollTheDiceAfterPlayerTwoTurn [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
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
	self assert: (aGame positionOf: spaceShip1) equals: 1
]

{ #category : #tests }
GameTest >> testFV10TurnsWhenThreePlayersArePLaying [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 spaceShip3 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	spaceShip3 := SpaceShip named: 'Joseph'.


	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
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
GameTest >> testFV11WormholeGoesBackwards [

	| aGame wormholeTile3 wormholeTile5 aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	wormholeTile3 := Wormhole betweenTiles: { 3. 5 }.
	wormholeTile5 := Wormhole betweenTiles: { 5. 3 }.

	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          wormholeTile3.
				          Null create.
				          wormholeTile5.
				          Null create.
				          Null create }
		          finishingAfter: 2
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
GameTest >> testFV12WormholeGoesForward [

	| aGame wormholeTile8 wormholeTile12 aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	wormholeTile8 := Wormhole betweenTiles: { 8. 12 }.
	wormholeTile12 := Wormhole betweenTiles: { 12. 8 }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          wormholeTile8.
				          Null create.
				          Null create.
				          Null create.
				          wormholeTile12.
				          Null create }
		          finishingAfter: 2
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
GameTest >> testFV13WormholeIsNotOnANormalTile [

	| aGame wormholeTile3 wormholeTile7 aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	wormholeTile3 := Wormhole betweenTiles: { 3. 7 }.
	wormholeTile7 := Wormhole betweenTiles: { 7. 3 }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          wormholeTile3.
				          Null create.
				          Null create.
				          Null create.
				          wormholeTile7 }
		          finishingAfter: 2
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

{ #category : #tests }
GameTest >> testSV01PlayersStartAtLapOne [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
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
	self assert: spaceShip1 lap equals: 1.
	self assert: spaceShip2 lap equals: 1
]

{ #category : #tests }
GameTest >> testSV02PlayerChangesLapAfterPassingTheLastTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 6. 6. 2. 2 }.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: spaceShip1 lap equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip2 lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 7.
	self assert: spaceShip1 lap equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 7.
	self assert: spaceShip2 lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 2.
	self assert: spaceShip1 lap equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 2.
	self assert: spaceShip2 lap equals: 2
]

{ #category : #tests }
GameTest >> testSV03PlayersWinsAfterCompletingAnAmountOfLaps [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 6. 3. 6. 3 }.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: spaceShip1 lap equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip2 lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: spaceShip1 lap equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 4.
	self assert: spaceShip2 lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: spaceShip1 lap equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip2 lap equals: 2.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: spaceShip1 lap equals: 3.

	self assert: aGame winner equals: spaceShip1
]

{ #category : #tests }
GameTest >> testSV04GameMustHaveOneOrMoreLaps [

	self
		should: [
			Board
				of: {
						Null create.
						Null create }
				finishingAfter: 0
				withDistance: 10 ]
		raise: Error
		withMessage: 'Game must have one or more laps!'
]

{ #category : #tests }
GameTest >> testSV05EverySpaceshipStartsWithAmountOfFuelEqualToTheDoubleOfTheDiceMaxRoll [

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 2
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

	self assert: spaceShip1 amountOfFuel equals: 12.
	self assert: spaceShip2 amountOfFuel equals: 12
]

{ #category : #tests }
GameTest >> testSV06WhenASpaceshipMovesItHasLessFuel [

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 2
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

	self assert: spaceShip1 amountOfFuel equals: 12.
	self assert: spaceShip2 amountOfFuel equals: 12.


	aGame playNextTurn.

	self assert: spaceShip1 amountOfFuel equals: 6
]

{ #category : #tests }
GameTest >> testSV07WhenASpaceshipRunsOutOfFuelItGoesBackToTileOneInLapBeforeMovementAndRechargesFuel [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := LoadedDie of: 6.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 amountOfFuel equals: 12.
	self assert: spaceShip2 amountOfFuel equals: 12.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 7.
	self assert: (aGame positionOf: spaceShip2) equals: 7.
	self assert: spaceShip1 amountOfFuel equals: 6.
	self assert: spaceShip2 amountOfFuel equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 lap equals: 1.
	self assert: spaceShip2 lap equals: 1.
	self assert: spaceShip1 amountOfFuel equals: 12.
	self assert: spaceShip2 amountOfFuel equals: 12
]

{ #category : #tests }
GameTest >> testSV08WhenASpaceshipRunsOutOfFuelAlsoItLosesTwoTurns [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 2. 6. 2. 6. 1. 1. 1. 1 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: spaceShip1 amountOfFuel equals: 12.
	self assert: spaceShip2 amountOfFuel equals: 12.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 3.
	self assert: (aGame positionOf: spaceShip2) equals: 7.
	self assert: spaceShip1 amountOfFuel equals: 10.
	self assert: spaceShip2 amountOfFuel equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 5.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 amountOfFuel equals: 8.
	self assert: spaceShip2 amountOfFuel equals: 12.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 8.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 amountOfFuel equals: 5.
	self assert: spaceShip2 amountOfFuel equals: 12.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 8.
	self assert: (aGame positionOf: spaceShip2) equals: 2.
	self assert: spaceShip1 amountOfFuel equals: 5.
	self assert: spaceShip2 amountOfFuel equals: 11
]

{ #category : #tests }
GameTest >> testSV09SpaceshipWantsToSkipTurnToHaveMaxFuel [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 3
		          withDistance: 10.


	aDie1 := SequenceDie of: { 2. 2. 2. 3. 2. 2 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: spaceShip1 amountOfFuel equals: 6.
	self assert: spaceShip2 amountOfFuel equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 3.
	self assert: (aGame positionOf: spaceShip2) equals: 3.

	spaceShip1 wantsToSkipTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 3.
	self assert: spaceShip1 amountOfFuel equals: 6.
	self assert: (aGame positionOf: spaceShip2) equals: 5.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 6
]

{ #category : #tests }
GameTest >> testSV10LandingInAnEffectTileAfterBeingMovedByAnEffectDoesNotCauseAnotherEffect [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 3
		          withDistance: 10.


	aDie1 := LoadedDie of: 5.

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

	self assert: (aGame positionOf: spaceShip1) equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 2
]

{ #category : #tests }
GameTest >> testSV11Spaceship2IsTheFirstSpaceShipAtSpaceShipsRankingAsHisPositionIsTheClosestToTheFinish [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := LoadedDie of: 3.

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

	self assert: (aGame positionOf: spaceShip1) equals: 4.
	self assert: (aGame positionOf: spaceShip2) equals: 4.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.

	self
		assert: aGame spaceShipsPositionsRanking first
		equals: spaceShip2.

	self
		assert: aGame spaceShipsPositionsRanking second
		equals: spaceShip1
]

{ #category : #tests }
GameTest >> testSV12BlackHoleEffectWhenSpaceShipHasEnoughFuelItGoesFourTilesBackwards [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          Null  new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          BlackHole new.
				          Null new.
				          Null new }
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := LoadedDie of: 5.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 amountOfFuel equals: 10.
	self assert: spaceShip2 amountOfFuel equals: 10.


	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 2.
	self assert: spaceShip1 amountOfFuel equals: 1.
	self assert: spaceShip2 amountOfFuel equals: 1
]

{ #category : #tests }
GameTest >> testSV13BlackHoleEffectWhenSpaceShipRunsOutOfFuelItGoesToTheFirstTileRechargesFuelAndLosesTwoTurns [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 1. 1. 4. 4 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 amountOfFuel equals: 8.
	self assert: spaceShip2 amountOfFuel equals: 8.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 2.
	self assert: spaceShip1 amountOfFuel equals: 7.
	self assert: spaceShip2 amountOfFuel equals: 7.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 amountOfFuel equals: 8.
	self assert: spaceShip2 amountOfFuel equals: 8
]

{ #category : #tests }
GameTest >> testSV14BlackHoleEffectWhenSpaceShipIsInTheFirstThreeTilesItGoesBackToThePreviousLapAndTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          Null new.
				          BlackHole new.
				          Null new.
				          Null new.
				          Null new.
				          Null new }
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 6. 6. 1. 1 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 lap equals: 1.
	self assert: spaceShip2 lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 lap equals: 2.
	self assert: spaceShip2 lap equals: 2.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 4.
	self assert: (aGame positionOf: spaceShip2) equals: 4.
	self assert: spaceShip1 lap equals: 1.
	self assert: spaceShip2 lap equals: 1
]

{ #category : #tests }
GameTest >> testSV15SpaceshipEscapesOfTheHyperGravityEffectWhenItGetsACertainNumber [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aDie1 := SequenceDie of: { 5. 5. 4. 4 }.
	aBoard := Board
		          of: {
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          (HyperGravity
					           needsToThrow: 4
					           above: aDie1 minRoll
					           below: aDie1 maxRoll).
				          Null new.
				          Null new }
		          finishingAfter: 2
		          withDistance: 10.


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

	self assert: (aGame positionOf: spaceShip1) equals: 6.
	self assert: (aGame positionOf: spaceShip2) equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 2.
	self assert: (aGame positionOf: spaceShip2) equals: 2
]

{ #category : #tests }
GameTest >> testSV16SpaceshipCannotEscapeFromTheHyperGravityEffectIfItDoesNotGetACertainNumber [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aDie1 := LoadedDie of: 5.
	aBoard := Board
		          of: {
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          Null new.
				          (HyperGravity
					           needsToThrow: 4
					           above: aDie1 minRoll
					           below: aDie1 maxRoll).
				          Null new.
				          Null new }
		          finishingAfter: 2
		          withDistance: 10.

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

	self assert: (aGame positionOf: spaceShip1) equals: 6.
	self assert: (aGame positionOf: spaceShip2) equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 6.
	self assert: (aGame positionOf: spaceShip2) equals: 6
]

{ #category : #tests }
GameTest >> testSV17MoonWalkEffectWhenSpaceShipHasEnoughFuelItGoesNTilesBackwards [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 2. 3. 3 }.
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
	self assert: (aGame positionOf: spaceShip2) equals: 4.
	spaceShip2 fuel: 30.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 6.
	self assert: (aGame positionOf: spaceShip2) equals: 2
]

{ #category : #tests }
GameTest >> testSV18MoonWalkEffectWhenSpaceShipRunsOutOfFuelItGoesToTheFirstTileRechargesFuelAndLosesTwoTurns [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
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
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 2. 4. 4. 1. 1 }.

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
	self assert: (aGame positionOf: spaceShip2) equals: 5.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 7.
	self assert: (aGame positionOf: spaceShip2) equals: 1
]

{ #category : #tests }
GameTest >> testSV19MoonWalkEffectWhenSpaceShipIsInTheFirstThreeTilesItGoesBackToThePreviousLapAndTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          Null new.
				          (MoonWalk backwardDistance: 4).
				          Null new.
				          Null new.
				          Null new.
				          Null new }
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 6. 6. 1. 1 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 lap equals: 1.
	self assert: spaceShip2 lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 lap equals: 2.
	self assert: spaceShip2 lap equals: 2.

	aGame playNextTurn.
	aGame playNextTurn.


	self assert: spaceShip1 lap equals: 2.
	self assert: spaceShip2 lap equals: 1
]

{ #category : #tests }
GameTest >> testSV20HyperJumpEffectAssignsParsecsToSpaceshipAndItGoesForward [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 spaceShip3 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	spaceShip3 := SpaceShip named: 'Joseph'.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (HyperJump of: { 3. 2 }).
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withDistance: 10.
	aDie1 := SequenceDie of: { 3. 3. 3 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2.
				         spaceShip3 }
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
	self assert: (aGame positionOf: spaceShip3) equals: 6
]

{ #category : #tests }
GameTest >> testSV21AtomicBombEffectSendsAllSpaceshipsBackToTheFirstTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          AtomicBomb new.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withDistance: 10.
	aDie1 := SequenceDie of: { 6. 4. 3. 3. 6. 6. 20 }.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 lap equals: 1.
	self assert: spaceShip2 lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 5.
	self assert: spaceShip1 lap equals: 2.
	self assert: spaceShip2 lap equals: 1.
	self assert: spaceShip1 amountOfFuel equals: 34.
	self assert: spaceShip2 amountOfFuel equals: 36.

	aGame playNextTurn.


	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip1 lap equals: 2.
	self assert: spaceShip2 lap equals: 1.
	self assert: spaceShip1 amountOfFuel equals: 31.
	self assert: spaceShip2 amountOfFuel equals: 36
]

{ #category : #tests }
GameTest >> testSV22SequenceDie [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withDistance: 10.

	aDie1 := SequenceDie of: { 4. 3. 3 }.
	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: spaceShip1 lap equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	self assert: spaceShip2 lap equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 5.
	self assert: spaceShip1 lap equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 4.
	self assert: spaceShip2 lap equals: 1.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 2.
	self assert: spaceShip1 lap equals: 2
]

{ #category : #tests }
GameTest >> testSV23GameWithRandomBoardAndRandomDie [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 effectDistribution randomCollection aDie2 aDiceRoller |
	aDie1 := Die of: 3.
	aDie2 := Die of: 4.
	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.
	effectDistribution := EffectDistribution with: {
			                      (ProbabilityTile
				                       with: Null new
				                       and: 0.40).
			                      (ProbabilityTile
				                       with: BlackHole new
				                       and: 0.20).
			                      (ProbabilityTile
				                       with: (HyperGravity
						                        needsToThrow: 3
						                        above: aDiceRoller minRoll
						                        below: 6)
				                       and: 0.20).
			                      (ProbabilityTile
				                       with: (MoonWalk backwardDistance: 3)
				                       and: 0.10).
			                      (ProbabilityTile
				                       with: (HyperJump of: { 3. 2. 1 })
				                       and: 0.08).
			                      (ProbabilityTile
				                       with: AtomicBomb new
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 5.

	aBoard := Board
		          of: randomCollection
		          finishingAfter: 2
		          withDistance: 10.

	spaceShip1 := SpaceShip named: 'Danny'.
	spaceShip2 := SpaceShip named: 'Walter'.

	aGame := Game
		         playedBy: {
				         spaceShip1.
				         spaceShip2 }
		         on: aBoard
		         rolling: aDiceRoller.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]
