"
Invoked when invalid XML is detected and validation is on.
"
Class {
	#name : #XMLValidationException,
	#superclass : #XMLParserException,
	#category : #'XML-Parser-Exceptions'
}

{ #category : #'instance creation' }
XMLValidationException class >> undeclaredGeneralEntity: aName [
	^ self new
		messageText: 'Undeclared general entity reference &', aName, ';';
		yourself
]

{ #category : #'instance creation' }
XMLValidationException class >> undeclaredParameterEntity: aName [
	^ self new
		messageText: 'Undeclared parameter entity reference %', aName, ';';
		yourself
]

{ #category : #'instance creation' }
XMLValidationException class >> undeclaredUnparsedEntity: aName [
	^ self new
		messageText: 'Undeclared unparsed entity reference &', aName, ';';
		yourself
]
