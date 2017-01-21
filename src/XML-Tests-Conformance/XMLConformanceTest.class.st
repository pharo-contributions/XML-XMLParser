"
This class generates subclass TestCases from the W3C's XML test suite, which can be obtained from this URL: http://www.w3.org/XML/Test/

To rebuild from source, unzip the archive in your image directory, then evaluate:
	self buildTestCases.

To  make failing tests skippable or update the lists of skippable tests in subcalsses (if a skipped test has possibly been fixed so it will pass), evaluate:
	self buildSkippableTestsMethodsFromFailures.
"
Class {
	#name : #XMLConformanceTest,
	#superclass : #XMLSkippableTest,
	#instVars : [
		'ignorableParserExceptions'
	],
	#category : #'XML-Tests-Conformance'
}

{ #category : #accessing }
XMLConformanceTest class >> baseDirectory [
	^ 'xmlconf'
]

{ #category : #'building subclasses' }
XMLConformanceTest class >> buildDefaultSkippableTestsMethods [
	"self buildDefaultSkippableTestsMethods"
	self allSubclassesDo: [:each |
		each class
			compile: 'skippableTests
	^ #()'
			classified: #accessing].
]

{ #category : #'building subclasses' }
XMLConformanceTest class >> buildFailingTestMethodFor: aFileReference in: aClass [	
	aClass
		compile:
			(self failingTestMethodTemplate format:
				(Array
					with: (self testSelectorFor: aFileReference) asString
					with: (self relativePathStringFor: aFileReference)
					with: (self sourceSelectorFor: aFileReference) asString
					with: (self documentURIFor: aFileReference)))
		classified: #'tests - exception raising'
]

{ #category : #'building subclasses' }
XMLConformanceTest class >> buildPassingTestMethodFor: aFileReference in: aClass [
	| template arguments outputFileReference |

	arguments :=
		OrderedCollection
			with: (self testSelectorFor: aFileReference) asString
			with: (self relativePathStringFor: aFileReference)
			with: (self sourceSelectorFor: aFileReference) asString
			with: (self documentURIFor: aFileReference).

	outputFileReference :=
		((aFileReference pathString allButLast: aFileReference basename size),
			'out/',
			aFileReference basename) asFileReference.
	outputFileReference exists
		ifTrue: [
			template := self passingTestMethodWithOutputTemplate.
			arguments addLast: (self sourceSelectorFor: outputFileReference)]
		ifFalse: [template := self passingTestMethodTemplate].

	aClass
		compile: (template format: arguments)
		classified: #'tests'.
]

{ #category : #'building subclasses' }
XMLConformanceTest class >> buildSkippableTestsMethodsFromFailures [
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
XMLConformanceTest class >> buildSourceFileClassMethodFor: aFileReference in: aClass [
	| sourceSelector pathString sourceStream isInString |

	sourceSelector := self sourceSelectorFor: aFileReference.
	pathString := self relativePathStringFor: aFileReference.

	sourceStream := (String new: aFileReference size) writeStream.
	"Use XMLFileHandle to get proper (inferred from BOMs) decoding of both
	UTF-8 and UTF-16. This makes it harder to test for invalid UTF in source
	but easier to get the xml source into the image."
	isInString := true.
	aFileReference fullName asXMLFileHandle readStreamDo: [:readStream |
		[readStream atEnd]
			whileFalse: [
				readStream peek == $'
					ifTrue: [
						isInString
							ifFalse: [
								sourceStream nextPutAll: ', '''.
								isInString := true].
						sourceStream
							nextPut: $'; "escape it"
							nextPut: readStream next]
					ifFalse: [
						(readStream peek isSeparator
							or: [readStream peek asciiValue between: 32 and: 126])
							ifTrue: [
								isInString
									ifFalse: [
										sourceStream nextPutAll: ', '''.
										isInString := true].
								sourceStream nextPut: readStream next]
							ifFalse: [
								isInString
									ifTrue: [
										sourceStream nextPut: $'.
										isInString := false].
								sourceStream
									nextPutAll: ', 16r';
									nextPutAll: readStream next asciiValue printStringHex;
									nextPutAll: ' asCharacter asString']]]].

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
XMLConformanceTest class >> buildTestCaseForSuite: aSuite [
	| testCaseClass fileVisitor badSourceFiles |

	testCaseClass := self createSubclassForSuite: aSuite.
	fileVisitor :=
		XMLConformanceFileVisitor
			suite: aSuite
			skipFilesInBase: (self suitesWithSkippableBases includes: aSuite).
	(PreorderGuide for: fileVisitor) show: (self fileReferenceForSuite: aSuite).

	badSourceFiles := Set new.
	(fileVisitor passingTestFiles,
		fileVisitor passingTestOutputFiles,
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
XMLConformanceTest class >> buildTestCases [
	"
	self buildTestCases
	"

	self supportedTestSuites do: [:each | self buildTestCaseForSuite: each].
	self buildSkippableTestsMethodsFromFailures.
]

{ #category : #'building subclasses' }
XMLConformanceTest class >> buildTestMethodFor: aFileReference in: aClass usingTemplate: aTemplate classified: aCategory [
	aClass
		compile:
			(aTemplate format:
				(Array
					with: (self testSelectorFor: aFileReference)
					with: (self sourceSelectorFor: aFileReference)
					with: (self relativePathStringFor: aFileReference)
					with: (self documentURIFor: aFileReference)))
		classified: aCategory
]

{ #category : #accessing }
XMLConformanceTest class >> classNameForSuite: aSuite [
	^ ('XMLConformance',
		(self classNameStemForSuite: aSuite),
		'Test') asSymbol
]

{ #category : #accessing }
XMLConformanceTest class >> classNameStemForSuite: aSuite [
	^ (aSuite = 'xmltest'
		ifTrue: ['Expat']
		ifFalse: [aSuite]) capitalized
]

{ #category : #'building subclasses' }
XMLConformanceTest class >> createSubclassForSuite: aSuite [
	^ self
		subclass: (self classNameForSuite: aSuite)
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: self category
]

{ #category : #paths }
XMLConformanceTest class >> documentURIFor: aFileReference [
	^ self pathStringRelativeToSuiteFor: aFileReference
]

{ #category : #'method templates' }
XMLConformanceTest class >> failingTestMethodTemplate [
	^ '{1}
	"Source file: {2}"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #{1}.
	self
		should: [
			self
				parse: self class {3}
				documentURI: ''{4}'']
		raise: self parserExceptions'
]

{ #category : #accessing }
XMLConformanceTest class >> fileReferenceForSuite: aSuite [
	^ FileSystem workingDirectory / self baseDirectory / aSuite
]

{ #category : #accessing }
XMLConformanceTest class >> ignorableParserExceptions [
	"Can be overridden to return a single exception or an ExceptionSet of
	exceptions built with #, like 'XMLHTTPException, XMLFileException'"
	^ nil
]

{ #category : #testing }
XMLConformanceTest class >> isAbstract [
	^ false
]

{ #category : #'method templates' }
XMLConformanceTest class >> passingTestMethodTemplate [
	^ '{1}
	"Source file: {2}"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #{1}.
	self
		shouldnt: [
			[self
				parse: self class {3}
				documentURI: ''{4}'']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions'
]

{ #category : #'method templates' }
XMLConformanceTest class >> passingTestMethodWithOutputTemplate [
	^ '{1}
	"Source file: {2}"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #{1}.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class {3}
						documentURI: ''{4}''.
				self
					assertDocument: document 
					canonicallyEquals: self class {5}]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions'
]

{ #category : #paths }
XMLConformanceTest class >> pathStringRelativeToSuiteFor: aFileReference [
	^ self relativePathStringFromSegments:
		(aFileReference pathSegments copyAfter: self baseDirectory) allButFirst
]

{ #category : #paths }
XMLConformanceTest class >> relativePathStringFor: aFileReference [
	^ self relativePathStringFromSegments:
		(aFileReference pathSegments copyAfter: self baseDirectory)
]

{ #category : #paths }
XMLConformanceTest class >> relativePathStringFromSegments: aSegmentArray [
	^ String streamContents: [:stream |
		aSegmentArray withIndexDo: [:each :i |
			i > 1
				ifTrue: [stream nextPut: $/].
			stream nextPutAll: each]]
]

{ #category : #'method templates' }
XMLConformanceTest class >> sourceFileMethodTemplate [
	^ '{1}
	"Source file: {2}"

	^ ''{3}'''
]

{ #category : #selectors }
XMLConformanceTest class >> sourceSelectorFor: aFileReference [
	^ self sourceSelectorForPath: (self pathStringRelativeToSuiteFor: aFileReference)
]

{ #category : #selectors }
XMLConformanceTest class >> sourceSelectorForPath: aPathString [
	^ ('source', (aPathString select: [:each | each isAlphaNumeric])) asSymbol
]

{ #category : #accessing }
XMLConformanceTest class >> suitesWithSkippableBases [
	^ self supportedTestSuites copyWithout: 'oasis'
]

{ #category : #accessing }
XMLConformanceTest class >> supportedTestSuites [
	^ #('xmltest' 'sun' 'oasis')
]

{ #category : #selectors }
XMLConformanceTest class >> testSelectorFor: aFileReference [
	^ self testSelectorForPath: (self pathStringRelativeToSuiteFor: aFileReference)
]

{ #category : #selectors }
XMLConformanceTest class >> testSelectorForPath: aPathString [
	^ ('test', (aPathString select: [:each | each isAlphaNumeric])) asSymbol
]

{ #category : #asserting }
XMLConformanceTest >> assertDocument: aDocument canonicallyEquals: aString [
	self assert:
		(self canonicalOutputFromDocument: aDocument) =
			(self outputWithNormalizedLineEndings: aString)
]

{ #category : #private }
XMLConformanceTest >> canonicalOutputFromDocument: aDocument [
	| writer |

	writer := XMLConformanceWriter new.
	aDocument hasDoctypeDefinition
		ifTrue: [| doctypeDefinition |
			doctypeDefinition := aDocument doctypeDefinition.
			doctypeDefinition notations values asSet
				ifNotEmpty: [:referencedNotations |
					writer doctypeDeclaration
						root: aDocument doctypeDeclaration root;
						publicID: aDocument doctypeDeclaration publicID;
						systemID: aDocument doctypeDeclaration systemID;
						with: [
							(referencedNotations sorted: [:a :b | a name <= b name]) do: [:each |
								writer notationDeclaration
									name: each name;
									publicID: each publicID;
									systemID: each systemID]]]].

	aDocument writeInnerXMLOn: writer.

	^ writer contents.
]

{ #category : #parsing }
XMLConformanceTest >> domParse: aString documentURI: aURIString [
	^ (self
		parserClass: self domParserClass
		on: aString
		documentURI: aURIString)
			preservesIgnorableWhitespace: true;
			parseDocument
]

{ #category : #accessing }
XMLConformanceTest >> domParserClass [
	^ XMLDOMParser
]

{ #category : #accessing }
XMLConformanceTest >> ignorableParserExceptions [
	^ ignorableParserExceptions
		ifNil: [ignorableParserExceptions := self class ignorableParserExceptions]
]

{ #category : #testing }
XMLConformanceTest >> isIgnorableParserException: anError [
	^ self ignorableParserExceptions notNil
		and: [self ignorableParserExceptions handles: anError]
]

{ #category : #accessing }
XMLConformanceTest >> newVirtualFileExternalEntityResolver [
	^ XMLConformanceVirtualFileExternalEntityResolver virtualFileClass: self class
]

{ #category : #private }
XMLConformanceTest >> outputWithNormalizedLineEndings: aString [
	"just in case the LFs in the output method source got converted
	to CRs or CRLFs on fileIn"
	^ (XMLNestedStreamReader on: aString readStream) upToEnd
]

{ #category : #parsing }
XMLConformanceTest >> parse: aString documentURI: aURIString [
	^ (self
		parserClass: self domParserClass
		on: aString
		documentURI: aURIString)
			parseDocument
]

{ #category : #accessing }
XMLConformanceTest >> parserClass [
	^ SAXHandler
]

{ #category : #parsing }
XMLConformanceTest >> parserClass: aParserClass on: aString documentURI: aURIString [ 
	| parser |

	parser :=
		aParserClass
			on: aString
			documentURI: aURIString.

	"none of the tests use namespaces, but the Expat suite has examples with
	invalid QNames that trigger namespace exceptions, so namespace support is
	disabled, and because the source is pre-decoded from UTF-8/UTF-16, decoding
	is disabled"
	^ parser
		usesNamespaces: false;
		isValidating: true;
		resolvesExternalEntities: true;
		externalEntityResolver: self newVirtualFileExternalEntityResolver;
		decodesCharacters: false.
]

{ #category : #accessing }
XMLConformanceTest >> parserExceptions [
	^ XMLParserException
]
