Extension { #name : #String }

{ #category : #'*xml-parser' }
String >> applyLanguageInfomation: languageEnvironment [
	
	| leadingChar |
	leadingChar := languageEnvironment leadingChar.
	self withIndexDo: [:each :idx |
		each asciiValue > 255
			ifTrue: [self at: idx put: (Character leadingChar: leadingChar code: each asUnicode)]]
]
