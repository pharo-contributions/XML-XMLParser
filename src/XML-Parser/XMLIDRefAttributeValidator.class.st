Class {
	#name : #XMLIDRefAttributeValidator,
	#superclass : #XMLAttributeValidator,
	#instVars : [
		'idrefs'
	],
	#category : #'XML-Parser-Validation'
}

{ #category : #accessing }
XMLIDRefAttributeValidator >> idrefs [
	^ idrefs ifNil: [idrefs := Set new].
]

{ #category : #validation }
XMLIDRefAttributeValidator >> validateAttributes: anAttributeDictionary [
	| idref |

	idref := anAttributeDictionary at: name ifAbsent: [^ self].
	self validateID: idref.
	self idrefs add: idref.
]
