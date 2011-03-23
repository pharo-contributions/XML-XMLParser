Class {
	#name : #XMLAttributeDeclaration,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'attributeName',
		'type',
		'defaultDeclaration'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLAttributeDeclaration class >> elementName: anElementName attributeName: anAttributeName type: aType defaultDeclaration: aDefaultDeclaration [
	^ self new
		setElementName: anElementName
		attributeName: anAttributeName
		type: aType
		defaultDeclaration: aDefaultDeclaration
]

{ #category : #accessing }
XMLAttributeDeclaration >> attributeName [
	^ attributeName ifNil: [attributeName := '']
]

{ #category : #accessing }
XMLAttributeDeclaration >> defaultDeclaration [
	^ defaultDeclaration ifNil: [defaultDeclaration := '']
]

{ #category : #accessing }
XMLAttributeDeclaration >> elementName [
	^ self name
]

{ #category : #initialization }
XMLAttributeDeclaration >> setElementName: anElementName attributeName: anAttributeName type: aType defaultDeclaration: aDefaultDeclaration [
	name := anElementName.
	attributeName := anAttributeName.
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
		elementName: self elementName;
		attributeName: self attributeName;
		type: self type;
		defaultDeclaration: self defaultDeclaration
]
