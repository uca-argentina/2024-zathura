Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OverloadCard >> effect [

	^ -2
]

{ #category : #delegating }
OverloadCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAnOverloadCardPlay: self
]
