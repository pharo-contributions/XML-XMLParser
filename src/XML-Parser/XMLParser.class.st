"
This class is a facade that parses XML using a driver and tokenizer. See SAXHandler and XMLDOMParser for ready-made front ends to it.
"
Class {
	#name : #XMLParser,
	#superclass : #Object,
	#instVars : [
		'tokenizer',
		'driver'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLParser class >> driver: aDriver on: aStringOrStream [
	^ self new setDriver: aDriver tokenizer: (aDriver tokenizerOn: aStringOrStream)
]

{ #category : #testing }
XMLParser >> atEnd [
	^ self tokenizer atEnd
]

{ #category : #accessing }
XMLParser >> driver [
	^ driver
]

{ #category : #parsing }
XMLParser >> parseDocument [
	[self atEnd] whileFalse: [self parseToken]
]

{ #category : #parsing }
XMLParser >> parseToken [
	^ self tokenizer nextToken
]

{ #category : #accessing }
XMLParser >> setDriver: aDriver tokenizer: aTokenizer [
	driver := aDriver.
	tokenizer := aTokenizer.
]

{ #category : #accessing }
XMLParser >> tokenizer [
	^ tokenizer
]
