Class {
	#name : 'XMLSingleCharacterReadStreamTest',
	#superclass : 'XMLAbstractReadStreamTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLSingleCharacterReadStreamTest class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
XMLSingleCharacterReadStreamTest >> character [
	^ $!
]

{ #category : 'accessing' }
XMLSingleCharacterReadStreamTest >> inputCollection [
	^ self character asString
]

{ #category : 'instance creation' }
XMLSingleCharacterReadStreamTest >> newStreamOn: aCollection [
	^ self streamClass on: aCollection first
]

{ #category : 'accessing' }
XMLSingleCharacterReadStreamTest >> streamClass [
	^ XMLSingleCharacterReadStream
]
