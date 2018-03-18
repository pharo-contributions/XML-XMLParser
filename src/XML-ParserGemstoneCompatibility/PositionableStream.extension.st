Extension { #name : #PositionableStream }

{ #category : #'*XML-ParserGemstoneCompatibility' }
PositionableStream >> isBinary [
	"needed for GZipReadStream and Zinc"
	^ self _collection isKindOf: ByteArray
]

{ #category : #'*XML-ParserGemstoneCompatibility' }
PositionableStream >> isXMLBinaryOrExternalStream [
	"some GS PositionableStream subclasses (like AnsiReadStream) override
	#isBinary to only treat ByteArray (not its subclasses) streams as
	binary, so we replace the #isBinary-based superclass version with this one,
	which skips #isBinary and sends #isKindOf: to catch ByteArray subclasses
	like Utf8"
	^ self _collection isKindOf: ByteArray
]
