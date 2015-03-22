"
This is an abstract class for general and parameter <!ENTITY> declarations.
"
Class {
	#name : #XMLEntityDeclaration,
	#superclass : #XMLDeclarationNode,
	#instVars : [
		'name',
		'replacement',
		'publicId',
		'systemId'
	],
	#category : #'XML-Parser-DOM'
}

{ #category : #'instance creation' }
XMLEntityDeclaration class >> name: aName publicID: aPublicID systemID: aSystemID [
	^ self new
		name: aName;
		publicID: aPublicID;
		systemID: aSystemID
]

{ #category : #'instance creation' }
XMLEntityDeclaration class >> name: aName replacement: aReplacement [
	^ self new
		name: aName;
		replacement: aReplacement
]

{ #category : #testing }
XMLEntityDeclaration >> isParameter [
	^ false
]

{ #category : #accessing }
XMLEntityDeclaration >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
XMLEntityDeclaration >> name: aName [
	name := aName
]

{ #category : #accessing }
XMLEntityDeclaration >> publicID [
	^ publicId ifNil: [publicId := '']
]

{ #category : #accessing }
XMLEntityDeclaration >> publicID: aPublicID [
	publicId := aPublicID
]

{ #category : #accessing }
XMLEntityDeclaration >> replacement [
	^ replacement ifNil: [replacement := '']
]

{ #category : #accessing }
XMLEntityDeclaration >> replacement: aReplacement [
	replacement := aReplacement
]

{ #category : #accessing }
XMLEntityDeclaration >> systemID [
	^ systemId ifNil: [systemId := '']
]

{ #category : #accessing }
XMLEntityDeclaration >> systemID: aSystemID [
	systemId := aSystemID
]
