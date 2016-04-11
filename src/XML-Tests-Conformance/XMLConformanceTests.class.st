"
This class generates subclass TestCases from the W3C's XML test suite, which can be obtained from this URL: http://www.w3.org/XML/Test/

To rebuild from source, unzip the archive in your image directory, then evaluate:
	self buildTestCases.

To  make failing tests skippable or update the lists of skippable tests in subcalsses (if a skipped test has possibly been fixed so it will pass), evaluate:
	self buildSkippableTestsMethodsFromFailures.
"
Class {
	#name : #XMLConformanceTests,
	#superclass : #TestCase,
	#instVars : [
		'skippableTests',
		'skippableExceptions'
	],
	#classVars : [
		'IsSkipping'
	],
	#category : #'XML-Tests-Conformance'
}

{ #category : #accessing }
XMLConformanceTests class >> baseDirectory [
	^ 'xmlconf'
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildDefaultSkippableTestsMethods [
	"self buildDefaultSkippableTestsMethods"
	self allSubclassesDo: [:each |
		each class
			compile: 'skippableTests
	^ #()'
			classified: #accessing].
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildFailingTestMethodFor: aFileReference in: aClass [
	self
		buildTestMethodFor: aFileReference
		in: aClass
		usingTemplate: self failingTestMethodTemplate
		classified: 'tests - exception raising' asSymbol
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildPassingTestMethodFor: aFileReference in: aClass [
	self
		buildTestMethodFor: aFileReference
		in: aClass
		usingTemplate: self passingTestMethodTemplate
		classified: 'tests' asSymbol
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildSkippableTestsMethodsFromFailures [
	"Run this after possibly fixing a failing skipped test so it
	will be excluded form the list of skippable tests.

	self buildSkippableTestsMethodsFromFailures
	"

	self buildDefaultSkippableTestsMethods.
	self allSubclassesDo: [:testCaseClass | | result failures methodSource |
		result := testCaseClass buildSuite run.
		failures := OrderedCollection new.
		result failures do: [:each | failures addLast: each selector asString].
		failures sort.

		methodSource :=
			(String streamContents: [:stream |
				stream nextPutAll: 'skippableTests
	^ #('.
				failures do: [:each |
					stream
						space;
						nextPutAll: each].
				stream nextPutAll: ' )']).

		testCaseClass class
			compile: methodSource
			classified: #accessing]
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildSourceFileClassMethodFor: aFileReference in: aClass [
	| sourceSelector pathString sourceStream |

	sourceSelector := self sourceSelectorFor: aFileReference.
	pathString := self relativePathStringFor: aFileReference.

	sourceStream := (String new: aFileReference size) writeStream.
	"Use XMLFileHandle to get proper (inferred from BOMs) decoding of both
	UTF-8 and UTF-16. This makes it harder to test for invalid UTF in source
	but easier to get the xml source into the image."
	aFileReference fullName asXMLFileHandle readStreamDo: [:readStream |
		[readStream atEnd]
			whileFalse: [
				readStream peek == $'
					ifTrue: [sourceStream nextPut: $'].
				sourceStream nextPut: readStream next]].

	aClass class
		compile:
			(self sourceFileMethodTemplate format:
				(Array
					with: sourceSelector asString
					with: pathString
					with: sourceStream contents))
		classified: #'xml source'.
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildTestCaseForSuite: aSuite [
	| testCaseClass fileVisitor badSourceFiles |

	testCaseClass := self createSubclassForSuite: aSuite.
	fileVisitor :=
		XMLConformanceFileVisitor
			suite: aSuite
			skipFilesInBase: (self suitesWithSkippableBases includes: aSuite).
	(PreorderGuide for: fileVisitor) show: (self fileReferenceForSuite: aSuite).

	badSourceFiles := Set new.
	(fileVisitor passingTestFiles,
		fileVisitor failingTestFiles,
		fileVisitor entityFiles) do: [:each |
			[self
				buildSourceFileClassMethodFor: each
				in: testCaseClass]
				on: Error
				do: [:error | badSourceFiles add: each]].

	fileVisitor passingTestFiles do: [:each |
		(badSourceFiles includes: each)
			ifFalse: [
				self
					buildPassingTestMethodFor: each
					in: testCaseClass]].
	fileVisitor failingTestFiles do: [:each |
		(badSourceFiles includes: each)
			ifFalse: [
				self
					buildFailingTestMethodFor: each
					in: testCaseClass]].
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildTestCases [
	"self buildTestCases"

	self supportedTestSuites do: [:each | self buildTestCaseForSuite: each].
	self buildSkippableTestsMethodsFromFailures.
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildTestMethodFor: aFileReference in: aClass usingTemplate: aTemplate classified: aCategory [
	| failingTestSelector sourceSelector pathString documentURI |

	failingTestSelector := self testSelectorFor: aFileReference.
	sourceSelector := self sourceSelectorFor: aFileReference.
	pathString := self relativePathStringFor: aFileReference.
	documentURI := self documentURIFor: aFileReference.
	aClass
		compile:
			(aTemplate format:
				(Array
					with: failingTestSelector asString
					with: pathString
					with: sourceSelector asString
					with: documentURI))
		classified: aCategory
]

{ #category : #accessing }
XMLConformanceTests class >> classNameForSuite: aSuite [
	^ ('XMLConformance',
		(self suiteClassNames
			at: aSuite
			ifAbsent: [aSuite]) capitalized,
		'Tests') asSymbol
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> createSubclassForSuite: aSuite [
	^ self
		subclass: (self classNameForSuite: aSuite)
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: self category
]

{ #category : #paths }
XMLConformanceTests class >> documentURIFor: aFileReference [
	^ self pathStringRelativeToSuiteFor: aFileReference
]

{ #category : #'method templates' }
XMLConformanceTests class >> failingTestMethodTemplate [
	^ '{1}
	"Source file: {2}"

	(self isSkippableTest: #{1})
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class {3}
				documentURI: ''{4}'']
		raise: self parserExceptions'
]

{ #category : #accessing }
XMLConformanceTests class >> fileReferenceForSuite: aSuite [
	^ FileSystem workingDirectory / self baseDirectory / aSuite
]

{ #category : #testing }
XMLConformanceTests class >> isSkipping [
	"allow skipping of certain tests by default"
	^ IsSkipping ifNil: [IsSkipping := true]
]

{ #category : #accessing }
XMLConformanceTests class >> isSkipping: aBoolean [
	"certain tests are skipped by default

	self isSkipping: false.
	self isSkipping: true.
	"
	IsSkipping := aBoolean
]

{ #category : #'method templates' }
XMLConformanceTests class >> passingTestMethodTemplate [
	^ '{1}
	"Source file: {2}"

	(self isSkippableTest: #{1})
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class {3}
				documentURI: ''{4}'']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions'
]

{ #category : #paths }
XMLConformanceTests class >> pathStringRelativeToSuiteFor: aFileReference [
	^ self relativePathStringFromSegments:
		(aFileReference pathSegments copyAfter: self baseDirectory) allButFirst
]

{ #category : #paths }
XMLConformanceTests class >> relativePathStringFor: aFileReference [
	^ self relativePathStringFromSegments:
		(aFileReference pathSegments copyAfter: self baseDirectory)
]

{ #category : #paths }
XMLConformanceTests class >> relativePathStringFromSegments: aSegmentArray [
	^ String streamContents: [:stream |
		aSegmentArray withIndexDo: [:each :i |
			i > 1
				ifTrue: [stream nextPut: $/].
			stream nextPutAll: each]]
]

{ #category : #accessing }
XMLConformanceTests class >> skippableTests [
	^ #()
]

{ #category : #'method templates' }
XMLConformanceTests class >> sourceFileMethodTemplate [
	^ '{1}
	"Source file: {2}"

	^ ''{3}'''
]

{ #category : #selectors }
XMLConformanceTests class >> sourceSelectorFor: aFileReference [
	^ self sourceSelectorForPath: (self pathStringRelativeToSuiteFor: aFileReference)
]

{ #category : #selectors }
XMLConformanceTests class >> sourceSelectorForPath: aPathString [
	^ ('source', (aPathString select: [:each | each isAlphaNumeric])) asSymbol
]

{ #category : #accessing }
XMLConformanceTests class >> suiteClassNames [
	^ Dictionary with: 'xmltest' -> 'expat'
]

{ #category : #accessing }
XMLConformanceTests class >> suitesWithSkippableBases [
	^ self supportedTestSuites copyWithout: 'oasis'
]

{ #category : #accessing }
XMLConformanceTests class >> supportedTestSuites [
	^ #('xmltest' 'sun' 'oasis')
]

{ #category : #selectors }
XMLConformanceTests class >> testSelectorFor: aFileReference [
	^ self testSelectorForPath: (self pathStringRelativeToSuiteFor: aFileReference)
]

{ #category : #selectors }
XMLConformanceTests class >> testSelectorForPath: aPathString [
	^ ('test', (aPathString select: [:each | each isAlphaNumeric])) asSymbol
]

{ #category : #'reflective operations' }
XMLConformanceTests >> doesNotUnderstand: aMessage [
	"for squeak"
	aMessage selector == #skip
		ifFalse: [super doesNotUnderstand: aMessage]
]

{ #category : #testing }
XMLConformanceTests >> isSkippableException: anError [
	^ self class isSkipping
		and: [self skippableExceptions handles: anError]
]

{ #category : #testing }
XMLConformanceTests >> isSkippableTest: aSelector [
	^ self class isSkipping
		and: [self skippableTests includes: aSelector]
]

{ #category : #accessing }
XMLConformanceTests >> newVirtualFileExternalEntityResolver [
	^ XMLConformanceVirtualFileExternalEntityResolver virtualFileClass: self class
]

{ #category : #parsing }
XMLConformanceTests >> parse: aString documentURI: aUri [
	| parser |

	parser :=
		self parserClass
			on: aString
			documentURI: aUri.

	"none of the tests use namespaces, but the Expat suite has examples with
	invalid QNames that trigger namespace exceptions, so namespace support is
	disabled, and because the source is pre-decoded from UTF-8/UTF-16, so
	decoding is disabled"
	parser
		usesNamespaces: false;
		isValidating: true;
		resolvesExternalEntities: true;
		externalEntityResolver: self newVirtualFileExternalEntityResolver;
		decodesCharacters: false;
		parseDocument.
]

{ #category : #accessing }
XMLConformanceTests >> parserClass [
	^ SAXHandler
]

{ #category : #accessing }
XMLConformanceTests >> parserExceptions [
	^ XMLParserException
]

{ #category : #private }
XMLConformanceTests >> skipOrReturnWith: aBlock [
	"skip is not portable to squeak"
	(self respondsTo: #skip)
		ifTrue: [self skip]
		ifFalse: [aBlock value]
]

{ #category : #accessing }
XMLConformanceTests >> skippableExceptions [
	^ skippableExceptions
		ifNil: [skippableExceptions := XMLFileException, XMLHTTPException, XMLLimitException]
]

{ #category : #accessing }
XMLConformanceTests >> skippableTests [
	^ skippableTests ifNil: [skippableTests := self class skippableTests asSet]
]
