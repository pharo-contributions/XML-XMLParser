Extension { #name : #String }

{ #category : #'*XML-Parser' }
String >> asXMLEscapedString [
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

{ #category : #'*XML-Parser' }
String >> asXMLFileHandle [
	^ XMLFileHandle path: self
]

{ #category : #'*XML-Parser' }
String >> asXMLHTTPRequest [
	^ XMLHTTPRequest url: self
]

{ #category : #'*XML-Parser' }
String >> asXMLStreamConverter [
	^ XMLStreamConverter newForEncoding: self
]

{ #category : #'*XML-Parser' }
String >> asXMLString [
	^ XMLString string: self
]

{ #category : #'*XML-Parser' }
String >> asXMLURI [
	^ XMLURI fromString: self
]

{ #category : #'*XML-Parser' }
String >> expandWithNamespaceURI: aURI [
	aURI size > 0
		ifTrue: [^ 'Q{', aURI, '}', self]
		ifFalse: [^ self]
]

{ #category : #'*XML-Parser' }
String >> hasPrefixBeforeLocalName [
	^ (self
		indexOf: $:
		startingAt: 2) > 0
]

{ #category : #'*XML-Parser' }
String >> isQualifiedName: aQualifiedName orLocalName: aLocalName [
	"optimized"
	^ self = aQualifiedName
		or: [(aQualifiedName size > aLocalName size)
			and: [self = aLocalName]]
]

{ #category : #'*XML-Parser' }
String >> isXMLNSAttributeName [
	^ (self beginsWith: 'xmlns')
		and: [self size = 5 "'xmlns' size"
			or: [(self at: 6) == $:]]
]

{ #category : #'*XML-Parser' }
String >> isXMLReservedAttributeName [
	^ self size > 4
		and: [self beginsWith: 'xml:']
]

{ #category : #'*XML-Parser' }
String >> localNameAfterPrefix [
	^ self localNameAfterPrefix: self prefixBeforeLocalName
]

{ #category : #'*XML-Parser' }
String >> localNameAfterPrefix: aPrefix [
	"optimized"
	| prefixSize |

	(prefixSize := aPrefix size) > 0
		ifTrue: [^ self copyFrom: prefixSize + 2 to: self size]
		ifFalse: [^ self]
]

{ #category : #'*XML-Parser' }
String >> parseXML [
	^ XMLDOMParser parse: self
]

{ #category : #'*XML-Parser' }
String >> prefixBeforeLocalName [
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

{ #category : #'*XML-Parser' }
String >> prefixBeforeLocalName: aLocalName [
	"optimized"
	| prefixSize |

	(prefixSize := self size - aLocalName size - 1) > 0
		ifTrue: [^ self copyFrom: 1 to: prefixSize]
		ifFalse: [^ '']
]

{ #category : #'*XML-Parser' }
String >> qualifyWithPrefix: aPrefix [
	"optimized"
	aPrefix size > 0
		ifTrue: [^ (aPrefix copyWith: $:), self]
		ifFalse: [^ self]
]
