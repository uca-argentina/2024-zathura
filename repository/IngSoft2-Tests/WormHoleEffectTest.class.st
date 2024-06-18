Class {
	#name : #WormHoleEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormHoleEffectTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: aErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #running }
WormHoleEffectTest >> testWormholeEffectCannotBeCreatedIfThereIsOnlyOneWormhole [

	self
		should: [ Wormhole betweenTiles: { 2 } ]
		raise: Error
		withMessage: 'Cannot create a single wormhole'
]
