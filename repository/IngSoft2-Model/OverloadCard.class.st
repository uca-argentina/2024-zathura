Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
OverloadCard >> cancelEffectUsing: cardPlayResolver [

	cardPlayResolver cancelAnOverloadCard: self
]

{ #category : #initialization }
OverloadCard >> effect [

	^ -2
]

{ #category : #delegating }
OverloadCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAnOverloadCardPlay: self
]
