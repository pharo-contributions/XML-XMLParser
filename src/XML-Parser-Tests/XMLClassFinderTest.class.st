Class {
	#name : 'XMLClassFinderTest',
	#superclass : 'TestCase',
	#category : 'XML-Parser-Tests-Utils',
	#package : 'XML-Parser-Tests',
	#tag : 'Utils'
}

{ #category : 'accessing' }
XMLClassFinderTest >> absentClassName [
	^ (self presentClassName asString, 'ShouldNotBePresent') asString
]

{ #category : 'accessing' }
XMLClassFinderTest >> classFinder [
	^ XMLClassFinder
]

{ #category : 'accessing' }
XMLClassFinderTest >> presentClass [
	^ self class
]

{ #category : 'accessing' }
XMLClassFinderTest >> presentClassName [
	^ self class name asSymbol
]

{ #category : 'tests' }
XMLClassFinderTest >> testClassNamed [

	self
		assert: (self classFinder classNamed: self presentClassName)
		identicalTo: self presentClass.
	self assert:
		(self classFinder classNamed: self absentClassName) isNil
]

{ #category : 'tests' }
XMLClassFinderTest >> testClassNamedIfAbsent [

	self
		assert: (self classFinder
				 classNamed: self presentClassName
				 ifAbsent: [ self fail ])
		identicalTo: self presentClass.
	self
		assert: (self classFinder
				 classNamed: self absentClassName
				 ifAbsent: [ #absent ])
		equals: #absent
]

{ #category : 'tests' }
XMLClassFinderTest >> testClassNamedIfPresent [
	self assert:
		(self classFinder
			classNamed: self presentClassName
			ifPresent: [:presentClass | #present -> presentClass]) equals:
				(#present -> self presentClass).
	"ensure cull: is used"
	self assert:
		(self classFinder
			classNamed: self presentClassName
			ifPresent: [#present]) equals: #present.

	self assert:
		(self classFinder
			classNamed: self absentClassName
			ifPresent: [self fail]) isNil
]

{ #category : 'tests' }
XMLClassFinderTest >> testClassNamedIfPresentIfAbsent [
	self assert:
		(self classFinder
			classNamed: self presentClassName
			ifPresent: [:presentClass | #present -> presentClass]
			ifAbsent: [self fail]) equals:
				(#present -> self presentClass).
	"ensure cull: is used"
	self assert:
		(self classFinder
			classNamed: self presentClassName
			ifPresent: [#present]
			ifAbsent: [self fail]) equals: #present.

	self assert:
		(self classFinder
			classNamed: self absentClassName
			ifPresent: [self fail]
			ifAbsent: [#absent]) equals: #absent
]

{ #category : 'tests' }
XMLClassFinderTest >> testHasClassNamed [
	self
		assert: (self classFinder hasClassNamed: self presentClassName);
		deny: (self classFinder hasClassNamed: self absentClassName)
]
