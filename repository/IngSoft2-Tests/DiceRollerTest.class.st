Class {
	#name : #DiceRollerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceRollerTest >> testDiceRollerRollEqualsTheSumOfEachDieThrow [

| aDie1 aDie2 aDie3 aDiceRoller|
aDie1:=LoadedDie of:3.
aDie2:=LoadedDie of:4.
aDie3:=LoadedDie of:5.

aDiceRoller:=DiceRoller of:{aDie1. aDie2. aDie3.}.

self assert: aDiceRoller roll equals: 12 
]
