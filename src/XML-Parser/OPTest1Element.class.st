Class {
	#name : #OPTest1Element,
	#superclass : #OPGenericElement,
	#category : #'XML-Parser-Opax-Test'
}

{ #category : #'instance creation' }
OPTest1Element class >> xmlTags [
	^OrderedCollection with: 'test1' with:'anotherTest1' with: 'Test1'
]
