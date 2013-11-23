"
This class is a DOM parser that turns potentially invalid and malformed HTML into a DOM tree. All tag and attribute names are converted to lowercase and markup is unrecognized in <script> and <style> sections.
"
Class {
	#name : #HTMLParser,
	#superclass : #XMLDOMParser,
	#category : #'XML-Parser-HTML'
}

{ #category : #content }
HTMLParser >> characters: aString [
	self topNode isElement
		ifFalse: [self startHTMLPreamble].
	super characters: aString.
]

{ #category : #private }
HTMLParser >> configurationClass [
	^ HTMLConfiguration
]

{ #category : #private }
HTMLParser >> driverClass [
	^ HTMLDriver
]

{ #category : #accessing }
HTMLParser >> elementNesterClass [
	^ HTMLElementNester
]

{ #category : #content }
HTMLParser >> startElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName attributes: aDictionary [
	(self topNode isElement
		or: [aQualifiedName = 'html'])
		ifFalse: [self startHTMLPreamble].
	super
		startElement: aQualifiedName
		prefix: aPrefix
		uri: aUri
		localName: aLocalName
		attributes: aDictionary.
]

{ #category : #private }
HTMLParser >> startHTMLPreamble [
	#('html' 'body')
		do: [:each |
			self
				startElement: each
				prefix: ''
				uri: ''
				localName: ''
				attributes: Dictionary new]
]
