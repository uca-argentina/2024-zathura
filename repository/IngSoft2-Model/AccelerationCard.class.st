Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
AccelerationCard >> effect [

	^ 1

]

{ #category : #initialization }
AccelerationCard >> playedBy:aSpaceship targetting:spaceships [
^CardPlay with:self appliedTo:spaceships by:aSpaceship.


]

{ #category : #initialization }
AccelerationCard >> uses:cardPlayResolver [
^cardPlayResolver resolveAnAccelerationCardPlay



]
