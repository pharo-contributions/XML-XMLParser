"
This class is a parser that can extract the scheme, user info, host, port, path segments, query (as an OrderedCollection of associations), and fragment of a URI. It does not handle percent decoding and raises no errors.
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
XMLURIParser >> nextDelimitedBy: aCollection [
	writeStream reset.
	[self atEnd
		or: [aCollection includes: self peek]]
		whileFalse: [writeStream nextPut: self next].
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
		ifTrue: [^ readStream upToEnd]
		ifFalse: [^ '']
]

{ #category : #parsing }
XMLURIParser >> parseHost [
	| host |

	self peek == $[
		ifTrue: [
			host := (self nextDelimitedBy: ']') copyWith: $].
			self peekFor: $]]
		ifFalse: [host := self nextDelimitedBy: HostDelimiters].
	^ host.
]

{ #category : #parsing }
XMLURIParser >> parsePathSegments [
	| pathSegments segment |

	pathSegments := OrderedCollection new.

	segment := self nextDelimitedBy: PathDelimiters.
	[self peekFor: $/]
		whileTrue: [
			pathSegments addLast: segment.
			segment := self nextDelimitedBy: PathDelimiters].
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
				XMLIntegerReader
					readFrom: readStream
					withBase: 10.
			[self atEnd
				or: [PathDelimiters includes: self peek]]
				whileFalse: [self next]].
	^ port.
]

{ #category : #parsing }
XMLURIParser >> parseQuery [
	"parse the query as an OrderedCollection of name=value associations
	to handle multiple values for the same key and different encoded keys
	that later percent/plus decode to the same key"

	| query key value |

	(self peekFor: $?)
		ifFalse: [^ OrderedCollection new: 0].

	query := OrderedCollection new.
	[self atEnd
		or: [(key := self nextDelimitedBy: QueryKeyDelimiters) isEmpty
			and: [self peek == $#]]]
		whileFalse: [| hasValue |
			(hasValue := self peekFor: $=)
				ifTrue: [value := self nextDelimitedBy: QueryValueDelimiters]
				ifFalse: [value := ''].
			(key notEmpty
				or: [hasValue])
				ifTrue: [query addLast: key -> value].
			self peekFor: $&].

	^ query.
]

{ #category : #parsing }
XMLURIParser >> parseScheme [
	| oldPosition scheme |

	oldPosition := self position.
	scheme := self nextDelimitedBy: SchemeDelimiters.
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
	userInfo := self nextDelimitedBy: UserInfoDelimiters.
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
	(self atEnd not
		and: [self peek = aCharacter])
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
