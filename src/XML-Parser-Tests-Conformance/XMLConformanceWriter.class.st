"
An XMLWriter for the XML Conformance test suite canonical XML format.
"
Class {
	#name : #XMLConformanceWriter,
	#superclass : #XMLWriter,
	#classVars : [
		'ContentConformanceCanonicalEscapes',
		'ContentStringConformanceCanonicalEscapes'
	],
	#category : #'XML-Parser-Tests-Conformance-Writer'
}

{ #category : #'class initialization' }
XMLConformanceWriter class >> initialize [
	"self initialize"

	self
		initializeContentConformanceCanonicalEscapes;
		initializeContentStringConformanceCanonicalEscapes
]

{ #category : #'class initialization' }
XMLConformanceWriter class >> initializeContentConformanceCanonicalEscapes [
	ContentConformanceCanonicalEscapes :=
		ContentCanonicalEscapes copy
			at: 9 put: '&#9;';
			at: 10 put: '&#10;';
			at: 13 put: '&#13;';
			at: $" asciiValue put: '&quot;';
			yourself
]

{ #category : #'class initialization' }
XMLConformanceWriter class >> initializeContentStringConformanceCanonicalEscapes [
	ContentStringConformanceCanonicalEscapes :=
		ContentStringCanonicalEscapes copy
			at: 9 put: '&#9;';
			at: 10 put: '&#10;';
			at: 13 put: '&#13;';
			at: $> asciiValue put: '&gt;';
			yourself
]

{ #category : #defaults }
XMLConformanceWriter >> canonicalWriterFormatterClass [
	^ XMLConformanceCanonicalWriterFormatter
]

{ #category : #defaults }
XMLConformanceWriter >> contentCanonicalEscapes [
	^ ContentConformanceCanonicalEscapes
]

{ #category : #defaults }
XMLConformanceWriter >> contentStringCanonicalEscapes [
	^ ContentStringConformanceCanonicalEscapes
]

{ #category : #writing }
XMLConformanceWriter >> doctypeDeclaration [
	^ self pushNewMarkupWriter: XMLConformanceDoctypeDeclarationWriter
]

{ #category : #writing }
XMLConformanceWriter >> notationDeclaration [
	^ self pushNewMarkupWriter: XMLConformanceNotationDeclarationWriter
]

{ #category : #writing }
XMLConformanceWriter >> pi [
	^ self pushNewMarkupWriter: XMLConformancePIWriter
]

{ #category : #private }
XMLConformanceWriter >> writeUnescapedString: aString [
	self isCanonical
		ifTrue: [
			"conformance canonical XML requires single quotes for these strings"
			self
				writeUnescapedString: aString
				quotedBy: $']
		ifFalse: [super writeUnescapedString: aString]
]
