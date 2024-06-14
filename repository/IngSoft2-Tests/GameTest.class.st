Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
		          withParsecs: 10.

	aDie1 := LoadedDie of: 3.


	self
		should: [ Game playedBy: {  } on: aBoard rolling: aDie1 usingCardsFrom:{'card1.'. 'card2.'}.]
		raise: Error
		withMessage: 'Game must have at least one player'
]

{ #category : #tests }
GameTest >> testFV02SpaceshipsStartAtFirstTile [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := #( 'Danny' 'Walter' ).
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
		          withParsecs: 10.

	aDie1 := LoadedDie of: 3.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).


	self assert: (aGame spaceshipCalled: 'Danny') name equals: 'Danny'.
	self assert: (aGame spaceshipCalled: 'Walter') name equals: 'Walter'.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1
]

{ #category : #tests }
GameTest >> testFV03GameHasEndedAsOneSpaceshipReachTheEnd [

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
				          Null create }
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: 9.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 2.



	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testFV04CantRollAfterGameEnded [

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
		          finishingAfter: 1
		          withParsecs: 10.

	aDie1 := LoadedDie of: 9.
	someSpaceships := { 'Danny'. 'Walter' }.
	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'Game has already ended'
]

{ #category : #tests }
GameTest >> testFV05IsValidWhenTheWinnerIsAssignedCorrectly [

	| aGame aBoard aDie1 someSpacheships |
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
		          withParsecs: 10.

	aDie1 := LoadedDie of: 8.
	someSpacheships := { 'Danny'. 'Walter' }.

	aGame := Game playedBy: someSpacheships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.


	self assert: aGame winner name equals: 'Danny'
]

{ #category : #tests }
GameTest >> testFV06GameIsPlayedWithTwoDice [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 3.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         rolling: aDiceRoller
					usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	self deny: aGame hasEnded.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1
]

{ #category : #tests }
GameTest >> testFV07GameWithRandomDie [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := Die of: 3.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self deny: aGame hasEnded.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testFV08GameWithTwoRandomDice [

	| aGame aBoard aDie1 aDie2 aDiceRoller someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withParsecs: 10.
	aDie1 := Die of: 3.
	aDie2 := Die of: 5.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.
	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self deny: aGame hasEnded.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testFV09PlayerOneCanRollTheDiceAfterPlayerTwoTurn [

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
				          Null create }
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: 3.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1
]

{ #category : #tests }
GameTest >> testFV10TurnsWhenThreePlayersArePLaying [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.


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
		          withParsecs: 10.

	aDie1 := LoadedDie of: 3.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.

	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.

	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Joseph') position equals: 4
]

{ #category : #tests }
GameTest >> testFV11WormholeGoesBackwards [

	| aGame wormholeTile3 wormholeTile5 aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
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
		          withParsecs: 10.

	aDie1 := LoadedDie of: 4.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3
]

{ #category : #tests }
GameTest >> testFV12WormholeGoesForward [

	| aGame wormholeTile8 wormholeTile12 aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
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
		          withParsecs: 10.
	aDie1 := LoadedDie of: 7.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 12
]

{ #category : #tests }
GameTest >> testFV13WormholeIsNotOnANormalTile [

	| aGame wormholeTile3 wormholeTile7 aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
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
		          withParsecs: 10.

	aDie1 := LoadedDie of: 4.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5
]

{ #category : #tests }
GameTest >> testSV01PlayersStartAtLapOne [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: 3.
	someSpaceships := { 'Danny'. 'Walter' }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1
]

{ #category : #tests }
GameTest >> testSV02PlayerChangesLapAfterPassingTheLastTile [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: { 6. 6. 2. 2 }.
	someSpaceships := { 'Danny'. 'Walter' }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

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
GameTest >> testSV03PlayersWinsAfterCompletingAnAmountOfLaps [

	| aGame aBoard aDie1 someSpaceships |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: { 6. 3. 6. 3 }.
	someSpaceships := { 'Danny'. 'Walter' }.
	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

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
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 2.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 3.

	self assert: aGame winner name equals: 'Danny'
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
				withParsecs: 10 ]
		raise: Error
		withMessage: 'Game must have one or more laps!'
]

{ #category : #tests }
GameTest >> testSV05EverySpaceshipStartsWithAmountOfFuelEqualToTheDoubleOfTheDiceMaxRoll [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 3.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         rolling: aDiceRoller
					usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 12.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 12
]

{ #category : #tests }
GameTest >> testSV06WhenASpaceshipMovesItHasLessFuel [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 3.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         rolling: aDiceRoller
					usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 12.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 12.


	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 6
]

{ #category : #tests }
GameTest >> testSV07WhenASpaceshipRunsOutOfFuelItGoesBackToTileOneInLapBeforeMovementAndRechargesFuel [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: 6.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 12.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 12.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') amountOfFuel equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 12.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 12
]

{ #category : #tests }
GameTest >> testSV08WhenASpaceshipRunsOutOfFuelAlsoItLosesTwoTurns [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: { 2. 6. 2. 6. 1. 1. 1. 1 }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 12.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 12.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 10.
	self assert: (aGame spaceshipCalled: 'Walter') amountOfFuel equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 8.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 12.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 8.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 5.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 12.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 8.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 5.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 11
]

{ #category : #tests }
GameTest >> testSV09SpaceshipSkipsTheirTurnToHaveMaxFuel [

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
		          finishingAfter: 3
		          withParsecs: 10.


	aDie1 := LoadedDie of: { 2. 2. 2. 3. 2. 2 }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') amountOfFuel equals: 6.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.

	aGame skipTurnFor: (aGame spaceshipCalled: 'Danny').
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6
]

{ #category : #tests }
GameTest >> testSV10LandingInAnEffectTileAfterBeingMovedByAnEffectDoesNotCauseAnotherEffect [

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
		          finishingAfter: 3
		          withParsecs: 10.


	aDie1 := LoadedDie of: 5.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2
]

{ #category : #tests }
GameTest >> testSV11Spaceship2IsTheFirstSpaceShipAtSpaceShipsRankingAsHisPositionIsTheClosestToTheFinish [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: 3.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.

	self
		assert: aGame spaceShipsPositionsRanking first name
		equals: 'Walter'.

	self
		assert: aGame spaceShipsPositionsRanking second name
		equals: 'Danny'
]

{ #category : #tests }
GameTest >> testSV12BlackHoleEffectWhenSpaceShipHasEnoughFuelItGoesFourTilesBackwards [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: 5.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 10.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 10.


	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') amountOfFuel equals: 1
]

{ #category : #tests }
GameTest >> testSV13BlackHoleEffectWhenSpaceShipRunsOutOfFuelItGoesToTheFirstTileRechargesFuelAndLosesTwoTurns [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: { 1. 1. 4. 4 }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 8.
	self assert: (aGame spaceshipCalled: 'Walter') amountOfFuel equals: 8.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') amountOfFuel equals: 7.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 8.
	self assert: (aGame spaceshipCalled: 'Walter') amountOfFuel equals: 8
]

{ #category : #tests }
GameTest >> testSV14BlackHoleEffectWhenSpaceShipIsInTheFirstThreeTilesItGoesBackToThePreviousLapAndTile [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: { 6. 6. 1. 1 }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

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
GameTest >> testSV15SpaceshipEscapesOfTheHyperGravityEffectWhenItGetsACertainNumber [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aDie1 := LoadedDie of: { 5. 5. 4. 4 }.
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
		          finishingAfter: 2
		          withParsecs: 10.


	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

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
GameTest >> testSV16SpaceshipCannotEscapeFromTheHyperGravityEffectIfItDoesNotGetACertainNumber [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter' }.
	aDie1 := LoadedDie of: 5.
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
		          finishingAfter: 2
		          withParsecs: 10.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

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
GameTest >> testSV17MoonWalkEffectWhenSpaceShipHasEnoughFuelItGoesNTilesBackwards [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: { 2. 3. 3 }.
	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	(aGame spaceshipCalled: 'Walter') fuel: 30.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2
]

{ #category : #tests }
GameTest >> testSV18MoonWalkEffectWhenSpaceShipRunsOutOfFuelItGoesToTheFirstTileRechargesFuelAndLosesTwoTurns [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: { 2. 4. 4. 1. 1 }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.

	aGame playNextTurn.

	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1
]

{ #category : #tests }
GameTest >> testSV19MoonWalkEffectWhenSpaceShipIsInTheFirstThreeTilesItGoesBackToThePreviousLapAndTile [

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
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: { 6. 6. 1. 1 }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

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
GameTest >> testSV20HyperJumpEffectAssignsParsecsToSpaceshipAndItGoesForward [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
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
		          withParsecs: 10.
	aDie1 := LoadedDie of: { 3. 3. 3 }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

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
GameTest >> testSV21AtomicBombEffectSendsAllSpaceshipsBackToTheFirstTile [

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
		          finishingAfter: 2
		          withParsecs: 10.
	aDie1 := LoadedDie of: { 6. 4. 3. 3. 6. 6. 20 }.

	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

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
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 34.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 36.

	aGame playNextTurn.


	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') amountOfFuel equals: 31.
	self
		assert: (aGame spaceshipCalled: 'Walter') amountOfFuel
		equals: 36
]

{ #category : #tests }
GameTest >> testSV22SequenceDie [

	| aGame aBoard aDie1 someSpaceships |
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          finishingAfter: 2
		          withParsecs: 10.

	aDie1 := LoadedDie of: { 4. 3. 3 }.
	someSpaceships := { 'Danny'. 'Walter' }.
	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom:(Deck of: {'card1'. 'card2'}).

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
GameTest >> testSV23GameWithRandomBoardAndRandomDie [

	| aGame aBoard aDie1 someSpaceships effectDistribution randomCollection aDie2 aDiceRoller |
	aDie1 := Die of: 3.
	aDie2 := Die of: 4.
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
				                       with: (HyperJump of: { 3. 2. 1 })
				                       and: 0.08).
			                      (ProbabilityEffectTile
				                       with: AtomicBomb new
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 5.

	aBoard := Board
		          of: randomCollection
		          finishingAfter: 2
		          withParsecs: 10.

	someSpaceships := { 'Danny'. 'Walter' }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         rolling: aDiceRoller
					usingCardsFrom:(Deck of: {'card1'. 'card2'}).		

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
GameTest >> testTV24EverySpaceshipStartsWithTwoCards [

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
		          finishingAfter: 2
		          withParsecs: 10.
	aDie1 := LoadedDie of: { 6. 4. 3. 3. 6. 6. 20 }.

	aDeck := Deck of: {'card1'. 'card2'}.
	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom: aDeck.

	self assert:(aGame cardsHandLengthOf:'Danny') equals: 2.
	self assert:(aGame cardsHandLengthOf:'Walter') equals: 2.

	aGame playNextTurn.
	aGame playNextTurn.
]

{ #category : #tests }
GameTest >> testTV25WhenSpaceshipLandsInCardGiverTileItReceivesACard [

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
		          finishingAfter: 2
		          withParsecs: 10.
	aDie1 := LoadedDie of: { 2. 2. }.

	aDeck := Deck of: {'card1'. 'card2'}.
	aGame := Game playedBy: someSpaceships on: aBoard rolling: aDie1 usingCardsFrom: aDeck.

	self assert:(aGame cardsHandLengthOf:'Danny') equals: 2.
	self assert:(aGame cardsHandLengthOf:'Walter') equals: 2.

	aGame playNextTurn.
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert:(aGame cardsHandLengthOf:'Danny') equals: 3.
	self assert:(aGame cardsHandLengthOf:'Walter') equals: 2.
]
