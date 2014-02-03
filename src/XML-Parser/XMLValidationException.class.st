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
	^ self
		undeclaredGeneralEntity: aName
		isParsed: true
]

{ #category : #'instance creation' }
XMLValidationException class >> undeclaredGeneralEntity: aName isParsed: aBoolean [
	^ self new
		messageText:
			'Undeclared ',
			(aBoolean ifTrue: ['general'] ifFalse: ['unparsed']),
			' entity reference &', aName, ';';
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
	^ self
		undeclaredGeneralEntity: aName
		isParsed: false
]
