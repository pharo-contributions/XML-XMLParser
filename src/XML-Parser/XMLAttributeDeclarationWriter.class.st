Class {
	#name : #XMLAttributeDeclarationWriter,
	#superclass : #XMLMarkupDeclarationWriter,
	#instVars : [
		'attributeName',
		'defaultDeclaration'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #accessing }
XMLAttributeDeclarationWriter >> attributeName [
	^ attributeName ifNil: [attributeName := '']
]

{ #category : #accessing }
XMLAttributeDeclarationWriter >> attributeName: aName [
	attributeName := aName
]

{ #category : #accessing }
XMLAttributeDeclarationWriter >> declarationType [
	^ 'ATTLIST'
]

{ #category : #accessing }
XMLAttributeDeclarationWriter >> defaultDeclaration [
	^ defaultDeclaration ifNil: [defaultDeclaration := '']
]

{ #category : #accessing }
XMLAttributeDeclarationWriter >> defaultDeclaration: aDefaultDeclaration [
	defaultDeclaration := aDefaultDeclaration
]

{ #category : #accessing }
XMLAttributeDeclarationWriter >> elementName [
	^ self name
]

{ #category : #accessing }
XMLAttributeDeclarationWriter >> elementName: aName [
	self name: aName
]

{ #category : #accessing }
XMLAttributeDeclarationWriter >> type [
	^ type ifNil: [type := 'CDATA']
]

{ #category : #accessing }
XMLAttributeDeclarationWriter >> type: aType [
	type := aType
]

{ #category : #private }
XMLAttributeDeclarationWriter >> writeBody [
	self writer
		writeName: self attributeName;
		space;
		writeName: self type.

	self defaultDeclaration
		ifNotEmpty: [
			self writer
				space;
				nextPutAll: self defaultDeclaration]
]
