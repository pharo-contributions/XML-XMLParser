Class {
	#name : #XMLOrderPreservingDictionaryTest,
	#superclass : #DictionaryTest,
	#category : #'XML-Parser-Tests'
}

{ #category : #testing }
XMLOrderPreservingDictionaryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #coverage }
XMLOrderPreservingDictionaryTest >> classToBeTested [
	^ XMLOrderPreservingDictionary
]

{ #category : #requirements }
XMLOrderPreservingDictionaryTest >> collectionClass [
	^ XMLOrderPreservingDictionary
]

{ #category : #'as yet unclassified' }
XMLOrderPreservingDictionaryTest >> testAssociationAtError [
	self shouldnt: [self nonEmpty associationAt: self keyNotIn] raise: Error.
]

{ #category : #tests }
XMLOrderPreservingDictionaryTest >> testAtError [	
	| dict keyIn |

	dict := self nonEmpty.
	keyIn := dict keys anyOne.
	
	self
		shouldnt: [dict at: keyIn] raise: Error;
		shouldnt: [dict at: self keyNotIn] raise: Error.
]

{ #category : #'as yet unclassified' }
XMLOrderPreservingDictionaryTest >> testKeyAtIdentityValue [	
	| dict value result |

	dict := self nonEmpty .
	value := dict values anyOne.
	
	result := dict keyAtIdentityValue: value.
	self assert: (dict at: result) = value.
	self shouldnt: [dict keyAtIdentityValue: self valueNotIn ] raise: Error
]

{ #category : #tests }
XMLOrderPreservingDictionaryTest >> testKeyAtValue [	
	| dict value result |

	dict := self nonEmpty .
	value := dict values anyOne.
	
	result := dict keyAtValue: value.
	self assert: (dict at: result) = value.
	self shouldnt: [dict keyAtValue: self valueNotIn ] raise: Error.
]

{ #category : #'as yet unclassified' }
XMLOrderPreservingDictionaryTest >> testKeysAndValuesRemove [
	| oldSize collection keyIn |
	
	collection := self nonEmptyDict .
	oldSize := collection  size.
	keyIn := collection keys anyOne.
	
	collection  keysAndValuesRemove: [:key :value | key == self keyNotInNonEmptyDict ].
	self assert: (collection  size = (oldSize )).
	
	collection  keysAndValuesRemove: [:key :value | key == keyIn ].
	self assert: (collection  size = (oldSize - 1)).
	self shouldnt: [collection at: keyIn] raise: Error.
]

{ #category : #'as yet unclassified' }
XMLOrderPreservingDictionaryTest >> testPrintNameOn [
	| stream |

	stream := String new writeStream.
	self nonEmpty printNameOn: stream.
	self assert: stream contents = ('an ', self collectionClass name)
]

{ #category : #tests }
XMLOrderPreservingDictionaryTest >> testRemoveKey [
	"self debug: #testRemoveKey"
	| collection oldSize keyIn |

	collection := self nonEmptyDict .
	oldSize := collection size.
	keyIn := collection  keys anyOne.
	
	collection removeKey: keyIn .
	self assert: (collection  size = (oldSize - 1)).
	self shouldnt: [ (collection  at: keyIn )] raise: Error.
	self shouldnt: [collection removeKey: self keyNotInNonEmptyDict] raise: Error
]

{ #category : #tests }
XMLOrderPreservingDictionaryTest >> testRemoveKeyIfAbsent [
	| collection oldSize keyIn value result |

	collection := self nonEmptyDict .
	oldSize := collection size.
	keyIn := collection  keys anyOne.
	value := collection at: keyIn .
	
	result := collection removeKey: keyIn ifAbsent: [888].
	
	self assert: result = value.
	self assert: (collection size = (oldSize - 1)).
	self shouldnt: [collection at: keyIn] raise: Error.
	self assert: (collection removeKey: self keyNotInNonEmptyDict ifAbsent: [888]) = 888.
]
