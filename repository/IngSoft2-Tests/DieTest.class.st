Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].
]

{ #category : #tests }
DieTest >> testDieCannotBeCreatedWithLessThanThreeFaces [ 

self should:[Die of:2] raise: Error withMessage: 'Faces should be more than 2'
]

{ #category : #tests }
DieTest >> testDieIsCreatedWithAnAmountOfFacesAndRollsBetweenOneAndAmountOfFaces [ 

| aDie |
aDie:=Die of:4.

self assert:((aDie roll) between: 1 and:4).
]
