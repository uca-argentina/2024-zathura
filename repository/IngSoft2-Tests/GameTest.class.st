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
aTile1:=Tile new.
aTile2:=Tile new.
aTile3:=Tile new.
aTile4:=Tile new.
aTile5:=Tile new.
aTile6:=Tile new.
aTile7:=Tile new.

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.
	
	aDie1 := LoadedDie of: 6.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'} ).
				
	self deny: (aGame hasEnded).
	self assert: (aGame positionOf: 'Danny') tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 1.
	
aGame rollDiceCupFor: 'Danny'.
	self assert: (aGame hasEnded).
	self assert: (aGame positionOf: 'Danny') tileNumber equals: 7.
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 1.
	
self should:[aGame rollDiceCupFor:'Danny'] raise: Error withMessage: 'Game has already ended'
]

{ #category : #tests }
GameTest >> testDannyCanRollTheDiceAfterWalterTurn [

| aGame aTile1 aTile2 aTile3 aBoard aDie1 aDiceCup aTile4 aTile5|

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aTile4 := Tile new.
	aTile5 := Tile new.
	
	aBoard := Board ofTiles: { aTile1. aTile2. aTile3. aTile4. aTile5.}.
	
	aDie1 := LoadedDie of: 3.
	aDiceCup := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceCup
				players: ( {'Danny'. 'Walter'.} ).
	
	aGame rollDiceCupFor: 'Danny'.
	aGame rollDiceCupFor: 'Walter'.
	
	self assert: ( aGame positionOf: 'Danny' ) tileNumber equals: 4.
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 4.
	self assert: ( aGame turnOf: 'Danny' ).
]

{ #category : #tests }
GameTest >> testGameHasEndedAsOnePlayerReachTheEnd [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

aTile1:=Tile new.
aTile2:=Tile new.
aTile3:=Tile new.
aTile4:=Tile new.
aTile5:=Tile new.
aTile6:=Tile new.
aTile7:=Tile new.

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.

aGame:= Game withBoard: aBoard diceCollection:aDiceRoller players: ({'Danny'.'Walter'}).

	self assert: ( aGame positionOf: 'Danny' ) tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 1.
	
aGame rollDiceCupFor: 'Danny'.
	self deny: (aGame hasEnded).
	self assert: (aGame positionOf: 'Danny') tileNumber equals: 4.
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 1.
	
aGame rollDiceCupFor: 'Danny'.
	self assert: (aGame hasEnded).
	self assert: (aGame positionOf: 'Danny') tileNumber equals: 7.
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 1.
]

{ #category : #tests }
GameTest >> testGameHasNotEndedAsNoPlayerReachedTheEnd [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

aTile1:=Tile new.
aTile2:=Tile new.
aTile3:=Tile new.
aTile4:=Tile new.
aTile5:=Tile new.
aTile6:=Tile new.
aTile7:=Tile new.

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.

aGame:= Game withBoard: aBoard diceCollection:aDiceRoller players: ({'Danny'.'Walter'}).

self deny: (aGame hasEnded).
	self assert: ( aGame positionOf: 'Danny' ) tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 1.
	
aGame rollDiceCupFor: 'Danny'.

self assert: (aGame positionOf: 'Danny') tileNumber equals: 4.
self deny: (aGame hasEnded).
]

{ #category : #tests }
GameTest >> testGameMustHaveAtLeastOnePlayer [

| aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

aTile1:=Tile new.
aTile2:=Tile new.
aTile3:=Tile new.
aTile4:=Tile new.
aTile5:=Tile new.
aTile6:=Tile new.
aTile7:=Tile new.

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.


self should:[Game withBoard: aBoard diceCollection:aDiceRoller players: {}] raise: Error 
withMessage: 'Game must have at least one player'.
]

{ #category : #tests }
GameTest >> testPlayerMovesFiveTiles [
| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|

aTile1:=Tile new.
aTile2:=Tile new.
aTile3:=Tile new.
aTile4:=Tile new.
aTile5:=Tile new.
aTile6:=Tile new.
aTile7:=Tile new.

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.

aDie1:=LoadedDie of: 5.
aDiceRoller:=DiceRoller of:{aDie1}.

aGame:= Game withBoard: aBoard diceCollection:aDiceRoller players: ({'Danny'.'Walter'}).
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 1.
	
aGame rollDiceCupFor: 'Walter'.
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 6.
]

{ #category : #tests }
GameTest >> testPlayersStartAtFirstTile [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|
aTile1:=Tile new.
aTile2:=Tile new.
aTile3:=Tile new.
aTile4:=Tile new.
aTile5:=Tile new.
aTile6:=Tile new.
aTile7:=Tile new.

aBoard:=Board ofTiles:{aTile1. aTile2. aTile3. aTile4. aTile5. aTile6. aTile7.}.
	
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'} ).
				
	self assert: (aGame positionOf: 'Danny') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Walter') tileNumber equals: 1.
]

{ #category : #tests }
GameTest >> testPlayingUntilWinning [

| aGame aTile1 aTile2 aTile3 aTile4 aTile5 aTile6 aTile7 aBoard aDie1 aDiceRoller|
aTile1:=Tile new.
aTile2:=Tile new.
aTile3:=Tile new.
aTile4:=Tile new.
aTile5:=Tile new.
aTile6:=Tile new.
aTile7:=Tile new.

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
GameTest >> testWormholeGoesBackwards [

	| aGame aTile1 aTile2 aTile3 aBoard aDie1 aDiceRoller aTile4 aTile5 |

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aTile4 := Tile new.
	aTile5 := Tile new.
	aBoard := Board ofTiles: { aTile1. aTile2. aTile3. aTile4. aTile5.}.
	
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'.} ).
	
	aGame hasWormholeFrom: 2 to:4.
	aGame rollDiceCupFor: 'Danny'.

	self assert: ( aGame positionOf: 'Danny' ) tileNumber equals: 2.
]

{ #category : #tests }
GameTest >> testWormholeGoesForward [

	| aGame aTile1 aTile2 aTile3 aBoard aDie1 aDiceRoller aTile4 aTile5 |

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aTile4 := Tile new.
	aTile5 := Tile new.
	aBoard := Board ofTiles: { aTile1. aTile2. aTile3. aTile4. aTile5.}.
	
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'.} ).
	
	aGame hasWormholeFrom: 4 to:5. 
	aGame rollDiceCupFor: 'Danny'.

	self assert: ( aGame positionOf: 'Danny' ) tileNumber equals: 5.
]

{ #category : #tests }
GameTest >> testWormholeIsNotOnANormalTile [

	| aGame aTile1 aTile2 aTile3 aBoard aDie1 aDiceRoller aTile4 aTile5 aTile6 |

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aTile4 := Tile new.
	aTile5 := Tile new.
	aTile6 := Tile new.
	aBoard := Board ofTiles: { aTile1. aTile2. aTile3. aTile4. aTile5. aTile6}.
	
	aDie1 := LoadedDie of: 4.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'.} ).
	
	aGame hasWormholeFrom: 4 to:6. 
	aGame rollDiceCupFor: 'Danny'.

	self assert: ( aGame positionOf: 'Danny' ) tileNumber equals: 5.
]
