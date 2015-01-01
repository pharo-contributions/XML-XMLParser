"
This class generates subclass TestCases from the W3C's XML test suite, which can be obtained from this URL: http://www.w3.org/XML/Test/

To rebuild from source, unzip the archive in your image directory, then evaluate:

self buildTestCases.
"
Class {
	#name : #XMLConformanceTests,
	#superclass : #TestCase,
	#category : #'XML-Tests-Conformance'
}

{ #category : #accessing }
XMLConformanceTests class >> baseDirectory [
	^ 'xmlconf'
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
XMLConformanceTests class >> buildSourceFileClassMethodFor: aFileReference in: aClass [
	| sourceSelector pathString sourceStream |

	sourceSelector := (self sourceSelectorFor: aFileReference).
	pathString := self relativePathStringFor: aFileReference.

	sourceStream := (String new: aFileReference size) writeStream.
	aFileReference readStreamDo: [:readStream |
		[readStream atEnd not]
			whileTrue: [
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
		classified: 'xml source' asSymbol.
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

	badSourceFiles := OrderedCollection new.
	(fileVisitor passingTestFiles,
		fileVisitor failingTestFiles,
		fileVisitor entityFiles) do: [:each |
			[self
				buildSourceFileClassMethodFor: each
				in: testCaseClass]
				on: ZnCharacterEncodingError
				do: [:error | badSourceFiles add: each]].

	(fileVisitor passingTestFiles copyWithoutAll: badSourceFiles)
		do: [:each |
			self
				buildPassingTestMethodFor: each
				in: testCaseClass].
	(fileVisitor failingTestFiles copyWithoutAll: badSourceFiles)
		do: [:each |
			self
				buildFailingTestMethodFor: each
				in: testCaseClass].
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildTestCases [
	"self buildTestCases"

	self supportedTestSuites do: [:each | self buildTestCaseForSuite: each]
]

{ #category : #'building subclasses' }
XMLConformanceTests class >> buildTestMethodFor: aFileReference in: aClass usingTemplate: aTemplate classified: aCategory [
	| failingTestSelector sourceSelector pathString documentUri |

	failingTestSelector := self testSelectorFor: aFileReference.
	sourceSelector := self sourceSelectorFor: aFileReference.
	pathString := self relativePathStringFor: aFileReference.
	documentUri := self documentURIFor: aFileReference.
	aClass
		compile:
			(aTemplate format:
				(Array
					with: failingTestSelector asString
					with: pathString
					with: sourceSelector asString
					with: documentUri))
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

{ #category : #'method templates' }
XMLConformanceTests class >> passingTestMethodTemplate [
	^ '{1}
	"Source file: {2}"

	self
		shouldnt: [
			[self
				parse: self class {3}
				documentURI: ''{4}'']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skip]
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
	^ (XMLFileException, XMLHTTPException, XMLLimitException) handles: anError
]

{ #category : #accessing }
XMLConformanceTests >> newVirtualFileResolver [
	^ XMLConformanceVirtualFileResolver virtualFileClass: self class
]

{ #category : #parsing }
XMLConformanceTests >> parse: aString documentURI: aUri [
	| parser |

	parser :=
		self parserClass
			on: aString
			documentURI: aUri.
	parser
		usesNamespaces: false;
		isValidating: true;
		resolvesExternalEntities: true;
		externalEntityResolver: self newVirtualFileResolver;
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
