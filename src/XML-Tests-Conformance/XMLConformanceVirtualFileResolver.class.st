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
XMLConformanceVirtualFileResolver >> resolveEntity: aUri [
	^ (XMLConformanceVirtualFileHandle path: aUri asXMLURI path) getFromClass: virtualFileClass
]

{ #category : #accessing }
XMLConformanceVirtualFileResolver >> virtualFileClass: aClass [
	virtualFileClass := aClass
]
