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
LoadedDieTest >> testDieCanBeCreatedWithAnAmountOfFaces [

	| aDie |
	aDie := LoadedDie of: 5.
	self assert: aDie roll equals: 5
]

{ #category : #tests }
LoadedDieTest >> testDieCannotBeCreatedWithLessThanThreeFaces [

	self
		should: [ LoadedDie of: 2 ]
		raise: Error
		withMessage: 'Faces should be more than 2'
]

{ #category : #tests }
LoadedDieTest >> testDieMinRollIsEqualTo1 [

	| aLoadedDie |
	aLoadedDie := LoadedDie of: 3.
	self assert: aLoadedDie minRoll equals: 1
]
