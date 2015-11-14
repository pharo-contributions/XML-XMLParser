"
A class for XML URIs. It uses the XMLURIParser to parse URIs and can combine URIs using /, can decode URI paths, and can retrieve contents of http:// and file:// URLs using XMLHTTPRequest and XMLFileHandle.
"
Class {
	#name : #XMLURI,
	#superclass : #Object,
	#instVars : [
		'scheme',
		'hasAuthorityPrefix',
		'userInfo',
		'host',
		'port',
		'pathSegments',
		'queryString',
		'fragment'
	],
	#category : #'XML-Parser-URI'
}

{ #category : #'instance creation' }
XMLURI class >> fromString: aString [
	^ self basicNew initialize fromString: aString
]

{ #category : #'instance creation' }
XMLURI class >> new [
	^ self fromString: ''
]

{ #category : #combining }
XMLURI >> / aURIOrString [
	| uriToCombineWith |

	(uriToCombineWith := aURIOrString asXMLURI) isEmpty
		ifFalse: [
			(uriToCombineWith isRelative)
				ifTrue: [^ self copy combineWithRelativeURI: uriToCombineWith]
				ifFalse: [^ uriToCombineWith]]
]

{ #category : #comparing }
XMLURI >> = anObject [
	self == anObject
		ifTrue: [^ true].

	self class == anObject class
		ifFalse: [^ false].

	scheme = anObject scheme
		ifFalse: [^ false].
	hasAuthorityPrefix = anObject hasAuthorityPrefix
		ifFalse: [^ false].
	userInfo = anObject userInfo
		ifFalse: [^ false].
	host = anObject host
		ifFalse: [^ false].
	port = anObject port
		ifFalse: [^ false].
	pathSegments = anObject pathSegments
		ifFalse: [^ false].
	queryString = anObject queryString
		ifFalse: [^ false].
	fragment = anObject fragment
		ifFalse: [^ false].
	^ true.
]

{ #category : #private }
XMLURI >> addDotPathSegment [
	self hasNonDirectoryPath
		ifTrue: [self haveDirectoryPath]
]

{ #category : #private }
XMLURI >> addDoubleDotPathSegment [
	self hasPath
		ifFalse: [^ self].

	self hasRootPath
		ifTrue: [pathSegments removeAll]
		ifFalse: [| hadAbsolutePath |
			hadAbsolutePath := self hasAbsolutePath.
			self hasDirectoryPath
				ifTrue: [pathSegments removeLast].
			self hasPath
				ifTrue: [
					pathSegments removeLast.
					(self hasPath
						or: [hadAbsolutePath])
						ifTrue: [self haveDirectoryPath]]].
]

{ #category : #private }
XMLURI >> addPathSegment: aSegment [
	aSegment = '.'
		ifTrue: [^ self addDotPathSegment].
	aSegment = '..'
		ifTrue: [^ self addDoubleDotPathSegment].

	self hasPath
		ifTrue: [
			(self hasDirectoryPath
				and: [pathSegments size > 1])
				ifTrue: [pathSegments removeLast]]
		ifFalse: [
			self hasHost
				ifTrue: [pathSegments addLast: '']].

	pathSegments addLast: aSegment.
]

{ #category : #private }
XMLURI >> addPathSegmentsFrom: aURI [
	aURI hasPath
		ifFalse: [^ self].

	aURI hasAbsolutePath
		ifTrue: [pathSegments removeAll]
		ifFalse: [
			self hasNonDirectoryPath
				ifTrue: [
					pathSegments removeLast.
					self hasPath
						ifTrue: [self haveDirectoryPath]]].

	aURI pathSegments do: [:each | self addPathSegment: each].
]

{ #category : #converting }
XMLURI >> asRetrievableResource [
	^ self isLocalURI
		ifTrue: [XMLFileHandle path: self unescapedPath]
		ifFalse: [XMLHTTPRequest url: self asString]
]

{ #category : #converting }
XMLURI >> asString [
	"for compatibility with GS where Object>>asString isn't defined"
	^ self printString
]

{ #category : #converting }
XMLURI >> asXMLURI [
	^ self
]

{ #category : #private }
XMLURI >> combineWithRelativeURI: aRelativeURI [
	(aRelativeURI hasHost
		or: [aRelativeURI hasPath])
		ifTrue: [
			queryString := ''.
			fragment := ''].
	aRelativeURI hasHost
		ifTrue: [
			host := aRelativeURI host.
			pathSegments removeAll].
	aRelativeURI hasPort
		ifTrue: [port := aRelativeURI port].
	aRelativeURI hasPath
		ifTrue: [self addPathSegmentsFrom: aRelativeURI].
	aRelativeURI hasQueryString
		ifTrue: [queryString := aRelativeURI queryString].
	aRelativeURI hasFragment
		ifTrue: [fragment := aRelativeURI fragment].
]

{ #category : #accessing }
XMLURI >> fragment [
	^ fragment
]

{ #category : #initialization }
XMLURI >> fromString: aString [
	| parser  |

	parser := XMLURIParser on: aString.

	scheme := parser parseScheme.
	hasAuthorityPrefix := parser parseAuthorityPrefix.
	(hasAuthorityPrefix
		or: [scheme notEmpty])
		ifTrue: [
			userInfo := parser parseUserInfo.
			host := parser parseHost.
			port := parser parsePort]
		ifFalse: [
			userInfo := ''.
			host := ''].
	self setPathSegmentsFromString: parser parsePath.
	queryString := parser parseQueryString.
	fragment := parser parseFragment.
]

{ #category : #retrieving }
XMLURI >> get [
	^ self asRetrievableResource get
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
XMLURI >> hasAuthority [
	^ self hasUserInfo
		or: [self hasHost
			or: [self hasPort]]
]

{ #category : #testing }
XMLURI >> hasAuthorityPrefix [
	^ hasAuthorityPrefix
]

{ #category : #testing }
XMLURI >> hasDirectoryPath [
	^ pathSegments notEmpty
		and: [pathSegments last isEmpty]
]

{ #category : #testing }
XMLURI >> hasFragment [
	^ fragment notEmpty
]

{ #category : #testing }
XMLURI >> hasHost [
	^ host notEmpty
]

{ #category : #testing }
XMLURI >> hasNonDirectoryPath [
	^ self hasPath and: [self hasDirectoryPath not]
]

{ #category : #testing }
XMLURI >> hasPath [
	^ pathSegments notEmpty
]

{ #category : #testing }
XMLURI >> hasPort [
	^ port notNil
]

{ #category : #testing }
XMLURI >> hasQueryString [
	^ queryString notEmpty
]

{ #category : #testing }
XMLURI >> hasRootPath [
	^ pathSegments size = 2
		and: [pathSegments allSatisfy: [:each | each isEmpty]]
]

{ #category : #testing }
XMLURI >> hasScheme [
	^ scheme notEmpty
]

{ #category : #testing }
XMLURI >> hasUserInfo [
	^ userInfo notEmpty
]

{ #category : #comparing }
XMLURI >> hash [
	^ host hash bitXor: pathSegments hash
]

{ #category : #private }
XMLURI >> haveDirectoryPath [
	self hasPath
		ifFalse: [pathSegments addLast: ''].
	pathSegments addLast: ''.
]

{ #category : #accessing }
XMLURI >> host [
	^ host
]

{ #category : #testing }
XMLURI >> isEmpty [
	^ (self hasScheme
		or: [self hasAuthority
			or: [self hasPath
				or: [self hasQueryString
					or: [self hasFragment]]]]) not
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
	^ self pathPrintedUnescaped: false
]

{ #category : #printing }
XMLURI >> pathPrintedUnescaped: aBoolean [
	| writeStream |

	self hasPath
		ifFalse: [^ ''].

	writeStream := (String new: pathSegments size * 10) writeStream.
	self
		printPathSegmentsOn: writeStream
		unescaped: aBoolean.
	^ writeStream contents.
]

{ #category : #private }
XMLURI >> pathSegments [
	^ pathSegments
]

{ #category : #accessing }
XMLURI >> port [
	^ port
]

{ #category : #copying }
XMLURI >> postCopy [
	pathSegments := pathSegments copy
]

{ #category : #printing }
XMLURI >> printAuthorityOn: aStream [
	self hasAuthority
		ifTrue: [
			(self hasScheme not
				and: [self hasAuthorityPrefix])
				ifTrue: [aStream nextPutAll: '//'].
			self
				printUserInfoOn: aStream;
				printHostOn: aStream;
				printPortOn: aStream]
]

{ #category : #printing }
XMLURI >> printFragmentOn: aStream [
	self hasFragment
		ifTrue: [
			aStream
				nextPut: $#;
				nextPutAll: fragment]
]

{ #category : #printing }
XMLURI >> printHostOn: aStream [
	self hasHost
		ifTrue: [aStream nextPutAll: host]
]

{ #category : #printing }
XMLURI >> printOn: aStream [
	self
		printSchemeOn: aStream;
		printAuthorityOn: aStream;
		printPathSegmentsOn: aStream unescaped: false;
		printQueryStringOn: aStream;
		printFragmentOn: aStream
		
]

{ #category : #printing }
XMLURI >> printPathSegmentsOn: aStream unescaped: aBoolean [
	pathSegments
		do: [:each |
			aBoolean
				ifTrue: [self printUnescapedPathSegment: each on: aStream]
				ifFalse: [aStream nextPutAll: each]]
		separatedBy: [aStream nextPut: $/]
]

{ #category : #printing }
XMLURI >> printPortOn: aStream [
	self hasPort
		ifTrue: [
			aStream
				nextPut: $:;
				nextPutAll: port asString]
]

{ #category : #printing }
XMLURI >> printQueryStringOn: aStream [
	self hasQueryString
		ifTrue: [
			aStream
				nextPut: $?;
				nextPutAll: queryString]
]

{ #category : #printing }
XMLURI >> printSchemeOn: aStream [
	self hasScheme
		ifTrue: [
			aStream 
				nextPutAll: scheme;
				nextPut: $:.
			self hasAuthorityPrefix
				ifTrue: [aStream nextPutAll: '//']]
]

{ #category : #printing }
XMLURI >> printUnescapedPathSegment: aString on: aStream [
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
					aStream nextPut: (charCode ifNil: [$%]) asCharacter]
				ifFalse: [aStream nextPut: nextChar]].
]

{ #category : #printing }
XMLURI >> printUserInfoOn: aStream [
	self hasUserInfo
		ifTrue: [
			aStream
				nextPutAll: userInfo;
				nextPut: $@]
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

	"pathSegments must remain empty if the path string is empty, but splitting
	an empty string would add a single empty string to it"
	aString isEmpty
		ifFalse: [
			$/
				xmlParserSplit: aString
				do: [:segment | pathSegments addLast: segment]].
]

{ #category : #retrieving }
XMLURI >> streamGet [
	^ self asRetrievableResource streamGet
]

{ #category : #retrieving }
XMLURI >> streamGetUpToLimit: aMaxSize [
	^ self asRetrievableResource streamGetUpToLimit: aMaxSize
]

{ #category : #accessing }
XMLURI >> unescapedPath [
	^ self pathPrintedUnescaped: true
]

{ #category : #accessing }
XMLURI >> userInfo [
	^ userInfo
]
