Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #playing }
GameTest >> playUntilFinished: aGame [ 
	[aGame hasEnded] whileFalse:[aGame playNextTurn]
]

{ #category : #asserting }
GameTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should:anErrorBlock raise:anErrorClass withExceptionDo:[:error|self assert:error messageText equals:anErrorMessage].
]

{ #category : #playing }
GameTest >> standardGameInitializationWithLoadedDieOf3And2PlayersAnd7NormalTiles [
	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create.
						 NullEffect create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
		         on: aBoard
		         rolling: aDie1.
	^aGame

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
			          NullEffect create. }.

	aDie1 := LoadedDie of: 6.
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.

	aGame := Game
		         playedBy: {spaceShip1  . spaceShip2   }
		         on: aBoard
		         rolling: aDie1.

	self deny: aGame hasEnded.
	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	aGame playNextTurn.
	self assert: aGame hasEnded.
	self assert: (aGame positionOf: spaceShip1) equals: 7.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'Game has already ended'
]

{ #category : #tests }
GameTest >> testGameHasEndedAsOneSpaceshipReachTheEnd [
	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create.
						 NullEffect create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1.

	aGame playNextTurn.
	self deny: aGame hasEnded.
	self assert: (aGame positionOf: spaceShip1) equals: 4.
	self assert: (aGame positionOf: spaceShip2) equals: 1.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: aGame hasEnded.
	self assert: (aGame positionOf: spaceShip1) equals: 7.
	self assert: (aGame positionOf: spaceShip2) equals: 4
]

{ #category : #tests }
GameTest >> testGameIsPlayedWithTwoDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2|
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create. }.

	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 3.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: {spaceShip1. spaceShip2 }
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
GameTest >> testGameMustHaveAtLeastOneSpaceship [

	|aBoard aDie1 |

	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create. }.

	aDie1 := LoadedDie of: 3.


	self
		should: [ Game playedBy: {  } on: aBoard rolling: aDie1 ]
		raise: Error
		withMessage: 'Game must have at least one player'
]

{ #category : #tests }
GameTest >> testGameWithLoadedDieOfFiveFaces [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create. }.

	aDie1 := LoadedDie of: 5.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
		         on: aBoard
		         rolling: aDie1.
	self assert: (aGame positionOf: spaceShip1) equals: 1.

	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip1) equals: 6
]

{ #category : #tests }
GameTest >> testGameWithRandomDie [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create. }.

	aDie1 := Die of: 3.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
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

	| aGame aBoard aDie1 aDie2 aDiceRoller spaceShip1 spaceShip2|
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create. }.

	aDie1 := Die of: 3.
	aDie2 := Die of: 5.
	
	aDiceRoller :=DiceRoller of:{aDie1. aDie2.}.
	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
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
			          NullEffect create. }.

	aDie1 := LoadedDie of: 6.
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.

	aGame := Game
		         playedBy: {spaceShip1  . spaceShip2   }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	self deny: (aGame winner) nameGetter  equals: 'Walter'
]

{ #category : #tests }
GameTest >> testIsValidWhenTheWinnerIsAssignedCorrectly [

	|aGame|
	
	aGame := self standardGameInitializationWithLoadedDieOf3And2PlayersAnd7NormalTiles.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: aGame winner nameGetter equals: 'Danny'
]

{ #category : #tests }
GameTest >> testPlayerOneCanRollTheDiceAfterPlayerTwoTurn [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create.
						 NullEffect create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
		         on: aBoard
		         rolling: aDie1.
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame positionOf: spaceShip1) equals: 4.
	self assert: (aGame positionOf: spaceShip2) equals: 4.
	self assert: aGame turnOf equals: spaceShip1
	

]

{ #category : #tests }
GameTest >> testPlayerTwoCanRollTheDiceAfterPlayerOneTurn [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create.
						 NullEffect create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	self assert: (aGame positionOf:spaceShip1 ) equals: 4.
	self assert: aGame turnOf equals: spaceShip2
]

{ #category : #tests }
GameTest >> testSpaceshipsStartAtFirstTile [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create.
						 NullEffect create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: spaceShip1) equals: 1.
	self assert: (aGame positionOf: spaceShip2) equals: 1
]

{ #category : #tests }
GameTest >> testTurnsWhenThreePlayersArePLaying [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 spaceShip3|
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	spaceShip3:=SpaceShip named:'Joseph'.


	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2.spaceShip3 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip1) equals: 4.
		
	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip2) equals: 4.
	
	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip3 ) equals: 4.

]

{ #category : #tests }
GameTest >> testWhenItIsPlayerTwoTurnPlayerOneCantRoll [

	| aGame aBoard aDie1 spaceShip1 spaceShip2 |
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
						 NullEffect create.
						 NullEffect create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	self assert: (aGame positionOf: spaceShip1) equals: 4.
	self deny: aGame turnOf equals: spaceShip1
]

{ #category : #tests }
GameTest >> testWormholeGoesBackwards [

	| aGame wormholeTile3 wormholeTile5 aBoard aDie1 spaceShip1 spaceShip2|
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	wormholeTile3 := WormholeEffect create:{3. 5}.
	wormholeTile5 := WormholeEffect create:{5. 3}.

	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          wormholeTile3.
			          NullEffect create.
			          wormholeTile5.
			          NullEffect create.
			          NullEffect create. }.

	aDie1 := LoadedDie of: 4.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 3
]

{ #category : #tests }
GameTest >> testWormholeGoesForward [

	| aGame wormholeTile4 wormholeTile7 aBoard aDie1 spaceShip1 spaceShip2|
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	wormholeTile4 := WormholeEffect create: {4. 7}.
	wormholeTile7 := WormholeEffect create: {7. 4}.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          wormholeTile4.
			          NullEffect create.
			          NullEffect create.
			          wormholeTile7 }.
	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2}
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 7
]

{ #category : #tests }
GameTest >> testWormholeIsNotOnANormalTile [

	| aGame wormholeTile3 wormholeTile7 aBoard aDie1 spaceShip1 spaceShip2|
	spaceShip1:=SpaceShip named:'Danny'.
	spaceShip2:=SpaceShip named:'Walter'.
	wormholeTile3 := WormholeEffect create: {3. 7}.
	wormholeTile7 := WormholeEffect create: {7. 3}.
	aBoard := Board of: {
			          NullEffect create.
			          NullEffect create.
			          wormholeTile3.
			          NullEffect create.
			          NullEffect create.
			          NullEffect create.
			          wormholeTile7 }.

	aDie1 := LoadedDie of: 4.

	aGame := Game
		         playedBy: { spaceShip1. spaceShip2 }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.

	self assert: (aGame positionOf: spaceShip1) equals: 5
]
