Class {
	#name : #XMLComment,
	#superclass : #XMLNode,
	#instVars : [
		'string'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLComment class >> string: aString [
	^ self new string: aString
]

{ #category : #testing }
XMLComment >> isComment [
	^ true
]

{ #category : #printing }
XMLComment >> printXMLOn: aWriter [
	aWriter comment: self string
]

{ #category : #accessing }
XMLComment >> string [
	^ string ifNil: [string := '']
]

{ #category : #accessing }
XMLComment >> string: aString [
	string := aString
]
