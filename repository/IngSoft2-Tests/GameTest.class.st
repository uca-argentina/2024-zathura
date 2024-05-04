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
GameTest >> testMustHaveAtLeastOnePlayer [

| aTile1 aTile2 aTile3 aBoard aDie1 aDiceRoller|
aTile1:=Tile new.
aTile2:=Tile new.
aTile3:=Tile new.
aBoard:=Board ofTiles:{aTile1. aTile2. aTile3.}.

aDie1:=LoadedDie of: 3.
aDiceRoller:=DiceRoller of:{aDie1}.

self should: [Game withBoard: aBoard diceCollection:aDiceRoller players:{}] raise: Error withMessage: 'Game must have at least one player'.
]

{ #category : #tests }
GameTest >> testPlayerStartsAtTileNumberOne [ [

	| aGame aTile1 aTile2 aTile3 aBoard aDie1 aDiceRoller |

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aBoard := Board ofTiles: { aTile1. aTile2. aTile3. }.
	
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'.} ).

	self assert: ( aGame positionOf: 'Danny' ) tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Walter' ) tileNumber equals: 1
]
]

{ #category : #tests }
GameTest >> testPlayingUntilWinning [ [

	| aGame aTile1 aTile2 aTile3 aBoard aDie1 aDiceRoller |

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aBoard := Board ofTiles: { aTile1. aTile2. aTile3 }.
	
	aDie1 := LoadedDie of: 3.
	aDiceRoller := DiceRoller of: { aDie1 }.

	aGame := Game 
				withBoard: aBoard
				diceCollection: aDiceRoller
				players: ( {'Danny'. 'Walter'} ).
				
	self deny: (aGame hasEnded).	
	
]
]
