"
This class represents string nodes, or nodes that contain no markup. String nodes can be created directly using the class-side #string: message or by sending a String object #asXMLString. When printing, they escape special characters in their contents.
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

{ #category : #accessing }
XMLString >> addContent: aStringOrStringNode [
	string :=
		string
			ifNil: [aStringOrStringNode asString]
			ifNotNil: [string, aStringOrStringNode asString]
]

{ #category : #converting }
XMLString >> asString [
	^ self string
]

{ #category : #converting }
XMLString >> asXMLString [
	^ self
]

{ #category : #testing }
XMLString >> isContentNode [
	^ true
]

{ #category : #testing }
XMLString >> isStringNode [
	^ true
]

{ #category : #printing }
XMLString >> printContentOn: aStream [
	| lastChar |

	self string ifEmpty: [^ self].

	((lastChar := aStream peekLast) isNil
		or: [lastChar isSeparator
			or: [self string first isSeparator]])
		ifFalse: [aStream space].

	aStream nextPutAll: self string.
]

{ #category : #accessing }
XMLString >> string [
	^ string ifNil: [string := '']
]

{ #category : #accessing }
XMLString >> string: aString [
	string := aString asString
]

{ #category : #printing }
XMLString >> writeXMLOn: aWriter [
	aWriter string: self string
]
