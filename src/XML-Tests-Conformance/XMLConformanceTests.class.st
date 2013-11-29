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
XMLConformanceTests class >> buildSourceFileMethodFor: aFileReference class: aClass [
	| sourceSelector pathString sourceStream |

	sourceSelector := (self sourceSelectorFrom: aFileReference).
	pathString := self pathStringFrom: aFileReference.

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
	(PreorderGuide for: fileVisitor) show: (self directoryForSuite: aSuite).

	badSourceFiles := OrderedCollection new.
	(fileVisitor passingTestFiles,
		fileVisitor failingTestFiles,
		fileVisitor entityFiles) do: [:each |
			[self
				buildSourceFileMethodFor: each
				class: testCaseClass]
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

	failingTestSelector := self testSelectorFrom: aFileReference.
	sourceSelector := self sourceSelectorFrom: aFileReference.
	pathString := self pathStringFrom: aFileReference.
	documentUri := self documentURIFrom: aFileReference.
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
XMLConformanceTests class >> directoryForSuite: aSuite [
	^ FileSystem workingDirectory / self baseDirectory / aSuite
]

{ #category : #paths }
XMLConformanceTests class >> documentURIFrom: aFileReference [
	^ ($/ join: (self segmentsAfterSuite: aFileReference)) asString
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
		raise: self exceptionClass'
]

{ #category : #'method templates' }
XMLConformanceTests class >> passingTestMethodTemplate [
	^ '{1}
	"Source file: {2}"

	self
		shouldnt: [
			self
				parse: self class {3}
				documentURI: ''{4}'']
		raise: self exceptionClass'
]

{ #category : #paths }
XMLConformanceTests class >> pathStringFrom: aFileReference [
	^ ($/ join: (aFileReference pathSegments copyAfter: self baseDirectory)) asString
]

{ #category : #selectors }
XMLConformanceTests class >> sanitizedSelectorPartFromSegments: aSegmentArray [
	^ aSegmentArray concatenation asString select: [:each | each isAlphaNumeric]
]

{ #category : #paths }
XMLConformanceTests class >> segmentsAfterSuite: aFileReference [
	^ (aFileReference pathSegments copyAfter: self baseDirectory) allButFirst
]

{ #category : #'method templates' }
XMLConformanceTests class >> sourceFileMethodTemplate [
	^ '{1}
	"Source file: {2}"

	^ ''{3}'''
]

{ #category : #selectors }
XMLConformanceTests class >> sourceSelectorFrom: aFileReference [
	^ self sourceSelelctorFromSegments: (self segmentsAfterSuite: aFileReference)
]

{ #category : #selectors }
XMLConformanceTests class >> sourceSelelctorFromSegments: aSegmentArray [
	^ ('source', (self sanitizedSelectorPartFromSegments: aSegmentArray)) asSymbol
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
XMLConformanceTests class >> testSelectorFrom: aFileReference [
	^ 'test',
		(self sanitizedSelectorPartFromSegments:
			(self segmentsAfterSuite: aFileReference)) asSymbol
]

{ #category : #accessing }
XMLConformanceTests >> exceptionClass [
	^ XMLParserException
]

{ #category : #accessing }
XMLConformanceTests >> fileClientClass [
	^ XMLConformanceVirtualFileClient
]

{ #category : #parsing }
XMLConformanceTests >> parse: aString documentURI: aUri [
	| parser |

	parser :=
		self parserClass
			on: aString
			documentURI: aUri.
	parser configuration fileClient:
		(self fileClientClass testCaseClass: self class).
	parser
		usesNamespaces: true;
		isValidating: true;
		resolvesExternalEntities: true;
		parseDocument.
]

{ #category : #accessing }
XMLConformanceTests >> parserClass [
	^ SAXHandler
]
