Class {
	#name : #DTDElementMatcher,
	#superclass : #XMLFAMatcher,
	#instVars : [
		'element'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDElementMatcher class >> element: aName [
	^ self new element: aName
]

{ #category : #comparing }
DTDElementMatcher >> = anObject [
	^ anObject == self
		or: [anObject class == self class
			and: [anObject element = element]]
]

{ #category : #accessing }
DTDElementMatcher >> element [
	^ element
]

{ #category : #accessing }
DTDElementMatcher >> element: aName [
	element := aName
]

{ #category : #comparing }
DTDElementMatcher >> hash [
	^ element hash
]

{ #category : #matching }
DTDElementMatcher >> matchesElement: aName [
	^ element = aName
]

{ #category : #matching }
DTDElementMatcher >> matchesPCData: aString [
	^ false
]
