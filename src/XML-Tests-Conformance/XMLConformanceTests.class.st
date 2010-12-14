"
This class contains tests with source methods generated from the OASIS test suite, which can be obtained from this URL: http://www.oasis-open.org/committees/xml-conformance/xml-test-suite.shtml
"
Class {
	#name : #XMLConformanceTests,
	#superclass : #TestCase,
	#instVars : [
		'testsToSkip'
	],
	#category : #'XML-Tests-Conformance'
}

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> addMethod: testMethodString classified: classificationString [ 

	self compile: testMethodString classified: classificationString
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> baseTestDirectory [
	^ FileDirectory default directoryNamed: 'xmlconf'
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> filenameAt: partialPath [ 
	| platformPartialPath methodOfFileName stream |
	
	methodOfFileName := (partialPath copyWithoutAll: '.-/\') asSymbol.
	(self class includesSelector: methodOfFileName )
		ifTrue: [ ^ self perform: methodOfFileName ].
	
	platformPartialPath := partialPath replaceAll: $/ with: FileDirectory pathNameDelimiter.
	stream := CrLfFileStream
		readOnlyFileNamed: (self baseTestDirectory directoryNamed: platformPartialPath) pathName.
	self class compile: 'source', methodOfFileName asString, String cr, '	^ ', stream contents printString classified: 'source'.
	^ stream contents.
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> generateTestFrom: anVWXMLElement category: aString [
	|type testName testFile reference description testCode answerFile arguments |

	type := anVWXMLElement valueOfAttribute: 'TYPE' ifAbsent: [self error: 'missing test information'].
	testName := anVWXMLElement valueOfAttribute: 'ID' ifAbsent: [self error: 'missing test information'].
	testFile := anVWXMLElement valueOfAttribute: 'URI' ifAbsent: [self error: 'missing test information'].
	reference := anVWXMLElement valueOfAttribute: 'SECTIONS' ifAbsent: [self error: 'missing test information'].
	answerFile := anVWXMLElement valueOfAttribute: 'OUTPUT' ifAbsent: [nil].
	"Some test do not give correct answer. skip"
	type = 'valid' & (answerFile isNil)
		ifTrue:[^self]. 
	description := anVWXMLElement characterData.

	"sun test files do not follow the same pattern as the others"
	aString = 'sun' ifTrue:
		[testFile := 'sun/' , testFile.
		 answerFile notNil ifTrue:[ answerFile := 'sun/' , answerFile.]].

	arguments := OrderedCollection new: 5.
	arguments
		add: aString ,  (self remove: $- from: testName );
		add: testName;
		add: (description replaceAll: $" with: $ );
		add: (reference replaceAll: $" with: $ );
		add: testFile;
		add: answerFile.
	testCode := (type = 'valid') 
					ifTrue:[self validTestTemplate]
					ifFalse:[ (type = 'not-wf')
						ifTrue:[self notWellFormedTestTemplate]
						ifFalse:[ (type = 'invalid' or:[type = 'error'])
							ifTrue:[self invalidTestTemplate]
							ifFalse:[self error: 'Invalid test type']]].
	testCode := testCode expandMacrosWithArguments: arguments.
	self addMethod: testCode classified: aString , ' ' , (type replaceAll: $- with: $ ).
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> generateTests [
	"XMLParserTests generateTests"

	self
		removeTests: 'test_*';
		generateTestsFrom: 'xmltest/xmltest.xml' category:  'clark';
		generateTestsFrom: 'oasis/oasis.xml' category:  'oasis'.

	#('sun/valid/sun-valid.xml' 'sun/invalid/sun-invalid.xml' 'sun/not-wf/sun-not-wf.xml' 'sun/error/sun-error.xml') do: 
			[:each |  self generateTestsFrom: each category: 'sun']
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> generateTestsFrom: xmlFile category: aString [
	| tests  |

	tests := self xmlTestDriverIn: xmlFile .
	tests do: [:element | self generateTestFrom: element category: aString.]
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> haveParserValidate [
	"Return true if you want the parser to validate the test XML files against the DTD
	 It is not very useful to return false, as many tests will then fail. Should remove this
	option"
	^true
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> invalidTestTemplate [
	"<1s> = test name
	 <2s> = test ID
	 <3s> = description
	 <4s> = XML spec reference
	 <5s> = test path"
	^'test<1s>
	"<3s>
	 See XML Spec. 1.0 section: <4s>"

	(self class shouldSkipTests and: [testsToSkip includes: ''<2s>''])
		ifTrue:[^nil].

	self assert: [self runTest: ''<5s>'']
		raises: self exceptionSet'
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> notWellFormedTestTemplate [
	"<1s> = test name
	 <2s> = test ID
	 <3s> = description
	 <4s> = XML spec reference
	 <5s> = test path"
	^'test<1s>
	"<3s>
	 See XML Spec. 1.0 section: <4s>"

	(self class shouldSkipTests and: [testsToSkip includes: ''<2s>''])
		ifTrue:[^nil].

	self assert: [self runTest: ''<5s>'' ]
		raises: self exceptionsTest2'
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> remove: aCharacter from: aString [
	^aString reject: [:each | each = aCharacter]
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> removeTests: testMatchPattern [ 
	self selectors 
		do: [:selector | (testMatchPattern match: selector) ifTrue: [self removeSelector: selector]]
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> shouldSkipTests [
	"indicates if one wants to skip some tests"

	^true
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> validTestTemplate [
	"Template used to create the test methods for valid tests
	<1s> = test name
	 <2s> = test ID
	 <3s> = description
	 <4s> = XML spec reference
	 <5s> = test path
	 <6s> = answer file path" 
	^'test<1s>
	"<3s>
	 See XML Spec. 1.0 section: <4s>"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: ''<2s>''])
		ifTrue:[^nil].
	correctAnswer := (self class filenameAt:''<6s>'')  contentsOfEntireFile.

	[result := self runTest: ''<5s>'' ]
		on: VWXMLWarningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.'


"	correctAnswer := ((self class filenameAt:''<6s>'') withEncoding: #UTF_8 ) readStream contents."
]

{ #category : #'as yet unclassified' }
XMLConformanceTests class >> xmlTestDriverIn: aTailPathString [
	"Return an array of VWXMLElements containing the test"
	| document driverText mainElement |

	"Parser can not handle comments in files, but can handle them in strings
	 The above problem has been fixed, so could have the parser open the file.
	 Will keep this code for those that have not installed my fixes"
	driverText := (self filenameAt: aTailPathString) contentsOfEntireFile.
	document := self parserClass 
		processDocumentString: driverText
	 	beforeScanDo: [:parser | parser validate: false].

	"filter out the comments. There is only one top level element in an XML document"
	mainElement := (document selectNodes: [:each | each isElement] ) at: 1.
	^mainElement elementsNamed: 'TEST'
]

{ #category : #'as yet unclassified' }
XMLConformanceTests >> canonicalVersion: aDocument [
	|  aStream |
	aStream := WriteStream on: (String new: 10).
	aDocument
		canonicallyPrintOn: aStream.

	^aStream contents
]

{ #category : #'as yet unclassified' }
XMLConformanceTests >> exceptionSet [
	^  XMLParserWarning , XMLParsingException, XMLWellFormednessException, Error  

]

{ #category : #'as yet unclassified' }
XMLConformanceTests >> exceptionSet2 [
	^ XMLParserWarning, XMLParsingException, XMLWellFormednessException, Error
]

{ #category : #'as yet unclassified' }
XMLConformanceTests >> initialize [
	testsToSkip := self class allTestsToSkip.
]

{ #category : #'as yet unclassified' }
XMLConformanceTests >> parserClass [
	^Smalltalk at: self parserClassName
]

{ #category : #'as yet unclassified' }
XMLConformanceTests >> parserClassName [
	^#XMLDOMParser
]

{ #category : #'as yet unclassified' }
XMLConformanceTests >> runTest: aString [ 
	| test  |

	test := self parserClass parseDocumentFrom: aString.
	^self canonicalVersion: test.
]

{ #category : #'as yet unclassified' }
XMLConformanceTests >> warningSignal [
	^XMLWarning 
]
