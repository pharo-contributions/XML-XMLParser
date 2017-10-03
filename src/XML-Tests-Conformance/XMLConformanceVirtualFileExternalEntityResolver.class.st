"
This is a special DTD external entity resolver used to resolve virtual external entities stored as test suite class methods that return strings.
"
Class {
	#name : #XMLConformanceVirtualFileExternalEntityResolver,
	#superclass : #DTDExternalEntityResolver,
	#instVars : [
		'virtualFileClass'
	],
	#category : #'XML-Tests-Conformance-Files'
}

{ #category : #'instance creation' }
XMLConformanceVirtualFileExternalEntityResolver class >> virtualFileClass: aClass [
	^ self new virtualFileClass: aClass
]

{ #category : #private }
XMLConformanceVirtualFileExternalEntityResolver >> errorCannotResolveVirtualFilePath: aPath withSelector: aSelector [
	XMLFileException
		formatSignal:
			'Cannot resolve virtual file path "{1}" by sending #{2} to {3}: {4}'
		with: aPath
		with: aSelector asString
		with: self virtualFileClass name asString
		with: 'message not understood'
]

{ #category : #resolving }
XMLConformanceVirtualFileExternalEntityResolver >> resolveExternalEntityURI: anXMLURIOrURIString [
	| path sourceSelector |

	path := anXMLURIOrURIString asXMLURI path.
	sourceSelector := self virtualFileClass sourceSelectorForPath: path.
	(self virtualFileClass respondsTo: sourceSelector)
		ifFalse: [
			self
				errorCannotResolveVirtualFilePath: path
				withSelector: sourceSelector].
	^ self virtualFileClass perform: sourceSelector.
]

{ #category : #resolving }
XMLConformanceVirtualFileExternalEntityResolver >> streamResolveExternalEntityURI: anXMLURIOrURIString [
	^ (self resolveExternalEntityURI: anXMLURIOrURIString) readStream
]

{ #category : #accessing }
XMLConformanceVirtualFileExternalEntityResolver >> virtualFileClass [
	^ virtualFileClass
]

{ #category : #accessing }
XMLConformanceVirtualFileExternalEntityResolver >> virtualFileClass: aClass [
	virtualFileClass := aClass
]
