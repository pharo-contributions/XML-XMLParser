Extension { #name : #String }

{ #category : #'*xml-parser' }
String >> applyLanguageInfomation: languageEnvironment [
	
	| leadingChar |
	leadingChar := languageEnvironment leadingChar.
	self withIndexDo: [:each :idx |
		each asciiValue > 255
			ifTrue: [self at: idx put: (Character leadingChar: leadingChar code: each asUnicode)]]
]

{ #category : #'*xml-parser' }
String >> qualifyName: aLocalName [
	^ self, ':', aLocalName.
]

{ #category : #'*xml-parser' }
String >> splitQualifiedNameInto: aTwoArgumentBlock [
	"Split the name into namespace prefix and local name (the block arguments)."

	| i |
	i := self lastIndexOf: $: startingAt: self size ifAbsent: [0].
	^ aTwoArgumentBlock
		value: ((i > 1) ifTrue: [self copyFrom: 1 to: (i - 1)] ifFalse: [nil])
		value: (self copyFrom: i + 1 to: self size)
]
