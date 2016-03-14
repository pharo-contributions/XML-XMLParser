"
A class for XML URIs. Instances are immutable and support combining with other XMLURIs or URI strings using / (to resolve relative URIs in the context of the receiver), accessing URI components, creating copies with replaced components, and retrieving the contents of http:// and file:// URLs using XMLHTTPRequest and XMLFileHandle.

Uses XMLURIParser to parse URIs lazily (for example, when a URI compoenent is accessed with an ""accessing"" message) when created from a string and eagerly when created from a stream.
"
Class {
	#name : #XMLURI,
	#superclass : #Object,
	#instVars : [
		'uriString',
		'scheme',
		'hasAuthorityPrefix',
		'userInfo',
		'host',
		'port',
		'pathSegments',
		'query',
		'fragment'
	],
	#classVars : [
		'UnreservedCharacters'
	],
	#category : #'XML-Parser-URI'
}

{ #category : #'instance creation' }
XMLURI class >> fromStream: aStream [
	"streams must be parsed eagerly, unlike strings"
	^ self basicNew initialize parseURIStream: aStream
]

{ #category : #'instance creation' }
XMLURI class >> fromString: aString [
	^ self basicNew initialize uriString: aString
]

{ #category : #'class initialization' }
XMLURI class >> initialize [
	"self initialize"

	(UnreservedCharacters := BitmapCharacterSet new)
		addAll: ($a to: $z);
		addAll: ($A to: $Z);
		addAll: ($0 to: $9);
		addAll: '-._~'
]

{ #category : #'instance creation' }
XMLURI class >> new [
	^ self fromString: ''
]

{ #category : #accessing }
XMLURI class >> percentEncodeCharacter: aCharacter [
	^ String streamContents: [:stream |
		self
			printPercentEncodedCharacter: aCharacter
			on: stream]
]

{ #category : #accessing }
XMLURI class >> percentOrPlusEncodeCharacter: aCharacter [
	^ String streamContents: [:stream |
		self
			printPercentOrPlusEncodedCharacter: aCharacter
			on: stream]
]

{ #category : #accessing }
XMLURI class >> printPercentEncodedCharacter: aCharacter on: aStream [
	(XMLPercentEncodingWriteStreamAdapter on: aStream)
		nextPut: aCharacter
]

{ #category : #accessing }
XMLURI class >> printPercentOrPlusEncodedCharacter: aCharacter on: aStream [
	aCharacter asciiValue = 32 "Character space asciiValue"
		ifTrue: [aStream nextPut: $+]
		ifFalse: [
			self
				printPercentEncodedCharacter: aCharacter
				on: aStream]
]

{ #category : #'instance creation' }
XMLURI class >> readFrom: aStringOrStream [
	aStringOrStream isStream
		ifTrue: [^ self fromStream: aStringOrStream]
		ifFalse: [^ self fromString: aStringOrStream]
]

{ #category : #combining }
XMLURI >> / aURIOrURIString [
	"Returns the argument URI if it is absolute or the argument resolved in the
	context of the receiver if it is relative, to do relative path resolution
	or replace hosts, query strings, and other components."

	| uriToCombineWith |

	(uriToCombineWith := aURIOrURIString asXMLURI) isEmpty
		ifFalse: [
			(uriToCombineWith isRelative)
				ifTrue: [^ self combinedWithRelativeURI: uriToCombineWith]
				ifFalse: [^ uriToCombineWith]]
]

{ #category : #comparing }
XMLURI >> = anObject [
	self == anObject
		ifTrue: [^ true].

	self class == anObject class
		ifFalse: [^ false].

	self scheme = anObject scheme
		ifFalse: [^ false].
	self userInfo = anObject userInfo
		ifFalse: [^ false].
	self host = anObject host
		ifFalse: [^ false].
	self port = anObject port
		ifFalse: [^ false].
	self pathSegments = anObject pathSegments
		ifFalse: [^ false].
	self query = anObject query
		ifFalse: [^ false].
	self fragment = anObject fragment
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
		ifTrue: [self removePathSegments]
		ifFalse: [| hadAbsolutePath |
			hadAbsolutePath := self hasAbsolutePath.
			self hasDirectoryPath
				ifTrue: [self removeLastPathSegment].
			self hasPath
				ifTrue: [
					self removeLastPathSegment.
					(self hasPath
						or: [hadAbsolutePath])
						ifTrue: [self haveDirectoryPath]]].
]

{ #category : #private }
XMLURI >> addPathSegment: aString [
	aString = '.'
		ifTrue: [^ self addDotPathSegment].
	aString = '..'
		ifTrue: [^ self addDoubleDotPathSegment].

	self hasPath
		ifTrue: [
			(self hasDirectoryPath
				and: [self pathSegments size > 1])
				ifTrue: [self removeLastPathSegment]]
		ifFalse: [
			self hasHost
				ifTrue: [self pathSegments addLast: '']].

	self pathSegments addLast: aString.
]

{ #category : #private }
XMLURI >> addPathSegmentsFrom: aURI [
	aURI hasPath
		ifFalse: [^ self].

	aURI hasAbsolutePath
		ifTrue: [self removePathSegments]
		ifFalse: [
			self hasNonDirectoryPath
				ifTrue: [
					self removeLastPathSegment.
					self hasPath
						ifTrue: [self haveDirectoryPath]]].

	aURI pathSegments do: [:each | self addPathSegment: each].
]

{ #category : #converting }
XMLURI >> asRetrievableResource [
	^ self isLocalURI
		ifTrue: [self path asXMLFileHandle]
		ifFalse: [self asString asXMLHTTPRequest]
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
XMLURI >> combinedWithRelativeURI: aRelativeURI [
	| copy |

	copy := self copy.
	aRelativeURI hasUserInfo
		ifTrue: [
			^ copy
				userInfo: aRelativeURI userInfo;
				host: aRelativeURI host;
				port: aRelativeURI port;
				pathSegments: aRelativeURI pathSegments;
				query: aRelativeURI query;
				fragment: aRelativeURI fragment].
	aRelativeURI hasHost
		ifTrue: [
			^ copy
				host: aRelativeURI host;
				port: aRelativeURI port;
				pathSegments: aRelativeURI pathSegments;
				query: aRelativeURI query;
				fragment: aRelativeURI fragment].
	aRelativeURI hasPort
		ifTrue: [
			^ copy
				port: aRelativeURI port;
				pathSegments: aRelativeURI pathSegments;
				query: aRelativeURI query;
				fragment: aRelativeURI fragment].
	aRelativeURI hasPath
		ifTrue: [
			^ copy "copy path segments before modifying"
				pathSegments: self pathSegments copy;
				addPathSegmentsFrom: aRelativeURI;
				query: aRelativeURI query;
				fragment: aRelativeURI fragment].
	aRelativeURI hasQuery
		ifTrue: [
			^ copy
				query: aRelativeURI query;
				fragment: aRelativeURI fragment].
	aRelativeURI hasFragment
		ifTrue: [^ copy fragment: aRelativeURI fragment].
]

{ #category : #copying }
XMLURI >> copyWithFragment: aString [
	^ self copy fragment: aString
]

{ #category : #copying }
XMLURI >> copyWithHost: aString [
	^ self copy host: aString
]

{ #category : #copying }
XMLURI >> copyWithPath: aString [
	^ self copyWithPathSegments: (XMLURIParser on: aString) parsePathSegments
]

{ #category : #copying }
XMLURI >> copyWithPathSegments: aCollection [
	^ self copy pathSegments: (OrderedCollection newFrom: aCollection)
]

{ #category : #copying }
XMLURI >> copyWithPort: anInteger [
	^ self copy port: anInteger
]

{ #category : #copying }
XMLURI >> copyWithQuery: aDictionary [
	^ self copy query: (OrderPreservingStringDictionary newFrom: aDictionary)
]

{ #category : #copying }
XMLURI >> copyWithScheme: aString [
	^ self copy
		scheme: aString;
		hasAuthorityPrefix:
			(self hasAuthorityPrefix
				or: [self hasScheme not])
]

{ #category : #copying }
XMLURI >> copyWithUserInfo: aString [
	^ self copy userInfo: aString
]

{ #category : #accessing }
XMLURI >> fragment [
	self parseURIStringIfUnparsed.
	^ fragment.
]

{ #category : #private }
XMLURI >> fragment: aString [
	fragment := aString
]

{ #category : #retrieving }
XMLURI >> get [
	^ self asRetrievableResource get
]

{ #category : #retrieving }
XMLURI >> getUpToLimit: aMaxSize decoding: aBoolean [
	^ self asRetrievableResource
		getUpToLimit: aMaxSize
		decoding: aBoolean
]

{ #category : #testing }
XMLURI >> hasAbsolutePath [
	^ self pathSegments notEmpty
		and: [self pathSegments first isEmpty]
]

{ #category : #testing }
XMLURI >> hasAuthority [
	^ self hasUserInfo
		or: [self hasHost
			or: [self hasPort]]
]

{ #category : #testing }
XMLURI >> hasAuthorityPrefix [
	self parseURIStringIfUnparsed.
	^ hasAuthorityPrefix.
]

{ #category : #private }
XMLURI >> hasAuthorityPrefix: aBoolean [
	hasAuthorityPrefix := aBoolean
]

{ #category : #testing }
XMLURI >> hasDirectoryPath [
	^ self pathSegments notEmpty
		and: [self pathSegments last isEmpty]
]

{ #category : #testing }
XMLURI >> hasFragment [
	^ self fragment notEmpty
]

{ #category : #testing }
XMLURI >> hasHost [
	^ self host notEmpty
]

{ #category : #testing }
XMLURI >> hasNonDirectoryPath [
	^ self hasPath
		and: [self hasDirectoryPath not]
]

{ #category : #testing }
XMLURI >> hasPath [
	^ self pathSegments notEmpty
]

{ #category : #testing }
XMLURI >> hasPort [
	^ self port notNil
]

{ #category : #testing }
XMLURI >> hasQuery [
	^ self query notEmpty
]

{ #category : #testing }
XMLURI >> hasRootPath [
	^ self pathSegments size = 2
		and: [self pathSegments allSatisfy: [:each | each isEmpty]]
]

{ #category : #testing }
XMLURI >> hasScheme [
	^ self scheme notEmpty
]

{ #category : #testing }
XMLURI >> hasUserInfo [
	^ self userInfo notEmpty
]

{ #category : #comparing }
XMLURI >> hash [
	^ self host hash bitXor: self pathSegments hash
]

{ #category : #private }
XMLURI >> haveDirectoryPath [
	self hasPath
		ifFalse: [self pathSegments addLast: ''].
	self pathSegments addLast: ''.
]

{ #category : #accessing }
XMLURI >> host [
	self parseURIStringIfUnparsed.
	^ host.
]

{ #category : #private }
XMLURI >> host: aString [
	host := aString
]

{ #category : #testing }
XMLURI >> isEmpty [
	self hasScheme
		ifTrue: [^ false].
	self hasAuthority
		ifTrue: [^ false].
	self hasPath
		ifTrue: [^ false].
	self hasQuery
		ifTrue: [^ false].
	self hasFragment
		ifTrue: [^ false].

	^ true.
]

{ #category : #testing }
XMLURI >> isFileURI [
	^ self scheme = 'file'
]

{ #category : #testing }
XMLURI >> isLocalURI [
	^ self isFileURI
		or: [self isRelative
			and: [self hasHost not]]
]

{ #category : #testing }
XMLURI >> isRelative [
	^ self hasScheme not
]

{ #category : #testing }
XMLURI >> notEmpty [
	^ self isEmpty not
]

{ #category : #private }
XMLURI >> parseURIStream: aStream [
	| parser |

	parser := XMLURIParser on: aStream.
	self
		scheme: parser parseScheme;
		hasAuthorityPrefix: parser parseAuthorityPrefix.
	(self hasScheme
		or: [self hasAuthorityPrefix])
		ifTrue: [
			self
				userInfo: parser parseUserInfo;
				host: parser parseHost;
				port: parser parsePort]
		ifFalse: [
			self
				userInfo: '';
				host: ''].
	self
		pathSegments: parser parsePathSegments;
		query: parser parseQuery;
		fragment: parser parseFragment.
]

{ #category : #private }
XMLURI >> parseURIStringIfUnparsed [
	scheme
		ifNil: [self parseURIStream: self uriString readStream]
]

{ #category : #accessing }
XMLURI >> path [
	self hasPath
		ifTrue: [| writeStream |
			writeStream := (String new: self pathSegments size * 10) writeStream.
			self
				printPathWithPercentEncoding: false
				on: writeStream.
			^ writeStream contents]
		ifFalse: [^ '']
]

{ #category : #accessing }
XMLURI >> pathSegments [
	"copy the return value before modifying it"

	self parseURIStringIfUnparsed.
	^ pathSegments.
]

{ #category : #private }
XMLURI >> pathSegments: aPathSegmentCollection [
	pathSegments := aPathSegmentCollection
]

{ #category : #enumerating }
XMLURI >> pathSegmentsDo: aBlock [
	self pathSegments do: aBlock
]

{ #category : #accessing }
XMLURI >> port [
	self parseURIStringIfUnparsed.
	^ port.
]

{ #category : #private }
XMLURI >> port: anInteger [
	port := anInteger
]

{ #category : #copying }
XMLURI >> postCopy [
	"the copyWith* methods modify copies, so any URI string of a copy must be parsed
	if it hasn't been already and then cleared because it will be obsolete after a
	URI component is changed"
	self
		parseURIStringIfUnparsed;
		uriString: nil
]

{ #category : #printing }
XMLURI >> print: aString withPercentEncodingOn: aStream [
	"to:do: for speed"
	1 to: aString size do: [:i | | nextChar |
		nextChar := aString at: i.
		(UnreservedCharacters includes: nextChar)
			ifTrue: [aStream nextPut: nextChar]
			ifFalse: [
				self class
					printPercentEncodedCharacter: nextChar
					on: aStream]].
]

{ #category : #printing }
XMLURI >> print: aString withPercentOrPlusEncodingOn: aStream [
	"to:do: for speed"
	1 to: aString size do: [:i | | nextChar |
		nextChar := aString at: i.
		(UnreservedCharacters includes: nextChar)
			ifTrue: [aStream nextPut: nextChar]
			ifFalse: [
				self class
					printPercentOrPlusEncodedCharacter: nextChar
					on: aStream]].
]

{ #category : #printing }
XMLURI >> printAuthorityOn: aStream [
	self hasAuthority
		ifTrue: [
			self
				printUserInfoOn: aStream;
				printHostOn: aStream;
				printPortOn: aStream]
]

{ #category : #printing }
XMLURI >> printAuthorityPrefixOn: aStream [
	(self hasAuthorityPrefix
		or: [self hasScheme not and: [self hasAuthority]])
		ifTrue: [aStream nextPutAll: '//']
]

{ #category : #printing }
XMLURI >> printFragmentOn: aStream [
	self hasFragment
		ifTrue: [
			aStream nextPut: $#.
			self
				print: self fragment
				withPercentEncodingOn: aStream]
]

{ #category : #printing }
XMLURI >> printHostOn: aStream [
	self hasHost
		ifTrue: [
			(self host first == $[
				and: [self host last == $]])
				ifTrue: [| atBeginning |
					atBeginning := true.
					aStream nextPut: $[.
					$:
						xmlSplit:
							(self host
								copyFrom: 2
								to: self host size - 1)
						do: [:each |
							atBeginning
								ifTrue: [atBeginning := false]
								ifFalse: [aStream nextPut: $:].
							self
								print: each
								withPercentEncodingOn: aStream].
					aStream nextPut: $]]
				ifFalse: [
					self
						print: self host
						withPercentEncodingOn: aStream]]
]

{ #category : #printing }
XMLURI >> printOn: aStream [
	self uriString
		ifNil: [| writeStream |
			writeStream := (String new: 64) writeStream.
			self
				printSchemeOn: writeStream;
				printAuthorityPrefixOn: writeStream;
				printAuthorityOn: writeStream;
				printPathPrefixOn: writeStream;
				printPathOn: writeStream;
				printQueryOn: writeStream;
				printFragmentOn: writeStream.
			self uriString: writeStream contents].
	aStream nextPutAll: self uriString.
]

{ #category : #printing }
XMLURI >> printPathOn: aStream [
	self
		printPathWithPercentEncoding: true
		on: aStream
]

{ #category : #printing }
XMLURI >> printPathPrefixOn: aStream [
	(self hasPath
		and: [self hasAbsolutePath not
			and: [self hasScheme or: [self hasAuthority]]])
		ifTrue: [aStream nextPut: $/]
]

{ #category : #printing }
XMLURI >> printPathWithPercentEncoding: aBoolean on: aStream [
	self pathSegments
		do: [:each |
			aBoolean
				ifTrue: [
					self
						print: each
						withPercentEncodingOn: aStream]
				ifFalse: [aStream nextPutAll: each]]
		separatedBy: [aStream nextPut: $/]
]

{ #category : #printing }
XMLURI >> printPortOn: aStream [
	self hasPort
		ifTrue: [
			aStream nextPut: $:.
			port printOn: aStream]
]

{ #category : #printing }
XMLURI >> printQueryOn: aStream [
	| atBeginning |

	self hasQuery
		ifFalse: [^ self].
	
	aStream nextPut: $?.
	atBeginning := true.
	self queryKeysAndValuesDo: [:key :value |
		atBeginning
			ifTrue: [atBeginning := false]
			ifFalse: [aStream nextPut: $&].
		self
			print: key
			withPercentOrPlusEncodingOn: aStream.
		aStream nextPut: $=.
		self
			print: value
			withPercentOrPlusEncodingOn: aStream].
]

{ #category : #printing }
XMLURI >> printSchemeOn: aStream [
	self hasScheme
		ifTrue: [
			aStream "do not percent encode scheme"
				nextPutAll: self scheme;
				nextPut: $:]
]

{ #category : #printing }
XMLURI >> printUserInfoOn: aStream [
	self hasUserInfo
		ifTrue: [
			self
				print: self userInfo
				withPercentEncodingOn: aStream.
			aStream nextPut: $@]
]

{ #category : #accessing }
XMLURI >> query [
	"copy the return value before modifying it"

	self parseURIStringIfUnparsed.
	^ query.
]

{ #category : #private }
XMLURI >> query: aDictionary [
	query := aDictionary
]

{ #category : #accessing }
XMLURI >> queryAt: aName [
	^ self query at: aName
]

{ #category : #accessing }
XMLURI >> queryAt: aName ifAbsent: aBlock [
	^ self query
		at: aName
		ifAbsent: aBlock
]

{ #category : #testing }
XMLURI >> queryIncludesKey: aKey [
	^ self query includesKey: aKey
]

{ #category : #accessing }
XMLURI >> queryKeys [
	^ self query keys
]

{ #category : #enumerating }
XMLURI >> queryKeysAndValuesDo: aTwoArgumentBlock [
	self query keysAndValuesDo: aTwoArgumentBlock
]

{ #category : #private }
XMLURI >> removeLastPathSegment [
	^ self pathSegments removeLast
]

{ #category : #private }
XMLURI >> removePathSegments [
	^ self pathSegments removeAll
]

{ #category : #accessing }
XMLURI >> scheme [
	self parseURIStringIfUnparsed.
	^ scheme.
]

{ #category : #private }
XMLURI >> scheme: aString [
	scheme := aString
]

{ #category : #retrieving }
XMLURI >> streamGet [
	^ self asRetrievableResource streamGet
]

{ #category : #retrieving }
XMLURI >> streamGetUpToLimit: aMaxSize decoding: aBoolean [
	^ self asRetrievableResource
		streamGetUpToLimit: aMaxSize
		decoding: aBoolean
]

{ #category : #private }
XMLURI >> uriString [
	^ uriString
]

{ #category : #private }
XMLURI >> uriString: aString [
	uriString := aString
]

{ #category : #accessing }
XMLURI >> userInfo [
	self parseURIStringIfUnparsed.
	^ userInfo.
]

{ #category : #private }
XMLURI >> userInfo: aString [
	userInfo := aString
]
