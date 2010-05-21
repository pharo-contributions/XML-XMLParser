Class {
	#name : #OPTest2Element,
	#superclass : #OPGenericElement,
	#category : #'XML-Parser-Opax'
}

{ #category : #'instance creation' }
OPTest2Element class >> xmlTags [
	^OrderedCollection with: 'test2' with:'anotherTest2' with: 'Test2'
]
