Class {
	#name : #UnitOfMeasurement,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
UnitOfMeasurement class >> with: unit [

	self subclassResponsibility
]

{ #category : #initialization }
UnitOfMeasurement >> initialize: someUnit [

	self subclassResponsibility
]

{ #category : #converting }
UnitOfMeasurement >> valueAsParsecs [

	self subclassResponsibility
]
