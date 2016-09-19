Extension { #name : #GsFile }

{ #category : #'*XML-Parser-GemstoneCompatibility' }
GsFile >> isStream [
	"needed so #parse: and similar messages can accept GsFile arguments"
	^ true
]

{ #category : #'*XML-Parser-GemstoneCompatibility' }
GsFile >> upToEnd [
	"needed for compatibility with XMLReadStreamAdapter
	(GsFile>>#contents works like #upToEnd, so this is OK)"
	^ self contents
]
