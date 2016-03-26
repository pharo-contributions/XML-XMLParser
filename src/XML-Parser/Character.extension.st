Extension { #name : #Character }

{ #category : #'*XML-Parser' }
Character >> isXMLChar [
	"Range tests are faster and use less memory than a BitmapCharacterSet, and
	a temp is used because Character in newer SpurVM images has no 'value'
	inst var.
	
	Char ::=
		#x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]"

	| tempValue |

	(tempValue := self asciiValue) >= 16r20
		ifTrue: [
			tempValue <= 16rD7FF
				ifTrue: [^ true].

			tempValue >= 16rE000
				ifFalse: [^ false].
			tempValue <= 16rFFFD
				ifTrue: [^ true].

			tempValue >= 16r10000
				ifFalse: [^ false].
			^ tempValue <= 16r10FFFF].

	tempValue = 16r9
		ifTrue: [^ true].
	tempValue = 16rA
		ifTrue: [^ true].
	^ tempValue = 16rD.
]

{ #category : #'*XML-Parser' }
Character >> isXMLNCNameChar [
	"should be the same as isXMLNameChar except without a test for $:"

	| tempValue |

	(tempValue := self asciiValue) <= 16r7A "$z asciiValue hex"
		ifTrue: [
			tempValue >= 16r61 "$a asciiValue hex"
				ifTrue: [^ true].

			tempValue >= 16r41 "$A asciiValue hex"
				ifTrue: [
					tempValue <= 16r5A "$Z asciiValue hex"
						ifTrue: [^ true].
					^ tempValue = 16r5F]. "$_ asciiValue hex"

			tempValue >= 16r30 "$0 asciiValue hex"
				ifTrue: [^ tempValue <= 16r39]. "$9 asciiValue hex; no $: test"

			tempValue = 16r2E "$. asciiValue hex"
				ifTrue: [^ true].
			^ tempValue = 16r2D]. "$- asciiValue hex"

	tempValue >= 16rC0
		ifFalse: [^ tempValue = 16rB7].
	tempValue <= 16rD6
		ifTrue: [^ true].

	tempValue >= 16rD8
		ifFalse: [^ false].
	tempValue <= 16rF6
		ifTrue: [^ true].

	tempValue >= 16rF8
		ifFalse: [^ false].
	tempValue <= 16r2FF
		ifTrue: [^ true].

	tempValue >= 16r300
		ifFalse: [^ false].
	tempValue <= 16r36F
		ifTrue: [^ true].

	tempValue >= 16r370
		ifFalse: [^ false].
	tempValue <= 16r37D
		ifTrue: [^ true].

	tempValue >= 16r37F
		ifFalse: [^ false].
	tempValue <= 16r1FFF
		ifTrue: [^ true].

	tempValue >= 16r200C
		ifFalse: [^ false].
	tempValue <= 16r200D
		ifTrue: [^ true].

	tempValue >= 16r203F
		ifFalse: [^ false].
	tempValue <= 16r2040
		ifTrue: [^ true].

	tempValue >= 16r2070
		ifFalse: [^ false].
	tempValue <= 16r218F
		ifTrue: [^ true].

	tempValue >= 16r2C00
		ifFalse: [^ false].
	tempValue <= 16r2FEF
		ifTrue: [^ true].

	tempValue >= 16r3001
		ifFalse: [^ false].
	tempValue <= 16rD7FF
		ifTrue: [^ true].

	tempValue >= 16rF900
		ifFalse: [^ false].
	tempValue <= 16rFDCF
		ifTrue: [^ true].

	tempValue >= 16rFDF0
		ifFalse: [^ false].
	tempValue <= 16rFFFD
		ifTrue: [^ true].

	tempValue >= 16r10000
		ifFalse: [^ false].
	^ tempValue <= 16rEFFFF.
]

{ #category : #'*XML-Parser' }
Character >> isXMLNCNameStartChar [
	"should be the same as isXMLNameChar except without a test for $:"

	| tempValue |

	(tempValue := self asciiValue) <= 16r7A "$z asciiValue hex"
		ifTrue: [
			tempValue >= 16r61 "$a asciiValue hex"
				ifTrue: [^ true].

			tempValue >= 16r41 "$A asciiValue hex"
				ifFalse: [^ false].
			tempValue <= 16r5A "$Z asciiValue hex"
				ifTrue: [^ true].

			^ tempValue = 16r5F]. "$_ asciiValue hex; no $: test"

	tempValue >= 16rC0
		ifFalse: [^ false].
	tempValue <= 16rD6
		ifTrue: [^ true].

	tempValue >= 16rD8
		ifFalse: [^ false].
	tempValue <= 16rF6
		ifTrue: [^ true].

	tempValue >= 16rF8
		ifFalse: [^ false].
	tempValue <= 16r2FF
		ifTrue: [^ true].

	tempValue >= 16r370
		ifFalse: [^ false].
	tempValue <= 16r37D
		ifTrue: [^ true].

	tempValue >= 16r37F
		ifFalse: [^ false].
	tempValue <= 16r1FFF
		ifTrue: [^ true].

	tempValue >= 16r200C
		ifFalse: [^ false].
	tempValue <= 16r200D
		ifTrue: [^ true].

	tempValue >= 16r2070
		ifFalse: [^ false].
	tempValue <= 16r218F
		ifTrue: [^ true].

	tempValue >= 16r2C00
		ifFalse: [^ false].
	tempValue <= 16r2FEF
		ifTrue: [^ true].

	tempValue >= 16r3001
		ifFalse: [^ false].
	tempValue <= 16rD7FF
		ifTrue: [^ true].

	tempValue >= 16rF900
		ifFalse: [^ false].
	tempValue <= 16rFDCF
		ifTrue: [^ true].

	tempValue >= 16rFDF0
		ifFalse: [^ false].
	tempValue <= 16rFFFD
		ifTrue: [^ true].

	tempValue >= 16r10000
		ifFalse: [^ false].
	^ tempValue <= 16rEFFFF.
]

{ #category : #'*XML-Parser' }
Character >> isXMLNameChar [
	"Range tests are faster and use less memory than a BitmapCharacterSet, and
	a temp is used because Character in newer SpurVM images has no 'value'
	inst var.
	
	NameStartChar ::=
		':' | [A-Z] | '_' | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] |
		[#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] |
		[#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] |
		[#x10000-#xEFFFF]
	NameChar ::=
		NameStartChar | '-' | '.' | [0-9] | #xB7 | [#x0300-#x036F] |
		[#x203F-#x2040]"

	| tempValue |

	(tempValue := self asciiValue) <= 16r7A "$z asciiValue hex"
		ifTrue: [
			tempValue >= 16r61 "$a asciiValue hex"
				ifTrue: [^ true].

			tempValue >= 16r41 "$A asciiValue hex"
				ifTrue: [
					tempValue <= 16r5A "$Z asciiValue hex"
						ifTrue: [^ true].
					^ tempValue = 16r5F]. "$_ asciiValue hex"

			tempValue >= 16r30 "$0 asciiValue hex"
				ifTrue: [
					tempValue <= 16r39 "$9 asciiValue hex"
						ifTrue: [^ true].
					^ tempValue = 16r3A]. "$: asciiValue hex"

			tempValue = 16r2E "$. asciiValue hex"
				ifTrue: [^ true].
			^ tempValue = 16r2D]. "$- asciiValue hex"

	tempValue >= 16rC0
		ifFalse: [^ tempValue = 16rB7].
	tempValue <= 16rD6
		ifTrue: [^ true].

	tempValue >= 16rD8
		ifFalse: [^ false].
	tempValue <= 16rF6
		ifTrue: [^ true].

	tempValue >= 16rF8
		ifFalse: [^ false].
	tempValue <= 16r2FF
		ifTrue: [^ true].

	tempValue >= 16r300
		ifFalse: [^ false].
	tempValue <= 16r36F
		ifTrue: [^ true].

	tempValue >= 16r370
		ifFalse: [^ false].
	tempValue <= 16r37D
		ifTrue: [^ true].

	tempValue >= 16r37F
		ifFalse: [^ false].
	tempValue <= 16r1FFF
		ifTrue: [^ true].

	tempValue >= 16r200C
		ifFalse: [^ false].
	tempValue <= 16r200D
		ifTrue: [^ true].

	tempValue >= 16r203F
		ifFalse: [^ false].
	tempValue <= 16r2040
		ifTrue: [^ true].

	tempValue >= 16r2070
		ifFalse: [^ false].
	tempValue <= 16r218F
		ifTrue: [^ true].

	tempValue >= 16r2C00
		ifFalse: [^ false].
	tempValue <= 16r2FEF
		ifTrue: [^ true].

	tempValue >= 16r3001
		ifFalse: [^ false].
	tempValue <= 16rD7FF
		ifTrue: [^ true].

	tempValue >= 16rF900
		ifFalse: [^ false].
	tempValue <= 16rFDCF
		ifTrue: [^ true].

	tempValue >= 16rFDF0
		ifFalse: [^ false].
	tempValue <= 16rFFFD
		ifTrue: [^ true].

	tempValue >= 16r10000
		ifFalse: [^ false].
	^ tempValue <= 16rEFFFF.
]

{ #category : #'*XML-Parser' }
Character >> isXMLNameStartChar [
	"Range tests are faster and use less memory than a BitmapCharacterSet, and
	a temp is used because Character in newer SpurVM images has no 'value'
	inst var.
	
	NameStartChar ::=
		':' | [A-Z] | '_' | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] |
		[#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] |
		[#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] |
		[#x10000-#xEFFFF]"

	| tempValue |

	(tempValue := self asciiValue) <= 16r7A "$z asciiValue hex"
		ifTrue: [
			tempValue >= 16r61 "$a asciiValue hex"
				ifTrue: [^ true].

			tempValue >= 16r41 "$A asciiValue hex"
				ifTrue: [
					tempValue <= 16r5A "$Z asciiValue hex"
						ifTrue: [^ true].
					^ tempValue = 16r5F]. "$_ asciiValue hex"
	
			^ tempValue = 16r3A]. "$: asciiValue hex"

	tempValue >= 16rC0
		ifFalse: [^ false].
	tempValue <= 16rD6
		ifTrue: [^ true].

	tempValue >= 16rD8
		ifFalse: [^ false].
	tempValue <= 16rF6
		ifTrue: [^ true].

	tempValue >= 16rF8
		ifFalse: [^ false].
	tempValue <= 16r2FF
		ifTrue: [^ true].

	tempValue >= 16r370
		ifFalse: [^ false].
	tempValue <= 16r37D
		ifTrue: [^ true].

	tempValue >= 16r37F
		ifFalse: [^ false].
	tempValue <= 16r1FFF
		ifTrue: [^ true].

	tempValue >= 16r200C
		ifFalse: [^ false].
	tempValue <= 16r200D
		ifTrue: [^ true].

	tempValue >= 16r2070
		ifFalse: [^ false].
	tempValue <= 16r218F
		ifTrue: [^ true].

	tempValue >= 16r2C00
		ifFalse: [^ false].
	tempValue <= 16r2FEF
		ifTrue: [^ true].

	tempValue >= 16r3001
		ifFalse: [^ false].
	tempValue <= 16rD7FF
		ifTrue: [^ true].

	tempValue >= 16rF900
		ifFalse: [^ false].
	tempValue <= 16rFDCF
		ifTrue: [^ true].

	tempValue >= 16rFDF0
		ifFalse: [^ false].
	tempValue <= 16rFFFD
		ifTrue: [^ true].

	tempValue >= 16r10000
		ifFalse: [^ false].
	^ tempValue <= 16rEFFFF.
]

{ #category : #'*XML-Parser' }
Character >> isXMLSeparator [
	"a temp is used because Character in newer SpurVM images
	has no 'value' inst var"
	| tempValue |

	(tempValue := self asciiValue) = 32 "space"
		ifTrue: [^ true].
	tempValue = 10 "line feed"
		ifTrue: [^ true].
	tempValue = 9 "tab"
		ifTrue: [^ true].
	^ tempValue = 13. "carriage return; no form feeds"
]

{ #category : #'*XML-Parser' }
Character >> isXMLWhitespace [
	"a temp is used because Character in newer SpurVM images
	has no 'value' inst var"
	| tempValue |

	(tempValue := self asciiValue) = 32 "space"
		ifTrue: [^ true].
	tempValue = 10 "line feed"
		ifTrue: [^ true].
	tempValue = 9 "tab"
		ifTrue: [^ true].
	tempValue = 13 "carriage return"
		ifTrue: [^ true].
	^ tempValue = 12. "form feed"
]

{ #category : #'*XML-Parser' }
Character class >> xmlSeparators [
	^ String
		with: 32 asCharacter "space"
		with: 10 asCharacter "lf"
		with: 9 asCharacter "tab"
		with: 13 asCharacter "cr"
]

{ #category : #'*XML-Parser' }
Character >> xmlSplit: aString [
	"faster, portable version"
	| parts |

	parts := OrderedCollection new.
	self
		xmlSplit: aString
		do: [:each | parts addLast: each].
	^ parts.
]

{ #category : #'*XML-Parser' }
Character >> xmlSplit: aString do: aBlock [
	"faster, portable version"
	| start |

	start := 1.
	1 to: aString size do: [:end |
		(aString at: end) == self
			ifTrue: [
				aBlock value: (aString copyFrom: start to: end - 1).
				start := end + 1]].
	start > aString size
		ifTrue: [
			"either aString is empty or it ends with self"
			aBlock value: '']
		ifFalse: [aBlock value: (aString copyFrom: start to: aString size)].
]

{ #category : #'*XML-Parser' }
Character class >> xmlWhitespace [
	^ self xmlSeparators copyWith: 12 asCharacter "form feed"
]
