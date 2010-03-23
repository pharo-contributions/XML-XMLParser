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
	^ (aString respondsTo: #string) ifTrue: [aString string] ifFalse: [aString]
]
