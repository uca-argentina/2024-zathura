Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OverloadCard >> effect [

	^ -2
]

{ #category : #initialization }
OverloadCard >> playedBy: aSpaceship targetting: anotherSpaceship [

	^ CardPlay with: self appliedTo: anotherSpaceship by: aSpaceship
]

{ #category : #delegating }
OverloadCard >> uses: cardPlayResolver [

	^ cardPlayResolver resolveAnOverloadCardPlay
]
