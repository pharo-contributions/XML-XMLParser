"
This class is a DOM parser that turns potentially invalid and malformed HTML into a DOM tree. All tag and attribute names are converted to lowercase and markup is unrecognized in <script> and <style> sections.

(When printing the resulting DOM, use canonicallyPrintOn: and canonicallyPrinted.)
"
Class {
	#name : #HTMLParser,
	#superclass : #XMLDOMParser,
	#category : #'XML-Parser-HTML'
}

{ #category : #private }
HTMLParser >> driverClass [
	^ HTMLDriver
]

{ #category : #private }
HTMLParser >> elementNesterClass [
	^ HTMLElementNester
]

{ #category : #content }
HTMLParser >> endElement: anElementName prefix: aPrefix uri: aUri localName: aLocalName [
	(self topNode isElement and: [self topNode isNamed: anElementName])
		ifTrue: [self popNode]

]

{ #category : #private }
HTMLParser >> findUniqueElementFor: anElementName [
	^ (#('html' 'head' 'body') includes: anElementName)
		ifTrue: [self document findElementNamed: anElementName]
		ifFalse: [nil]
]

{ #category : #content }
HTMLParser >> startElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName attributes: aDictionary [
	| element |

	(element := self findUniqueElementFor: aQualifiedName)
		ifNotNil: [
			self pushNode: element.
			^ self].

	super
		startElement: aQualifiedName
		prefix: aPrefix
		uri: aUri
		localName: aLocalName
		attributes: aDictionary.
]
