"
This is a class for automatic encoding detection of streams that infers encodings from byte order marks (BOM) or implicit encodings from a sequence of one or more null bytes before or after the first ASCII character.

(It actually implements the YAML implicit encoding detection algorithm, looking for any leading ASCII char instead of just '<' before or after a null sequence, because this algorithm is more general, supporting non-XML text, and the standard XML algorithm is non-normative.)
"
Class {
	#name : #XMLImplicitEncodingDetector,
	#superclass : #XMLEncodingDetector,
	#category : #'XML-Parser-Streams'
}

{ #category : #testing }
XMLImplicitEncodingDetector >> detectsImplicitEncodings [
	^ true
]
