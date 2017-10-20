"
This is a class for Zinc HTTP responses.
"
Class {
	#name : #XMLZincHTTPResponse,
	#superclass : #XMLHTTPResponse,
	#instVars : [
		'zincResponse'
	],
	#category : #'XML-Parser-HTTP'
}

{ #category : #accessing }
XMLZincHTTPResponse >> content [
	^ self zincResponse contents ifNil: ['']
]

{ #category : #accessing }
XMLZincHTTPResponse >> contentLength [
	^ self zincResponse contentLength
]

{ #category : #accessing }
XMLZincHTTPResponse >> headerAt: aKey ifAbsent: aBlock [
	self zincResponse headers
		at: aKey
		ifPresent: [:value |
			^ value isArray
				ifTrue: [value first]
				ifFalse: [value]].
	^ aBlock value
]

{ #category : #enumerating }
XMLZincHTTPResponse >> headerKeysAndValuesDo: aTwoArgumentBlock [
	self zincResponse headersDo: aTwoArgumentBlock
]

{ #category : #enumerating }
XMLZincHTTPResponse >> headerValuesAt: aKey do: aBlock [
	self zincResponse headers
		at: aKey
		ifPresent: [:value |
			value isArray
				ifTrue: [value do: aBlock]
				ifFalse: [aBlock value: value]]
]

{ #category : #testing }
XMLZincHTTPResponse >> isSuccess [
	^ self zincResponse isSuccess
]

{ #category : #printing }
XMLZincHTTPResponse >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self zincResponse;
		nextPut: $).
]

{ #category : #initialization }
XMLZincHTTPResponse >> setZincResponse: aZincResponse [
	zincResponse := aZincResponse
]

{ #category : #accessing }
XMLZincHTTPResponse >> status [
	^ self zincResponse status
]

{ #category : #accessing }
XMLZincHTTPResponse >> statusLine [
	^ self zincResponse statusLine
		ifNil: ['']
		ifNotNil: [:statusLine | statusLine printString]
]

{ #category : #private }
XMLZincHTTPResponse >> zincResponse [
	^ zincResponse
]
