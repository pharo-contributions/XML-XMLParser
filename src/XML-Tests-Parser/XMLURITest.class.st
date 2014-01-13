Class {
	#name : #XMLURITest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #strings }
XMLURITest >> absolute [
	^ '/absolute/path'
]

{ #category : #strings }
XMLURITest >> absoluteDir [
	^ '/absolute/path/'
]

{ #category : #strings }
XMLURITest >> absoluteDirRelativeCombined [
	^ '/absolute/path/relative/path'
]

{ #category : #strings }
XMLURITest >> absoluteRelativeCombined [
	^ '/absolute/relative/path'
]

{ #category : #strings }
XMLURITest >> domain [
	^ 'http://www.example.com'
]

{ #category : #strings }
XMLURITest >> fileHostURIString [
	^ 'file://', self host, self absolute
]

{ #category : #strings }
XMLURITest >> fileURIString [
	^ 'file://', self absolute
]

{ #category : #strings }
XMLURITest >> fragment [
	^ '#fragmentID'
]

{ #category : #strings }
XMLURITest >> fullURIString [
	^ self domain, self absolute, self queryString, self fragment
]

{ #category : #strings }
XMLURITest >> host [
	^ self domain copyAfterLast: $/
]

{ #category : #strings }
XMLURITest >> queryString [
	^ '?name1=value1&name2=value2'
]

{ #category : #strings }
XMLURITest >> relative [
	^ 'relative/path'
]

{ #category : #strings }
XMLURITest >> scheme [
	^ self domain copyUpTo: $:
]

{ #category : #strings }
XMLURITest >> schemelessURIString [
	^ (self domain copyAfter: $:), self absolute, self queryString, self fragment
]

{ #category : #tests }
XMLURITest >> testCombiningAbsoluteURIs [
	| domainUri fullUri fileUri relativeUri |

	domainUri := self domain asXMLURI.
	fullUri := self fullURIString asXMLURI.
	fileUri := self fileURIString asXMLURI.
	relativeUri := self relative asXMLURI.
	self
		assert: (domainUri / self fullURIString) = fullUri;
		assert: (fullUri / self domain) = domainUri;
		assert: (fullUri / self fileURIString) = fileUri;
		assert: (relativeUri / self domain) = domainUri;
		assert: (relativeUri / self fullURIString) = fullUri;
		assert: (relativeUri / self fileURIString) = fileUri.
]

{ #category : #tests }
XMLURITest >> testCombiningRelativeURIs [
	| domainUri absolutePathUri absoluteDirPathUri |

	domainUri := self domain asXMLURI.
	absolutePathUri := (self domain, self absolute) asXMLURI.
	absoluteDirPathUri := (self domain, self absoluteDir) asXMLURI.
	self
		assert: (domainUri / self absolute) = (self domain, self absolute) asXMLURI;
		assert: (domainUri / self absoluteDir) = (self domain, self absoluteDir) asXMLURI;
		assert: (absolutePathUri / self relative) = (self domain, self absoluteRelativeCombined) asXMLURI;
		assert: (absoluteDirPathUri / self relative) = (self domain, self absoluteDirRelativeCombined) asXMLURI;
		assert: (absolutePathUri / self queryString) = (self domain, self absolute, self queryString) asXMLURI;
		assert: (absolutePathUri / self fragment) = (self domain, self absolute, self fragment) asXMLURI;
		assert: (domainUri / self schemelessURIString) = self fullURIString asXMLURI.
]

{ #category : #tests }
XMLURITest >> testConverting [
	| fullUri |

	fullUri := XMLURI fromString: self fullURIString.

	self
		assert: self fullURIString asXMLURI = fullUri;
		assert: fullUri asXMLURI == fullUri.
]

{ #category : #tests }
XMLURITest >> testParsingAbsolutePathURI [
	| uri |

	uri := self absolute asXMLURI.
	self
		deny: uri isFileURI;
		assert: uri isRelative;
		assert: uri isLocalURI;
		assert: uri scheme isEmpty;
		assert: uri host isEmpty;
		assert: uri path = self absolute;
		assert: uri queryString isEmpty;
		assert: uri fragment isEmpty.
]

{ #category : #tests }
XMLURITest >> testParsingDomainURI [
	| uri |

	uri := self domain asXMLURI.
	self
		deny: uri isFileURI;
		deny: uri isRelative;
		deny: uri isLocalURI;
		assert: uri scheme = self scheme;
		assert: uri host = self host;
		assert: uri path isEmpty;
		assert: uri queryString isEmpty;
		assert: uri fragment isEmpty.
]

{ #category : #tests }
XMLURITest >> testParsingFileHostURI [
	| uri |

	uri := self fileHostURIString asXMLURI.
	self
		deny: uri isRelative;
		assert: uri isFileURI;
		assert: uri isLocalURI;
		assert: uri scheme = 'file';
		assert: uri host = self host;
		assert: uri path = self absolute;
		assert: uri queryString isEmpty;
		assert: uri fragment isEmpty.
]

{ #category : #tests }
XMLURITest >> testParsingFileURI [
	| uri |

	uri := self fileURIString asXMLURI.
	self
		deny: uri isRelative;
		assert: uri isFileURI;
		assert: uri isLocalURI;
		assert: uri scheme = 'file';
		assert: uri host isEmpty;
		assert: uri path = self absolute;
		assert: uri queryString isEmpty;
		assert: uri fragment isEmpty.
]

{ #category : #tests }
XMLURITest >> testParsingFullURI [
	| uri |

	uri := self fullURIString asXMLURI.
	self
		deny: uri isFileURI;
		deny: uri isRelative;
		deny: uri isLocalURI;
		assert: uri scheme = self scheme;
		assert: uri host = self host;
		assert: uri path = self absolute;
		assert: uri queryString = self queryString allButFirst;
		assert: uri fragment = self fragment allButFirst.
]

{ #category : #tests }
XMLURITest >> testParsingRelativePathURI [
	| uri |

	uri := self relative asXMLURI.
	self
		deny: uri isFileURI;
		assert: uri isRelative;
		assert: uri isLocalURI;
		assert: uri scheme isEmpty;
		assert: uri host isEmpty;
		assert: uri path = self relative;
		assert: uri queryString isEmpty;
		assert: uri fragment isEmpty.
]

{ #category : #tests }
XMLURITest >> testParsingURIWithoutScheme [
	| uri |

	uri := self schemelessURIString asXMLURI.
	self
		deny: uri isFileURI;
		assert: uri isRelative;
		assert: uri isLocalURI;
		assert: uri scheme isEmpty;
		assert: uri host = self host;
		assert: uri path = self absolute;
		assert: uri queryString = self queryString allButFirst;
		assert: uri fragment = self fragment allButFirst.
]

{ #category : #tests }
XMLURITest >> testSchemeAndHostCaseSensitivity [
	| uri uppercaseUri |

	uri := self fullURIString asXMLURI.
	uppercaseUri := self fullURIString asUppercase asXMLURI.
	self
		assert: uri scheme = uppercaseUri scheme;
		assert: uri host = uppercaseUri host;
		deny: uri path = uppercaseUri path;
		deny: uri queryString = uppercaseUri queryString;
		deny: uri fragment = uppercaseUri fragment.
]

{ #category : #tests }
XMLURITest >> testURIEquality [
	| fullUri string |

	string := self fullURIString.
	fullUri := string asXMLURI.
	self
		assert: fullUri = fullUri;
		assert: fullUri = string asXMLURI;
		deny: fullUri = (string copyReplaceAll: self scheme with: 'new') asXMLURI;
		deny: fullUri = (string copyReplaceAll: self host with: 'new') asXMLURI;
		deny: fullUri = (string copyReplaceAll: self absolute with: 'new') asXMLURI;
		deny: fullUri = (string copyReplaceAll: self queryString with: 'new') asXMLURI;
		deny: fullUri = (string copyReplaceAll: self fragment with: 'new') asXMLURI.
]

{ #category : #tests }
XMLURITest >> testURIPrinting [
	self
		assert: self fullURIString asXMLURI printString = self fullURIString;
		assert: self schemelessURIString asXMLURI printString = self schemelessURIString;
		assert: self absolute asXMLURI printString = self absolute;
		assert: self relative asXMLURI printString = self relative;
		assert: self absoluteDir asXMLURI printString = self absoluteDir;
		assert: self fileURIString asXMLURI printString = self fileURIString;
		assert: self fileHostURIString asXMLURI printString = self fileHostURIString;
		assert: '/' asXMLURI printString = '/';
		assert: '' asXMLURI printString isEmpty.
]