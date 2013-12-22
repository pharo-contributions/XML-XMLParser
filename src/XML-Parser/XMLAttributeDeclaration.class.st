Class {
	#name : #XMLAttributeDeclaration,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'type',
		'defaultDeclaration',
		'attribute',
		'element'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLAttributeDeclaration class >> element: anElementName attribute: anAttributeName type: aType defaultDeclaration: aDefaultDeclaration [
	^ self new
		setElement: anElementName
		attribute: anAttributeName
		type: aType
		defaultDeclaration: aDefaultDeclaration
]

{ #category : #accessing }
XMLAttributeDeclaration >> attribute [
	^ attribute ifNil: [attribute := '']
]

{ #category : #accessing }
XMLAttributeDeclaration >> defaultDeclaration [
	^ defaultDeclaration ifNil: [defaultDeclaration := '']
]

{ #category : #accessing }
XMLAttributeDeclaration >> element [
	^ element ifNil: [element := '']
]

{ #category : #initialization }
XMLAttributeDeclaration >> setElement: anElementName attribute: anAttributeName type: aType defaultDeclaration: aDefaultDeclaration [
	element := anElementName.
	attribute := anAttributeName.
	type := aType.
	defaultDeclaration := aDefaultDeclaration.
]

{ #category : #accessing }
XMLAttributeDeclaration >> type [
	^ type ifNil: [type := '']
]

{ #category : #printing }
XMLAttributeDeclaration >> writeXMLOn: aWriter [
	aWriter attributeDeclaration
		element: self element;
		attribute: self attribute;
		type: self type;
		defaultDeclaration: self defaultDeclaration
]
