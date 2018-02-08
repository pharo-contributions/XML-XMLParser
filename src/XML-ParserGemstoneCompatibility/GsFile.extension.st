Extension { #name : #GsFile }

{ #category : #'*XML-ParserGemstoneCompatibility' }
GsFile >> isStream [
	"needed so #parse: and similar messages can accept GsFile arguments"
	^ true
]

{ #category : #'*XML-ParserGemstoneCompatibility' }
GsFile >> isXMLBinaryOrExternalStream [
	^ self isExternal
]

{ #category : #'*XML-ParserGemstoneCompatibility' }
GsFile >> upToEnd [
	"needed for compatibility with XMLReadStreamAdapter
	(GsFile>>#contents works like #upToEnd, so this is OK)"
	^ self contents
]
