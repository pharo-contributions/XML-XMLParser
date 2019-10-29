Class {
	#name : #XMLLazyAttributeDictionaryTest,
	#superclass : #XMLAttributeDictionaryTest,
	#category : #'XML-Parser-Tests'
}

{ #category : #accessing }
XMLLazyAttributeDictionaryTest >> dictionaryClass [
	^ XMLLazyAttributeDictionary
]

{ #category : #testing }
XMLLazyAttributeDictionaryTest >> isTestingLazyDictionary [
	^ true
]
