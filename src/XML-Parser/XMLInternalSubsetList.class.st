"
This class represents the list of nodes that comprise a document's internal DTD subset.
"
Class {
	#name : #XMLInternalSubsetList,
	#superclass : #XMLObservableList,
	#category : #'XML-Parser-Nodes'
}

{ #category : #private }
XMLInternalSubsetList >> added: aNode [
	self notifyOf: #addedNode: with: aNode.
]

{ #category : #private }
XMLInternalSubsetList >> adding: aNode [
]

{ #category : #private }
XMLInternalSubsetList >> removed: aNode [
	self notifyOf: #removedNode: with: aNode.
]
