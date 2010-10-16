"
This is a wide (multibyte) character code table. It is effectively a tree of byte tables with the leafs at level 4.
"
Class {
	#name : #XMLWideCharacterCodeTable,
	#superclass : #XMLCharacterCodeTable,
	#category : #'XML-Parser-Utilities'
}

{ #category : #'instance creation' }
XMLWideCharacterCodeTable class >> byteMap: aByteMap codeIndexes: aCodeIndexList size: aSize [
	^ self basicNew
		setByteMap: aByteMap
		codeIndexes: aCodeIndexList
		size: aSize
]

{ #category : #accessing }
XMLWideCharacterCodeTable >> at: aCharacterCode ifAbsent: aBlock [
	| table |

	table := codeTable.
	self
		bytesFrom: aCharacterCode
		do: [:each | (table := table at: each) ifNil: [^ aBlock value]]
		lastByte: [:lastByte | ^ (table at: lastByte) ifNil: aBlock].
]

{ #category : #accessing }
XMLWideCharacterCodeTable >> at: aCharacterCode put: aValue [
	| table |

	table := codeTable.
	self
		bytesFrom: aCharacterCode
		do: [:each |
			table := (table at: each) ifNil: [table at: each put: self newByteIndexedTable]]
		lastByte: [:lastByte |
			(table at: lastByte)
				ifNil: [self addCodeIndex: aCharacterCode].
			^ table at: lastByte put: aValue].
]

{ #category : #enumerating }
XMLWideCharacterCodeTable >> bytesFrom: aCharacterCode do: aBlock lastByte: aSecondBlock [
	aBlock value: ((aCharacterCode bitAnd: 16rFF000000) bitShift: -24) + 1.
	aBlock value: ((aCharacterCode bitAnd: 16r00FF0000) bitShift: -16) + 1.
	aBlock value: ((aCharacterCode bitAnd: 16r0000FF00) bitShift: -8) + 1.
	aSecondBlock value: (aCharacterCode bitAnd: 16r000000FF) + 1.
]

{ #category : #testing }
XMLWideCharacterCodeTable >> isWideCharacterCodeTable [
	^ true
]

{ #category : #removing }
XMLWideCharacterCodeTable >> removeAt: aCharacterCode ifAbsent: aBlock [
	| table value |

	table := codeTable.
	self
		bytesFrom: aCharacterCode
		do: [:each | (table := table at: each) ifNil: [^ aBlock value]]
		lastByte: [:lastByte |
			(value := table at: lastByte)
				ifNil: [^ aBlock value].
			table at: lastByte put: nil.
			self removeCodeIndex: aCharacterCode.
			^ value].
]

{ #category : #initialization }
XMLWideCharacterCodeTable >> setByteMap: aByteMap codeIndexes: aCodeIndexList size: aSize [
	((((codeTable := self newByteIndexedTable)
		at: 1 put: self newByteIndexedTable))
			at: 1 put: self newByteIndexedTable)
				at: 1 put: aByteMap.
	codeIndexes := aCodeIndexList.
	tally := aSize.
]
