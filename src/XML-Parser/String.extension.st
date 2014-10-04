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
String >> qualifiedNameLocalPart [
	^ self qualifiedNameLocalPartFromPrefix: self qualifiedNamePrefix
]

{ #category : #'*XML-Parser' }
String >> qualifiedNameLocalPartFromPrefix: aPrefix [
	"optimized"
	aPrefix size > 0
		ifTrue: [^ self copyFrom: aPrefix size + 2 to: self size]
		ifFalse: [^ self]
]

{ #category : #'*XML-Parser' }
String >> qualifiedNamePrefix [
	"Split the name into namespace prefix
	(Optimized code)"
	| i |

	i := self size - 1.
	[i > 1]
		whileTrue: [
			((self at: i) == $:)
				ifTrue: [^ (self copyFrom: 1 to: i - 1)].
			i := i - 1].
	^ ''.
]
