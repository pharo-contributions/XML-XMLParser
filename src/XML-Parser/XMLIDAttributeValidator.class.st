Class {
	#name : #XMLIDAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'ids'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLIDAttributeValidator >> ids [
	^ ids ifNil: [ids := Set new]
	
]

{ #category : #validation }
XMLIDAttributeValidator >> validateAttributes: anAttributeDictionary [
	| id |

	id := anAttributeDictionary at: name ifAbsent: [^ self].
	self validateID: id.
	(self ids includes: id)
		ifTrue: [XMLValidationException signal: 'ID ', id, ' used more than once for <', element. '>'].
	self ids add: id.
]
