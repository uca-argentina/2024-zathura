Class {
	#name : #EffectDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectDistributionTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
EffectDistributionTest >> testEffectDistributionSumOfProbabilitiesMustBeEqualToOne [ 

	| effectDistribution |
	self
	should: [ 
			effectDistribution := EffectDistribution with: { 
					        (ProbabilityTile with: NullEffect new and: 0.40).
					        (ProbabilityTile with: BlackHoleEffect new and: 0.20).
					        (ProbabilityTile with: (HyperGravityEffect needsToThrow:3) and: 0.20).
					        (ProbabilityTile with: (MoonWalkEffect backwardDistance:3) and: 0.10).
					        (ProbabilityTile with: (HyperJumpEffect of:{3. 2. 1.}) and: 0.08).
					        (ProbabilityTile with: AtomicBombEffect new and: 0.03). } ]
		raise: Error
		withMessage: 'The sum of the probabilities must be equal to 1!'
]

{ #category : #tests }
EffectDistributionTest >> testProbabilityEffectProbabilityMustBeBetwenZeroAndOne [

	self
		should: [ ProbabilityTile with: NullEffect new and: 2 ]
		raise: Error
		withMessage: 'Probability must be between 0 and 1!'
]

{ #category : #tests }
EffectDistributionTest >> testThatIfAtomicBombEffectHasTwoPercentProbabilityItHasBetweenZeroAndTwelveTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount |
	nullEffect := NullEffect new.
	blackHoleEffect:= BlackHoleEffect new.
	hyperGravityEffect:= HyperGravityEffect needsToThrow:3.
	moonWalkEffect:= MoonWalkEffect backwardDistance:3.
	hyperJumpEffect:= HyperJumpEffect of:{3. 2. 1.}.
	atomicBombEffect:= AtomicBombEffect new.
	
effectDistribution := EffectDistribution with: { 
			        (ProbabilityTile with: nullEffect and: 0.40).
					  (ProbabilityTile with: blackHoleEffect and: 0.2).
			        (ProbabilityTile with: hyperGravityEffect and: 0.2).
			        (ProbabilityTile with: moonWalkEffect and: 0.10).
			        (ProbabilityTile with: hyperJumpEffect and: 0.08).
			        (ProbabilityTile with: atomicBombEffect and: 0.02).
			         }.

randomCollection := effectDistribution randomCollectionWith: 100.

effectCount := randomCollection count: [ :effect | effect = atomicBombEffect ].

self assert: (effectCount between: 0 and: 12).
]

{ #category : #tests }
EffectDistributionTest >> testThatIfBlackHoleEffectHasTwentyPercentProbabilityItHasBetweenTenAndFortyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount |
	nullEffect := NullEffect new.
	blackHoleEffect:= BlackHoleEffect new.
	hyperGravityEffect:= HyperGravityEffect needsToThrow:3.
	moonWalkEffect:= MoonWalkEffect backwardDistance:3.
	hyperJumpEffect:= HyperJumpEffect of:{3. 2. 1.}.
	atomicBombEffect:= AtomicBombEffect new.
	
effectDistribution := EffectDistribution with: { 
			        (ProbabilityTile with: nullEffect and: 0.40).
					  (ProbabilityTile with: blackHoleEffect and: 0.2).
			        (ProbabilityTile with: hyperGravityEffect and: 0.2).
			        (ProbabilityTile with: moonWalkEffect and: 0.10).
			        (ProbabilityTile with: hyperJumpEffect and: 0.08).
			        (ProbabilityTile with: atomicBombEffect and: 0.02).
			         }.

randomCollection := effectDistribution randomCollectionWith: 100.

effectCount := randomCollection count: [ :effect | effect = blackHoleEffect ].

self assert: (effectCount between: 10 and: 40).
]

{ #category : #tests }
EffectDistributionTest >> testThatIfHyperGravityEffectHasTwentyPercentProbabilityItHasBetweenTenAndFortyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount |
	nullEffect := NullEffect new.
	blackHoleEffect:= BlackHoleEffect new.
	hyperGravityEffect:= HyperGravityEffect needsToThrow:3.
	moonWalkEffect:= MoonWalkEffect backwardDistance:3.
	hyperJumpEffect:= HyperJumpEffect of:{3. 2. 1.}.
	atomicBombEffect:= AtomicBombEffect new.
	
effectDistribution := EffectDistribution with: { 
			        (ProbabilityTile with: nullEffect and: 0.40).
					  (ProbabilityTile with: blackHoleEffect and: 0.2).
			        (ProbabilityTile with: hyperGravityEffect and: 0.2).
			        (ProbabilityTile with: moonWalkEffect and: 0.10).
			        (ProbabilityTile with: hyperJumpEffect and: 0.08).
			        (ProbabilityTile with: atomicBombEffect and: 0.02).
			         }.

randomCollection := effectDistribution randomCollectionWith: 100.

effectCount := randomCollection count: [ :effect | effect = hyperGravityEffect ].

self assert: (effectCount between: 10 and: 40).
]

{ #category : #tests }
EffectDistributionTest >> testThatIfHyperJumpEffectHasEightPercentProbabilityItHasBetweenZeroAndEighteenTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount |
	nullEffect := NullEffect new.
	blackHoleEffect:= BlackHoleEffect new.
	hyperGravityEffect:= HyperGravityEffect needsToThrow:3.
	moonWalkEffect:= MoonWalkEffect backwardDistance:3.
	hyperJumpEffect:= HyperJumpEffect of:{3. 2. 1.}.
	atomicBombEffect:= AtomicBombEffect new.
	
effectDistribution := EffectDistribution with: { 
			        (ProbabilityTile with: nullEffect and: 0.40).
					  (ProbabilityTile with: blackHoleEffect and: 0.2).
			        (ProbabilityTile with: hyperGravityEffect and: 0.2).
			        (ProbabilityTile with: moonWalkEffect and: 0.10).
			        (ProbabilityTile with: hyperJumpEffect and: 0.08).
			        (ProbabilityTile with: atomicBombEffect and: 0.02).
			         }.

randomCollection := effectDistribution randomCollectionWith: 100.

effectCount := randomCollection count: [ :effect | effect = hyperJumpEffect ].

self assert: (effectCount between: 0 and: 18).
]

{ #category : #tests }
EffectDistributionTest >> testThatIfMoonWalkEffectHasTenPercentProbabilityItHasBetweenZeroAndTwentyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount |
	nullEffect := NullEffect new.
	blackHoleEffect:= BlackHoleEffect new.
	hyperGravityEffect:= HyperGravityEffect needsToThrow:3.
	moonWalkEffect:= MoonWalkEffect backwardDistance:3.
	hyperJumpEffect:= HyperJumpEffect of:{3. 2. 1.}.
	atomicBombEffect:= AtomicBombEffect new.
	
effectDistribution := EffectDistribution with: { 
			        (ProbabilityTile with: nullEffect and: 0.40).
					  (ProbabilityTile with: blackHoleEffect and: 0.2).
			        (ProbabilityTile with: hyperGravityEffect and: 0.2).
			        (ProbabilityTile with: moonWalkEffect and: 0.10).
			        (ProbabilityTile with: hyperJumpEffect and: 0.08).
			        (ProbabilityTile with: atomicBombEffect and: 0.02).
			         }.

randomCollection := effectDistribution randomCollectionWith: 100.

effectCount := randomCollection count: [ :effect | effect = moonWalkEffect ].

self assert: (effectCount between: 0 and: 20).
]

{ #category : #tests }
EffectDistributionTest >> testThatIfNullEffectHasFortyPercentProbabilityItHasBetweenThirtyAndSixtyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount |
	nullEffect := NullEffect new.
	blackHoleEffect:= BlackHoleEffect new.
	hyperGravityEffect:= HyperGravityEffect needsToThrow:3.
	moonWalkEffect:= MoonWalkEffect backwardDistance:3.
	hyperJumpEffect:= HyperJumpEffect of:{3. 2. 1.}.
	atomicBombEffect:= AtomicBombEffect new.
	
effectDistribution := EffectDistribution with: { 
			        (ProbabilityTile with: nullEffect and: 0.40).
					  (ProbabilityTile with: blackHoleEffect and: 0.2).
			        (ProbabilityTile with: hyperGravityEffect and: 0.2).
			        (ProbabilityTile with: moonWalkEffect and: 0.10).
			        (ProbabilityTile with: hyperJumpEffect and: 0.08).
			        (ProbabilityTile with: atomicBombEffect and: 0.02).
			         }.

randomCollection := effectDistribution randomCollectionWith: 100.

effectCount := randomCollection count: [ :effect | effect = nullEffect ].

self assert: (effectCount between: 30 and: 60).
]
