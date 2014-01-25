"
A base class for XML URIs. It uses the XMLURIParser to parse URIs.
"
Class {
	#name : #XMLURI,
	#superclass : #Object,
	#instVars : [
		'scheme',
		'host',
		'pathSegments',
		'queryString',
		'fragment'
	],
	#category : #'XML-Parser-URI'
}

{ #category : #'instance creation' }
XMLURI class >> fromString: aString [
	^ self new fromString: aString
]

{ #category : #combining }
XMLURI >> / aUriOrString [
	| uriToCombineWith |

	uriToCombineWith := aUriOrString asXMLURI.
	^ (uriToCombineWith isRelative)
		ifTrue: [self copy combineWithURI: uriToCombineWith]
		ifFalse: [uriToCombineWith].
]

{ #category : #comparing }
XMLURI >> = anObject [
	self == anObject
		ifTrue: [^ true].
	self class == anObject class
		ifFalse: [^ false].

	^ scheme = anObject scheme
		and: [host = anObject host
			and: [pathSegments = anObject pathSegments
				and: [queryString = anObject queryString
					and: [fragment = anObject fragment]]]].
]

{ #category : #private }
XMLURI >> addPathSegment: aSegment [
	(aSegment = '.' or: [aSegment = '..'])
		ifTrue: [
			(aSegment = '..' and: [pathSegments notEmpty])
				ifTrue: [pathSegments removeLast].
			^ self].

	(aSegment notEmpty
		and: [pathSegments isEmpty
			and: [self hasHost]])
		ifTrue: [pathSegments addFirst: ''].

	pathSegments addLast: aSegment.
]

{ #category : #private }
XMLURI >> addPathSegmentsFrom: aUri [
	aUri pathSegments
		ifEmpty: [^ self].

	aUri hasAbsolutePath
		ifTrue: [pathSegments removeAll]
		ifFalse: [
			pathSegments
				ifNotEmpty: [pathSegments removeLast]].

	aUri pathSegments do: [:each | self addPathSegment: each].
]

{ #category : #converting }
XMLURI >> asRetrievableResource [
	^ self isLocalURI
		ifTrue: [XMLFileHandle path: self unescapedPath]
		ifFalse: [XMLHTTPRequest url: self asString]
]

{ #category : #converting }
XMLURI >> asString [
	"for compatibility if Object>>asString isn't defined"
	^ self printString
]

{ #category : #converting }
XMLURI >> asXMLURI [
	^ self
]

{ #category : #private }
XMLURI >> combineWithURI: aUri [
	aUri hasHost
		ifTrue: [host := aUri host].

	self addPathSegmentsFrom: aUri.
	queryString := aUri queryString.
	fragment := aUri fragment.
]

{ #category : #accessing }
XMLURI >> fragment [
	^ fragment
]

{ #category : #initialization }
XMLURI >> fromString: aString [
	| parser  |

	parser := XMLURIParser on: aString.
	self
		setScheme: parser parseScheme
		host: parser parseHost
		path: parser parsePath
		queryString: parser parseQueryString
		fragment: parser parseFragment.
]

{ #category : #retrieving }
XMLURI >> get [
	^ self getUpToLimit: nil
]

{ #category : #retrieving }
XMLURI >> getUpToLimit: aMaxSize [
	^ self asRetrievableResource getUpToLimit: aMaxSize
]

{ #category : #testing }
XMLURI >> hasAbsolutePath [
	^ pathSegments notEmpty
		and: [pathSegments first isEmpty]
]

{ #category : #testing }
XMLURI >> hasHost [
	^ host notEmpty
]

{ #category : #comparing }
XMLURI >> hash [
	^ host hash bitXor: pathSegments hash
]

{ #category : #accessing }
XMLURI >> host [
	^ host
]

{ #category : #testing }
XMLURI >> isFileURI [
	^ scheme = 'file'
]

{ #category : #testing }
XMLURI >> isLocalURI [
	^ self isFileURI or: [self isRelative]
]

{ #category : #testing }
XMLURI >> isRelative [
	^ scheme isEmpty
		or: [host isEmpty
			and: [self isFileURI not]]
]

{ #category : #accessing }
XMLURI >> path [
	^ self pathPrintStringUnescaped: false
]

{ #category : #printing }
XMLURI >> pathPrintStringUnescaped: aBoolean [
	| pathStream |

	pathSegments
		ifEmpty: [^ ''].

	pathStream := (String new: 16) writeStream.
	self
		printPathSegmentsOn: pathStream
		unescaped: aBoolean.
	^ pathStream contents.
]

{ #category : #private }
XMLURI >> pathSegments [
	^ pathSegments
]

{ #category : #copying }
XMLURI >> postCopy [
	pathSegments := pathSegments copy
]

{ #category : #printing }
XMLURI >> printFragmentOn: aStream [
	fragment ifNotEmpty: [
		aStream
			nextPut: $#;
			nextPutAll: fragment]
]

{ #category : #printing }
XMLURI >> printHostOn: aStream [
	host ifNotEmpty: [
		scheme ifEmpty: [aStream nextPutAll: '//'].
		aStream nextPutAll: host]
]

{ #category : #printing }
XMLURI >> printOn: aStream [
	self
		printSchemeOn: aStream;
		printHostOn: aStream;
		printPathSegmentsOn: aStream unescaped: false;
		printQueryStringOn: aStream;
		printFragmentOn: aStream
		
]

{ #category : #printing }
XMLURI >> printPathSegmentsOn: aStream unescaped: aBoolean [
	pathSegments
		do: [:each |
			aBoolean
				ifTrue: [self printUnescaped: each on: aStream]
				ifFalse: [aStream nextPutAll: each]]
		separatedBy: [aStream nextPut: $/]
]

{ #category : #printing }
XMLURI >> printQueryStringOn: aStream [
	queryString ifNotEmpty: [
		aStream
			nextPut: $?;
			nextPutAll: queryString]
]

{ #category : #printing }
XMLURI >> printSchemeOn: aStream [
	scheme ifNotEmpty: [
		aStream
			nextPutAll: scheme;
			nextPutAll: '://']
]

{ #category : #printing }
XMLURI >> printUnescaped: aString on: aStream [
	| readStream nextChar charCode |

	readStream := aString readStream.
	[readStream atEnd]
		whileFalse: [
			(nextChar := readStream next) == $%
				ifTrue: [
					charCode := 
						XMLIntegerReader
							readFrom: readStream
							withBase: 16
							upTo: 2.
					nextChar := (charCode ifNil: [$%]) asCharacter].
			aStream nextPut: nextChar].
]

{ #category : #accessing }
XMLURI >> queryString [
	^ queryString
]

{ #category : #accessing }
XMLURI >> scheme [
	^ scheme
]

{ #category : #private }
XMLURI >> setPathSegmentsFromString: aString [
	pathSegments := OrderedCollection new.

	aString ifEmpty: [^ self].

	$/ split: aString do: [:segment | pathSegments addLast: segment].
]

{ #category : #initialization }
XMLURI >> setScheme: aScheme host: aHost path: aPath queryString: aQueryString fragment: aFragment [
	scheme := aScheme.
	host := aHost.
	self setPathSegmentsFromString: aPath.
	queryString := aQueryString.
	fragment := aFragment.
]

{ #category : #accessing }
XMLURI >> unescapedPath [
	^ self pathPrintStringUnescaped: true
]
