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
					                      (ProbabilityEffectTile
						                       with: Null new
						                       and: 0.30).
					                      (ProbabilityEffectTile
						                       with: BlackHole new
						                       and: 0.20).
					                      (ProbabilityEffectTile
						                       with: (HyperGravity needsToThrow: 3)
						                       and: 0.20).
					                      (ProbabilityEffectTile
						                       with: (MoonWalk backwardDistance: 3)
						                       and: 0.10).
					                      (ProbabilityEffectTile
						                       with: CardGiver new
						                       and: 0.10).
					                      (ProbabilityEffectTile
						                       with: (HyperJump of: { 3. 2. 1 })
						                       and: 0.08).
					                      (ProbabilityEffectTile
						                       with: AtomicBomb new
						                       and: 0.03) } ]
		raise: Error
		withMessage: 'The sum of the probabilities must be equal to 1!'
]

{ #category : #tests }
EffectDistributionTest >> testProbabilityEffectProbabilityMustBeBetwenZeroAndOne [

	self
		should: [ ProbabilityEffectTile with: Null new and: 2 ]
		raise: Error
		withMessage: 'Probability must be between 0 and 1!'
]

{ #category : #tests }
EffectDistributionTest >> testThatIfAtomicBombEffectHasTwoPercentProbabilityItHasBetweenZeroAndTwelveTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := EffectDistribution with: {
			                      (ProbabilityEffectTile
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityEffectTile
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityEffectTile
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = atomicBombEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
EffectDistributionTest >> testThatIfBlackHoleEffectHasTwentyPercentProbabilityItHasBetweenTenAndFortyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := EffectDistribution with: {
			                      (ProbabilityEffectTile
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityEffectTile
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityEffectTile
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = blackHoleEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
EffectDistributionTest >> testThatIfHyperGravityEffectHasTwentyPercentProbabilityItHasBetweenTenAndFortyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := EffectDistribution with: {
			                      (ProbabilityEffectTile
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityEffectTile
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityEffectTile
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = hyperGravityEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
EffectDistributionTest >> testThatIfHyperJumpEffectHasEightPercentProbabilityItHasBetweenZeroAndEighteenTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := EffectDistribution with: {
			                      (ProbabilityEffectTile
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityEffectTile
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityEffectTile
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = hyperJumpEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
EffectDistributionTest >> testThatIfMoonWalkEffectHasTenPercentProbabilityItHasBetweenZeroAndTwentyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := EffectDistribution with: {
			                      (ProbabilityEffectTile
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityEffectTile
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityEffectTile
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = moonWalkEffect ].

	self assert: (effectCount between: 0 and: 100)
]

{ #category : #tests }
EffectDistributionTest >> testThatIfNullEffectHasFortyPercentProbabilityItHasBetweenThirtyAndSixtyTilesInRandomCollection [

	| nullEffect blackHoleEffect hyperGravityEffect moonWalkEffect hyperJumpEffect atomicBombEffect effectDistribution randomCollection effectCount cardGiverEffect |
	nullEffect := Null new.
	blackHoleEffect := BlackHole new.
	hyperGravityEffect := HyperGravity needsToThrow: 3.
	moonWalkEffect := MoonWalk backwardDistance: 3.
	hyperJumpEffect := HyperJump of: { 3. 2. 1 }.
	atomicBombEffect := AtomicBomb new.
	cardGiverEffect := CardGiver new.

	effectDistribution := EffectDistribution with: {
			                      (ProbabilityEffectTile
				                       with: nullEffect
				                       and: 0.30).
			                      (ProbabilityEffectTile
				                       with: cardGiverEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: blackHoleEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: hyperGravityEffect
				                       and: 0.2).
			                      (ProbabilityEffectTile
				                       with: moonWalkEffect
				                       and: 0.10).
			                      (ProbabilityEffectTile
				                       with: hyperJumpEffect
				                       and: 0.08).
			                      (ProbabilityEffectTile
				                       with: atomicBombEffect
				                       and: 0.02) }.

	randomCollection := effectDistribution randomCollectionWith: 100.

	effectCount := randomCollection count: [ :effect |
		               effect = nullEffect ].

	self assert: (effectCount between: 0 and: 100)
]
