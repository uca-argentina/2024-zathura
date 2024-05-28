Class {
	#name : #SequenceDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SequenceDieTest >> testALoadedDieCanThrowASequenceOfDifferentRolls [

	| aDie |
	aDie := SequenceDie of: { 4. 9. 5 }.

	self assert: aDie roll equals: 4.
	self assert: aDie roll equals: 9.
	self assert: aDie roll equals: 5.
	self assert: aDie roll equals: 4
]

{ #category : #tests }
SequenceDieTest >> testDieMinRollIsEqualTo1 [

	| aSequenceDie |
	aSequenceDie := SequenceDie of: { 4. 9. 5 }.
	self assert: aSequenceDie minRoll equals: 1
]
