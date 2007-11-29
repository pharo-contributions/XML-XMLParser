Class {
	#name : #XMLStringNode,
	#superclass : #XMLNode,
	#instVars : [
		'string'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLStringNode class >> string: aString [
	^self new string: aString
]

{ #category : #accessing }
XMLStringNode >> characterData [
	^self string
]

{ #category : #testing }
XMLStringNode >> isText [
	^true
]

{ #category : #printing }
XMLStringNode >> printXMLOn: writer [
	writer pcData: self string
]

{ #category : #accessing }
XMLStringNode >> string [
	^string ifNil: ['']
]

{ #category : #accessing }
XMLStringNode >> string: aString [
	string := aString
]
