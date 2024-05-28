Class {
	#name : 'XMLLazyAttributeDictionaryTest',
	#superclass : 'XMLAttributeDictionaryTest',
	#category : 'XML-Parser-Tests-Base',
	#package : 'XML-Parser-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
XMLLazyAttributeDictionaryTest >> dictionaryClass [
	^ XMLLazyAttributeDictionary
]

{ #category : 'testing' }
XMLLazyAttributeDictionaryTest >> isTestingLazyDictionary [
	^ true
]
