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
XMLConformanceVirtualFileResolver >> resolveEntityURI: aUri [
	^ (XMLConformanceVirtualFileHandle
		virtualPath: aUri asXMLURI unescapedPath
		sourceClass: virtualFileClass) get
]

{ #category : #accessing }
XMLConformanceVirtualFileResolver >> virtualFileClass: aClass [
	virtualFileClass := aClass
]
