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

{ #category : #private }
XMLConformanceVirtualFileExternalEntityResolver >> errorVirtualFilePath: aPath exceedsMazSize: aMaxSize [
	XMLFileException
		formatSignal: 'Virtual file at "{1}" exceeds max size of {2} bytes'
		with: aPath
		with: aMaxSize
]

{ #category : #resolving }
XMLConformanceVirtualFileExternalEntityResolver >> resolveExternalEntityURI: anXMLURIOrURIString upToLimit: aMaxSize [
	| path sourceSelector contents |

	path := anXMLURIOrURIString asXMLURI path.
	sourceSelector := self virtualFileClass sourceSelectorForPath: path.
	(self virtualFileClass respondsTo: sourceSelector)
		ifFalse: [
			self
				errorCannotResolveVirtualFilePath: path
				withSelector: sourceSelector].

	contents := self virtualFileClass perform: sourceSelector.
	(aMaxSize notNil
		and: [contents size > aMaxSize])
		ifTrue: [
			self
				errorVirtualFilePath: path
				exceedsMazSize: aMaxSize].

	^ DTDDecodedResolvedExternalParsedEntityReplacement contents: contents.
]

{ #category : #resolving }
XMLConformanceVirtualFileExternalEntityResolver >> streamResolveExternalEntityURI: anXMLURIOrURIString upToLimit: aMaxSize [
	^ (self
		resolveExternalEntityURI: anXMLURIOrURIString
		upToLimit: aMaxSize) readStream
]

{ #category : #accessing }
XMLConformanceVirtualFileExternalEntityResolver >> virtualFileClass [
	^ virtualFileClass
]

{ #category : #accessing }
XMLConformanceVirtualFileExternalEntityResolver >> virtualFileClass: aClass [
	virtualFileClass := aClass
]
