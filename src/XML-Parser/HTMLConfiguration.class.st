Class {
	#name : #HTMLConfiguration,
	#superclass : #XMLDOMConfiguration,
	#category : #'XML-Parser-HTML'
}

{ #category : #accessing }
HTMLConfiguration >> isValidating [
	^ false
]

{ #category : #accessing }
HTMLConfiguration >> usesNamespaces [
	^ false
]
