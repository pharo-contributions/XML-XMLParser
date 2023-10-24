"
An abstract and portable test case for sets.
"
Class {
	#name : #XMLAbstractSetTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests-Base'
}

{ #category : #testing }
XMLAbstractSetTest class >> isAbstract [
	^ true
]

{ #category : #testing }
XMLAbstractSetTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
XMLAbstractSetTest >> absentSetElement [
	self subclassResponsibility
]

{ #category : #asserting }
XMLAbstractSetTest >> assertSet: aFirstSet equals: aSecondSet [

	self
		assert: aFirstSet equals: aSecondSet;
		assert: aSecondSet equals: aFirstSet
]

{ #category : #asserting }
XMLAbstractSetTest >> denySet: aFirstSet equals: aSecondSet [

	self
		deny: aFirstSet equals: aSecondSet;
		deny: aFirstSet identicalTo: aSecondSet;
		deny: aSecondSet equals: aFirstSet;
		deny: aSecondSet identicalTo: aFirstSet
]

{ #category : #accessing }
XMLAbstractSetTest >> disjointSetElements [
	self subclassResponsibility
]

{ #category : #accessing }
XMLAbstractSetTest >> emptySet [
	^ self setClass new
]

{ #category : #accessing }
XMLAbstractSetTest >> setClass [
	self subclassResponsibility
]

{ #category : #accessing }
XMLAbstractSetTest >> setElements [
	self subclassResponsibility
]

{ #category : #accessing }
XMLAbstractSetTest >> setWithDisjointElements [
	^ self setClass newFrom: self disjointSetElements
]

{ #category : #accessing }
XMLAbstractSetTest >> setWithElements [
	^ self setClass newFrom: self setElements
]

{ #category : #tests }
XMLAbstractSetTest >> testAdd [

	| set |
	set := self emptySet.
	self setElements do: [ :each |
		self
			assert: (set add: each) identicalTo: each;
			assert: (set includes: each) ].
	self
		assert: set equals: self setWithElements;
		assert:
			(self setElements allSatisfy: [ :each | (set add: each) == each ]);
		assert: set equals: self setWithElements
]

{ #category : #tests }
XMLAbstractSetTest >> testConcatenation [

	| firstSet secondSet |
	firstSet := self setWithElements.
	self
		assert: firstSet , self setWithElements
		equals: self setWithElements.

	secondSet := self setWithDisjointElements.
	self
		assert: firstSet , secondSet equals: secondSet , firstSet;
		deny: firstSet , secondSet equals: firstSet;
		deny: firstSet , secondSet equals: secondSet;
		assert: firstSet , secondSet
		equals:
			(self setClass newFrom: self setElements , self disjointSetElements)
]

{ #category : #tests }
XMLAbstractSetTest >> testCopy [

	| set copy |
	set := self setWithElements.
	copy := set copy.
	self
		assert: set equals: copy;
		deny: set identicalTo: copy.

	set addAll: self disjointSetElements.
	self deny: set equals: copy.

	copy addAll: self disjointSetElements.
	self assert: set equals: copy
]

{ #category : #tests }
XMLAbstractSetTest >> testDo [

	| enumerated |
	enumerated := OrderedCollection new.
	self emptySet do: [ :each | enumerated addLast: each ].
	self assert: enumerated size equals: 0.

	self setWithElements do: [ :each | enumerated addLast: each ].
	self
		assert: enumerated size equals: self setElements size;
		assert:
			(self setElements allSatisfy: [ :each | enumerated includes: each ])
]

{ #category : #tests }
XMLAbstractSetTest >> testEquals [
	| set |

	set := self emptySet.
	self
		assertSet: set equals: self emptySet;
		denySet: set equals: self setWithElements;
		denySet: set equals: self setWithDisjointElements.

	set := self setWithElements.
	self
		assertSet: set equals: self setWithElements;
		denySet: set equals: self setWithDisjointElements.

	set := self setWithDisjointElements.
	self assertSet: set equals: self setWithDisjointElements
]

{ #category : #tests }
XMLAbstractSetTest >> testIncludes [
	| set |

	set := self emptySet.
	self deny: (self setElements anySatisfy: [:each | set includes: each]).

	set := self setWithElements.
	self assert: (self setElements allSatisfy: [:each | set includes: each]).
	self deny: (self disjointSetElements anySatisfy: [:each | set includes: each]).

	set := self setWithDisjointElements.
	self assert: (self disjointSetElements allSatisfy: [:each | set includes: each])
]

{ #category : #tests }
XMLAbstractSetTest >> testNewFrom [

	self
		assert: (self setClass newFrom: self setElements)
		equals: self setWithElements
]

{ #category : #tests }
XMLAbstractSetTest >> testRemoveAll [

	| set |
	set := self setWithElements.
	self
		assert: set removeAll identicalTo: set;
		assert: set isEmpty
]

{ #category : #tests }
XMLAbstractSetTest >> testRemoveIfAbsent [

	| set |
	set := self setWithElements.
	self setElements do: [ :each |
		self
			assert: (set remove: each ifAbsent: [ self fail ])
			identicalTo: each.
		self deny: (set includes: each).
		self
			assert: (set remove: each ifAbsent: [ self absentSetElement ])
			identicalTo: self absentSetElement.
		self should: [ set remove: each ] raise: Error ].
	self assert: set isEmpty
]

{ #category : #tests }
XMLAbstractSetTest >> testSize [

	| set size |
	set := self emptySet.
	size := 0.
	self assert: set size equals: size.
	self setElements do: [ :each |
		set add: each.
		size := size + 1.
		self assert: set size equals: size ]
]
