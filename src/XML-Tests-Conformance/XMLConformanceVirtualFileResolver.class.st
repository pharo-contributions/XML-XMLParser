"
This is a special DTD entity resolver used to resolve virtual external entities stored as test suite class methods.
"
Class {
	#name : #XMLConformanceVirtualFileResolver,
	#superclass : #DTDExternalEntityResolver,
	#instVars : [
		'virtualFileClass'
	],
	#category : #'XML-Tests-Conformance'
}

{ #category : #'instance creation' }
XMLConformanceVirtualFileResolver class >> virtualFileClass: aClass [
	^ self new virtualFileClass: aClass
]

{ #category : #resolving }
XMLConformanceVirtualFileResolver >> resolveEntityURI: aURIOrURIString [
	^ self resolveEntityWith: [:maxSize |
		(XMLConformanceVirtualFileHandle
			virtualPath: aURIOrURIString asXMLURI unescapedPath
			sourceClass: virtualFileClass) get]
]

{ #category : #resolving }
XMLConformanceVirtualFileResolver >> streamResolveEntityURI: aURIOrURIString [
	^ self resolveEntityWith: [:maxSize |
		(XMLConformanceVirtualFileHandle
			virtualPath: aURIOrURIString asXMLURI unescapedPath
			sourceClass: virtualFileClass) streamGet]
]

{ #category : #accessing }
XMLConformanceVirtualFileResolver >> virtualFileClass: aClass [
	virtualFileClass := aClass
]
