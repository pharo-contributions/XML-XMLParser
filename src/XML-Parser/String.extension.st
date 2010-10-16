Extension { #name : #String }

{ #category : #'*xml-parser' }
String >> applyLanguageInfomation: aLanguageEnvironment [
	| leadingChar |

	leadingChar := aLanguageEnvironment leadingChar.
	self withIndexDo: [:each :i |
		each asciiValue > 255
			ifTrue: [
				self
					at: i
					put: (Character leadingChar: leadingChar code: each asUnicode)]]
]

{ #category : #'*xml-parser' }
String >> asXMLString [
	^ XMLString string: self
]

{ #category : #'*xml-parser' }
String >> splitQualifiedNameInto: aTwoArgumentBlock [
	"Split the name into namespace prefix and local name (the block arguments)."
	| i |

	i := self size.
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
