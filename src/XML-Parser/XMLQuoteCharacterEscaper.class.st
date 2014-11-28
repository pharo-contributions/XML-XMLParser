"
An escaper for $' and $"" characters used for entities in literal contexts.
"
Class {
	#name : #XMLQuoteCharacterEscaper,
	#superclass : #Object,
	#instVars : [
		'streamReader'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #'instance creation' }
XMLQuoteCharacterEscaper class >> for: aStreamReader [
	^ self new streamReader: aStreamReader
]

{ #category : #escaping }
XMLQuoteCharacterEscaper >> nextCharacter: aCharacter [
	aCharacter ==  $"
		ifTrue: [
			self pushBack: '#34;'.
			^ $&].
	aCharacter == $'
		ifTrue: [
			self pushBack: '#39;'.
			^ $&].
	^ aCharacter.
]

{ #category : #private }
XMLQuoteCharacterEscaper >> pushBack: aString [
	streamReader pushBack: aString
]

{ #category : #accessing }
XMLQuoteCharacterEscaper >> streamReader: aStreamReader [
	streamReader := aStreamReader
]
