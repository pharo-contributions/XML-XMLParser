"
This class is a DOM parser that turns potentially invalid and malformed HTML into a DOM tree. All tag and attribute names are converted to lowercase and markup is unrecognized in <script>, <style>, <title>, and <textarea> sections.

(When printing the DOM tree, use canonicallyPrintOn: or canonicallyPrinted instead of printOn:, printString, or asString to avoid empty elements being printed as self-closing tags, because some (like <script/>) are not handled correctly by browsers.)
"
Class {
	#name : #HTMLParser,
	#superclass : #XMLDOMParser,
	#category : #'XML-Parser-HTML'
}

{ #category : #private }
HTMLParser >> driverClass [
	^ HTMLParserDriver
]

{ #category : #content }
HTMLParser >> endElement: anElementName prefix: aPrefix uri: aUri localName: aLocalName [
	(self topNode isElement
		and: [self topNode isNamed: anElementName])
		ifTrue: [self popNode]

]

{ #category : #content }
HTMLParser >> startElement: aQualifiedName prefix: aPrefix uri: aUri localName: aLocalName attributes: aDictionary [
	| element |

	(self document root notNil
		and: [(element := self uniqueElementNamed: aQualifiedName) notNil])
		ifTrue: [
			self pushNode: element.
			^ self].

	super
		startElement: aQualifiedName
		prefix: aPrefix
		uri: aUri
		localName: aLocalName
		attributes: aDictionary.
]

{ #category : #private }
HTMLParser >> uniqueElementNamed: anElementName [
	^ anElementName = 'html'
		ifTrue: [self document root]
		ifFalse: [
			(anElementName = 'head' or: [anElementName = 'body'])
				ifTrue: [self document root elementAt: anElementName]
				ifFalse: [nil]]
]
