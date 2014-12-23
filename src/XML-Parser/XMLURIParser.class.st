"
This is a basic URI parser that can split a URI into scheme, host (with port), path, query string, and fragment.
"
Class {
	#name : #XMLURIParser,
	#superclass : #Object,
	#instVars : [
		'uriStream',
		'writeStream'
	],
	#category : #'XML-Parser-URI'
}

{ #category : #'instance creation' }
XMLURIParser class >> on: aString [
	^ self new uri: aString
]

{ #category : #private }
XMLURIParser >> parseDoubleSlashOrReset [
	2 timesRepeat: [
		(uriStream atEnd not
			and: [uriStream peek == $/])
				ifTrue: [uriStream next]
				ifFalse: [
					uriStream reset.
					^ false]].
	^ true.
]

{ #category : #parsing }
XMLURIParser >> parseFragment [
	^ self
		parseUpToAnyNotSkipping: ''
		startingAfter: $#
]

{ #category : #parsing }
XMLURIParser >> parseHostAfterScheme: aScheme [
	^ (aScheme notEmpty
		or: [self parseDoubleSlashOrReset])
		ifTrue: [(self parseUpToAnyNotSkipping: ':/?#') asLowercase]
		ifFalse: [''].
]

{ #category : #parsing }
XMLURIParser >> parsePath [
	^ self parseUpToAnyNotSkipping: '?#'
]

{ #category : #parsing }
XMLURIParser >> parsePort [
	(uriStream atEnd not
		and: [uriStream peek == $:])
		ifFalse: [^ nil].

	^ XMLIntegerReader
		readFrom:
			(self
				parseUpToAnyNotSkipping: '/?#'
				startingAfter: $:) readStream
		withBase: 10.
]

{ #category : #parsing }
XMLURIParser >> parseQueryString [
	^ self
		parseUpToAnyNotSkipping: '#'
		startingAfter: $?
]

{ #category : #parsing }
XMLURIParser >> parseScheme [
	| scheme |

	scheme := uriStream upTo: $:.
	^ self parseDoubleSlashOrReset
		ifTrue: [scheme asLowercase]
		ifFalse: [''].

	
	
		
]

{ #category : #private }
XMLURIParser >> parseUpToAnyNotSkipping: aCollection [
	^ self
		parseUpToAnyNotSkipping: aCollection
		startingAfter: nil
]

{ #category : #private }
XMLURIParser >> parseUpToAnyNotSkipping: aCollection startingAfter: aCharacter [
	aCharacter ifNotNil: [
		(uriStream atEnd not
			and: [uriStream peek == aCharacter])
			ifFalse: [^ ''].
		uriStream next].

	^ aCollection
		ifEmpty: [uriStream upToEnd]
		ifNotEmpty: [
			writeStream reset.
			[uriStream atEnd
				or: [aCollection includes: uriStream peek]]
				whileFalse: [writeStream nextPut: uriStream next].
			writeStream contents].
]

{ #category : #accessing }
XMLURIParser >> uri: aString [
	uriStream := aString readStream.
	writeStream := (String new: aString size) writeStream.
]
