"
This is an abstract base class for HTTP responses.
"
Class {
	#name : #XMLHTTPResponse,
	#superclass : #Object,
	#instVars : [
		'request'
	],
	#category : #'XML-Parser-HTTP'
}

{ #category : #parsing }
XMLHTTPResponse class >> charsetFromContentType: aContentTypeString [
	"Implemented here so the HTML tokenizer can access it when parsing
	<meta> attributes"
	$;
		xmlSplit: aContentTypeString
		do: [:contentTypeField | | contentTypeFieldWithoutWhitespace i | 
			contentTypeFieldWithoutWhitespace :=
				contentTypeField reject: [:each | each isXMLWhitespace].
			(i := contentTypeFieldWithoutWhitespace indexOf: $=) > 0
				ifTrue: [
					(contentTypeFieldWithoutWhitespace
						copyFrom: 1
						to: i - 1) = 'charset'
						ifTrue: [
							^ contentTypeFieldWithoutWhitespace
								copyFrom: i + 1
								to: contentTypeFieldWithoutWhitespace size]]].
	^ ''.
]

{ #category : #'instance creation' }
XMLHTTPResponse class >> request: aRequest [
	^ self new setRequest: aRequest
]

{ #category : #accessing }
XMLHTTPResponse >> content [
	"Returns the response content as a string"

	self subclassResponsibility
]

{ #category : #accessing }
XMLHTTPResponse >> contentCharacterEncoding [
	"Returns the response content character encoding name as a string"

	| encoding |

	^ (encoding := self class charsetFromContentType: self contentType) isEmpty
		ifTrue: [self defaultContentCharacterEncoding]
		ifFalse: [encoding]
]

{ #category : #accessing }
XMLHTTPResponse >> contentLength [
	"Returns the content length in bytes or nil if absent"

	self subclassResponsibility
]

{ #category : #accessing }
XMLHTTPResponse >> contentType [
	^ self headerAt: 'Content-Type'
]

{ #category : #defaults }
XMLHTTPResponse >> defaultContentCharacterEncoding [
	"'...media subtypes of the 'text' type are defined to have a default
	charset value of 'ISO-8859-1' when received via HTTP.'"
	^ 'ISO-8859-1'
]

{ #category : #accessing }
XMLHTTPResponse >> headerAt: aKey [
	^ self
		headerAt: aKey
		ifAbsent: ['']
]

{ #category : #accessing }
XMLHTTPResponse >> headerAt: aKey ifAbsent: aBlock [
	self subclassResponsibility
]

{ #category : #enumerating }
XMLHTTPResponse >> headerKeysAndValuesDo: aTwoArgumentBlock [
	self subclassResponsibility
]

{ #category : #enumerating }
XMLHTTPResponse >> headerKeysDo: aBlock [
	self headerKeysAndValuesDo: [:key :value |
		aBlock value: key]
]

{ #category : #accessing }
XMLHTTPResponse >> headerValuesAt: aKey [
	| values |

	values := OrderedCollection new.
	self
		headerValuesAt: aKey
		do: [:each | values addLast: each].
	^ values.
]

{ #category : #enumerating }
XMLHTTPResponse >> headerValuesAt: aKey do: aBlock [
	self subclassResponsibility
]

{ #category : #testing }
XMLHTTPResponse >> includesHeaderKey: aKey [
	self
		headerAt: aKey
		ifAbsent: [^ false].
	^ true.
]

{ #category : #testing }
XMLHTTPResponse >> isSuccess [
	self subclassResponsibility
]

{ #category : #accessing }
XMLHTTPResponse >> request [
	"Returns the XMLHTTPRequest object that created this response"

	^ request
]

{ #category : #initialization }
XMLHTTPResponse >> setRequest: aRequest [
	request := aRequest
]

{ #category : #accessing }
XMLHTTPResponse >> status [
	"Returns the status code as an integer"

	self subclassResponsibility
]

{ #category : #accessing }
XMLHTTPResponse >> statusLine [
	"Returns the status line as a string"

	self subclassResponsibility
]
