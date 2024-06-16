Class {
	#name : #EffectManager,
	#superclass : #Object,
	#instVars : [
		'game',
		'board',
		'spaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EffectManager class >> usedIn: aGame with: aBoard affecting:someShips [

	^ self new initializeIn: aGame using:aBoard affecting:someShips.
]

{ #category : #accessing }
EffectManager >> applyEffectOnLandingShip: aSpaceship [

	| effectToApply |
	effectToApply := board tiles at: aSpaceship position.
	effectToApply triggeredBy: aSpaceship on: self 
]

{ #category : #playing }
EffectManager >> applyMoonwalkMoving: anAmountOfTiles notAffecting:aShip [
	| filteredShips |
	filteredShips :=  spaceships select: [ :spaceship |
		                 spaceship ~= aShip ].
	filteredShips do: [ :spaceship |
		board move: spaceship by: anAmountOfTiles ]
]

{ #category : #playing }
EffectManager >> giveCardFromDeckTo:aSpaceship [
	game giveCardFromDeckTo: aSpaceship 
]

{ #category : #initialization }
EffectManager >> initializeIn: aGame using:aBoard affecting: someShips [
	game:=aGame.
	board:=aBoard.
	spaceships:=someShips.
]

{ #category : #accessing }
EffectManager >> move: aSpaceShip by: anAmountOfTiles [
	board move:aSpaceShip by:anAmountOfTiles
]

{ #category : #playing }
EffectManager >> move: aSpaceship jumping: aQuantityOfParsec [
	| tilesToMove |

	tilesToMove := (aQuantityOfParsec
	                // (board parsecs  / board amountOfTiles  )) truncated.

	self move:  aSpaceship by:  tilesToMove .
]

{ #category : #playing }
EffectManager >> moveAllSpaceshipsToFirstPosition [

	board moveAllSpaceshipsToFirstPosition:spaceships.
]
