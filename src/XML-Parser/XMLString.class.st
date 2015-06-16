"
This class represents string (character data) nodes. Instances are mutable and can be created using the class-side #string: message or by sending a String #asXMLString. When printing, they XML-escape special characters.
"
Class {
	#name : #XMLString,
	#superclass : #XMLNode,
	#instVars : [
		'string'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLString class >> string: aString [
	^ self new string: aString
]

{ #category : #private }
XMLString >> acceptsContent [
	^ true
]

{ #category : #adding }
XMLString >> addContent: aStringOrStringNode [
	string :=
		string
			ifNil: [aStringOrStringNode asString]
			ifNotNil: [string, aStringOrStringNode asString]
]

{ #category : #adding }
XMLString >> append: aStringOrStringNode [
	self addContent: aStringOrStringNode
]

{ #category : #converting }
XMLString >> asString [
	^ self string
]

{ #category : #converting }
XMLString >> asXMLEscapedString [
	^ self string asXMLEscapedString
]

{ #category : #converting }
XMLString >> asXMLString [
	^ self
]

{ #category : #testing }
XMLString >> beginsWith: aStringOrStringNode [
	^ self string beginsWith: aStringOrStringNode asString
]

{ #category : #accessing }
XMLString >> contentString: aString [
	self string: aString
]

{ #category : #replacing }
XMLString >> deleteFrom: aStart to: anEnd [
	self replaceFrom: aStart to: anEnd with: ''
]

{ #category : #testing }
XMLString >> endsWith: aStringOrStringNode [
	^ self string endsWith: aStringOrStringNode asString
]

{ #category : #testing }
XMLString >> includesSubstring: aStringOrStringNode [
	^ (self indexOfSubstring: aStringOrStringNode) > 0
]

{ #category : #accessing }
XMLString >> indexOfSubstring: aStringOrStringNode [
	^ self string
		findString: aStringOrStringNode asString
		startingAt: 1
]

{ #category : #testing }
XMLString >> isContentNode [
	^ true
]

{ #category : #testing }
XMLString >> isEmpty [
	^ self string isEmpty
]

{ #category : #testing }
XMLString >> isString: aStringOrStringNode [
	^ self string = aStringOrStringNode asString
]

{ #category : #testing }
XMLString >> isStringNode [
	^ true
]

{ #category : #testing }
XMLString >> isStringNode: aStringOrStringNode [
	^ self isString: aStringOrStringNode
]

{ #category : #testing }
XMLString >> isWhitespace [
	^ self isEmpty not
		and: [self string allSatisfy: [:each | each xmlParserIsWhitespace]]
]

{ #category : #'splitting/merging' }
XMLString >> mergeAdjacent [
	"merges a string node with adjacent string nodes in parent"
	| siblingNodes selfIndex adjacentNode |

	self hasParent
		ifFalse: [^ self].

	siblingNodes := self parent nodes.
	selfIndex := siblingNodes indexOf: self.
	[(adjacentNode := siblingNodes at: selfIndex + 1) notNil
		and: [adjacentNode isStringNode]]
		whileTrue: [
			self append: adjacentNode.
			siblingNodes removeAt: selfIndex + 1].

	[(adjacentNode := siblingNodes at: selfIndex - 1) notNil
		and: [adjacentNode isStringNode]]
		whileTrue: [
			self prepend: adjacentNode.
			siblingNodes removeAt: selfIndex - 1.
			selfIndex := selfIndex - 1].
]

{ #category : #adding }
XMLString >> prepend: aStringOrStringNode [
	self string: aStringOrStringNode asString, self string
]

{ #category : #printing }
XMLString >> printRawContentOn: aStream [
	aStream nextPutAll: self string
]

{ #category : #replacing }
XMLString >> replaceAll: aSource with: aReplacement [
	"works like copyReplaceAll:with:"
	self string:
		(self string
			copyReplaceAll: aSource asString
			with: aReplacement asString)
]

{ #category : #replacing }
XMLString >> replaceFrom: aStart to: aStop with: aReplacement [
	"works like copyReplaceFrom:to:with: and
	can be used to insert, delete, and replace"
	| start stop |

	start := (aStart max: 1) min: self size + 1.
	stop := (aStop max: start - 1) min: self size.
	self string:
		(self string
			copyReplaceFrom: start
			to: stop
			with: aReplacement asString)
]

{ #category : #accessing }
XMLString >> size [
	^ self string size
]

{ #category : #private }
XMLString >> sortKey [
	^ self string
]

{ #category : #'splitting/merging' }
XMLString >> splitAt: anOffset [
	| newNode |

	newNode := self copy.
	self replaceFrom: anOffset to: self size with: ''.
	newNode replaceFrom: 1 to: anOffset - 1 with: ''.

	self hasParent
		ifTrue: [self parent addNode: newNode after: self].

	^ newNode.
]

{ #category : #accessing }
XMLString >> string [
	^ string ifNil: [string := '']
]

{ #category : #accessing }
XMLString >> string: aString [
	string := aString asString
]

{ #category : #validating }
XMLString >> validateWith: aValidator [
	aValidator validatePCData: self string
]

{ #category : #printing }
XMLString >> writeXMLOn: aWriter [
	aWriter string: self string
]
