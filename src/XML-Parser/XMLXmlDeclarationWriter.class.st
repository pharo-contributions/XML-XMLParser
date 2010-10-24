"
This class generates <?xml ...?> declarations.
"
Class {
	#name : #XMLXmlDeclarationWriter,
	#superclass : #XMLPIWriter,
	#instVars : [
		'encoding',
		'version',
		'standalone'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #accessing }
XMLXmlDeclarationWriter >> encoding [
	^ encoding ifNil: [encoding := 'UTF-8']
]

{ #category : #accessing }
XMLXmlDeclarationWriter >> encoding: anEncoding [
	encoding := anEncoding
]

{ #category : #accessing }
XMLXmlDeclarationWriter >> standalone [
	^ standalone
]

{ #category : #accessing }
XMLXmlDeclarationWriter >> standalone: aBoolean [
	standalone := aBoolean
]

{ #category : #accessing }
XMLXmlDeclarationWriter >> target [
	^ 'xml'
]

{ #category : #accessing }
XMLXmlDeclarationWriter >> version [
	^ version ifNil: [version := '1.0']
]

{ #category : #accessing }
XMLXmlDeclarationWriter >> version: aVersion [
	version := aVersion
]

{ #category : #accessing }
XMLXmlDeclarationWriter >> writeBody [
	self writer
		writeName: 'version' value: self version asString;
		space;
		writeName: 'encoding' value: self encoding.

	self standalone
		ifNotNil: [
			self writer
				space;
				writeName: 'standalone'
				value: (self standalone ifTrue: ['yes'] ifFalse: ['no'])]
]
