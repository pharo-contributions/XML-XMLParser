Class {
	#name : #XMLOrderedListTest,
	#superclass : #OrderedCollectionTest,
	#category : #'XML-Parser-Tests'
}

{ #category : #coverage }
XMLOrderedListTest >> classToBeTested [
	^ XMLOrderedList
]

{ #category : #'test - creation' }
XMLOrderedListTest >> collectionClass [
	^ XMLOrderedList
]
