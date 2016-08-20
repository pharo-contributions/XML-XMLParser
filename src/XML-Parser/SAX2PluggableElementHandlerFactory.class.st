"
This class is a pluggable element handler factory with an API like XMLPluggableElementFactory. Instances can be injected into a SAX2ElementParser with #elementHandlerFactory: before parsing.

You can map combinations of element name, namespace URI, and attributes to specific element handler classes using the ""handling"" messages, and change the default element handler class when there's no mapping with #elementHandlerClass:.
"
Class {
	#name : #SAX2PluggableElementHandlerFactory,
	#superclass : #SAX2ElementHandlerFactory,
	#instVars : [
		'elementClassMapper',
		'elementHandlerClass'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
SAX2PluggableElementHandlerFactory >> classForElement: aQualifiedName namespaceURI: aURI localName: aLocalName attributes: anAssociationCollection [
	^ elementClassMapper
		classForElement: aQualifiedName
		namespaceURI: aURI
		attributes: anAssociationCollection
		ifNone: [self elementHandlerClass]
]

{ #category : #accessing }
SAX2PluggableElementHandlerFactory >> elementClassMapper [
	^ elementClassMapper
]

{ #category : #accessing }
SAX2PluggableElementHandlerFactory >> elementClassMapper: anElementClassMapper [
	elementClassMapper := anElementClassMapper
]

{ #category : #'private ' }
SAX2PluggableElementHandlerFactory >> elementClassMapperClass [
	^ XMLSimpleElementClassMapper
]

{ #category : #accessing }
SAX2PluggableElementHandlerFactory >> elementHandlerClass [
	^ elementHandlerClass
]

{ #category : #accessing }
SAX2PluggableElementHandlerFactory >> elementHandlerClass: aClass [
	elementHandlerClass := aClass
]

{ #category : #handling }
SAX2PluggableElementHandlerFactory >> handleElement: anElementName attributes: aCollectionOrAttributeSpec withClass: aClass [
	"aCollectionOrAttributeSpec can be some kind of XMLAttributeSpec or a
	collection of associations of required attribute names and values, and the
	required values can be strings, blocks, or nil meaning the attribute is
	required but can take any value"

	elementClassMapper
		mapElement: anElementName
		attributeSpec: aCollectionOrAttributeSpec asXMLAttributeSpec
		toClass: aClass
]

{ #category : #handling }
SAX2PluggableElementHandlerFactory >> handleElement: anElementName namespaceURI: aURI attributes: aCollectionOrAttributeSpec withClass: aClass [
	"aCollectionOrAttributeSpec can be some kind of XMLAttributeSpec or a
	collection of associations of required attribute names and values, and the
	required values can be strings, blocks, or nil meaning the attribute is
	required but can take any value"

	elementClassMapper
		mapElement: anElementName
		namespaceURI: aURI
		attributeSpec: aCollectionOrAttributeSpec asXMLAttributeSpec
		toClass: aClass
]

{ #category : #handling }
SAX2PluggableElementHandlerFactory >> handleElement: anElementName namespaceURI: aURI withClass: aClass [
	elementClassMapper
		mapElement: anElementName
		namespaceURI: aURI
		toClass: aClass
]

{ #category : #handling }
SAX2PluggableElementHandlerFactory >> handleElement: anElementName withClass: aClass [
	elementClassMapper
		mapElement: anElementName
		toClass: aClass
]

{ #category : #handling }
SAX2PluggableElementHandlerFactory >> handleElements: anElementNameCollection namespaceURI: aNamespaceURI withClass: aClass [
	elementClassMapper
		mapElements: anElementNameCollection
		namespaceURI: aNamespaceURI
		toClass: aClass
]

{ #category : #handling }
SAX2PluggableElementHandlerFactory >> handleElements: anElementNameCollection withClass: aClass [
	elementClassMapper
		mapElements: anElementNameCollection
		toClass: aClass
]

{ #category : #handling }
SAX2PluggableElementHandlerFactory >> handleElementsMatchingClass: aClass [
	elementClassMapper mapAllMatchingElementsToClass: aClass
]

{ #category : #handling }
SAX2PluggableElementHandlerFactory >> handleElementsMatchingClasses: aClassCollection [
	elementClassMapper mapAllMatchingElementsToClasses: aClassCollection
]

{ #category : #initialization }
SAX2PluggableElementHandlerFactory >> initialize [
	super initialize.

	elementClassMapper := self elementClassMapperClass new.
	elementHandlerClass := SAX2ElementHandler.
]

{ #category : #copying }
SAX2PluggableElementHandlerFactory >> postCopy [
	super postCopy.

	elementClassMapper := elementClassMapper copy.
]
