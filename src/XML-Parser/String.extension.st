Extension { #name : #String }

{ #category : #'*XML-Parser' }
String >> asXMLString [
	^ XMLString string: self
]

{ #category : #'*XML-Parser' }
String >> asXMLURI [
	^ XMLURI fromString: self
]

{ #category : #'*XML-Parser' }
String >> splitQualifiedNameInto: aTwoArgumentBlock [
	"Split the name into namespace prefix and local name (the block arguments).
	(Optimized code; profile when modifying.)"
	| i |

	i := self size - 1.
	[i > 1]
		whileTrue: [
			((self at: i) == $:)
				ifTrue: [
					^ aTwoArgumentBlock
						value: (self copyFrom: 1 to: i - 1)
						value: (self copyFrom: i + 1 to: self size)].
			i := i - 1].
	^ aTwoArgumentBlock
		value: ''
		value: self
]
