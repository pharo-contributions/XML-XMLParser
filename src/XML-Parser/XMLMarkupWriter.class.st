"
This is a base class for markup writers. Subclasses override messages like #writePrologue and #writeEpilogue to write markup using the supplied XMLWriter object.
"
Class {
	#name : #XMLMarkupWriter,
	#superclass : #Object,
	#instVars : [
		'writer',
		'parent'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #'instance creation' }
XMLMarkupWriter class >> writer: aWriter [
	^ self new writer: aWriter
]

{ #category : #private }
XMLMarkupWriter >> beWritten [
	self writer writtenMarkupWriter: self.
]

{ #category : #testing }
XMLMarkupWriter >> hasParent [
	^ self parent notNil
]

{ #category : #testing }
XMLMarkupWriter >> isActiveMarkupWriter [
	^ self writer activeMarkupWriter == self
]

{ #category : #testing }
XMLMarkupWriter >> isTagWriter [
	^ false
]

{ #category : #private }
XMLMarkupWriter >> nextMarkupWriter: aMarkupWriter [
	self write
]

{ #category : #accessing }
XMLMarkupWriter >> parent [
	^ parent
]

{ #category : #accessing }
XMLMarkupWriter >> parent: aParentMarkupWriter [
	parent := aParentMarkupWriter
]

{ #category : #printing }
XMLMarkupWriter >> printOn: aStream [
	self writer printOn: aStream
]

{ #category : #'writing markup' }
XMLMarkupWriter >> write [
	self
		writePrologue;
		writeBody;
		writeEpilogue;
		beWritten
]

{ #category : #private }
XMLMarkupWriter >> writeBody [
]

{ #category : #private }
XMLMarkupWriter >> writeEpilogue [
]

{ #category : #private }
XMLMarkupWriter >> writePrologue [
]

{ #category : #accessing }
XMLMarkupWriter >> writer [
	^ writer
]

{ #category : #initialization }
XMLMarkupWriter >> writer: aWriter [
	writer := aWriter
]
