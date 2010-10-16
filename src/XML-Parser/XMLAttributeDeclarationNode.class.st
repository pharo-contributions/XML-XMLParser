Class {
	#name : #XMLAttributeDeclarationNode,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'attributeName',
		'type',
		'defaultDeclaration'
	],
	#category : #'XML-Parser-Nodes'
}

{ #category : #'instance creation' }
XMLAttributeDeclarationNode class >> elementName: anElementName attributeName: anAttributeName type: aType defaultDeclaration: aDefaultDeclaration [
	^ self new
		setElementName: anElementName
		attributeName: anAttributeName
		type: aType
		defaultDeclaration: aDefaultDeclaration
]

{ #category : #accessing }
XMLAttributeDeclarationNode >> attributeName [
	^ attributeName
]

{ #category : #accessing }
XMLAttributeDeclarationNode >> defaultDeclaration [
	^ defaultDeclaration
]

{ #category : #accessing }
XMLAttributeDeclarationNode >> elementName [
	^ self name
]

{ #category : #printing }
XMLAttributeDeclarationNode >> printXMLOn: aWriter [
	aWriter attributeDeclaration
		elementName: self elementName;
		attributeName: self attributeName;
		type: self type;
		defaultDeclaration: self defaultDeclaration
]

{ #category : #initialization }
XMLAttributeDeclarationNode >> setElementName: anElementName attributeName: anAttributeName type: aType defaultDeclaration: aDefaultDeclaration [
	name := anElementName.
	attributeName := anAttributeName.
	type := aType.
	defaultDeclaration := aDefaultDeclaration.
]

{ #category : #accessing }
XMLAttributeDeclarationNode >> type [
	^ type
]
