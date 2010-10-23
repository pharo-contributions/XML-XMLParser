"
This class allows you to generate well-formed XML documents using an API similar to Seaside's canvas and tag brush API.

Markup can be created by sending an instance any of the messages under ""writing markup."" The messages that take no arguments return an instance of an XMLMarkupWriter subclass. These objects can be configured with messages like #name: and #attributeAt:put:. Sending them #write or a specific writing message that accepts markup to embed within (#content: or #internalSubset: for example) causes the markup writer's configuration to be committed and its markup written to the output stream. For markup writers that can have embedded markup, the argument to the writing message can be a string, collection (of strings and blocks), a block, or nil. The block passed in can optionally take an argument, which will be the XMLWriter object that created the markup writer object. Within the block you can generate additional, child markup that will be contained by the parent. Creating additional non-embedded markup will cause any unwritten markup from a previous markup writer to be written, as will sending an XMLWriter or XMLMarkupWriter #contents, #asString, #printOn:, or #write.

Here is an example, which you can highlight and evaluate with cmd-p to see the result:

	| writer |
	(writer := XMLWriter new) enablePrettyPrinting.
	writer xml.
	writer tag
			name: 'foo:bar';
			xmlnsAt: 'foo' put: 'http://foo';
			attributeAt: 'a' put: 'one';
			attributeAt: 'b' put: 'two';
			content: [
				writer tag: 'bar' content: [
					writer
						string: 'test';
						tag: 'baz';
						tag: 'foobar' content: 'test']]
"
Class {
	#name : #XMLWriter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'activeMarkupWriter',
		'currentIndentLevel',
		'indentString',
		'lineBreak',
		'isCanonical',
		'omitsLineBreaks'
	],
	#classVars : [
		'CarriageReturn',
		'CharacterEscapes',
		'LineFeed',
		'SpecialCharacters'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #'class initialization' }
XMLWriter class >> initialize [
	"self initialize"

	(CharacterEscapes := CharacterMap new)
		at: $& put: '&amp;';
		at: $" put: '&quot;';
		at: $< put: '&lt;';
		at: $> put: '&gt;'.

	CarriageReturn := Character cr.
	LineFeed := Character lf.

	(SpecialCharacters := CharacterSet new)
		addAll: CharacterEscapes keys;
		add: CarriageReturn;
		add: LineFeed.
]

