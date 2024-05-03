Class {
	#name : #LoadedDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LoadedDieTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].
]

{ #category : #tests }
LoadedDieTest >> testDieCanBeCreatedWithAnAmountOfFaces [

| aDie |
aDie:= LoadedDie of:5.
self assert: aDie throw equals:5.
]

{ #category : #tests }
LoadedDieTest >> testDieCannotBeCreatedWithLessThanThreeFaces [ 

self should:[LoadedDie of:2] raise: Error withMessage: 'Faces should be more than 2'

]
