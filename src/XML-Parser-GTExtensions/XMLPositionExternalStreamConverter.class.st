"
This class converts an external stream into a string with line endings normalized to CRs (the Pharo/Squeak LE) and decodes it from any of the supported character encodings.
"
Class {
	#name : #XMLPositionExternalStreamConverter,
	#superclass : #Object,
	#instVars : [
		'streamReader',
		'outputStream',
		'writeStream'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #converting }
XMLPositionExternalStreamConverter class >> convert: aStringOrStream [
	^ (self on: aStringOrStream) convert
]

{ #category : #converting }
XMLPositionExternalStreamConverter class >> on: aStringOrStream [
	^ self
		on: aStringOrStream
		readLimit: XMLParserLimits defaultReadLimit
]

{ #category : #'instance creation' }
XMLPositionExternalStreamConverter class >> on: aStringOrStream readLimit: aReadLimit [
	^ self new
		setStream:
			(aStringOrStream isStream
				ifTrue: [aStringOrStream]
				ifFalse: [aStringOrStream readStream])
		readLimit: aReadLimit
]

{ #category : #converting }
XMLPositionExternalStreamConverter >> convert [
	^ self
		detectCurrentEncoding;
		nextXMLDeclaration;
		upToEnd
]

{ #category : #'private ' }
XMLPositionExternalStreamConverter >> detectCurrentEncoding [
	streamReader detectCurrentEncoding

]

{ #category : #'private ' }
XMLPositionExternalStreamConverter >> expectNextAll: aString [
	aString do: [:each |
		self next == each
			ifFalse: [^ nil]].
	^ aString.
]

{ #category : #'private ' }
XMLPositionExternalStreamConverter >> next [
	^ streamReader next
		ifNotNil: [:nextChar | outputStream nextPut: nextChar]
]

{ #category : #'private ' }
XMLPositionExternalStreamConverter >> nextXMLAttributeNamed: anAttributeName [
	| quote nextChar |

	self skipSeparators.
	(self expectNextAll: anAttributeName)
		ifNil: [^ nil].

	self skipSeparators.
	self next == $=
		ifFalse: [^ nil].
	self skipSeparators.

	((quote := self next) == $"
		or: [quote == $'])
		ifFalse: [^ nil].

	writeStream reset.
	[(nextChar := self next) isNil
		or: [nextChar == quote]]
		whileFalse: [writeStream nextPut: nextChar].

	nextChar
		ifNil: [^ nil]
		ifNotNil: [^ writeStream contents].
]

{ #category : #'private ' }
XMLPositionExternalStreamConverter >> nextXMLDeclaration [
	self skipSeparators.
	(self expectNextAll: '<?xml')
		ifNil: [^ self].

	self skipSeparators.
	(self nextXMLAttributeNamed: 'version')
		ifNil: [^ self].

	self skipSeparators.
	(self nextXMLAttributeNamed: 'encoding')
		ifNotNil: [:encodingName | streamReader convertFromEncoding: encodingName].
]

{ #category : #'private ' }
XMLPositionExternalStreamConverter >> peek [
	^ streamReader peek
]

{ #category : #initialization }
XMLPositionExternalStreamConverter >> setStream: aStream readLimit: aReadLimit [
	streamReader :=
		XMLNestedStreamReader
			on: (XMLDecodingReadStreamAdapter onExternalStream: aStream)
			readLimit: aReadLimit.
	"this is the preferred LE char for Pharo/Squeak"
	streamReader normalizedLineEndingChar: Character cr.

	outputStream := (String new: aReadLimit) writeStream.
	writeStream := (String new: 128) writeStream.
]

{ #category : #'private ' }
XMLPositionExternalStreamConverter >> skipSeparators [
	[self peek xmlParserIsSeparator]
		whileTrue: [self next]
]

{ #category : #'private ' }
XMLPositionExternalStreamConverter >> upToEnd [
	[self next notNil] whileTrue.
	^ outputStream contents.
]
