Extension { #name : #Collection }

{ #category : #'*XML-Parser' }
Collection >> includesXMLQualifiedName: aQualifiedName orLocalName: aLocalName [
	"optimized"
	1 to: self size do: [:i |
		((self at: i)
			isXMLQualifiedName: aQualifiedName
			orLocalName: aLocalName)
			ifTrue: [^ true]].
	^ false.
]
