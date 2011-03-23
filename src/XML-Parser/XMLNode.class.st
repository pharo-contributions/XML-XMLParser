"
This is a base class for XML nodes. It contains testing messages and methods to set and access the parent node and sibling nodes. It also provides a number messages to control printing.
"
Class {
	#name : #XMLNode,
	#superclass : #Object,
	#instVars : [
		'parent',
		'notifier'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #utility }
XMLNode class >> notifications [
	| notifications parser parsedMethods |
	notifications := WriteStream on: (Array new: 10).
	parser := Parser new.
	parsedMethods := IdentityDictionary new.
	(self allMethodsInCategory: #notification)
		do: [ :notifierSelector | 
			| methodNode |
			(SystemNavigation default allSendersOf: notifierSelector inClass: self)
				do: [ :methodReference | 
					methodNode := parsedMethods
						at: methodReference selector
						ifAbsentPut: (parser parse: methodReference sourceCode class: self).
					methodNode
						nodesDo: [ :node | 
							| firstArgument |
							(node isMessage
								and: [ node selector key asSymbol = notifierSelector and: [ (firstArgument := node arguments first) isLiteral ] ])
								ifTrue: [ notifications nextPut: firstArgument key asSymbol ] ] ] ].
	^ notifications contents
]

{ #category : #accessing }
XMLNode >> addContent: aStringOrStringNode [
	XMLDOMException signal: 'Node cannot contain content'
]

{ #category : #observing }
XMLNode >> addObserver: anObserver [
	self notifier addObserver: anObserver
]

{ #category : #enumerating }
XMLNode >> allNodesDo: aBlock [
	aBlock value: self
]

{ #category : #printing }
XMLNode >> canonicallyPrintOn: aStream [
	(XMLWriter on: aStream)
		isCanonical: true;
		writeWith: [:writer | self writeXMLOn: writer]
]

{ #category : #printing }
XMLNode >> canonicallyPrinted [
	^ String streamContents: [:stream | self printCanonicalOn: stream]
]

{ #category : #accessing }
XMLNode >> characterData [
	self deprecated: 'use #contentString instead'.

	^ self contentString.
]

{ #category : #accessing }
XMLNode >> contentString [
 	"This returns the combined content string of all descendants with spaces inserted wher necessary."
	^ String streamContents: [:stream | self printContentOn: stream]
]

{ #category : #testing }
XMLNode >> hasChildren [
	^ false
]

{ #category : #testing }
XMLNode >> hasParent [
	^ self parent notNil
]

{ #category : #testing }
XMLNode >> isCData [
	^ false
]

{ #category : #testing }
XMLNode >> isComment [
	^ false
]

{ #category : #testing }
XMLNode >> isContentNode [
	^ false
]

{ #category : #testing }
XMLNode >> isDocument [
	^ false
]

{ #category : #testing }
XMLNode >> isElement [
	^ false
]

{ #category : #testing }
XMLNode >> isEmpty [
	self deprecated: 'use "hasChildren not" instead'.

	^ self hasChildren not
]

{ #category : #testing }
XMLNode >> isPI [
	^ false
]

{ #category : #testing }
XMLNode >> isProcessingInstruction [
	self deprecated: 'use #isPI instead'.

	^ self isPI.
]

{ #category : #testing }
XMLNode >> isStringNode [
	^ false
]

{ #category : #testing }
XMLNode >> isTag [
	self deprecated: 'use #isElement instead'.

	^ self isElement.
]

{ #category : #testing }
XMLNode >> isTagOrText [
	self deprecated: 'use #isContentNode instead'.

	^ self isContentNode.
]

{ #category : #testing }
XMLNode >> isText [
	self deprecated: 'use #isStringNode instead'.

	^ self isStringNode.
]

{ #category : #accessing }
XMLNode >> nextNode [
	^ self parent ifNotNil: [self parent nodeAfter: self]
]

{ #category : #testing }
XMLNode >> notEmpty [
	self deprecated: 'use #hasChildren instead'.

	^ self hasChildren.
]

{ #category : #accessing }
XMLNode >> notifier [
	^ notifier ifNil: [notifier := XMLNotifier new]
]

{ #category : #notification }
XMLNode >> notifyOf: aSelector with: anArgument [
	self notifier notifyOf: aSelector with: anArgument
]

{ #category : #notification }
XMLNode >> notifyOf: aSelector with: aFirstArgument with: aSecondArgument [
	self notifier notifyOf: aSelector with: aFirstArgument with: aSecondArgument
]

{ #category : #notification }
XMLNode >> notifyOf: aSelector with: aFirstArgument with: aSecondArgument with: aThirdArgument [
	self notifier
		notifyOf: aSelector
		with: aFirstArgument
		with: aSecondArgument
		with: aThirdArgument
]

{ #category : #notification }
XMLNode >> notifyOf: aSelector withArguments: anArray [
	self notifier notifyOf: aSelector withArguments: anArray
]

{ #category : #accessing }
XMLNode >> parent [
	^ parent
]

{ #category : #accessing }
XMLNode >> parent: aParentNode [
	parent := aParentNode
]

{ #category : #printing }
XMLNode >> prettyPrintOn: aStream [
	(XMLWriter on: aStream)
		enablePrettyPrinting;
		writeWith: [:writer | self writeXMLOn: writer]
]

{ #category : #printing }
XMLNode >> prettyPrinted [
	^ String streamContents: [:stream | self prettyPrintOn: stream]
]

{ #category : #accessing }
XMLNode >> previousNode [
	^ self parent ifNotNil: [self parent nodeBefore: self]
]

{ #category : #printing }
XMLNode >> printCanonicalOn: aStream [
	self deprecated: 'use #canonicallyPrintOn: instead'.

	self canonicallyPrintOn: aStream.
]

{ #category : #printing }
XMLNode >> printContentOn: aStream [
]

{ #category : #printing }
XMLNode >> printOn: aStream [
	(XMLWriter on: aStream) writeWith: [:writer | self writeXMLOn: writer].
]

{ #category : #printing }
XMLNode >> printXMLOn: aWriter [
	self deprecated: 'use #writeXMLWith: instead'.

	self writeXMLOn: aWriter.
]

{ #category : #observing }
XMLNode >> removeObserver: anObserver [
	self notifier removeObserver: anObserver
]

{ #category : #printing }
XMLNode >> writeXMLOn: aWriter [
	self subclassResponsibility
]
