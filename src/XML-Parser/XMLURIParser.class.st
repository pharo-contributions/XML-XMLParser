"
This class is a parser that can extract the scheme, user info, host, port, path segments, query (as a dictionary), and fragment of a URI. It automatically handles percent decoding and raises no errors.
"
Class {
	#name : #XMLURIParser,
	#superclass : #Object,
	#instVars : [
		'writeStream',
		'readStream'
	],
	#classVars : [
		'HostDelimiters',
		'PathDelimiters',
		'QueryKeyDelimiters',
		'QueryValueDelimiters',
		'SchemeDelimiters',
		'UserInfoDelimiters'
	],
	#category : #'XML-Parser-URI'
}

{ #category : #'class initialization' }
XMLURIParser class >> initialize [
	"self initialize"

	self
		initializeSchemeDelimiters;
		initializeUserInfoDelimiters;
		initializeHostDelimiters;
		initializePathDelimiters;
		initializeQueryKeyDelimiters;
		initializeQueryValueDelimiters
]

{ #category : #'class initialization' }
XMLURIParser class >> initializeHostDelimiters [
	HostDelimiters := BitmapCharacterSet newFrom: ':/?#'
]

{ #category : #'class initialization' }
XMLURIParser class >> initializePathDelimiters [
	PathDelimiters := BitmapCharacterSet newFrom: '/?#'
]

{ #category : #'class initialization' }
XMLURIParser class >> initializeQueryKeyDelimiters [
	QueryKeyDelimiters := BitmapCharacterSet newFrom: '=&#'
]

{ #category : #'class initialization' }
XMLURIParser class >> initializeQueryValueDelimiters [
	QueryValueDelimiters := BitmapCharacterSet newFrom: '&#'
]

{ #category : #'class initialization' }
XMLURIParser class >> initializeSchemeDelimiters [
	"including % disallows percent encoding in schemes"
	SchemeDelimiters := BitmapCharacterSet newFrom: ':@/?#%'
]

{ #category : #'class initialization' }
XMLURIParser class >> initializeUserInfoDelimiters [
	UserInfoDelimiters := BitmapCharacterSet newFrom: '@/?#'
]

{ #category : #'instance creation' }
XMLURIParser class >> on: aStringOrStream [
	^ self new on: aStringOrStream
]

{ #category : #private }
XMLURIParser >> atEnd [
	^ readStream atEnd
]

{ #category : #private }
XMLURIParser >> next [
	self atEnd
		ifTrue: [^ nil]
		ifFalse: [^ readStream next]
]

{ #category : #private }
XMLURIParser >> nextIntegerWithBase: aBase upTo: aLimit [
	^ XMLIntegerReader
		readFrom: readStream
		withBase: aBase
		upTo: aLimit
]

{ #category : #private }
XMLURIParser >> nextPercentEncodedChar [
	| nextChar |

	(nextChar := self next) == $%
		ifTrue: [^ ((self nextIntegerWithBase: 16 upTo: 2) ifNil: [$%]) asCharacter]
		ifFalse: [^ nextChar]
]

{ #category : #private }
XMLURIParser >> nextPercentEncodedDelimitedBy: aCollection [
	writeStream reset.
	[self atEnd
		or: [aCollection includes: self peek]]
		whileFalse: [writeStream nextPut: self nextPercentEncodedChar].
	^ writeStream contents.
]

{ #category : #private }
XMLURIParser >> nextPercentEncodedUpToEnd [
	writeStream reset.
	[self atEnd]
		whileFalse: [writeStream nextPut: self nextPercentEncodedChar].
	^ writeStream contents.
]

{ #category : #private }
XMLURIParser >> nextPercentOrPlusEncodedChar [
	| nextChar |

	(nextChar := self next) == $%
		ifTrue: [^ ((self nextIntegerWithBase: 16 upTo: 2) ifNil: [$%]) asCharacter]
		ifFalse: [
			nextChar == $+
				ifTrue: [^ Character space]
				ifFalse: [^ nextChar]]
]

{ #category : #private }
XMLURIParser >> nextPercentOrPlusEncodedDelimitedBy: aCollection [
	writeStream reset.
	[self atEnd
		or: [aCollection includes: self peek]]
		whileFalse: [writeStream nextPut: self nextPercentOrPlusEncodedChar].
	^ writeStream contents.
]

{ #category : #initialization }
XMLURIParser >> on: aStringOrStream [
	readStream :=
		aStringOrStream isStream
			ifTrue: [aStringOrStream]
			ifFalse: [aStringOrStream readStream].
	writeStream := (String new: 64) writeStream.
]

{ #category : #parsing }
XMLURIParser >> parseAuthorityPrefix [
	| oldPosition |

	oldPosition := self position.
	((self peekFor: $/)
		and: [self peekFor: $/])
		ifTrue: [^ true]
		ifFalse: [
			self position: oldPosition.
			^ false].
]

{ #category : #parsing }
XMLURIParser >> parseFragment [
	(self peekFor: $#)
		ifTrue: [^ self nextPercentEncodedUpToEnd]
		ifFalse: [^ '']
]

{ #category : #parsing }
XMLURIParser >> parseHost [
	| host |

	self peek == $[
		ifTrue: [
			host := (self nextPercentEncodedDelimitedBy: ']') copyWith: $].
			self peekFor: $]]
		ifFalse: [host := self nextPercentEncodedDelimitedBy: HostDelimiters].
	^ host asLowercase.
]

{ #category : #parsing }
XMLURIParser >> parsePathSegments [
	| pathSegments segment |

	pathSegments := OrderedCollection new.

	segment := self nextPercentEncodedDelimitedBy: PathDelimiters.
	[self peekFor: $/]
		whileTrue: [
			pathSegments addLast: segment.
			segment := self nextPercentEncodedDelimitedBy: PathDelimiters].
	(pathSegments isEmpty
		and: [segment isEmpty])
		ifFalse: [pathSegments addLast: segment].

	^ pathSegments.
]

{ #category : #parsing }
XMLURIParser >> parsePort [
	| port |

	(self peekFor: $:)
		ifTrue: [
			port :=
				self
					nextIntegerWithBase: 10
					upTo: nil.
			[self atEnd
				or: [PathDelimiters includes: self peek]]
				whileFalse: [self next]].
	^ port.
]

{ #category : #parsing }
XMLURIParser >> parseQuery [
	| query key value |

	query := OrderPreservingStringDictionary new.
	(self peekFor: $?)
		ifFalse: [^ query].

	[self atEnd
		or: [(key := self nextPercentOrPlusEncodedDelimitedBy: QueryKeyDelimiters) isEmpty
			and: [self peek == $#]]]
		whileFalse: [| hasValue |
			(hasValue := self peekFor: $=)
				ifTrue: [value := self nextPercentOrPlusEncodedDelimitedBy: QueryValueDelimiters]
				ifFalse: [value := ''].
			(key notEmpty
				or: [hasValue])
				ifTrue: [
					query
						at: key
						put: value].
			self peekFor: $&].

	^ query.
]

{ #category : #parsing }
XMLURIParser >> parseScheme [
	| oldPosition scheme |

	oldPosition := self position.
	scheme := self nextPercentEncodedDelimitedBy: SchemeDelimiters.
	(self peekFor: $:)
		ifTrue: [^ scheme asLowercase]
		ifFalse: [
			self position: oldPosition.
			^ ''].
]

{ #category : #parsing }
XMLURIParser >> parseUserInfo [
	| userInfo oldPosition |

	oldPosition := self position.
	userInfo := self nextPercentEncodedDelimitedBy: UserInfoDelimiters.
	(self peekFor: $@)
		ifTrue: [^ userInfo]
		ifFalse: [
			self position: oldPosition.
			^ ''].
]

{ #category : #private }
XMLURIParser >> peek [
	self atEnd
		ifTrue: [^ nil]
		ifFalse: [^ readStream peek]
]

{ #category : #private }
XMLURIParser >> peekFor: aCharacter [
	self peek == aCharacter
		ifTrue: [
			self next.
			^ true]
		ifFalse: [^ false]
]

{ #category : #private }
XMLURIParser >> position [
	^ readStream position
]

{ #category : #private }
XMLURIParser >> position: anInteger [
	readStream position: anInteger
]
