Class {
	#name : #LightYear,
	#superclass : #UnitOfMeasurement,
	#instVars : [
		'lightYears'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LightYear class >> with: lightYears [

	^ self new initialize: lightYears
]

{ #category : #initialization }
LightYear >> initialize: someLightYear [

	lightYears := someLightYear
]

{ #category : #converting }
LightYear >> valueAsParsecs [

	^ lightYears / 3
]
