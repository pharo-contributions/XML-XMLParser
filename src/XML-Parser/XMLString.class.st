"
XMLString nodes can be created directly using the class-side #string: message or by sending a string #asXMLNode. When printing, they XML-escape their content.
"
Class {
	#name : #XMLString,
	#superclass : #XMLNode,
	#instVars : [
		'string'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLString class >> string: aString [
	^ self new string: aString
]

{ #category : #accessing }
XMLString >> addContent: aString [
	self string: self string, (self toString: aString)
]

{ #category : #accessing }
XMLString >> characterData [
	^ self string
]

{ #category : #testing }
XMLString >> isText [
	^ true
]

{ #category : #printing }
XMLString >> printXMLOn: writer [
	writer pcData: self string
]

{ #category : #accessing }
XMLString >> string [
	^ string ifNil: ['']
]

{ #category : #accessing }
XMLString >> string: aString [
	string := self toString: aString
]

{ #category : #private }
XMLString >> toString: aString [
	^ (aString isKindOf: String)
		ifTrue: [aString]
		ifFalse: [aString string]
]
