Class {
	#name : #XMLNodeListTest,
	#superclass : #XMLObservableListTest,
	#instVars : [
		'nodes',
		'newNode',
		'absentNode',
		'changedNodes'
	],
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLNodeListTest >> absentElement [
	^ absentNode ifNil: [absentNode := 'absentElement' asXMLString]
]

{ #category : #accessing }
XMLNodeListTest >> afterAddingToNotifications [
	^ #(addedNode: addedElement:)
]

{ #category : #accessing }
XMLNodeListTest >> afterRemovingFromNotifications [
	^ #(removedNode: removedElement:)
]

{ #category : #accessing }
XMLNodeListTest >> beforeAddingToNotifications [
	^ #(addingNode:)
]

{ #category : #accessing }
XMLNodeListTest >> changeElement: anElement [
	^ (changedNodes ifNil: [changedNodes := IdentityDictionary new])
		at: anElement
		ifAbsentPut: [anElement copy]
]

{ #category : #accessing }
XMLNodeListTest >> listClass [
	^ XMLNodeList
]

{ #category : #accessing }
XMLNodeListTest >> listElements [
	nodes ifNil: [
		nodes := OrderedCollection new.
		super listElements withIndexDo: [:each :i |
			i even
				ifTrue: [nodes addLast: (XMLElement named: each)]
				ifFalse: [nodes addLast: each asXMLString]].
		nodes := nodes asArray].
	^ nodes copy.
]

{ #category : #accessing }
XMLNodeListTest >> newElement [
	^ newNode ifNil: [newNode := 'newElement' asXMLString]
]

{ #category : #accessing }
XMLNodeListTest >> observerClass [
	^ XMLRecordingNodeListObserver
]

{ #category : #accessing }
XMLNodeListTest >> reverseSortBlock [
	^ [:a :b | a sortKey > b sortKey]
]

{ #category : #accessing }
XMLNodeListTest >> sortBlock [
	^ [:a :b | a sortKey <= b sortKey]
]
