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

	driver handleStartQuotedStringPosition: self currentPosition + 1.
	attributeValue := super nextAttributeValue.
	driver handleEndQuotedStringPosition: self currentPosition.

	^ attributeValue.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextCDataSection [
	driver handleStartCDataPosition: self currentPosition - 1.
	super nextCDataSection.
	driver handleEndCDataPosition: self currentPosition.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextCharacterReferenceOnCharacterDataStream [
	| result |

	driver handleStartEntityReferencePosition: self currentPosition.
	result := super nextCharacterReferenceOnCharacterDataStream.
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

	driver handleStartQuotedStringPosition: self currentPosition + 1.
	entityValue := super nextEntityValue.
	driver handleEndQuotedStringPosition: self currentPosition.

	^ entityValue.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextGeneralEntityReferenceOnCharacterDataStream [
	driver handleStartEntityReferencePosition: self currentPosition.
	self nextName.
	driver handleEndEntityReferencePosition: self currentPosition + 1.
	self expectNext: $;.

	^ false.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextPIData [
	| nextChar quotedStringStart quote |

	characterDataStream reset.
	[(nextChar := streamReader next) == nil
		or: [nextChar == $?
			and: [streamReader peek == $>]]]
		whileFalse: [
			nextChar isXMLChar
				ifFalse: [self errorNonCharInPIValue: nextChar].
			quotedStringStart
				ifNil: [
					(nextChar == $"
						or: [nextChar == $'])
						ifTrue: [
							quote := nextChar.
							quotedStringStart := self currentPosition]]
				ifNotNil: [
					nextChar == quote
						ifTrue: [
							driver
								handleStartQuotedStringPosition: quotedStringStart;
								handleEndQuotedStringPosition: self currentPosition.
							quotedStringStart := nil]].
			characterDataStream nextPut: nextChar].
	self expectTerminator.
	^ characterDataStream contents.
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
XMLPositionWellFormedParserTokenizer >> nextParameterEntityReferenceOnCharacterDataStream [
	^ self nextParameterEntityReference
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextPublicIDLiteral [
	| publicID |

	driver handleStartQuotedStringPosition: self currentPosition + 1.
	publicID := super nextPublicIDLiteral.
	driver handleEndQuotedStringPosition: self currentPosition.

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

	driver handleStartQuotedStringPosition: self currentPosition + 1.
	systemID := super nextSystemIDLiteral.
	driver handleEndQuotedStringPosition: self currentPosition.

	^ systemID.
]

{ #category : #'tokenizing - dtd' }
XMLPositionWellFormedParserTokenizer >> nextSystemIDLiteralWithoutURIFragment [
	| systemID |

	driver handleStartQuotedStringPosition: self currentPosition + 1.
	systemID := super nextSystemIDLiteralWithoutURIFragment.
	driver handleEndQuotedStringPosition: self currentPosition.

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

	driver handleStartQuotedStringPosition: self currentPosition + 1.
	encoding := super nextXMLEncodingAttributeValue.
	driver handleEndQuotedStringPosition: self currentPosition.

	^ encoding.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLStandaloneAttributeValue [
	| yesOrNo |

	driver handleStartQuotedStringPosition: self currentPosition + 1.
	yesOrNo := super nextXMLStandaloneAttributeValue.
	driver handleEndQuotedStringPosition: self currentPosition.

	^ yesOrNo.
]

{ #category : #tokenizing }
XMLPositionWellFormedParserTokenizer >> nextXMLVersionAttributeValue [
	| version |

	driver handleStartQuotedStringPosition: self currentPosition + 1.
	version := super nextXMLVersionAttributeValue.
	driver handleEndQuotedStringPosition: self currentPosition.

	^ version.
]
