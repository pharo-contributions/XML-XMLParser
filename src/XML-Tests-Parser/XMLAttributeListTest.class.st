Class {
	#name : #XMLAttributeListTest,
	#superclass : #XMLObservableListTest,
	#instVars : [
		'attributes',
		'newAttribute',
		'absentAttribute',
		'changedAttributes'
	],
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLAttributeListTest >> absentListItem [
	^ absentAttribute
		ifNil: [absentAttribute := XMLAttribute name: 'absentName' value: 'absentValue']
]

{ #category : #accessing }
XMLAttributeListTest >> afterAddingToNotifications [
	^ #(addedAttribute:)
]

{ #category : #accessing }
XMLAttributeListTest >> afterRemovingFromNotifications [
	^ #(removedAttribute:)
]

{ #category : #testing }
XMLAttributeListTest >> allowsDuplicates [
	^ false
]

{ #category : #assertions }
XMLAttributeListTest >> assertList: aList copiedFrom: aSecondList equals: aThirdList [
	super
		assertList: aList
		copiedFrom: aSecondList
		equals: aThirdList.
	self
		assert: aList attributesByName size = aList size;
		assert: aList attributesByName = aThirdList attributesByName;
		deny: aList attributesByName == aSecondList attributesByName.
]

{ #category : #assertions }
XMLAttributeListTest >> assertList: aList isCopyOf: aSecondList [
	super assertList: aList isCopyOf: aSecondList.
	self
		assert: aList attributesByName size = aList size;
		assert: aList attributesByName = aSecondList attributesByName;
		deny: aList attributesByName == aSecondList attributesByName.
]

{ #category : #accessing }
XMLAttributeListTest >> beforeAddingToNotifications [
	^ #(addingAttribute:)
]

{ #category : #accessing }
XMLAttributeListTest >> changeListItem: anAttribute [
	^ (changedAttributes ifNil: [changedAttributes := IdentityDictionary new])
		at: anAttribute
		ifAbsentPut: [
			XMLAttribute
				name: 'new', anAttribute name
				value: 'new', anAttribute value]
]

{ #category : #accessing }
XMLAttributeListTest >> listClass [
	^ XMLAttributeList
]

{ #category : #accessing }
XMLAttributeListTest >> listItems [
	attributes ifNil: [
		attributes :=
			super listItems collect: [:each |
				XMLAttribute name: each value: each]].
	^ attributes copy.
]

{ #category : #accessing }
XMLAttributeListTest >> newListItem [
	^ newAttribute
		ifNil: [newAttribute := XMLAttribute name: 'newName' value: 'newValue']
]

{ #category : #accessing }
XMLAttributeListTest >> observerClass [
	^ XMLRecordingAttributeListObserver
]

{ #category : #accessing }
XMLAttributeListTest >> reverseSortBlock [
	^ [:a :b | a sortKey > b sortKey]
]

{ #category : #accessing }
XMLAttributeListTest >> sortBlock [
	^ [:a :b | a sortKey <= b sortKey]
]
