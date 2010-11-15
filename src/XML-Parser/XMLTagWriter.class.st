"
This class generates XML tags for elements. You can specifiy the attributes of the start tag using the #attribute* messages, and you can add xmlns: namespace declarations using the #xmlns* messages. If you do not send #content:, or if you do but the argument is nil or a block that generates no markup, then only a single, empty tag in the form of ""<empty />"" will be generated, unless the writer object that created the tag writer object is configured to generate canonical XML, in which case an empty start/end tag pair like ""<empty></empty>"" will be generated.

You can supply child markup content using #content: or the generic #with: message. Namespace declarations will be ignored if a parent element has equivalent declarations (and they were thus already generated).
"
Class {
	#name : #XMLTagWriter,
	#superclass : #XMLEmbeddedMarkupWriter,
	#instVars : [
		'name',
		'defaultNamespace',
		'prefixMappings',
		'attributes'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #accessing }
XMLTagWriter >> attributeAt: aName [
	^ self attributeAt: aName ifAbsent: ['']
]

{ #category : #accessing }
XMLTagWriter >> attributeAt: aName ifAbsent: aBlock [
	^ self attributes at: aName ifAbsent: aBlock
]

{ #category : #accessing }
XMLTagWriter >> attributeAt: aName ifAbsentPut: aBlock [
	^ self attributes at: aName ifAbsentPut: aBlock
]

{ #category : #accessing }
XMLTagWriter >> attributeAt: aName put: aValue [
	^ self attributes at: aName put: aValue
]

{ #category : #accessing }
XMLTagWriter >> attributes [
	^ attributes ifNil: [attributes := XMLOrderPreservingDictionary new]
]

{ #category : #accessing }
XMLTagWriter >> attributes: aDictionaryOrArray [
	aDictionaryOrArray associationsDo: [:each | self attributes add: each]
]

{ #category : #'embedding markup' }
XMLTagWriter >> content: aStringOrBlockOrCollection [
	self deprecated: 'use #with: instead'.

	^ self with: aStringOrBlockOrCollection.
]

{ #category : #private }
XMLTagWriter >> embedString: aString [
	self writer string: aString
]

{ #category : #private }
XMLTagWriter >> hasWrittenXmlns: aDefaultNamespace [
	^ self parent notNil
		and: [self parent isTagWriter
			and: [self parent xmlns = aDefaultNamespace]]
]

{ #category : #private }
XMLTagWriter >> hasWrittenXmlns: aPrefix uri: aUri [
	^ self parent notNil
		and: [self parent isTagWriter
			and: [(self parent xmlnsAt: aPrefix ifAbsent: [^ false]) = aUri]]
]

{ #category : #testing }
XMLTagWriter >> isTagWriter [
	^ true
]

{ #category : #accessing }
XMLTagWriter >> name [
	^ name ifNil: ['']
]

{ #category : #accessing }
XMLTagWriter >> name: aName [
	name := aName
]

{ #category : #accessing }
XMLTagWriter >> prefixMappings [
	^ prefixMappings ifNil: [prefixMappings := XMLOrderPreservingDictionary new]
]

{ #category : #private }
XMLTagWriter >> writeAttributes [
	attributes ifNotNil: [
		self
			writeKeysAndValuesFrom: self attributes
			with: [:attrName :attrValue |
				self writer
					writeName: attrName value: attrValue]]
]

{ #category : #private }
XMLTagWriter >> writeBeforeEmbeddedMarkup [
	self writer
		nextPut: $>;
		indent
]

{ #category : #private }
XMLTagWriter >> writeEndTag [
	self writer
		nextPutAll: '</';
		writeName: self name;
		nextPut: $>
]

{ #category : #private }
XMLTagWriter >> writeEpilogue [
	self hasEmbeddedMarkup
		ifTrue: [
			self writer outdent.
			self hasEmbeddedMarkupWriters
				ifTrue: [self writer cr].
			self writeEndTag]
		ifFalse: [
			self writer isCanonical
				ifTrue: [
					self writer nextPut: $>.
					self writeEndTag]
				ifFalse: [
					self writer
						space;
						nextPutAll: '/>']].
]

{ #category : #private }
XMLTagWriter >> writeKeysAndValuesFrom: aDictionary with: aTwoArgumentBlock [
	self writer isCanonical
		ifTrue: [
			aDictionary keys asSortedCollection do: [:each |
				aTwoArgumentBlock value: each value: (aDictionary at: each)]]
		ifFalse: [aDictionary keysAndValuesDo: aTwoArgumentBlock]
]

{ #category : #private }
XMLTagWriter >> writePrologue [
	self writer
		cr;
		nextPut: $<;
		writeName: (self name ifNil: ['']).
	self
		writeXmlnsDeclarations;
		writeAttributes.
]

{ #category : #private }
XMLTagWriter >> writeXmlnsDeclarations [
	self xmlns
		ifNotEmpty: [
			(self hasWrittenXmlns: self xmlns)
				ifFalse: [self writer writeName: 'xmlns' value: self xmlns]].

	self prefixMappings
		ifNotEmpty: [
			self
				writeKeysAndValuesFrom: self prefixMappings
				with: [:prefix :uri |
					(self hasWrittenXmlns: prefix uri: uri)
						ifFalse: [self writer writeName: 'xmlns:', prefix value: uri]]].
]

{ #category : #accessing }
XMLTagWriter >> xmlns [
	^ defaultNamespace ifNil: ['']
]

{ #category : #accessing }
XMLTagWriter >> xmlns: aUri [
	defaultNamespace := aUri
]

{ #category : #accessing }
XMLTagWriter >> xmlnsAt: aPrefix [
	^ self prefixMappings at: aPrefix ifAbsent: ['']
]

{ #category : #accessing }
XMLTagWriter >> xmlnsAt: aPrefix ifAbsent: aBlock [
	^ self prefixMappings at: aPrefix ifAbsent: aBlock
]

{ #category : #accessing }
XMLTagWriter >> xmlnsAt: aPrefix ifAbsentPut: aUri [
	^ self prefixMappings at: aPrefix ifAbsentPut: aUri
]

{ #category : #accessing }
XMLTagWriter >> xmlnsAt: aPrefix put: aValue [
	^ self prefixMappings at: aPrefix put: aValue
]

{ #category : #accessing }
XMLTagWriter >> xmlnsDeclarations: aDictionaryOrArray [
	aDictionaryOrArray associationsDo: [:each |
		(each key isEmptyOrNil or: [each key = 'xmlns'])
			ifTrue: [self xmlns: each value]
			ifFalse: [self xmlnsAt: each key put: each value]]
]
