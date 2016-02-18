Extension { #name : #Stream }

{ #category : #'*XML-Parser' }
Stream >> parseXML [
	^ XMLDOMParser parse: self
]
