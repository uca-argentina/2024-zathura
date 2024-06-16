Class {
	#name : #LightYear,
	#superclass : #UnitOfMeasurement,
	#instVars : [
		'lightYear'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LightYear class >> with: lightYears [

	^ self new initialize: lightYears.
]

{ #category : #initialization }
LightYear >> initialize: someLightYear [

	lightYear := someLightYear.
]

{ #category : #'as yet unclassified' }
LightYear >> valueAsParsecs [
	^ (lightYear/3) .
]
