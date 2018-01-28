Extension { #name : #XMLAttribute }

{ #category : #'*XML-ParserGTExtensions' }
XMLAttribute >> removeFromParent [
	self parent removeAttributeNode: self
]

{ #category : #'*XML-ParserGTExtensions' }
XMLAttribute >> supportsSourceEditing [
	^ false
]
