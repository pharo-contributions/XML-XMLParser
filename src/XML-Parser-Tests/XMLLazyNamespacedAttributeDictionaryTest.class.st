Class {
	#name : #XMLLazyNamespacedAttributeDictionaryTest,
	#superclass : #XMLNamespacedAttributeDictionaryTest,
	#category : #'XML-Parser-Tests'
}

{ #category : #accessing }
XMLLazyNamespacedAttributeDictionaryTest >> dictionaryClass [
	^ XMLLazyNamespacedAttributeDictionary
]

{ #category : #testing }
XMLLazyNamespacedAttributeDictionaryTest >> isTestingLazyDictionary [
	^ true
]
