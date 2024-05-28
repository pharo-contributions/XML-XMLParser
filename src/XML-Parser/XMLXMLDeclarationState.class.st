"
A state for parsing the <?xml ...?> token.
"
Class {
	#name : 'XMLXMLDeclarationState',
	#superclass : 'XMLPrologState',
	#category : 'XML-Parser-Drivers',
	#package : 'XML-Parser',
	#tag : 'Drivers'
}

{ #category : 'testing' }
XMLXMLDeclarationState >> isXMLDeclarationState [
	^ true
]

{ #category : 'tokenizing' }
XMLXMLDeclarationState >> nextTokenFrom: aTokenizer [
	^ aTokenizer nextXMLDeclarationOrPrologToken
]

{ #category : 'testing' }
XMLXMLDeclarationState >> supportsEncodingDetection [
	^ true
]
