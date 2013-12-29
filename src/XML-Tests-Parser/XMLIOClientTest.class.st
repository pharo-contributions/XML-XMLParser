Class {
	#name : #XMLIOClientTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #tests }
XMLIOClientTest >> testClientSelectionFromURI [
	| resolver |

	resolver := DTDExternalEntityResolver new.
	self
		assert: ((resolver clientForURI: 'relative/path') isKindOf: XMLFileClient);
		assert: ((resolver clientForURI: '/absolute/path') isKindOf: XMLFileClient);
		assert: ((resolver clientForURI: 'http://www.example.com') isKindOf: XMLHTTPClient).
]

{ #category : #tests }
XMLIOClientTest >> testClientSelectionFromURIs [
	| resolver |

	resolver := DTDExternalEntityResolver new.
	self
		assert: ((resolver clientForURIs: #('relative' '/absolute')) isKindOf: XMLFileClient);
		assert: ((resolver clientForURIs: #('relative/path' 'relative')) isKindOf: XMLFileClient);
		assert: ((resolver clientForURIs: #('/absolute' '/absolute/path')) isKindOf: XMLFileClient).
	self assert:
		((resolver clientForURIs: #('http://www.example.com' 'relative'))
			isKindOf: XMLHTTPClient).
	self assert:
		((resolver clientForURIs: #('/absolute/path' 'http://www.example.com'))
			isKindOf: XMLHTTPClient).
	self assert:
		((resolver clientForURIs: #('http://www.example.com' 'http://www.example.com'))
			isKindOf: XMLHTTPClient).
]

{ #category : #tests }
XMLIOClientTest >> testFileClientPaths [
	| fileClient cwd cwdParent |

	fileClient := XMLFileClient defaultImplementation new.
	cwd := fileClient currentWorkingDirectory.
	cwdParent := cwd copyUpToLast: $/.
	self
		assert: cwd first == $/;
		deny: cwd last == $/;
		assert: (fileClient combineRelative: 'relative' withBase: 'relative/path') = 'relative/relative';
		assert: (fileClient combineRelative: 'relative/path' withBase: 'relative/path') = 'relative/relative/path';
		assert: (fileClient combineRelative: 'relative' withBase: cwd) = (cwdParent, '/relative');
		assert: (fileClient combineRelative: '/nonrelative' withBase: cwd) = '/nonrelative';
		assert: (fileClient combineRelative: '../../relative' withBase: cwd) = (cwdParent, '/../../relative');
		assert: (fileClient combineRelative: './relative' withBase: cwd) = (cwdParent, '/relative');
		assert: (fileClient combineRelative: '.relative' withBase: cwd) = (cwdParent, '/.relative').
]

{ #category : #tests }
XMLIOClientTest >> testHTTPClientPaths [
	| httpClient domain directoryUrl documentUrl queryUrl |

	httpClient := XMLHTTPClient defaultImplementation new.
	domain := 'http://www.example.com'.
	directoryUrl := domain, '/documents/'.
	documentUrl := directoryUrl, 'document.xml'.
	queryUrl := documentUrl, '?name=value'.
	self
		assert: (httpClient combineRelative: directoryUrl withBase: domain) = directoryUrl;
		assert: (httpClient combineRelative: '/nonrelative' withBase: domain) = (domain, '/nonrelative');
		assert: (httpClient combineRelative: '/nonrelative' withBase: directoryUrl) = (domain, '/nonrelative');
		assert: (httpClient combineRelative: '/nonrelative' withBase: documentUrl) = (domain, '/nonrelative');
		assert: (httpClient combineRelative: 'relative.xml' withBase: directoryUrl) = (directoryUrl, 'relative.xml');
		assert: (httpClient combineRelative: 'relative.xml' withBase: documentUrl) = (directoryUrl, 'relative.xml');
		assert: (httpClient combineRelative: 'relative.xml' withBase: queryUrl) = (directoryUrl, 'relative.xml').
]
