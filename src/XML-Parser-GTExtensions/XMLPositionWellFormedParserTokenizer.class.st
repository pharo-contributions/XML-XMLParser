"
This class is a tokenizer that tracks token start/end positions. Does not support entities.
"
Class {
	#name : #XMLPositionWellFormedParserTokenizer,
	#superclass : #XMLWellFormedParserTokenizer,
	#instVars : [
		'initialReadLimit'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #accessing }
XMLPositionWellFormedParserTokenizer >> currentPosition [
	^ initialReadLimit - streamReader readLimit
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextAttributeValue [
	| attributeValue |

	driver handleStartQuotedStringValuePosition: self currentPosition.
	attributeValue := super nextAttributeValue.
	driver handleEndQuotedStringValuePosition: self currentPosition - 1.

	^ attributeValue.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextCDataSection [
	driver handleStartCDataPosition: self currentPosition - 2.
	super nextCDataSection.
	driver handleEndCDataPosition: self currentPosition - 1.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextCharacterReferenceOnWriteStream [
	| result |

	driver handleStartEntityReferencePosition: self currentPosition - 1.
	result := super nextCharacterReferenceOnWriteStream.
	driver handleEndEntityReferencePosition: self currentPosition - 1.

	^ result.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextComment [
	driver handleStartCommentPosition: self currentPosition - 2.
	super nextComment.
	driver handleEndCommentPosition: self currentPosition - 1.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextDoctypeDeclaration [
	driver handleStartDoctypeDeclarationPosition: self currentPosition - 2.
	super nextDoctypeDeclaration.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextEndDoctypeDeclaration [
	super nextEndDoctypeDeclaration.
	driver handleEndDoctypeDeclarationPosition: self currentPosition - 1.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextEntityValue [
	| entityValue |

	driver handleStartQuotedStringValuePosition: self currentPosition.
	entityValue := super nextEntityValue.
	driver handleEndQuotedStringValuePosition: self currentPosition - 1.

	^ entityValue.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextGeneralEntityReferenceOnWriteStream [
	driver handleStartEntityReferencePosition: self currentPosition - 1.
	self nextName.
	driver handleEndEntityReferencePosition: self currentPosition.
	self expectNext: $;.

	^ false.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextPIWithTarget: aTarget [
	driver handleStartPIPosition: self currentPosition - (2 + aTarget size).
	super nextPIWithTarget: aTarget.
	driver handleEndPIPosition: self currentPosition - 1.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextParameterEntityReference [
	driver handleStartEntityReferencePosition: self currentPosition - 1.
	self nextName.
	driver handleEndEntityReferencePosition: self currentPosition.
	self expectNext: $;.
	^ false.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextParameterEntityReferenceInDeclaration [
	^ self nextParameterEntityReference
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextParameterEntityReferenceOnWriteStream [
	^ self nextParameterEntityReference
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextPublicIDLiteral [
	| publicID |

	driver handleStartQuotedStringValuePosition: self currentPosition.
	publicID := super nextPublicIDLiteral.
	driver handleEndQuotedStringValuePosition: self currentPosition - 1.

	^ publicID.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextSubsetDeclaration [
	driver handleStartDeclaration: self currentPosition - 2.
	super nextSubsetDeclaration.
	driver handleEndDeclaration: self currentPosition - 1.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextSystemIDLiteral [
	| systemID |

	driver handleStartQuotedStringValuePosition: self currentPosition.
	systemID := super nextSystemIDLiteral.
	driver handleEndQuotedStringValuePosition: self currentPosition - 1.

	^ systemID.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextTag [
	driver handleStartTagPosition: self currentPosition - 1.
	super nextTag.
	driver handleEndTagPosition: self currentPosition - 1.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLDeclaration [
	driver handleStartXMLDeclarationPosition: self currentPosition - 5. "'<?xml' size"
	super nextXMLDeclaration.
	driver handleEndXMLDeclarationPosition: self currentPosition - 1.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLEncodingAttributeValue [
	| encoding |

	driver handleStartQuotedStringValuePosition: self currentPosition.
	encoding := super nextXMLEncodingAttributeValue.
	driver handleEndQuotedStringValuePosition: self currentPosition - 1.

	^ encoding.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLStandaloneAttributeValue [
	| yesOrNo |

	driver handleStartQuotedStringValuePosition: self currentPosition.
	yesOrNo := super nextXMLStandaloneAttributeValue.
	driver handleEndQuotedStringValuePosition: self currentPosition - 1.

	^ yesOrNo.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLVersionAttributeValue [
	| version |

	driver handleStartQuotedStringValuePosition: self currentPosition.
	version := super nextXMLVersionAttributeValue.
	driver handleEndQuotedStringValuePosition: self currentPosition - 1.

	^ version.
]

{ #category : #initialization }
XMLPositionWellFormedParserTokenizer >> setDriver: aDriver stream: aStream readLimit: aReadLimit [
	super
		setDriver: aDriver
		stream: aStream
		readLimit: aReadLimit.
	initialReadLimit := aReadLimit + 1. "+1 to get 1-based positions"
]
