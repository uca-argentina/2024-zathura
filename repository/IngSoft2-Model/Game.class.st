Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'spaceships',
		'diceCollection',
		'hasEnded',
		'turnHandler',
		'deck',
		'cardHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertValidNumberOf: someSpaceShips [

	someSpaceShips isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #asserting }
Game class >> createSpaceshipsUsing: spaceshipNames [

	^spaceshipNames collect: [ :spaceship | SpaceShip named: spaceship]
]

{ #category : #asserting }
Game class >> playedBy: someSpaceShips on: aBoard rolling: dice usingCardsFrom:aDeck [
	|currentSpaceships|
	currentSpaceships := self createSpaceshipsUsing: someSpaceShips.
	self assertValidNumberOf: currentSpaceships.
	^ self new
		  initializePlayedBy: currentSpaceships
		  on: aBoard
		  rolling: dice
		  usingCardsFrom: aDeck.
]

{ #category : #accessing }
Game >> anySpaceShipAtLastTileAndLap [

	^ spaceships anySatisfy: [ :aSpaceship |
		  board laps + 1 = aSpaceship lap and: [ 1 = aSpaceship position ] ]
]

{ #category : #accessing }
Game >> applyEffectOnLandingShip: aSpaceship [

	| effectToApply |
	effectToApply := board tiles at: aSpaceship position.
	effectToApply triggeredBy: aSpaceship on: self
]

{ #category : #'as yet unclassified' }
Game >> cardsHandOf: aSpaceship [

	| spaceshipCardHandler |
	spaceshipCardHandler := cardHands
		detect: [ :hand | hand spaceship name = aSpaceship].
	^ spaceshipCardHandler
]

{ #category : #'as yet unclassified' }
Game >> cardsHands [

	^ cardHands.
]

{ #category : #asserting }
Game >> endGameIfPossible [

	self anySpaceShipAtLastTileAndLap ifTrue: [ hasEnded := true ]
]

{ #category : #testing }
Game >> hasEnded [

	^ hasEnded
]

{ #category : #initialization }
Game >> initializePlayedBy: someSpaceShips on: aBoard rolling: dice usingCardsFrom:aDeck [

	board := aBoard.
	diceCollection := dice.
	spaceships := someSpaceShips.
	hasEnded := false.
	deck:=aDeck.
	cardHands:=spaceships collect:[:spaceShip|CardsHand of:spaceShip using:aDeck].
	turnHandler := TurnHandler withPlayers: someSpaceShips.
	spaceships do: [ :aSpaceShip |
		aSpaceShip fuel: 2 * diceCollection maxRoll ]
	
]

{ #category : #accessing }
Game >> move: aSpaceShip by: anAmountOfTiles [
	board move:aSpaceShip by:anAmountOfTiles
	"temporary method. Move logic should be in game"
]

{ #category : #playing }
Game >> move: aSpaceship jumping: aQuantityOfParsec [
	| tilesToMove |

	tilesToMove := (aQuantityOfParsec
	                // (board parsecs  / board amountOfTiles  )) truncated.

	self move:  aSpaceship by:  tilesToMove .
]

{ #category : #playing }
Game >> move: aSpaceship withRollingResult: aResult [

	board move: aSpaceship by: aResult
]

{ #category : #playing }
Game >> moveAllSpaceshipsToFirstPosition [

	spaceships do: [ :aSpaceship |
		aSpaceship
			movePositionBy: 1 - aSpaceship position
			lapBy: 0
			neededFuel: 0 ]
]

{ #category : #playing }
Game >> playNextTurn [

	| rollingResult spaceshipTurn |
	self hasEnded ifTrue: [ Error signal: 'Game has already ended' ].
	spaceshipTurn := turnHandler nextSpaceshipTurn.
	rollingResult := spaceshipTurn rollDiceUsing: diceCollection.
	self move: spaceshipTurn withRollingResult: rollingResult.
	self applyEffectOnLandingShip: spaceshipTurn.
	self endGameIfPossible
]

{ #category : #asserting }
Game >> skipTurnFor: aSpaceship [

	aSpaceship skipTurn
]

{ #category : #accessing }
Game >> spaceShipsPositionsRanking [

	| spaceShipsPositions |
	spaceShipsPositions := spaceships.

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB |
		  ((spaceShipA lap - 1) * board amountOfTiles + spaceShipA position)
		  >=
		  ((spaceShipB lap - 1) * board amountOfTiles + spaceShipB position) ]
]

{ #category : #asserting }
Game >> spaceshipCalled: aName [
^ spaceships detect: [ :spaceship | spaceship name = aName ]
]

{ #category : #asserting }
Game >> spaceships [ 
^spaceships
]

{ #category : #asserting }
Game >> winner [

	| winner |
	self hasEnded ifFalse: [ ^ self hasEnded ].

	winner := spaceships detect: [ :aSpaceship |
		          aSpaceship position = 1 and: [
			          aSpaceship lap = (board laps + 1) ] ].
	^ winner
]
