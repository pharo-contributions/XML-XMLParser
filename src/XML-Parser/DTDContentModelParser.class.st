"
This class parses a DTD content model from an element declaration and produces a validator object from it.
"
Class {
	#name : #DTDContentModelParser,
	#superclass : #Object,
	#instVars : [
		'name',
		'contentModel'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDContentModelParser class >> name: aName contentModel: aContentModel [
	^ self new
		setName: aName
		contentModel: aContentModel
]

{ #category : #parsing }
DTDContentModelParser class >> parserForContentModel: aContentModel [
	^ (aContentModel notEmpty and: [aContentModel first == $(])
		ifTrue: [
			(aContentModel size > 1 and: [aContentModel second == $#])
				ifTrue: [DTDMixedContentModelParser]
				ifFalse: [DTDDFAContentModelParser]]
		ifFalse: [DTDAnyOrEmptyContentModelParser]
]

{ #category : #parsing }
DTDContentModelParser >> parse [
	"the tokenizer removes all spaces from the content model"
	(contentModel isEmpty or: [contentModel = 'ANY'])
		ifTrue: [^ XMLAnyElementValidator element: name].
	(contentModel = 'EMPTY')
		ifTrue: [^ XMLEmptyElementValidator element: name].

	^ (contentModel beginsWith: '(#PCDATA')
		ifTrue: [self parseMixedContentModel]
		ifFalse: [self parseDFAContentModel].
]

{ #category : #'instance creation' }
DTDContentModelParser >> setName: aName contentModel: aContentModel [
	name := aName.
	contentModel := aContentModel.
]
