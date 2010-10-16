"
Objects that use this trait can observe objects using TXMLObservable.
"
Trait {
	#name : #TXMLObserver,
	#category : #'XML-Parser-Nodes'
}

{ #category : #observing }
TXMLObserver >> startObserving: anObject [
	anObject addObserver: self.
]

{ #category : #observing }
TXMLObserver >> stopObserving: anObject [
	anObject removeObserver: self.
]
