"
This class resolves external entity references using HTTP and file clients.
"
Class {
	#name : #DTDExternalEntityResolver,
	#superclass : #Object,
	#category : #'XML-Parser-DTD'
}

{ #category : #combining }
DTDExternalEntityResolver >> combineURI: aBaseUri with: aRelativeUri [
	| baseUri combinedUri |

	baseUri := XMLURI fromString: aBaseUri.
	combinedUri := baseUri / aRelativeUri.
	(combinedUri isLocalURI and: [baseUri isLocalURI not])
		ifTrue: [XMLLimitException signal: 'Local URI referenced from non-local URI'].

	^ combinedUri.
]

{ #category : #accessing }
DTDExternalEntityResolver >> defaultDocumentURI [
	^ XMLFileHandle defaultImplementation currentWorkingDirectoryPath, '/default'
]

{ #category : #resolving }
DTDExternalEntityResolver >> resolveEntity: aUri [
	^ aUri asXMLURI get
]

{ #category : #private }
DTDExternalEntityResolver >> resolveEntity: aName uri: anEntityUri from: aSourceUri class: aClass [
	| combinedUri |

	combinedUri :=
		self
			combineURI: aSourceUri
			with: anEntityUri.
	^ aClass
		name: aName
		replacement: (self resolveEntity: combinedUri) contents
		uri: combinedUri asString.
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
