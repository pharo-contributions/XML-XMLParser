Class {
	#name : 'XMLLazyNamespacedAttributeDictionaryTest',
	#superclass : 'XMLNamespacedAttributeDictionaryTest',
	#category : 'XML-Parser-Tests-Base',
	#package : 'XML-Parser-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
XMLLazyNamespacedAttributeDictionaryTest >> dictionaryClass [
	^ XMLLazyNamespacedAttributeDictionary
]

{ #category : 'testing' }
XMLLazyNamespacedAttributeDictionaryTest >> isTestingLazyDictionary [
	^ true
]
