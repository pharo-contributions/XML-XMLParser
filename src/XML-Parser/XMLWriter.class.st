"
This class allows you to generate well-formed XML documents using an API similar to Seaside's canvas and tag brush API.

Markup can be created by sending an instance any of the messages under ""writing markup."" The messages that take no arguments return an instance of an XMLMarkupWriter subclass. These objects can be configured with messages like #name: and #attributeAt:put:. Sending them #write or a specific writing message that accepts markup to embed within (the generic #with: message) causes the markup writer's configuration to be committed and its markup to be written to the output stream. For markup writers that can have embedded markup, the argument to the writing message can be a string, collection (of strings and blocks), a block, or nil. The block passed in can optionally take an argument, which will be the XMLWriter object that created the markup writer object. Within the block you can generate additional, child markup that will be contained by the parent. Creating additional non-embedded markup will cause any unwritten markup from a previous markup writer to be written, as will sending an XMLWriter or XMLMarkupWriter #contents, #printOn:, or the aforementioned #write.

Here is an example that you can highlight and evaluate with cmd-p to see the result:

	| writer |
	writer := XMLWriter new.
	writer
		enablePrettyPrinting;
		xml;
		comment: 'an example'.
	writer tag
		name: 'example:user';
		xmlnsAt: 'example' put: 'urn://example';
		with: [
			writer
				tag: 'username' with: 'jsmith';
				tag: 'real-name' with: 'John Smith';
				tag: 'age' with: '25';
				tag: 'id' with: '101']

Since the last message sent (#tag:with:) is an explicit serialization message, #write does not need to be sent. However, if you don't end with a serialization message, you must end with #write:

	| writer |
	writer := XMLWriter new.
	writer tag
		name: 'emptyTag';
		attributeAt: 'a' put: 'one';
		write.

Sending #write to the XMLWriter or markup writer object has the same effect. A simple way to avoid having to remember to send #write is to generate all markup within a top-level #writeWith: block, which will do it for you automatically:

	XMLWriter new
		writeWith: [:writer |
			writer tag
				name: 'emptyTag';
				attributeAt: 'a' put: 'value'].
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
	self write.
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
	self write.
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
		write;
		nextPut: $&;
		writeName: aName;
		nextPut: $;
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
XMLWriter >> lineBreak: aLineBreakCharOrString [
	lineBreak := aLineBreakCharOrString asString
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
		write;
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
	aStream nextPutAll: self contents.
]

{ #category : #'writing markup' }
XMLWriter >> raw: aString [
	self
		write;
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
		write;
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
XMLWriter >> tag: aName attributes: aDictionaryOrArray with: aStringOrCollectionOrBlock [
	^ (self tag: aName)
		attributes: aDictionaryOrArray;
		with: aStringOrCollectionOrBlock
]

{ #category : #'writing markup' }
XMLWriter >> tag: aName content: aStringOrCollectionOrBlock [
	self deprecated: 'use #tag:with: instead'.

	^ (self tag: aName) with: aStringOrCollectionOrBlock.
]

{ #category : #'writing markup' }
XMLWriter >> tag: aName with: aStringOrCollectionOrBlock [
	^ (self tag: aName) with: aStringOrCollectionOrBlock
]

{ #category : #'writing markup' }
XMLWriter >> write [
	self activeMarkupWriter
		ifNotNil: [self activeMarkupWriter write].
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
	(self atStart or: [self hasTrailingWhitespace])
		ifFalse: [self stream space].

	self
		writeName: aName;
		nextPut: $=;
		writeXmlEncodedString: aValue.
]

{ #category : #'writing markup' }
XMLWriter >> writeWith: aBlock [
	aBlock valueWithPossibleArgument: self.
	self write.
]

{ #category : #private }
XMLWriter >> writeXmlEncoded: aString [
	| lastIndex nextIndex |
	
	"Unroll the first search"
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
		nextPut: $";
		writeXmlEncoded: aString;
		nextPut: $"
]

{ #category : #private }
XMLWriter >> writtenMarkupWriter: aMarkupWriter [
	activeMarkupWriter := aMarkupWriter parent
]

{ #category : #'writing markup' }
XMLWriter >> xml [
	^ self addNewMarkupWriter: XMLXmlDeclarationWriter
]
