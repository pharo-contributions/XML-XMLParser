"
This class represents a processing instruction.

"
Class {
	#name : #XMLPI,
	#superclass : #XMLNode,
	#instVars : [
		'target',
		'data'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLPI class >> target: targetName data: aString [
	^ self new
		target: targetName;
		data: aString
]

{ #category : #accessing }
XMLPI >> data [
	^ data ifNil: [data := '']
]

{ #category : #accessing }
XMLPI >> data: aString [
	data := aString
]

{ #category : #testing }
XMLPI >> isPI [
	^ true
]

{ #category : #printing }
XMLPI >> printXMLOn: aWriter [
	aWriter pi
		target: self target;
		data: self data
]

{ #category : #accessing }
XMLPI >> target [
	^ target ifNil: [target := '']
]

{ #category : #accessing }
XMLPI >> target: aString [
	target := aString
]
