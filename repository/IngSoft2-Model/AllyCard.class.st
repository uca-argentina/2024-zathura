Class {
	#name : #AllyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
AllyCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAnAllyCardPlay: self
]
