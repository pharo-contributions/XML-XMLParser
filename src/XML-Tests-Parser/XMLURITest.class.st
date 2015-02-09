Class {
	#name : #XMLURITest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser'
}

{ #category : #private }
XMLURITest class >> generateStandardURICombiningTest [
	"self generateStandardURICombiningTest"
	| readStream isFirstTest source |

	readStream := self standardURICombiningTestTemplate readStream.
	isFirstTest := true.
	source :=
		String streamContents: [:writeStream |
			writeStream nextPutAll: 'testStandardURICombining
	| baseUri |

	baseUri := ''', self standardURICombiningTestBaseURI, ''' asXMLURI.
	self'.
			[readStream atEnd]
				whileFalse: [| argument result |
					readStream skipTo: $".
					argument := readStream upTo: $".
					readStream skipTo: $".
					result := readStream upTo: $".
					(argument isEmpty and: [result isEmpty])
						ifFalse: [
							isFirstTest
								ifTrue: [isFirstTest := false]
								ifFalse: [writeStream nextPut: $;].
							writeStream nextPutAll: '
		assert: (baseUri / ''', argument, ''' asXMLURI) = ''', result, ''' asXMLURI']]].

	self
		compile: source
		classified: 'tests'.
]

{ #category : #private }
XMLURITest class >> standardURICombiningTestBaseURI [
	^ 'http://a/b/c/d;p?q'
]

{ #category : #private }
XMLURITest class >> standardURICombiningTestTemplate [
	^ '
      "g:h"           =  "g:h"
      "g"             =  "http://a/b/c/g"
      "./g"           =  "http://a/b/c/g"
      "g/"            =  "http://a/b/c/g/"
      "/g"            =  "http://a/g"
      "//g"           =  "http://g"
      "?y"            =  "http://a/b/c/d;p?y"
      "g?y"           =  "http://a/b/c/g?y"
      "#s"            =  "http://a/b/c/d;p?q#s"
      "g#s"           =  "http://a/b/c/g#s"
      "g?y#s"         =  "http://a/b/c/g?y#s"
      ";x"            =  "http://a/b/c/;x"
      "g;x"           =  "http://a/b/c/g;x"
      "g;x?y#s"       =  "http://a/b/c/g;x?y#s"
      ""              =  "http://a/b/c/d;p?q"
      "."             =  "http://a/b/c/"
      "./"            =  "http://a/b/c/"
      ".."            =  "http://a/b/"
      "../"           =  "http://a/b/"
      "../g"          =  "http://a/b/g"
      "../.."         =  "http://a/"
      "../../"        =  "http://a/"
      "../../g"       =  "http://a/g"

      "../../../g"    =  "http://a/g"
      "../../../../g" =  "http://a/g"


      "/./g"          =  "http://a/g"
      "/../g"         =  "http://a/g"
      "g."            =  "http://a/b/c/g."
      ".g"            =  "http://a/b/c/.g"
      "g.."           =  "http://a/b/c/g.."
      "..g"           =  "http://a/b/c/..g"

      "./../g"        =  "http://a/b/g"
      "./g/."         =  "http://a/b/c/g/"
      "g/./h"         =  "http://a/b/c/g/h"
      "g/../h"        =  "http://a/b/c/h"
      "g;x=1/./y"     =  "http://a/b/c/g;x=1/y"
      "g;x=1/../y"    =  "http://a/b/c/y"

      "g?y/./x"       =  "http://a/b/c/g?y/./x"
      "g?y/../x"      =  "http://a/b/c/g?y/../x"
      "g#s/./x"       =  "http://a/b/c/g#s/./x"
      "g#s/../x"      =  "http://a/b/c/g#s/../x"

      "http:g"        =  "http:g"
'
]

{ #category : #accessing }
XMLURITest >> absolute [
	^ '/absolute/path'
]

{ #category : #accessing }
XMLURITest >> absoluteDir [
	^ '/absolute/path/'
]

{ #category : #accessing }
XMLURITest >> absoluteDirRelativeCombined [
	^ '/absolute/path/relative/path'
]

{ #category : #accessing }
XMLURITest >> absoluteRelativeCombined [
	^ '/absolute/relative/path'
]

{ #category : #accessing }
XMLURITest >> domain [
	^ 'http://www.example.com'
]

{ #category : #accessing }
XMLURITest >> domainWithPort [
	^ self domain, ':80'
]

{ #category : #accessing }
XMLURITest >> emailURIString [
	^ 'mailto:', self userInfo, '@', self host
]

{ #category : #accessing }
XMLURITest >> escaped [
	^ '%20%22%3c%3E%25+'
]

{ #category : #accessing }
XMLURITest >> fileHostURIString [
	^ 'file://', self host, self absolute
]

{ #category : #accessing }
XMLURITest >> fileURIString [
	^ 'file://', self absolute
]

{ #category : #accessing }
XMLURITest >> fragment [
	^ '#fragmentID'
]

{ #category : #accessing }
XMLURITest >> fullURIString [
	^ self domain, self absolute, self queryString, self fragment
]

{ #category : #accessing }
XMLURITest >> fullURIWithPortString [
	^ self domainWithPort, self absolute, self queryString, self fragment
]

{ #category : #accessing }
XMLURITest >> host [
	^ self domain copyAfterLast: $/
]

{ #category : #accessing }
XMLURITest >> port [
	^ 80
]

{ #category : #accessing }
XMLURITest >> queryString [
	^ '?name1=value1&name2=value2'
]

{ #category : #accessing }
XMLURITest >> relative [
	^ 'relative/path'
]

{ #category : #accessing }
XMLURITest >> relativeAbsoluteCombined [
	^ 'relative/absolute/path'
]

{ #category : #accessing }
XMLURITest >> scheme [
	^ self domain copyUpTo: $:
]

{ #category : #accessing }
XMLURITest >> schemelessURIString [
	^ (self domain copyAfter: $:), self absolute, self queryString, self fragment
]

{ #category : #accessing }
XMLURITest >> schemelessURIWithPortString [
	^ (self domainWithPort copyAfter: $:), self absolute, self queryString, self fragment
]

{ #category : #tests }
XMLURITest >> testCombiningAbsoluteURIs [
	| domainUri fullUri fileUri |

	domainUri := self domain asXMLURI.
	fullUri := self fullURIString asXMLURI.
	fileUri := self fileURIString asXMLURI.
	self
		assert: (domainUri / self fullURIString) = fullUri;
		assert: (domainUri / self domain) = domainUri;
		assert: (domainUri / self fileURIString) = fileUri;
		assert: (fullUri / self fullURIString) = fullUri;
		assert: (fullUri / self domain) = domainUri;
		assert: (fullUri / self fileURIString) = fileUri;
		assert: (fileUri / self fullURIString) = fullUri;
		assert: (fileUri / self domain) = domainUri;
		assert: (fileUri / self fileURIString) = fileUri.
]

{ #category : #tests }
XMLURITest >> testCombiningDotPathURIs [
	| relativePathUri absolutePathUri fullUri |

	relativePathUri := self relative asXMLURI.
	self
		assert: (relativePathUri / '.') = 'relative/' asXMLURI;
		assert: (relativePathUri / './.') = 'relative/' asXMLURI;
		assert: (relativePathUri / './path') = relativePathUri;
		assert: (relativePathUri / ('.', self absolute)) = self relativeAbsoluteCombined asXMLURI.

	absolutePathUri := self absolute asXMLURI.
	self
		assert: (absolutePathUri / '.') = '/absolute/' asXMLURI;
		assert: (absolutePathUri / './.') = '/absolute/' asXMLURI;
		assert: (absolutePathUri / './path') = absolutePathUri;
		assert: (absolutePathUri / ('./', self relative)) = self absoluteRelativeCombined asXMLURI.

	fullUri := self fullURIString asXMLURI.
	self
		assert: (fullUri / '.') = (self domain, '/absolute/') asXMLURI;
		assert: (fullUri / './.') = (self domain, '/absolute/') asXMLURI;
		assert: (fullUri / './path') = (self domain, self absolute) asXMLURI;
		assert: (fullUri / ('./', self relative)) = (self domain, self absoluteRelativeCombined) asXMLURI.
]

{ #category : #tests }
XMLURITest >> testCombiningDoubleDotPathURIs [
	| relativePathUri absolutePathUri fullUri |

	relativePathUri := self relative asXMLURI.
	self
		assert: (relativePathUri / '..') isEmpty;
		assert: (relativePathUri / '../..') isEmpty;
		assert: (relativePathUri / ('..', self absolute)) = 'absolute/path' asXMLURI;
		assert: (relativePathUri / ('../..', self absolute)) = 'absolute/path' asXMLURI;
		assert: (relativePathUri / ('../..', self absolute, '/..')) = 'absolute/' asXMLURI;
		assert: (relativePathUri / ('../..', self absolute, '/../..')) isEmpty.

	absolutePathUri := self absolute asXMLURI.
	self
		assert: (absolutePathUri / '..') hasRootPath;
		assert: (absolutePathUri / '../..') isEmpty;
		assert: (absolutePathUri / ('..', self absolute)) = absolutePathUri;
		assert: (absolutePathUri / ('../..', self absolute)) = 'absolute/path' asXMLURI;
		assert: (absolutePathUri / ('../..', self absolute, '/..')) = 'absolute/' asXMLURI;
		assert: (absolutePathUri / ('../..', self absolute, '/../..')) isEmpty.

	fullUri := self fullURIString asXMLURI.
	self
		assert: (fullUri / '..') hasRootPath;
		deny: (fullUri / '../..') hasPath;
		assert: (fullUri / ('..', self absolute)) = (self domain, self absolute) asXMLURI;
		assert: (fullUri / ('../..', self absolute)) = (self domain, self absolute) asXMLURI;
		assert: (fullUri / ('../..', self absolute, '/..')) = (self domain, '/absolute/') asXMLURI;
		assert: (fullUri / ('../..', self absolute, '/../')) = (self domain, '/absolute/') asXMLURI.
]

{ #category : #tests }
XMLURITest >> testCombiningRelativeURIs [
	| domainUri domainUriWithPort absolutePathUri absoluteDirPathUri |

	domainUri := self domain asXMLURI.
	domainUriWithPort := self domainWithPort asXMLURI.
	absolutePathUri := (self domain, self absolute) asXMLURI.
	absoluteDirPathUri := (self domain, self absoluteDir) asXMLURI.
	self
		assert: (domainUri / self relative) = (self domain, '/', self relative) asXMLURI;
		assert: (domainUri / self absolute) = (self domain, self absolute) asXMLURI;
		assert: (domainUri / self absoluteDir) = (self domain, self absoluteDir) asXMLURI;
		assert: (domainUriWithPort / self relative) = (self domainWithPort, '/', self relative) asXMLURI;
		assert: (domainUriWithPort / self absolute) = (self domainWithPort, self absolute) asXMLURI;
		assert: (domainUriWithPort / self absoluteDir) = (self domainWithPort, self absoluteDir) asXMLURI;
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
XMLURITest >> testIsEmpty [
	self
		assert: '' asXMLURI isEmpty;
		deny: '/' asXMLURI isEmpty;
		deny: self relative asXMLURI isEmpty;
		deny: self absolute asXMLURI isEmpty;
		deny: self domain asXMLURI isEmpty;
		deny: self queryString asXMLURI isEmpty;
		deny: self fragment asXMLURI isEmpty
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
		assert: uri userInfo isEmpty;
		assert: uri host isEmpty;
		assert: uri port isNil;
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
		assert: uri userInfo isEmpty;
		assert: uri host = self host;
		assert: uri port isNil;
		assert: uri path isEmpty;
		assert: uri queryString isEmpty;
		assert: uri fragment isEmpty.
]

{ #category : #tests }
XMLURITest >> testParsingDomainURIWithPort [
	| uri |

	uri := self domainWithPort asXMLURI.
	self
		deny: uri isFileURI;
		deny: uri isRelative;
		deny: uri isLocalURI;
		assert: uri scheme = self scheme;
		assert: uri userInfo isEmpty;
		assert: uri host = self host;
		assert: uri port = self port;
		assert: uri path isEmpty;
		assert: uri queryString isEmpty;
		assert: uri fragment isEmpty.
]

{ #category : #tests }
XMLURITest >> testParsingEmailURI [
	| uri |

	uri := self emailURIString asXMLURI.
	self
		deny: uri isFileURI;
		deny: uri isRelative;
		deny: uri isLocalURI;
		assert: uri scheme = 'mailto';
		assert: uri userInfo = self userInfo;
		assert: uri host = self host;
		assert: uri port isNil;
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
		assert: uri userInfo isEmpty;
		assert: uri host = self host;
		assert: uri port isNil;
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
		assert: uri userInfo isEmpty;
		assert: uri host isEmpty;
		assert: uri port isNil;
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
		assert: uri userInfo isEmpty;
		assert: uri host = self host;
		assert: uri port isNil;
		assert: uri path = self absolute;
		assert: uri queryString = self queryString allButFirst;
		assert: uri fragment = self fragment allButFirst.
]

{ #category : #tests }
XMLURITest >> testParsingFullURIWithPort [
	| uri |

	uri := self fullURIWithPortString asXMLURI.
	self
		deny: uri isFileURI;
		deny: uri isRelative;
		deny: uri isLocalURI;
		assert: uri scheme = self scheme;
		assert: uri userInfo isEmpty;
		assert: uri host = self host;
		assert: uri port = self port;
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
		assert: uri userInfo isEmpty;
		assert: uri host isEmpty;
		assert: uri port isNil;
		assert: uri path = self relative;
		assert: uri queryString isEmpty;
		assert: uri fragment isEmpty.
]

{ #category : #tests }
XMLURITest >> testParsingSchemelessURI [
	| uri |

	uri := self schemelessURIString asXMLURI.
	self
		deny: uri isFileURI;
		assert: uri isRelative;
		assert: uri isLocalURI;
		assert: uri scheme isEmpty;
		assert: uri userInfo isEmpty;
		assert: uri host = self host;
		assert: uri port isNil;
		assert: uri path = self absolute;
		assert: uri queryString = self queryString allButFirst;
		assert: uri fragment = self fragment allButFirst.
]

{ #category : #tests }
XMLURITest >> testParsingSchemelessURIWithPort [
	| uri |

	uri := self schemelessURIWithPortString asXMLURI.
	self
		deny: uri isFileURI;
		assert: uri isRelative;
		assert: uri isLocalURI;
		assert: uri scheme isEmpty;
		assert: uri userInfo isEmpty;
		assert: uri host = self host;
		assert: uri port = self port;
		assert: uri path = self absolute;
		assert: uri queryString = self queryString allButFirst;
		assert: uri fragment = self fragment allButFirst.
]

{ #category : #tests }
XMLURITest >> testPathUnescaping [
	| uri |

	uri := (self escaped, self relative, self escaped) asXMLURI.
	self
		assert: uri path = (self escaped, self relative, self escaped);
		assert: uri unescapedPath = (self unescaped, self relative, self unescaped);
		assert: '%' asXMLURI unescapedPath = '%'
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
XMLURITest >> testStandardURICombining [
	| baseUri |

	baseUri := 'http://a/b/c/d;p?q' asXMLURI.
	self
		assert: (baseUri / 'g:h' asXMLURI) = 'g:h' asXMLURI;
		assert: (baseUri / 'g' asXMLURI) = 'http://a/b/c/g' asXMLURI;
		assert: (baseUri / './g' asXMLURI) = 'http://a/b/c/g' asXMLURI;
		assert: (baseUri / 'g/' asXMLURI) = 'http://a/b/c/g/' asXMLURI;
		assert: (baseUri / '/g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseUri / '//g' asXMLURI) = 'http://g' asXMLURI;
		assert: (baseUri / '?y' asXMLURI) = 'http://a/b/c/d;p?y' asXMLURI;
		assert: (baseUri / 'g?y' asXMLURI) = 'http://a/b/c/g?y' asXMLURI;
		assert: (baseUri / '#s' asXMLURI) = 'http://a/b/c/d;p?q#s' asXMLURI;
		assert: (baseUri / 'g#s' asXMLURI) = 'http://a/b/c/g#s' asXMLURI;
		assert: (baseUri / 'g?y#s' asXMLURI) = 'http://a/b/c/g?y#s' asXMLURI;
		assert: (baseUri / ';x' asXMLURI) = 'http://a/b/c/;x' asXMLURI;
		assert: (baseUri / 'g;x' asXMLURI) = 'http://a/b/c/g;x' asXMLURI;
		assert: (baseUri / 'g;x?y#s' asXMLURI) = 'http://a/b/c/g;x?y#s' asXMLURI;
		assert: (baseUri / '' asXMLURI) = 'http://a/b/c/d;p?q' asXMLURI;
		assert: (baseUri / '.' asXMLURI) = 'http://a/b/c/' asXMLURI;
		assert: (baseUri / './' asXMLURI) = 'http://a/b/c/' asXMLURI;
		assert: (baseUri / '..' asXMLURI) = 'http://a/b/' asXMLURI;
		assert: (baseUri / '../' asXMLURI) = 'http://a/b/' asXMLURI;
		assert: (baseUri / '../g' asXMLURI) = 'http://a/b/g' asXMLURI;
		assert: (baseUri / '../..' asXMLURI) = 'http://a/' asXMLURI;
		assert: (baseUri / '../../' asXMLURI) = 'http://a/' asXMLURI;
		assert: (baseUri / '../../g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseUri / '../../../g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseUri / '../../../../g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseUri / '/./g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseUri / '/../g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseUri / 'g.' asXMLURI) = 'http://a/b/c/g.' asXMLURI;
		assert: (baseUri / '.g' asXMLURI) = 'http://a/b/c/.g' asXMLURI;
		assert: (baseUri / 'g..' asXMLURI) = 'http://a/b/c/g..' asXMLURI;
		assert: (baseUri / '..g' asXMLURI) = 'http://a/b/c/..g' asXMLURI;
		assert: (baseUri / './../g' asXMLURI) = 'http://a/b/g' asXMLURI;
		assert: (baseUri / './g/.' asXMLURI) = 'http://a/b/c/g/' asXMLURI;
		assert: (baseUri / 'g/./h' asXMLURI) = 'http://a/b/c/g/h' asXMLURI;
		assert: (baseUri / 'g/../h' asXMLURI) = 'http://a/b/c/h' asXMLURI;
		assert: (baseUri / 'g;x=1/./y' asXMLURI) = 'http://a/b/c/g;x=1/y' asXMLURI;
		assert: (baseUri / 'g;x=1/../y' asXMLURI) = 'http://a/b/c/y' asXMLURI;
		assert: (baseUri / 'g?y/./x' asXMLURI) = 'http://a/b/c/g?y/./x' asXMLURI;
		assert: (baseUri / 'g?y/../x' asXMLURI) = 'http://a/b/c/g?y/../x' asXMLURI;
		assert: (baseUri / 'g#s/./x' asXMLURI) = 'http://a/b/c/g#s/./x' asXMLURI;
		assert: (baseUri / 'g#s/../x' asXMLURI) = 'http://a/b/c/g#s/../x' asXMLURI;
		assert: (baseUri / 'http:g' asXMLURI) = 'http:g' asXMLURI
]

{ #category : #tests }
XMLURITest >> testURIEquality [
	| fullUri string emailUri |

	string := self fullURIString.
	fullUri := string asXMLURI.
	self
		assert: fullUri = fullUri;
		assert: fullUri = string asXMLURI;
		deny: fullUri = (string copyReplaceAll: self scheme with: 'new') asXMLURI;
		deny: fullUri = (string copyReplaceAll: '://' with: ':') asXMLURI;
		deny: fullUri = (string copyReplaceAll: self host with: 'new') asXMLURI;
		deny: fullUri = (string copyReplaceAll: self absolute with: 'new') asXMLURI;
		deny: fullUri = (string copyReplaceAll: self queryString with: 'new') asXMLURI;
		deny: fullUri = (string copyReplaceAll: self fragment with: 'new') asXMLURI.

	string := self emailURIString.
	emailUri := string asXMLURI.
	self
		assert: emailUri = emailUri;
		assert: emailUri = string asXMLURI;
		deny: fullUri = (string copyReplaceAll: self userInfo with: 'new') asXMLURI.
]

{ #category : #tests }
XMLURITest >> testURIPrinting [
	self
		assert: self fullURIString asXMLURI printString = self fullURIString;
		assert: self fullURIWithPortString asXMLURI printString = self fullURIWithPortString;
		assert: self schemelessURIString asXMLURI printString = self schemelessURIString;
		assert: self domain asXMLURI printString = self domain;
		assert: self domainWithPort asXMLURI printString = self domainWithPort;
		assert: self absolute asXMLURI printString = self absolute;
		assert: self relative asXMLURI printString = self relative;
		assert: self absoluteDir asXMLURI printString = self absoluteDir;
		assert: self fileURIString asXMLURI printString = self fileURIString;
		assert: self fileHostURIString asXMLURI printString = self fileHostURIString;
		assert: self emailURIString asXMLURI printString = self emailURIString;
		assert: '/' asXMLURI printString = '/';
		assert: '' asXMLURI printString isEmpty.
]

{ #category : #accessing }
XMLURITest >> unescaped [
	"the + is not an escape in paths, only in query strings"
	^ ' "<>%+'
]

{ #category : #accessing }
XMLURITest >> userInfo [
	^ 'user.name'
]
