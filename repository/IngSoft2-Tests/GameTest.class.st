Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should:anErrorBlock raise:anErrorClass withExceptionDo:[:error|self assert:error messageText equals:anErrorMessage].
]

{ #category : #tests }
GameTest >> testCantRollAfterGameEnded [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|
	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.
	
	aDie1 := LoadedDie of: 6.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'} ).
				
	self deny: (aGame hasEnded).
	self assert: (aGame positionOf: 'Danny')  equals: 1.
	self assert: ( aGame positionOf: 'Walter' )  equals: 1.
	
aGame rollDiceCup.
	self assert: (aGame hasEnded).
	self assert: (aGame positionOf: 'Danny')  equals: 7.
	self assert: ( aGame positionOf: 'Walter' )  equals: 1.
	
self should:[aGame rollDiceCup] raise: Error withMessage: 'Game has already ended'
]

{ #category : #tests }
GameTest >> testGameHasEndedAsOnePlayerReachTheEnd [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.

aGame:= Game withBoard: aBoard diceCollection:aDiceRoller players: ({'Danny'.'Walter'}).

	self assert: ( aGame positionOf: 'Danny' )  equals: 1.
	self assert: ( aGame positionOf: 'Walter' )  equals: 1.
	
aGame rollDiceCup.
	self deny: (aGame hasEnded).
	self assert: (aGame positionOf: 'Danny')  equals: 4.
	self assert: ( aGame positionOf: 'Walter' )  equals: 1.
aGame rollDiceCup.
aGame rollDiceCup.
	self assert: (aGame hasEnded).
	self assert: (aGame positionOf: 'Danny')  equals: 7.
	self assert: ( aGame positionOf: 'Walter' )  equals: 4.
]

{ #category : #tests }
GameTest >> testGameHasNotEndedAsNoPlayerReachedTheEnd [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.

aGame:= Game withBoard: aBoard diceCollection:aDiceRoller players: ({'Danny'.'Walter'}).

self deny: (aGame hasEnded).
	self assert: ( aGame positionOf: 'Danny' ) equals: 1.
	self assert: ( aGame positionOf: 'Walter' ) equals: 1.
	
aGame rollDiceCup.

self assert: (aGame positionOf: 'Danny') equals: 4.
self deny: (aGame hasEnded).
]

{ #category : #tests }
GameTest >> testGameMustHaveAtLeastOnePlayer [

| aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.


self should:[Game withBoard: aBoard diceCollection:aDiceRoller players: {}] raise: Error 
withMessage: 'Game must have at least one player'.
]

{ #category : #tests }
GameTest >> testIsInvalidWhenThereIsNoWinner [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|
	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.
	
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'} ).
				
	self deny: (aGame winner).		
]

{ #category : #tests }
GameTest >> testIsValidWhenThereIsWinner [

	| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller |
	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

	aBoard := Board ofTiles: {
			          aTile1.
			          aTile2.
			          aTile3.
			          aTile4.
			          aTile5.
			          aTile6.
			          aTile7 }.

	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game
		         withBoard: aBoard
		         diceCollection: aDiceRoller
		         players: { 'Danny'. 'Walter' }.
	aGame rollDiceCup.
	aGame rollDiceCup.
	aGame rollDiceCup.
	self assert: aGame winner equals: 'Danny'
]

{ #category : #tests }
GameTest >> testPlayer1CanRollTheDiceAfterPlayer2Turn [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.

aGame:= Game withBoard: aBoard diceCollection:aDiceRoller players: ({'Player1'.'Player2'}).
	
aGame rollDiceCup.
aGame rollDiceCup.
	self assert: (aGame positionOf: 'Player1')  equals: 4.
	self assert: ( aGame positionOf: 'Player2' )  equals: 4.
	self assert: ( aGame turnOf) equals: 'Player1' .
	
]

{ #category : #tests }
GameTest >> testPlayer2CanRollTheDiceAfterPlayer1Turn [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.

aGame:= Game withBoard: aBoard diceCollection:aDiceRoller players: ({'Player1'.'Player2'}).
	
aGame rollDiceCup.
	self assert: (aGame positionOf: 'Player1')  equals: 4.
	self assert: ( aGame turnOf) equals: 'Player2'.
	
]

{ #category : #tests }
GameTest >> testPlayerMovesFiveTiles [
| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

	aTile1 := NormalTile  ofTiles .
	aTile2 := NormalTile ofTiles .
	aTile3 := NormalTile ofTiles .
	aTile4 := NormalTile ofTiles .
	aTile5 := NormalTile ofTiles .
	aTile6 := NormalTile ofTiles .
	aTile7 := NormalTile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 5.
aDiceRoller:=DiceRoller of:{aDie1}.

aGame:= Game withBoard: aBoard diceCollection:aDiceRoller players: ({'Walter'.'Danny'}).
	self assert: ( aGame positionOf: 'Walter' ) equals: 1.
	
aGame rollDiceCup.
	self assert: ( aGame positionOf: 'Walter' ) equals: 6.
]

{ #category : #tests }
GameTest >> testPlayersStartAtFirstTile [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|
	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.
	
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'} ).
				
	self assert: (aGame positionOf: 'Danny') equals: 1.
	self assert: (aGame positionOf: 'Walter') equals: 1.
]

{ #category : #tests }
GameTest >> testPlayingUntilWinning [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|
	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.
	
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'} ).
				
	self deny: (aGame hasEnded).	
]

{ #category : #tests }
GameTest >> testScoreboardIsValidWhenSomeonesWins [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|
	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.
	
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'} ).
	aGame rollDiceCup.
	aGame rollDiceCup.
	aGame rollDiceCup.
	self assert: (aGame hasEnded).	
]

{ #category : #tests }
GameTest >> testWhenItIsPlayer2TurnPlayer1CantRoll [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	aTile4 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.

aGame:= Game withBoard: aBoard diceCollection:aDiceRoller players: ({'Player1'.'Player2'}).
	
aGame rollDiceCup.
	self assert: (aGame positionOf: 'Player1')  equals: 4.
	self deny: ( aGame turnOf) equals: 'Player1' .
	
]

{ #category : #tests }
GameTest >> testWormholeGoesBackwards [

	| aGame aTile1 aTile2 wormholeTile3 aTile4 wormholeTile5 aTile6 aTile7 aBoard  aDie1 aDiceRoller    |

	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	wormholeTile3 := WormholeTile ofTiles .
	aTile4 := Tile ofTiles .
	wormholeTile5 := WormholeTile ofTiles .
	aTile6 := Tile ofTiles .
	aTile7 := Tile ofTiles .
	wormholeTile5 linkATileToTheWormhole: wormholeTile3.
	wormholeTile3 linkATileToTheWormhole: wormholeTile5.
	
	aBoard := Board ofTiles: { aTile1. aTile2. wormholeTile3. aTile4. wormholeTile5. aTile6. aTile7}.
	
	aDie1 := LoadedDie of: 4.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'.} ).
	
	aGame rollDiceCupFor: 'Danny'.

	self assert: ( aGame positionOf: 'Danny' ) equals: 3.
]

{ #category : #tests }
GameTest >> testWormholeGoesForward [

	| aGame aTile1 aTile2 aTile3 wormholeTile4 aTile5 wormholeTile7 aTile6  aBoard  aDie1 aDiceRoller    |

	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	aTile3 := Tile ofTiles .
	wormholeTile4 := WormholeTile ofTiles .
	aTile6 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	wormholeTile7 := WormholeTile ofTiles .
	wormholeTile7 linkATileToTheWormhole: wormholeTile4.
	wormholeTile4 linkATileToTheWormhole: wormholeTile7.
	aBoard := Board ofTiles: { aTile1. aTile2. aTile3. wormholeTile4. aTile5.  aTile6. wormholeTile7}.
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'.} ).
	
	aGame rollDiceCupFor: 'Danny'.

	self assert: ( aGame positionOf: 'Danny' ) equals: 7.
]

{ #category : #tests }
GameTest >> testWormholeIsNotOnANormalTile [

| aGame aTile1 aTile2 wormholeTile3 aTile4 aTile5 aTile6 wormholeTile7 aBoard  aDie1 aDiceRoller    |

	aTile1 := Tile ofTiles .
	aTile2 := Tile ofTiles .
	wormholeTile3 := WormholeTile ofTiles .
	aTile4 := Tile ofTiles .
	wormholeTile7 := WormholeTile ofTiles .
	aTile6 := Tile ofTiles .
	aTile5 := Tile ofTiles .
	wormholeTile3 linkATileToTheWormhole: wormholeTile7.
	wormholeTile7 linkATileToTheWormhole: wormholeTile3.
	aBoard := Board ofTiles: { aTile1. aTile2. wormholeTile3. aTile4. aTile5. aTile6. wormholeTile7}.
	
	aDie1 := LoadedDie of: 4.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'.} ).
	
	aGame rollDiceCupFor: 'Danny'.

	self assert: ( aGame positionOf: 'Danny' ) equals: 5.
]
