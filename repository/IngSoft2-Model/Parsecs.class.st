Class {
	#name : #Parsecs,
	#superclass : #UnitOfMeasurement,
	#instVars : [
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Parsecs class >> with: parsecs [
	^ self new initialize: parsecs.
]

{ #category : #initialization }
Parsecs >> initialize: someParsecs [

	parsecs  := someParsecs .
]

{ #category : #initialization }
Parsecs >> valueAsParsecs [
	^ parsecs .
]
