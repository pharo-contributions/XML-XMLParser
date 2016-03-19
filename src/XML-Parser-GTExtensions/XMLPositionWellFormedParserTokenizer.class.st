"
This class is a tokenizer for well-formed XML that tracks token start/end positions. Does not support entities or validation.
"
Class {
	#name : #XMLPositionWellFormedParserTokenizer,
	#superclass : #XMLWellFormedParserTokenizer,
	#category : #'XML-Parser-GTExtensions-Highlighting-Parser'
}

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextAttributeValue [
	| attributeValue |

	driver handleStartQuotedStringValuePosition: self currentPosition + 1.
	attributeValue := super nextAttributeValue.
	driver handleEndQuotedStringValuePosition: self currentPosition.

	^ attributeValue.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextCDataSection [
	driver handleStartCDataPosition: self currentPosition - 1.
	super nextCDataSection.
	driver handleEndCDataPosition: self currentPosition.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextCharacterReferenceOnWriteStream [
	| result |

	driver handleStartEntityReferencePosition: self currentPosition.
	result := super nextCharacterReferenceOnWriteStream.
	driver handleEndEntityReferencePosition: self currentPosition.

	^ result.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextComment [
	driver handleStartCommentPosition: self currentPosition - 1.
	super nextComment.
	driver handleEndCommentPosition: self currentPosition.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextDoctypeDeclaration [
	driver handleStartDoctypeDeclarationPosition: self currentPosition - 1.
	super nextDoctypeDeclaration.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextEndDoctypeDeclaration [
	super nextEndDoctypeDeclaration.
	driver handleEndDoctypeDeclarationPosition: self currentPosition.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextEntityValue [
	| entityValue |

	driver handleStartQuotedStringValuePosition: self currentPosition + 1.
	entityValue := super nextEntityValue.
	driver handleEndQuotedStringValuePosition: self currentPosition.

	^ entityValue.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextGeneralEntityReferenceOnWriteStream [
	driver handleStartEntityReferencePosition: self currentPosition.
	self nextName.
	driver handleEndEntityReferencePosition: self currentPosition + 1.
	self expectNext: $;.

	^ false.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextPIWithTarget: aTarget [
	driver handleStartPIPosition: self currentPosition - (aTarget size + 1).
	super nextPIWithTarget: aTarget.
	driver handleEndPIPosition: self currentPosition.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextParameterEntityReference [
	driver handleStartEntityReferencePosition: self currentPosition.
	self nextName.
	driver handleEndEntityReferencePosition: self currentPosition + 1.
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

	driver handleStartQuotedStringValuePosition: self currentPosition + 1.
	publicID := super nextPublicIDLiteral.
	driver handleEndQuotedStringValuePosition: self currentPosition.

	^ publicID.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextSubsetDeclaration [
	driver handleStartDeclaration: self currentPosition - 1.
	super nextSubsetDeclaration.
	driver handleEndDeclaration: self currentPosition.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextSystemIDLiteral [
	| systemID |

	driver handleStartQuotedStringValuePosition: self currentPosition + 1.
	systemID := super nextSystemIDLiteral.
	driver handleEndQuotedStringValuePosition: self currentPosition.

	^ systemID.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextTag [
	driver handleStartTagPosition: self currentPosition.
	super nextTag.
	driver handleEndTagPosition: self currentPosition.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLDeclaration [
	driver handleStartXMLDeclarationPosition: self currentPosition - 4. "'<?xml' size"
	super nextXMLDeclaration.
	driver handleEndXMLDeclarationPosition: self currentPosition.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLEncodingAttributeValue [
	| encoding |

	driver handleStartQuotedStringValuePosition: self currentPosition + 1.
	encoding := super nextXMLEncodingAttributeValue.
	driver handleEndQuotedStringValuePosition: self currentPosition.

	^ encoding.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLStandaloneAttributeValue [
	| yesOrNo |

	driver handleStartQuotedStringValuePosition: self currentPosition + 1.
	yesOrNo := super nextXMLStandaloneAttributeValue.
	driver handleEndQuotedStringValuePosition: self currentPosition.

	^ yesOrNo.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLVersionAttributeValue [
	| version |

	driver handleStartQuotedStringValuePosition: self currentPosition + 1.
	version := super nextXMLVersionAttributeValue.
	driver handleEndQuotedStringValuePosition: self currentPosition.

	^ version.
]
