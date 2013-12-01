"
This client uses Zinc-HTTP, but does not refer to Zinc classes directly to avoid compile errors on platforms without Zinc.
"
Class {
	#name : #XMLZincClient,
	#superclass : #XMLHTTPClient,
	#category : #'XML-Parser-Clients'
}

{ #category : #paths }
XMLZincClient >> combineRelative: aRelativeUrl withBase: aBaseUrl [
	| url urlClass |

	urlClass := Smalltalk at: #ZnUrl.
	(self beginsWithSupportedURLProtocol: aRelativeUrl)
		ifTrue: [^ (urlClass fromString: aRelativeUrl) printString].

	url := urlClass fromString: aBaseUrl.
	url isDirectoryPath
		ifFalse: [url queryRemoveAll].
	(self isNonRelative: aRelativeUrl)
		ifTrue: [url clearPath]
		ifFalse: [url removeLastPathSegment].
	^ (url / aRelativeUrl) printString.
]

{ #category : #retrieving }
XMLZincClient >> get: aUrl timeout: aTimeout onError: aBlock [
	^ ((Smalltalk at: #ZnClient) new
		timeout: self timeout;
		ifFail: aBlock;
		url: aUrl;
		get) readStream
]