{ #category : #'instance creation' }
XMLWriter class >> new [
	^ self on: (String new: 512) writeStream
]

{ #category : #'instance creation' }
XMLWriter class >> on: aStream [
	^ self basicNew initialize
		stream: aStream
]

{ #category : #'writing markup' }
XMLWriter >> % aParameterEntityReference [
	^ self paramEntityRef: aParameterEntityReference
]

{ #category : #'writing markup' }
XMLWriter >> & anEntityReference [
	^ self entityRef: anEntityReference
]

{ #category : #accessing }
XMLWriter >> activeMarkupWriter [
	^ activeMarkupWriter
]

{ #category : #private }
XMLWriter >> addNewMarkupWriter: aMarkupWriterClass [
	| markupWriter |

	markupWriter := aMarkupWriterClass writer: self.

	self activeMarkupWriter
		ifNotNil: [self activeMarkupWriter nextMarkupWriter: markupWriter].

	^ activeMarkupWriter := markupWriter.
]

{ #category : #testing }
XMLWriter >> atStart [
	^ self stream position isZero
]

{ #category : #'writing markup' }
XMLWriter >> attributeDeclaration [
	^ self addNewMarkupWriter: XMLAttributeDeclarationWriter
]

{ #category : #'writing markup' }
XMLWriter >> cdata [
	^ self addNewMarkupWriter: XMLCDataWriter
]

{ #category : #'writing markup' }
XMLWriter >> cdata: aString [
	self cdata with: aString
]

{ #category : #actions }
XMLWriter >> close [
	self flushMarkup.
	self stream close.
]

{ #category : #'writing markup' }
XMLWriter >> comment [
	^ self addNewMarkupWriter: XMLCommentWriter
]

{ #category : #'writing markup' }
XMLWriter >> comment: aString [
	self comment with: aString
]

{ #category : #accessing }
XMLWriter >> contents [
	self flushMarkup.
	^ self stream contents.
]

{ #category : #private }
XMLWriter >> cr [
	(self omitsLineBreaks or: [self atStart])
		ifTrue: [^ self].

	self nextPutAll: self lineBreak.
	self isCanonical
		ifFalse: [self writeIndent].
]

{ #category : #private }
XMLWriter >> currentIndentLevel [
	^ currentIndentLevel ifNil: [currentIndentLevel := 0].
]

{ #category : #'writing markup' }
XMLWriter >> doctype [
	^ self addNewMarkupWriter: XMLDoctypeDeclarationWriter
]

{ #category : #'writing markup' }
XMLWriter >> elementDeclaration [
	^ self addNewMarkupWriter: XMLElementDeclarationWriter
]

{ #category : #accessing }
XMLWriter >> enablePrettyPrinting [
	self indentString: '    '.
	self omitsLineBreaks: false.
]

{ #category : #'writing markup' }
XMLWriter >> entityDeclaration [
	^ self addNewMarkupWriter: XMLEntityDeclarationWriter
]

{ #category : #'writing markup' }
XMLWriter >> entityRef: aName [
	self
		flushMarkup;
		nextPut: $&;
		writeName: aName;
		nextPut: $;
]

{ #category : #private }
XMLWriter >> eq [
	self nextPut: $=
]

{ #category : #private }
XMLWriter >> flushMarkup [
	self activeMarkupWriter
		ifNotNil: [self activeMarkupWriter flushMarkup].
]

{ #category : #private }
XMLWriter >> flushedMarkupWriter: aMarkupWriter [
	activeMarkupWriter := aMarkupWriter parent
]

{ #category : #testing }
XMLWriter >> hasTrailingWhitespace [
	| lastChar |

	^ (lastChar := self lastChar) notNil
		and: [lastChar isSeparator]
]

{ #category : #private }
XMLWriter >> indent [
	currentIndentLevel := self currentIndentLevel + 1
]

{ #category : #accessing }
XMLWriter >> indentString [
	^ indentString ifNil: [indentString := '']
]

{ #category : #accessing }
XMLWriter >> indentString: aString [
	currentIndentLevel := 0.
	indentString := aString.
]

{ #category : #testing }
XMLWriter >> isCanonical [
	^ isCanonical ifNil: [isCanonical := false]
]

{ #category : #accessing }
XMLWriter >> isCanonical: aBoolean [
	isCanonical := aBoolean
]

{ #category : #private }
XMLWriter >> lastChar [
	^ self stream peekLast
]

{ #category : #accessing }
XMLWriter >> lineBreak [
	^ lineBreak ifNil: [lineBreak := String cr]
]

{ #category : #accessing }
XMLWriter >> lineBreak: aLineBreak [
	lineBreak := aLineBreak asString
]

{ #category : #private }
XMLWriter >> nextPut: aCharacter [
	self stream nextPut: aCharacter
]

{ #category : #private }
XMLWriter >> nextPutAll: aString [
	self stream nextPutAll: aString
]

{ #category : #'writing markup' }
XMLWriter >> notationDeclaration [
	^ self addNewMarkupWriter: XMLNotationDeclarationWriter
]

{ #category : #testing }
XMLWriter >> omitsLineBreaks [
	^ omitsLineBreaks ifNil: [omitsLineBreaks := true]
]

{ #category : #accessing }
XMLWriter >> omitsLineBreaks: aBoolean [
	omitsLineBreaks := aBoolean
]

{ #category : #private }
XMLWriter >> outdent [
	currentIndentLevel := self currentIndentLevel - 1
]

{ #category : #'writing markup' }
XMLWriter >> paramEntityRef: aName [
	self
		flushMarkup;
		nextPut: $%;
		writeName: aName;
		nextPut: $;
]

{ #category : #'writing markup' }
XMLWriter >> pcdata: aString [
	self string: aString
]

{ #category : #'writing markup' }
XMLWriter >> pi [
	^ self addNewMarkupWriter: XMLPIWriter
]

{ #category : #printing }
XMLWriter >> printOn: aStream [
	self contents printOn: aStream.
]

{ #category : #private }
XMLWriter >> quote [
	self nextPut: $"
]

{ #category : #'writing markup' }
XMLWriter >> raw: aString [
	self
		flushMarkup;
		nextPutAll: aString
]

{ #category : #private }
XMLWriter >> space [
	(self isCanonical and: [self hasTrailingWhitespace])
		ifFalse: [self stream space]
]

{ #category : #accessing }
XMLWriter >> stream [
	^ stream
]

{ #category : #accessing }
XMLWriter >> stream: aStream [
	stream := aStream
]

{ #category : #'writing markup' }
XMLWriter >> string: aString [
	self
		flushMarkup;
		writeXmlEncoded: aString.
]

{ #category : #'writing markup' }
XMLWriter >> tag [
	^ self addNewMarkupWriter: XMLTagWriter
]

{ #category : #'writing markup' }
XMLWriter >> tag: aName [
	^ self tag name: aName
]

{ #category : #'writing markup' }
XMLWriter >> tag: aName attributes: aDictionaryOrArray content: aStringOrCollectionOrBlock [
	^ (self tag: aName)
		attributes: aDictionaryOrArray;
		content: aStringOrCollectionOrBlock
]

{ #category : #'writing markup' }
XMLWriter >> tag: aName content: aStringOrCollectionOrBlock [
	^ (self tag: aName) content: aStringOrCollectionOrBlock
]

{ #category : #'writing markup' }
XMLWriter >> write [
	self flushMarkup
]

{ #category : #private }
XMLWriter >> writeIndent [
	self currentIndentLevel timesRepeat: [self nextPutAll: self indentString]
]

{ #category : #private }
XMLWriter >> writeName: aString [
	self nextPutAll: aString
]

{ #category : #private }
XMLWriter >> writeName: aName value: aValue [
	self hasTrailingWhitespace
		ifFalse: [self space].

	self
		writeName: aName;
		eq;
		writeXmlEncodedString: aValue.
]

{ #category : #private }
XMLWriter >> writeXmlEncoded: aString [
	| lastIndex nextIndex |
	
	"Unroll the first search to avoid copying"
	lastIndex := 1.
	nextIndex := String
		findFirstInString: aString
		inSet: SpecialCharacters byteArrayMap
		startingAt: lastIndex.
	nextIndex isZero
		ifTrue: [^ self nextPutAll: aString].

	[nextIndex isZero]
		whileFalse: [| char |
			self
				nextPutAll: (aString copyFrom: lastIndex to: nextIndex - 1);
				nextPutAll:
					(((char := aString at: nextIndex) == LineFeed or: [char == CarriageReturn])
						ifTrue: [self lineBreak]
						ifFalse: [CharacterEscapes at: char]).
			lastIndex := nextIndex + 1.
			nextIndex := String
				findFirstInString: aString
				inSet: SpecialCharacters byteArrayMap
				startingAt: lastIndex].
	self nextPutAll: (aString copyFrom: lastIndex to: aString size).
]

{ #category : #private }
XMLWriter >> writeXmlEncodedString: aString [
	self
		quote;
		writeXmlEncoded: aString;
		quote
]

{ #category : #'writing markup' }
XMLWriter >> xml [
	^ self addNewMarkupWriter: XMLXmlDeclarationWriter
]
