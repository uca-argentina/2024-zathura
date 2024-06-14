Class {
	#name : #LoadedDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LoadedDieTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: aErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
LoadedDieTest >> testALoadedDieCanBeCreatedWithAnAmountOfFaces [

	| aDie |
	aDie := LoadedDie of: 1.

	self assert: aDie roll equals: 1.
	self assert: aDie roll equals: 1.
	self assert: aDie roll equals: 1.
	self assert: aDie roll equals: 1
]

{ #category : #tests }
LoadedDieTest >> testALoadedDieCanThrowASequenceOfDifferentRolls [

	| aDie |
	aDie := LoadedDie of: { 4. 9. 5 }.

	self assert: aDie roll equals: 4.
	self assert: aDie roll equals: 9.
	self assert: aDie roll equals: 5.
	self assert: aDie roll equals: 4
]

{ #category : #tests }
LoadedDieTest >> testLoadedDieCannotYieldNumbersBelow1 [

	self
		should: [ LoadedDie of: -1 ]
		raise: Error
		withMessage: 'No roll can be lower than 1'
]
