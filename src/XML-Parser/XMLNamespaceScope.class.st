Class {
	#name : #XMLNamespaceScope,
	#superclass : #Object,
	#instVars : [
		'scope',
		'currentBindings',
		'useNamespaces',
		'validateAttributes'
	],
	#category : #'XML-Parser'
}

{ #category : #private }
XMLNamespaceScope >> currentScope [
	^self scope last
]

{ #category : #scope }
XMLNamespaceScope >> declareNamespace: ns uri: uri [
	"Declare the given name space prefix with the given URL"

	ns = 'xmlns'
		ifTrue: [^self defaultNamespace: uri].
	self establishLocalBindings.
	currentBindings removeKey: ns ifAbsent: [].
	currentBindings at: ns put: uri
]

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace [
	^self currentScope first
]

{ #category : #accessing }
XMLNamespaceScope >> defaultNamespace: ns [
	"Declare the default namespace."
	self currentScope at: 1 put: ns
]

{ #category : #scope }
XMLNamespaceScope >> enterScope [
	self scope addLast: { self defaultNamespace. nil. currentBindings. }
]

{ #category : #private }
XMLNamespaceScope >> establishLocalBindings [
	(self currentScope at: 2)
		ifNil: [
			currentBindings := currentBindings copy.
			self currentScope at: 2 put: currentBindings]
]

{ #category : #private }
XMLNamespaceScope >> initScope [
	scope := OrderedCollection new: 20.
	currentBindings := Dictionary new.
	scope addLast: {'http://www.w3.org/TR/REC-xml-names'. currentBindings. nil. }.

]

{ #category : #scope }
XMLNamespaceScope >> leaveScope [
	| leftScope |
	leftScope := self scope removeLast.
	currentBindings := (self currentScope at: 2) ifNil: [leftScope at: 3]
]

{ #category : #private }
XMLNamespaceScope >> namespaceAliases: namespace [
	"Locate all namespaces that are aliases of the given URI."

	| aliases uri |
	aliases _ Set new.
	uri _ self namespaceURIOf: namespace ifAbsent: [self parseError: 'Attribute refers to undefined namespace ' , namespace asString ].
	currentBindings keysAndValuesDo: [:ns :u |
		(u = uri
			and: [ns ~= namespace])
			ifTrue: [aliases add: ns]].
	^ aliases
]

{ #category : #accessing }
XMLNamespaceScope >> namespaceURIOf: ns [
	"Retrieve the URI of the given namespace prefix, if it is defined. A nil namespace
	returns the global namespace"

	^ self namespaceURIOf: ns ifAbsent: [ nil ]
]

{ #category : #accessing }
XMLNamespaceScope >> namespaceURIOf: ns ifAbsent: aBlock [
	"Retrieve the URI of the given namespace prefix, if it is defined. 
	A nil namespace returns the default namespace. 
	If no namespace can be found the value of the block is returned"

	^ns
		ifNil: [self defaultNamespace]
		ifNotNil: [currentBindings at: ns ifAbsent: aBlock]
]

{ #category : #accessing }
XMLNamespaceScope >> namespaces [
	^currentBindings
]

{ #category : #private }
XMLNamespaceScope >> scope [
	scope ifNil: [self initScope].
	^scope
]

{ #category : #validation }
XMLNamespaceScope >> validateAttributes: attributeList [
	"check all attribute namespaces are defined and not duplicated by aliasing"
	| namespace localName |
	attributeList keysDo: [:attrName |
		self splitName: attrName into: [:ns :ln |
			namespace _ ns.
			localName _ ln].
		namespace ifNotNil: [
			(self namespaceAliases: namespace) do: [:alias |
				(attributeList includesKey: alias , ':' , localName)
					ifTrue: [self parseError: 'Attributes ' , attrName , ' and ' , alias , ':' , localName , ' are aliased to namespace ' , (self namespaceURIOf: namespace) ]]]]
]
