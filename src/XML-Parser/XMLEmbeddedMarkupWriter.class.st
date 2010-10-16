"
This class is a markup writer that supports embedding of child markup.
"
Class {
	#name : #XMLEmbeddedMarkupWriter,
	#superclass : #XMLMarkupWriter,
	#instVars : [
		'isWritingBody',
		'hasEmbeddedMarkup',
		'hasEmbeddedMarkupWriters'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #private }
XMLEmbeddedMarkupWriter >> embedBlock: aBlock [
	aBlock valueWithPossibleArgument: self writer
]

{ #category : #private }
XMLEmbeddedMarkupWriter >> embedCollection: aCollection [
	aCollection do: [:each | self embedValue: each]
]

{ #category : #private }
XMLEmbeddedMarkupWriter >> embedString: aString [
	self writer nextPutAll: aString
]

{ #category : #private }
XMLEmbeddedMarkupWriter >> embedValue: aValue [
	aValue ifNil: [^ self].

	aValue isString
		ifTrue: [^ self embedString: aValue].
	aValue isCollection
		ifTrue: [^ self embedCollection: aValue].
	aValue isBlock
		ifTrue: [^ self embedBlock: aValue].

	self error: 'Value object must be a string, collection or block'.
]

{ #category : #private }
XMLEmbeddedMarkupWriter >> flushMarkup [
	self isWritingBody
		ifTrue: [
			self hasEmbeddedMarkup
				ifFalse: [self startWritingEmbeddedMarkup]]
		ifFalse: [self with: nil]
]

{ #category : #testing }
XMLEmbeddedMarkupWriter >> hasEmbeddedMarkup [
	^ hasEmbeddedMarkup ifNil: [hasEmbeddedMarkup := false]
]

{ #category : #testing }
XMLEmbeddedMarkupWriter >> hasEmbeddedMarkupWriters [
	^ hasEmbeddedMarkupWriters ifNil: [hasEmbeddedMarkupWriters := false]
]

{ #category : #testing }
XMLEmbeddedMarkupWriter >> isWritingBody [
	^ isWritingBody ifNil: [isWritingBody := false]
]

{ #category : #private }
XMLEmbeddedMarkupWriter >> nextMarkupWriter: aMarkupWriter [
	self isWritingBody
		ifTrue: [
			self hasEmbeddedMarkup
				ifFalse: [self startWritingEmbeddedMarkup].
			aMarkupWriter parent: self.
			hasEmbeddedMarkupWriters := true]
		ifFalse: [self flushMarkup]
]

{ #category : #private }
XMLEmbeddedMarkupWriter >> startWritingEmbeddedMarkup [	
	hasEmbeddedMarkup := true.
	self writeBeforeEmbeddedMarkup.
]

{ #category : #'embedding markup' }
XMLEmbeddedMarkupWriter >> with: aStringOrCollectionOrBlock [
	self
		writePrologue;
		writeBody: aStringOrCollectionOrBlock;
		writeEpilogue;
		flushed
]

{ #category : #private }
XMLEmbeddedMarkupWriter >> writeBeforeEmbeddedMarkup [
]

{ #category : #private }
XMLEmbeddedMarkupWriter >> writeBody: aStringOrCollectionOrBlock [
	isWritingBody := true.

	self embedValue: aStringOrCollectionOrBlock.
	self isActiveMarkupWriter
		ifFalse: [self writer flushMarkup].

	isWritingBody := false.
]
