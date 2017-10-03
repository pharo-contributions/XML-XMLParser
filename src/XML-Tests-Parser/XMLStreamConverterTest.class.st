"
Abstract, do not run.
"
Class {
	#name : #XMLStreamConverterTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #testing }
XMLStreamConverterTest class >> isAbstract [
	^ true
]

{ #category : #testing }
XMLStreamConverterTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
XMLStreamConverterTest >> caseInvertedEncodingNameFrom: anEncodingName [
	| shouldUppercase |

	^ anEncodingName collect: [:each |
		(shouldUppercase ifNil: [shouldUppercase := each isLowercase])
			ifTrue: [
				shouldUppercase := false.
				each asUppercase]
			ifFalse: [
				shouldUppercase := true.
				each asLowercase]]
]

{ #category : #accessing }
XMLStreamConverterTest >> encodingNames [
	^ self streamConverterClass encodingNames
]

{ #category : #accessing }
XMLStreamConverterTest >> encodingNamesWithCaseInversions [
	| encodingNamesWithCaseInversions |

	encodingNamesWithCaseInversions := self encodingNames copy.
	self encodingNames do: [:each |
		"add the case inversion, as well as its inversion"
		encodingNamesWithCaseInversions add:
			(self caseInvertedEncodingNameFrom:
				(encodingNamesWithCaseInversions add:
					(self caseInvertedEncodingNameFrom: each)))].
	^ encodingNamesWithCaseInversions.
]

{ #category : #'instance creation' }
XMLStreamConverterTest >> newStreamConverter [
	^ self streamConverterClass new
]

{ #category : #accessing }
XMLStreamConverterTest >> streamConverterClass [
	^ XMLStreamConverter
]

{ #category : #tests }
XMLStreamConverterTest >> testAsXMLStreamConverter [
	| streamConverter |

	streamConverter := self newStreamConverter.
	self assert: streamConverter asXMLStreamConverter == streamConverter.
]

{ #category : #tests }
XMLStreamConverterTest >> testCanConvertEncoding [
	self encodingNamesWithCaseInversions do: [:each |
		self assert: (self streamConverterClass canConvertEncoding: each)].
	self unconvertableEncodingNames do: [:each |
		self deny: (self streamConverterClass canConvertEncoding: each)].
]

{ #category : #tests }
XMLStreamConverterTest >> testEncoding [
	self encodingNamesWithCaseInversions do: [:each | | streamConverter |
		streamConverter := XMLStreamConverter newForEncoding: each.
		self assert: streamConverter class == self streamConverterClass.
		self assert:
			streamConverter encoding =
				self streamConverterClass primaryEncodingName]
]

{ #category : #tests }
XMLStreamConverterTest >> testIsDefault [
	self deny: self newStreamConverter isDefault
]

{ #category : #tests }
XMLStreamConverterTest >> testIsNull [
	self deny: self newStreamConverter isNull
]

{ #category : #accessing }
XMLStreamConverterTest >> unconvertableEncodingNames [
	^ #('unconvertableEncodingName')
]
