Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBombEffect >> triggeredBy: aPlayer on: aBoard [

	aBoard spaceships do: [ :player |
		player movePositionBy: 1 - player position lapBy: 0 neededFuel: 0 ]
]
