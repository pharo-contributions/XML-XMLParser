"
This class is shared by attribute validators to validate element IDs and ID references, including xml:id IDs.
"
Class {
	#name : #XMLElementIDValidator,
	#superclass : #Object,
	#instVars : [
		'elementsAndIdAttributes',
		'idReferences',
		'ids'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLElementIDValidator >> elementsAndIDAttributes [
	^ elementsAndIdAttributes ifNil: [elementsAndIdAttributes := Dictionary new]
]

{ #category : #private }
XMLElementIDValidator >> errorDuplicateID: anId inAttribute: anAttribute [
	XMLValidationException
		formatSignal: 'Duplicate element ID "{1}" used in attribute "{2}"'
		with: anId
		with: anAttribute
]

{ #category : #private }
XMLElementIDValidator >> errorInvalidID: anId inAttribute: anAttribute [
	XMLValidationException
		formatSignal: 'Invalid element ID value "{1}" in attribute "{2}"'
		with: anId
		with: anAttribute
]

{ #category : #private }
XMLElementIDValidator >> errorMultipleIDAttributesForElement: anElement [
	XMLValidationException
		formatSignal: 'Element <{1}> has multiple ID attributes'
		with: anElement
]

{ #category : #private }
XMLElementIDValidator >> errorUnknownIDReference: anId [
	XMLValidationException
		formatSignal: 'Reference to unknown element ID "{1}"'
		with: anId
]

{ #category : #accessing }
XMLElementIDValidator >> idReferences [
	^ idReferences ifNil: [idReferences := Set new]
]

{ #category : #accessing }
XMLElementIDValidator >> ids [
	^ ids ifNil: [ids := Set new]
]

{ #category : #validating }
XMLElementIDValidator >> validateID: anId inAttribute: anAttribute [
	(XMLWellFormedParserTokenizer isName: anId)
		ifFalse: [
			self
				errorInvalidID: anId
				inAttribute: anAttribute].
	self
		validateUniquenessOfID: anId
		inAttribute: anAttribute.
]

{ #category : #validating }
XMLElementIDValidator >> validateIDAttribute: anAttribute forElement: anElement [
	| oldSize |

	"checking size after is faster than includes test"
	oldSize := self elementsAndIDAttributes size.
	(self elementsAndIDAttributes
		at: anElement
		put: anAttribute;
		size) > oldSize
		ifFalse: [self errorMultipleIDAttributesForElement: anElement].
]

{ #category : #validating }
XMLElementIDValidator >> validateIDReference: anId inAttribute: anAttribute [
	(XMLWellFormedParserTokenizer isName: anId)
		ifFalse: [
			self
				errorInvalidID: anId
				inAttribute: anAttribute].
	self idReferences add: anId.
]

{ #category : #validating }
XMLElementIDValidator >> validateIDReferences [
	self idReferences do: [:each |
		(self ids includes: each)
			ifFalse: [self errorUnknownIDReference: each]]
]

{ #category : #private }
XMLElementIDValidator >> validateUniquenessOfID: anId inAttribute: anAttribute [
	| oldSize |

	"checking size after is faster than includes test"
	oldSize := self ids size.
	(self ids
		add: anId;
		size) > oldSize
		ifFalse: [
			self
				errorDuplicateID: anId
				inAttribute: anAttribute].
]

{ #category : #validating }
XMLElementIDValidator >> validateXMLID: anId [
	(XMLWellFormedParserTokenizer isNCName: anId)
		ifFalse: [
			self
				errorInvalidID: anId
				inAttribute: 'xml:id'].
	self
		validateUniquenessOfID: anId
		inAttribute: 'xml:id'.
]
