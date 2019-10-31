Class {
	#name : #XMLLazyNamespacedAttributeDictionaryTest,
	#superclass : #XMLNamespacedAttributeDictionaryTest,
	#category : #'XML-Parser-Tests-Base'
}

{ #category : #accessing }
XMLLazyNamespacedAttributeDictionaryTest >> dictionaryClass [
	^ XMLLazyNamespacedAttributeDictionary
]

{ #category : #testing }
XMLLazyNamespacedAttributeDictionaryTest >> isTestingLazyDictionary [
	^ true
]
