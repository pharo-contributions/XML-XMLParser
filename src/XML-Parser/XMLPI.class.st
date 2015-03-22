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
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLPI class >> target: aTargetString data: aDataString [
	^ self new
		target: aTargetString;
		data: aDataString
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

{ #category : #private }
XMLPI >> sortKey [
	^ self target
]

{ #category : #accessing }
XMLPI >> target [
	^ target ifNil: [target := '']
]

{ #category : #accessing }
XMLPI >> target: aString [
	target := aString
]

{ #category : #printing }
XMLPI >> writeXMLOn: aWriter [
	aWriter pi
		target: self target;
		data: self data
]
