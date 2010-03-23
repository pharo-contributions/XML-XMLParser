Class {
	#name : #XMLOrderedList,
	#superclass : #OrderedCollection,
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLOrderedList >> after: anObject [
	^ self after: anObject ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderedList >> at: anIndex [
	^ self at: anIndex ifAbsent: [self defaultValue]
]

{ #category : #accessing }
XMLOrderedList >> at: anIndex ifAbsent: aBlock [
	^ (anIndex between: 1 and: self size)
		ifTrue: [super at: anIndex]
		ifFalse: [aBlock value]
]

{ #category : #accessing }
XMLOrderedList >> before: anObject [
	^ self before: anObject ifAbsent: [self defaultValue]
]

{ #category : #copying }
XMLOrderedList >> copy [
	^ self species withAll: self
]

{ #category : #copying }
XMLOrderedList >> copyEmpty [
	^ self species new: self size
]

{ #category : #copying }
XMLOrderedList >> copyFrom: start to: end [
	^ super copyFrom: (start max: 1) to: (self size min: end)
]

{ #category : #defaults }
XMLOrderedList >> defaultValue [
	^ nil
]

{ #category : #errors }
XMLOrderedList >> domError: anErrorMessage [
	XMLDOMException signal: anErrorMessage.
	^ nil.
	
]

{ #category : #printing }
XMLOrderedList >> printOn: aStream [
	self printXMLOn: (XMLWriter on: aStream)
]

{ #category : #printing }
XMLOrderedList >> printXMLOn: writer [
	self do: [:each | each printXMLOn: writer].
]

{ #category : #copying }
XMLOrderedList >> species [
	^ XMLOrderedList
]
