Class {
	#name : #DiceRollerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceRollerTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
DiceRollerTest >> testDiceRollerMustBeCreatedWithAtLeastTwoDice [

	| aDie1 aDiceRoller |
	aDie1 := LoadedDie of: 3.

	self
		should: [ aDiceRoller := DiceRoller of: { aDie1 } ]
		raise: Error
		withMessage: 'A DiceRoller must have more than one die'
]

{ #category : #tests }
DiceRollerTest >> testDiceRollerRollEqualsTheSumOfEachDieThrow [

	| aDie1 aDie2 aDie3 aDiceRoller |
	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 4.
	aDie3 := LoadedDie of: 5.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2.
			               aDie3 }.

	self assert: aDiceRoller roll equals: 12
]

{ #category : #tests }
DiceRollerTest >> testMinimumRollIsEqualToAmountOfDiceInDiceRoller [

	| aDie1 aDie2 aDie3 aDiceRoller |
	aDie1 := LoadedDie of: 3.
	aDie2 := LoadedDie of: 4.
	aDie3 := LoadedDie of: 5.

	aDiceRoller := DiceRoller of: {
			               aDie1.
			               aDie2.
			               aDie3 }.

	self assert: aDiceRoller minRoll equals: 3
]
