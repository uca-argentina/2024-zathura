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

{ #category : #tests }
GameTest >> testCantRollAfterGameEnded [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 6.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	self deny: aGame hasEnded.
	self assert: (aGame positionOf: 'Danny') equals: 1.
	self assert: (aGame positionOf: 'Walter') equals: 1.

	aGame playNextTurn.
	self assert: aGame hasEnded.
	self assert: (aGame positionOf: 'Danny') equals: 7.
	self assert: (aGame positionOf: 'Walter') equals: 1.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'Game has already ended'
]

{ #category : #tests }
GameTest >> testGameHasEndedAsOneSpaceshipReachTheEnd [
	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: 'Danny') equals: 1.
	self assert: (aGame positionOf: 'Walter') equals: 1.

	aGame playNextTurn.
	self deny: aGame hasEnded.
	self assert: (aGame positionOf: 'Danny') equals: 4.
	self assert: (aGame positionOf: 'Walter') equals: 1.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: aGame hasEnded.
	self assert: (aGame positionOf: 'Danny') equals: 7.
	self assert: (aGame positionOf: 'Walter') equals: 4
]

{ #category : #tests }
GameTest >> testGameHasNotEndedAsNoSpaceshipReachedTheEnd [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	self deny: aGame hasEnded
]

{ #category : #tests }
GameTest >> testGameIsPlayedWithTwoDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller|

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
						 Tile create. }.

	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 3.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDiceRoller.

	self assert: (aGame positionOf: 'Danny') equals: 1.
	self assert: (aGame positionOf: 'Walter') equals: 1.

	aGame playNextTurn.
	self deny: aGame hasEnded.
	self assert: (aGame positionOf: 'Danny') equals: 7.
	self assert: (aGame positionOf: 'Walter') equals: 1
]

{ #category : #tests }
GameTest >> testGameMustHaveAtLeastOneSpaceship [

	|aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 3.


	self
		should: [ Game playedBy: {  } on: aBoard rolling: aDie1 ]
		raise: Error
		withMessage: 'Game must have at least one player'
]

{ #category : #tests }
GameTest >> testGameWithRandomDie [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := Die of: 3.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	self deny: aGame hasEnded.
	self assert: (aGame positionOf: 'Danny') equals: 1.
	self assert: (aGame positionOf: 'Walter') equals: 1.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testGameWithTwoRandomDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := Die of: 3.
	aDie2 := Die of: 5.
	
	aDiceRoller :=DiceRoller of:{aDie1. aDie2.}.
	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	self deny: aGame hasEnded.
	self assert: (aGame positionOf: 'Danny') equals: 1.
	self assert: (aGame positionOf: 'Walter') equals: 1.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testIsInvalidWhenThereIsNoWinner [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	self deny: aGame winner
]

{ #category : #tests }
GameTest >> testIsValidWhenThereIsWinner [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: aGame winner equals: 'Danny'
]

{ #category : #tests }
GameTest >> testPlayerOneCanRollTheDiceAfterPlayerTwoTurn [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.
			
	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Player1'. 'Player2' }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: 'Player1') equals: 4.
	self assert: (aGame positionOf: 'Player2') equals: 4.
	self assert: aGame turnOf equals: 'Player1'
]

{ #category : #tests }
GameTest >> testPlayerTwoCanRollTheDiceAfterPlayerOneTurn [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Player1'. 'Player2' }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	self assert: (aGame positionOf: 'Player1') equals: 4.
	self assert: aGame turnOf equals: 'Player2'
]

{ #category : #tests }
GameTest >> testPlayingUntilWinning [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.
			
	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	self deny: aGame hasEnded
]

{ #category : #tests }
GameTest >> testScoreboardIsValidWhenSomeonesWins [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testSpaceshipMovesFiveTiles [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 5.

	aGame := Game
		         playedBy: { 'Walter'. 'Danny' }
		         on: aBoard
		         rolling: aDie1.
	self assert: (aGame positionOf: 'Walter') equals: 1.

	aGame playNextTurn.
	self assert: (aGame positionOf: 'Walter') equals: 6
]

{ #category : #tests }
GameTest >> testSpaceshipsStartAtFirstTile [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.
	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	self assert: (aGame positionOf: 'Danny') equals: 1.
	self assert: (aGame positionOf: 'Walter') equals: 1
]

{ #category : #tests }
GameTest >> testWhenItIsPlayerTwoTurnPlayerOneCantRoll [

	| aGame aBoard aDie1 |

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Player1'. 'Player2' }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.
	self assert: (aGame positionOf: 'Player1') equals: 4.
	self deny: aGame turnOf equals: 'Player1'
]

{ #category : #tests }
GameTest >> testWormholeGoesBackwards [

	| aGame wormholeTile3 wormholeTile5 aBoard aDie1|
	wormholeTile3 := WormholeTile create.
	wormholeTile5 := WormholeTile create.
	wormholeTile5 linkATileToTheWormhole: wormholeTile3.
	wormholeTile3 linkATileToTheWormhole: wormholeTile5.

	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          wormholeTile3.
			          Tile create.
			          wormholeTile5.
			          Tile create.
			          Tile create. }.

	aDie1 := LoadedDie of: 4.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Danny') equals: 3
]

{ #category : #tests }
GameTest >> testWormholeGoesForward [

	| aGame wormholeTile4 wormholeTile7 aBoard aDie1|
	wormholeTile4 := WormholeTile create.
	wormholeTile7 := WormholeTile create.
	wormholeTile7 linkATileToTheWormhole: wormholeTile4.
	wormholeTile4 linkATileToTheWormhole: wormholeTile7.
	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          Tile create.
			          wormholeTile4.
			          Tile create.
			          Tile create.
			          wormholeTile7 }.
	aDie1 := LoadedDie of: 3.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Danny') equals: 7
]

{ #category : #tests }
GameTest >> testWormholeIsNotOnANormalTile [

	| aGame wormholeTile3 wormholeTile7 aBoard aDie1|
	wormholeTile3 := WormholeTile create.
	wormholeTile7 := WormholeTile create.
	wormholeTile3 linkATileToTheWormhole: wormholeTile7.
	wormholeTile7 linkATileToTheWormhole: wormholeTile3.
	aBoard := Board ofTiles: {
			          Tile create.
			          Tile create.
			          wormholeTile3.
			          Tile create.
			          Tile create.
			          Tile create.
			          wormholeTile7 }.

	aDie1 := LoadedDie of: 4.

	aGame := Game
		         playedBy: { 'Danny'. 'Walter' }
		         on: aBoard
		         rolling: aDie1.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Danny') equals: 5
]
