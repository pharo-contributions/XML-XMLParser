Class {
	#name : #XMLPI,
	#superclass : #XMLNode,
	#instVars : [
		'target',
		'data'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLPI class >> target: targetName data: aString [
	^self new
		target: targetName;
		data: aString
]

{ #category : #accessing }
XMLPI >> data [
	^data
]

{ #category : #accessing }
XMLPI >> data: aString [
	data := aString
]

{ #category : #testing }
XMLPI >> isProcessingInstruction [
	^true
]

{ #category : #printing }
XMLPI >> printXMLOn: writer [
	writer pi: self target data: self data
]

{ #category : #accessing }
XMLPI >> target [
	^target
]

{ #category : #accessing }
XMLPI >> target: aString [
	target := aString
]
