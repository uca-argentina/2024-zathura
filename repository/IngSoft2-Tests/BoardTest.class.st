Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithNegativeParsecs [

	self
		should: [
			Board
				of: {
						Null create.
						Null create.
						Null create }
				withUnitsOfMeasurement: (Parsecs with: -2) ]
		raise: Error
		withMessage: 'Parsecs cannot be a negative measure'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithOutTiles [

	self
		should: [ Board of: {  } withUnitsOfMeasurement: (Parsecs with: 10) ]
		raise: Error
		withMessage: 'Tiles should be 2 or more'
]
