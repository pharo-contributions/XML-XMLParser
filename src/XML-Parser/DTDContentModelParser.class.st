"
This is a base class for DTD content model parsers that turn element declarations into validators.
"
Class {
	#name : #DTDContentModelParser,
	#superclass : #Object,
	#instVars : [
		'element',
		'contentModel'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDContentModelParser class >> element: anElement contentModel: aContentModel [
	^ self new
		setElement: anElement
		contentModel: aContentModel
]

{ #category : #parsing }
DTDContentModelParser class >> parserForContentModel: aContentModel [
	"the tokenizer removes all spaces from the content model"
	^ (aContentModel notEmpty and: [aContentModel first == $(])
		ifTrue: [
			(aContentModel size > 1 and: [aContentModel second == $#])
				ifTrue: [DTDMixedContentModelParser]
				ifFalse: [DTDDFAContentModelParser]]
		ifFalse: [DTDLiteralContentModelParser]
]

{ #category : #parsing }
DTDContentModelParser >> parse [
	self subclassResponsibility
]

{ #category : #initialization }
DTDContentModelParser >> setElement: anElement contentModel: aContentModel [
	element := anElement.
	contentModel := aContentModel.
]
