Extension { #name : #Collection }

{ #category : #'*XML-Parser' }
Collection >> includesQualifiedName: aQualifiedName orLocalName: aLocalName [
	self do: [:each |
		(each
			isQualifiedName: aQualifiedName
			orLocalName: aLocalName)
			ifTrue: [^ true]].
	^ false.
]
