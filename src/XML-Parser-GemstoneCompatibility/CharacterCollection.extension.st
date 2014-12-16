Extension { #name : #CharacterCollection }

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> asXMLEscapedString [
	| stream |

	stream := (self class new: self size) writeStream.
	self do: [:each |
		each == $<
			ifTrue: [stream nextPutAll: '&lt;']
			ifFalse: [
				each == $> "needed to escape ]]> in PCDATA"
					ifTrue: [stream nextPutAll: '&gt;']
					ifFalse: [
						each == $&
							ifTrue: [stream nextPutAll: '&amp;']
							ifFalse: [stream nextPut: each]]]].
	^ stream contents.
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> asXMLString [
	^ XMLString string: self
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> asXMLURI [
	^ XMLURI fromString: self
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> expandWithNamespaceURI: aNamespaceUri [
	^ aNamespaceUri
		ifEmpty: [self]
		ifNotEmpty: [((aNamespaceUri copyWithFirst: ${) copyWith: $}), self]
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> hasPrefixBeforeLocalName [
	^ (self
		indexOf: $:
		startingAt: 2) > 0
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> isNamespaceAttributeName [
	^ (self beginsWith: 'xmlns')
		and: [self size = 5
			or: [(self at: 6) == $:]]
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> isQualifiedName: aQualifiedName orLocalName: aLocalName [
	^ self = aQualifiedName
		or: [(aQualifiedName size > aLocalName size)
			and: [self = aLocalName]]
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> isReservedAttributeName [
	^ self size > 4
		and: [self beginsWith: 'xml:']
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> localNameAfterPrefix [
	^ self localNameAfterPrefix: self prefixBeforeLocalName
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> localNameAfterPrefix: aPrefix [
	"optimized"
	| prefixSize |

	(prefixSize := aPrefix size) > 0
		ifTrue: [^ self copyFrom: prefixSize + 2 to: self size]
		ifFalse: [^ self]
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> parseXML [
	^ XMLDOMParser parse: self
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> prefixBeforeLocalName [
	"Split the name into namespace prefix
	(Optimized code)"
	| i |

	i := self size.
	[i > 1]
		whileTrue: [
			((self at: i) == $:)
				ifTrue: [^ (self copyFrom: 1 to: i - 1)].
			i := i - 1].
	^ ''.
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> prefixBeforeLocalName: aLocalName [
	| prefixSize |

	(prefixSize := self size - aLocalName size - 1) > 0
		ifTrue: [^ self copyFrom: 1 to: prefixSize]
		ifFalse: [^ '']
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> qualifyWithPrefix: aPrefix [
	aPrefix size > 0
		ifTrue: [^ (aPrefix copyWith: $:), self]
		ifFalse: [^ self]
]
