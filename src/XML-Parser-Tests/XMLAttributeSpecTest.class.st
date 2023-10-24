Class {
	#name : #XMLAttributeSpecTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests-Utils'
}

{ #category : #testing }
XMLAttributeSpecTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
XMLAttributeSpecTest >> attributeSpecClass [
	^ XMLAttributeSpec
]

{ #category : #'instance creation' }
XMLAttributeSpecTest >> newAttributeSpec [
	^ self attributeSpecClass new
]

{ #category : #tests }
XMLAttributeSpecTest >> testAsXMLAttributeSpec [

	| attributeSpec |
	attributeSpec := self newAttributeSpec.
	self
		assert: attributeSpec asXMLAttributeSpec
		identicalTo: attributeSpec
]
