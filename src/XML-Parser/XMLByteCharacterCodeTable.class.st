"
This class is a simple byte-indexed character code table with 256 (0-255) entries.
"
Class {
	#name : #XMLByteCharacterCodeTable,
	#superclass : #XMLCharacterCodeTable,
	#category : #'XML-Parser-Utilities'
}

{ #category : #converting }
XMLByteCharacterCodeTable >> asWideCharacterCodeTable [
	^ XMLWideCharacterCodeTable byteMap: codeTable codeIndexes: codeIndexes size: tally
]

{ #category : #accessing }
XMLByteCharacterCodeTable >> at: aCharacterCode ifAbsent: aBlock [
	^ (codeTable at: aCharacterCode + 1) ifNil: aBlock
]

{ #category : #accessing }
XMLByteCharacterCodeTable >> at: aCharacterCode put: aValue [
	| i |

	i := aCharacterCode + 1.
	(codeTable at: i)
		ifNil: [self addCodeIndex: aCharacterCode].

	^ codeTable at: i put: aValue.
]

{ #category : #removing }
XMLByteCharacterCodeTable >> removeAt: aCharacterCode ifAbsent: aBlock [
	| value i |

	i := aCharacterCode + 1.
	(value := codeTable at: i)
		ifNil: [^ aBlock value].
	codeTable at: i put: nil.
	self removeCodeIndex: aCharacterCode.
	^ value.
]
