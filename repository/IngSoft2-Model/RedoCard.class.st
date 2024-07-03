Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
RedoCard >> uses: cardPlayResolver [

	cardPlayResolver resolveARedoCardPlay:self
]
