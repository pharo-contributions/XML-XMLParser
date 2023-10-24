Extension { #name : #TestCase }

{ #category : #'*XML-Parser-Tests' }
TestCase >> xmlShould: aBlock enumerate: aCollection [

	| enumerated |
	enumerated := OrderedCollection new.
	aBlock value: [ :each | enumerated add: each ].
	self assert: enumerated equals: aCollection asOrderedCollection
]

{ #category : #'*XML-Parser-Tests' }
TestCase >> xmlShould: aBlock enumerate: aFirstCollection and: aSecondCollection [

	| firstEnumerated secondEnumerated |
	firstEnumerated := OrderedCollection new.
	secondEnumerated := OrderedCollection new.
	aBlock value: [ :first :second |
		firstEnumerated addLast: first.
		secondEnumerated addLast: second ].
	self
		assert: firstEnumerated
		equals: aFirstCollection asOrderedCollection;
		assert: secondEnumerated
		equals: aSecondCollection asOrderedCollection
]

{ #category : #'*XML-Parser-Tests' }
TestCase >> xmlShould: aBlock unorderedEnumerate: aCollection [

	| enumerated |
	enumerated := OrderedCollection new.
	aBlock value: [ :each | enumerated add: each ].
	self
		assert: enumerated sorted
		equals: aCollection asOrderedCollection sorted
]

{ #category : #'*XML-Parser-Tests' }
TestCase >> xmlShould: aBlock unorderedEnumerate: aFirstCollection and: aSecondCollection [

	| firstEnumerated secondEnumerated |
	firstEnumerated := OrderedCollection new.
	secondEnumerated := OrderedCollection new.
	aBlock value: [ :first :second |
		firstEnumerated addLast: first.
		secondEnumerated addLast: second ].
	self
		assert: firstEnumerated sorted
		equals: aFirstCollection asOrderedCollection sorted.
	self
		assert: secondEnumerated sorted
		equals: aSecondCollection asOrderedCollection sorted
]
