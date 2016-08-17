Extension { #name : #Collection }

{ #category : #'*XML-Parser' }
Collection >> asXMLAttributeSpec [
	^ XMLSimpleAttributeSpec attributes: self
]

{ #category : #'*XML-Parser' }
Collection >> includesXMLName: aName [
	"optimized with do: instead of anySatisfy:"
	self do: [:each |
		(aName isXMLQualifiedOrLocalName: each)
			ifTrue: [^ true]].
	^ false.
]
