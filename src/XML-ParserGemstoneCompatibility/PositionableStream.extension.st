Extension { #name : #PositionableStream }

{ #category : #'*XML-ParserGemstoneCompatibility' }
PositionableStream >> isBinary [
	"needed for GZipReadStream and Zinc"
	^ self _collection class == ByteArray
]
