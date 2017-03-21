Extension { #name : #XMLNode }

{ #category : #'*XML-Explorer' }
XMLNode >> explorerContents [
	^ #()
]

{ #category : #'*XML-Explorer' }
XMLNode >> explorerLabel [
	^ XMLWriter writeWith: [:writer |
		self writeExplorerLabelXMLOn: writer]
]

{ #category : #'*XML-Explorer' }
XMLNode >> hasExplorerContents [
	^ false
]

{ #category : #'*XML-Explorer' }
XMLNode >> writeExplorerLabelXMLOn: aWriter [
	self writeXMLOn: aWriter
]
