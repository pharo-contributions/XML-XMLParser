"
This class represents the list of nodes that comprise a document's internal DTD subset.
"
Class {
	#name : #XMLInternalSubsetList,
	#superclass : #XMLObservableList,
	#category : #'XML-Parser-DOM'
}

{ #category : #private }
XMLInternalSubsetList >> afterAdding: aNode [
	observer ifNotNil: [observer addedNode: aNode]
]

{ #category : #private }
XMLInternalSubsetList >> afterRemoving: aNode [
	observer ifNotNil: [observer removedNode: aNode]
]

{ #category : #private }
XMLInternalSubsetList >> beforeAdding: aNode [
	observer ifNotNil: [observer addingNode: aNode]
]

{ #category : #sorting }
XMLInternalSubsetList >> sort [
	self sort: [:a :b | a sortKey <= b sortKey]
]
