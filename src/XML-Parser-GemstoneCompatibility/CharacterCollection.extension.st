Extension { #name : #CharacterCollection }

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> asXMLEscapedString [
	"returns a copy of self with &, <, and > escaped with &amp;, &lt;, and &gt;"
	| stream |

	stream := (self class new: self size) writeStream.
	"to:do: for performance"
	1 to: self size do: [:i | | nextChar |
		(nextChar := self at: i) == $<
			ifTrue: [stream nextPutAll: '&lt;']
			ifFalse: [
				nextChar == $> "needed to escape ]]> in PCDATA"
					ifTrue: [stream nextPutAll: '&gt;']
					ifFalse: [
						nextChar == $&
							ifTrue: [stream nextPutAll: '&amp;']
							ifFalse: [stream nextPut: nextChar]]]].
	^ stream contents.
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> asXMLFileHandle [
	^ XMLFileHandle path: self
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> asXMLHTTPRequest [
	^ XMLHTTPRequest url: self
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> asXMLStreamConverter [
	^ XMLStreamConverter newForEncoding: self
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
CharacterCollection >> expandWithNamespaceURI: aURI [
	aURI size > 0
		ifTrue: [^ 'Q{', aURI, '}', self]
		ifFalse: [^ self]
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> hasPrefixBeforeLocalName [
	^ (self
		indexOf: $:
		startingAt: 2) > 0
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> isQualifiedName: aQualifiedName orLocalName: aLocalName [
	"optimized"
	^ self = aQualifiedName
		or: [(aQualifiedName size > aLocalName size)
			and: [self = aLocalName]]
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> isXMLNSAttributeName [
	^ (self beginsWith: 'xmlns')
		and: [self size = 5 "'xmlns' size"
			or: [(self at: 6) == $:]]
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> isXMLReservedAttributeName [
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
	"optimized"
	| prefixSize |

	(prefixSize := self size - aLocalName size - 1) > 0
		ifTrue: [^ self copyFrom: 1 to: prefixSize]
		ifFalse: [^ '']
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
CharacterCollection >> qualifyWithPrefix: aPrefix [
	"optimized"
	aPrefix size > 0
		ifTrue: [^ (aPrefix copyWith: $:), self]
		ifFalse: [^ self]
]
