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
GameTest >> testGameHasEndedAsOnePlayerREadhedTheEnd [

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
