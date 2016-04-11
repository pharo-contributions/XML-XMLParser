Class {
	#name : #XMLSingleCharacterReadStreamTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLSingleCharacterReadStreamTest >> character [
	^ $!
]

{ #category : #'instance creation' }
XMLSingleCharacterReadStreamTest >> newStreamOnCharacter [
	^ self streamClass on: self character
]

{ #category : #accessing }
XMLSingleCharacterReadStreamTest >> streamClass [
	^ XMLSingleCharacterReadStream
]

{ #category : #tests }
XMLSingleCharacterReadStreamTest >> testAtEnd [
	| stream |

	stream := self newStreamOnCharacter.
	self deny: stream atEnd.

	stream next.
	self assert: stream atEnd.
]

{ #category : #tests }
XMLSingleCharacterReadStreamTest >> testIsBinary [
	self deny: self newStreamOnCharacter isBinary
]

{ #category : #tests }
XMLSingleCharacterReadStreamTest >> testIsStream [
	self assert: self newStreamOnCharacter isStream
]

{ #category : #tests }
XMLSingleCharacterReadStreamTest >> testNext [
	| stream |

	stream := self newStreamOnCharacter.
	self
		assert: stream next = self character;
		assert: stream next isNil.
]

{ #category : #tests }
XMLSingleCharacterReadStreamTest >> testPeek [
	| stream |

	stream := self newStreamOnCharacter.
	self assert: stream peek = self character.

	stream next.
	self assert: stream peek isNil.
]
