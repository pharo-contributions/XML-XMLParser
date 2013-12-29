"
This class resolves external entity references using HTTP and file clients.
"
Class {
	#name : #DTDExternalEntityResolver,
	#superclass : #Object,
	#instVars : [
		'httpClient',
		'fileClient'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #private }
DTDExternalEntityResolver >> clientForURI: aUri [
	^ self clientForURIs: (Array with: aUri)
]

{ #category : #private }
DTDExternalEntityResolver >> clientForURIs: aUriColleciton [
	^ (aUriColleciton anySatisfy: [:each |
		self httpClient beginsWithSupportedURLProtocol: each])
		ifTrue: [self httpClient]
		ifFalse: [self fileClient]
]

{ #category : #accessing }
DTDExternalEntityResolver >> defaultDocumentURI [
	^ self fileClient
		pathToFile: 'default'
		inDirectory: self fileClient currentWorkingDirectory
]

{ #category : #accessing }
DTDExternalEntityResolver >> entityURIFromRelative: aRelativeUri andBase: aBaseUri [
	^ (self clientForURIs: (Array with: aBaseUri with: aRelativeUri))
		combineRelative: aRelativeUri
		withBase: aBaseUri
]

{ #category : #accessing }
DTDExternalEntityResolver >> fileClient [
	^ fileClient ifNil: [fileClient := XMLFileClient defaultImplementation new]
]

{ #category : #accessing }
DTDExternalEntityResolver >> fileClient: aClient [
	fileClient := aClient
]

{ #category : #accessing }
DTDExternalEntityResolver >> httpClient [
	^ httpClient ifNil: [httpClient := XMLHTTPClient defaultImplementation new]
]

{ #category : #accessing }
DTDExternalEntityResolver >> httpClient: aClient [
	httpClient := aClient
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveEntity: aUri [
	^ (self clientForURI: aUri) get: aUri
]

{ #category : #private }
DTDExternalEntityResolver >> resolveEntity: aName uri: anEntityUri from: aSourceUri class: aClass [
	| absoluteUri |

	absoluteUri :=
		self
			entityURIFromRelative: anEntityUri
			andBase: aSourceUri.
	^ aClass
		name: aName
		replacement: (self resolveEntity: absoluteUri) contents
		uri: absoluteUri.
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveGeneralEntity: aName uri: anEntityUri from: aSourceUri [
	^ self
		resolveEntity: aName
		uri: anEntityUri
		from: aSourceUri
		class: DTDExternalGeneralEntity
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveParameterEntity: aName uri: anEntityUri from: aSourceUri [
	^ self
		resolveEntity: aName
		uri: anEntityUri
		from: aSourceUri
		class: DTDExternalParameterEntity
]
