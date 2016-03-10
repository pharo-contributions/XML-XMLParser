Extension { #name : #StandardOrderedDictionary }

{ #category : #'*XML-Parser' }
StandardOrderedDictionary >> errorDuplicateXMLAttribute: aKey [
	XMLWellFormednessException
		formatSignal: 'Duplicate attribute "{1}" in element'
		with: aKey
]

{ #category : #'*XML-Parser' }
StandardOrderedDictionary >> errorDuplicateXMLNamespace: aKey [
	aKey
		ifEmpty: [
			XMLWellFormednessException signal:
				'Duplicate default namespace declaration in element']
		ifNotEmpty: [
			XMLWellFormednessException
				formatSignal: 'Duplicate namespace declaration "xmlns:{1}" in element'
				with: aKey]
]

{ #category : #'*XML-Parser' }
StandardOrderedDictionary >> xmlAttributeAt: aKey put: aValue [
	"should be identical to at:put: except with an ifFalse: block
	added to handle duplicates"
	| oldSize |

	oldSize := dictionary size.
	dictionary at: aKey put: aValue.
	dictionary size > oldSize
		ifTrue: [
			orderedKeys size > oldSize
				ifFalse: [self growOrderedKeys].
			orderedKeys at: oldSize + 1 put: aKey]
		ifFalse: [self errorDuplicateXMLAttribute: aKey].
	^ aValue.
]

{ #category : #'*XML-Parser' }
StandardOrderedDictionary >> xmlNamespaceAt: aKey put: aValue [
	"should be identical to at:put: except with an ifFalse: block
	added to handle duplicates"
	| oldSize |

	oldSize := dictionary size.
	dictionary at: aKey put: aValue.
	dictionary size > oldSize
		ifTrue: [
			orderedKeys size > oldSize
				ifFalse: [self growOrderedKeys].
			orderedKeys at: oldSize + 1 put: aKey]
		ifFalse: [self errorDuplicateXMLNamespace: aKey].
	^ aValue.
]
