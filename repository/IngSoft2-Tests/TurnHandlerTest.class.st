Class {
	#name : #TurnHandlerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
TurnHandlerTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
TurnHandlerTest >> testATurnHandlerCanBeCreatedWithSomePlayers [

	| aTurnHandler aSpaceShip|

	aSpaceShip := SpaceShip named: 'Danny'.
	aTurnHandler:= TurnHandler withPlayers: {aSpaceShip}.
	self assert: (aTurnHandler players)first name  equals: 'Danny'
]

{ #category : #tests }
TurnHandlerTest >> testATurnHandlerCannotBeCreatedWithoutPlayers [


	self
		should: [TurnHandler withPlayers: {} ]
		raise: Error
		withMessage: 'Game must have at least one player'
]

{ #category : #tests }
TurnHandlerTest >> testPlayer1throwsfirst [
	| aTurnHandler aSpaceShip1 aSpaceShip2|

	aSpaceShip1 := SpaceShip named: 'Danny'.
	aSpaceShip2:=SpaceShip named: 'Walter'.
	aTurnHandler:= TurnHandler withPlayers: {aSpaceShip1. aSpaceShip2}.
	self assert:(aTurnHandler nextPlayerTurn name) equals:'Danny'.
]

{ #category : #tests }
TurnHandlerTest >> testPlayer2throwsAfterPlayer1 [
	| aTurnHandler aSpaceShip1 aSpaceShip2|

	aSpaceShip1 := SpaceShip named: 'Danny'.
	aSpaceShip2:=SpaceShip named: 'Walter'.
	aTurnHandler:= TurnHandler withPlayers: {aSpaceShip1. aSpaceShip2}.
	aTurnHandler nextPlayerTurn.
	self assert:(aTurnHandler nextPlayerTurn name) equals:'Walter'.
]