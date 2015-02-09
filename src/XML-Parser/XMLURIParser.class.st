"
This is a basic URI parser that can split a URI into scheme, host (with port), path, query string, and fragment.
"
Class {
	#name : #XMLURIParser,
	#superclass : #Object,
	#instVars : [
		'writeStream',
		'readStream'
	],
	#category : #'XML-Parser-URI'
}

{ #category : #'instance creation' }
XMLURIParser class >> on: aString [
	^ self new on: aString
]

{ #category : #initialization }
XMLURIParser >> on: aString [
	readStream := aString readStream.
	writeStream := (String new: aString size) writeStream.
]

{ #category : #parsing }
XMLURIParser >> parseAuthorityPrefix [
	| oldPosition |

	oldPosition := readStream position.
	((self parseNext: $/)
		and: [self parseNext: $/])
		ifTrue: [^ true]
		ifFalse: [
			readStream position: oldPosition.
			^ false].
]

{ #category : #parsing }
XMLURIParser >> parseFragment [
	^ self parseUpToEndAfterNext: $#
]

{ #category : #parsing }
XMLURIParser >> parseHost [
	^ (self parseUpToAnyNotSkipping: ':/?#') asLowercase
]

{ #category : #private }
XMLURIParser >> parseNext: aCharacter [
	(readStream atEnd not
		and: [readStream peek == aCharacter])
		ifTrue: [
			readStream next.
			^ true]
		ifFalse: [^ false]
]

{ #category : #parsing }
XMLURIParser >> parsePath [
	^ self parseUpToAnyNotSkipping: '?#'
]

{ #category : #parsing }
XMLURIParser >> parsePort [
	(self parseNext: $:)
		ifTrue: [
			^ XMLIntegerReader
				readFrom: (self parseUpToAnyNotSkipping: '/?#') readStream
				withBase: 10]
		ifFalse: [^ nil]
]

{ #category : #parsing }
XMLURIParser >> parseQueryString [
	^ self
		parseUpToAnyNotSkipping: '#'
		afterNext: $?
]

{ #category : #parsing }
XMLURIParser >> parseScheme [
	| scheme |

	scheme := self parseUpToAnyNotSkipping: ':/@?#'.
	(self parseNext: $:)
		ifTrue: [^ scheme asLowercase]
		ifFalse: [
			readStream reset.
			^ ''].
]

{ #category : #private }
XMLURIParser >> parseUpToAnyNotSkipping: aCollection [
	^ self
		parseUpToAnyNotSkipping: aCollection
		afterNext: nil
]

{ #category : #private }
XMLURIParser >> parseUpToAnyNotSkipping: aCollection afterNext: aCharacter [
	aCharacter
		ifNotNil: [
			(self parseNext: aCharacter)
				ifFalse: [^ '']].

	writeStream reset.
	[readStream atEnd
		or: [aCollection includes: readStream peek]]
		whileFalse: [writeStream nextPut: readStream next].
	^ writeStream contents.
]

{ #category : #private }
XMLURIParser >> parseUpToEndAfterNext: aCharacter [
	(self parseNext: aCharacter)
		ifTrue: [^ readStream upToEnd]
		ifFalse: [^ '']
]

{ #category : #parsing }
XMLURIParser >> parseUserInfo [
	| userInfo oldPosition |

	oldPosition := readStream position.
	userInfo := self parseUpToAnyNotSkipping: ':/@?#'.
	(self parseNext: $@)
		ifTrue: [^ userInfo]
		ifFalse: [
			readStream position: oldPosition.
			^ ''].
]
