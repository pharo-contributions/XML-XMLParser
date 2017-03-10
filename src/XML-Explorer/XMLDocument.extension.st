Extension { #name : #XMLDocument }

{ #category : #'*XML-Explorer' }
XMLDocument >> addExplorerContentsTo: aSequenceableCollection [
	self hasDoctypeDeclaration
		ifTrue: [
			aSequenceableCollection addLast:
				(ObjectExplorerWrapper
					with: self doctypeDeclaration
					name: (self doctypeDeclaration explorerLabel contractTo: 32)
					model: self)].
	super addExplorerContentsTo: aSequenceableCollection.
]

{ #category : #'*XML-Explorer' }
XMLDocument >> hasExplorerContents [
	^ self hasDoctypeDeclaration
		or: [super hasExplorerContents]
]

{ #category : #'*XML-Explorer' }
XMLDocument >> writeExplorerLabelXMLOn: aWriter [
	self writeXMLDeclarationOn: aWriter
]
