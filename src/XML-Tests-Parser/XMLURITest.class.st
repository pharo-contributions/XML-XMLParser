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
	| baseURI |

	baseURI := ''', self standardURICombiningTestBaseURI, ''' asXMLURI.
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
		assert: (baseURI / ''', argument, ''' asXMLURI) = ''', result, ''' asXMLURI']]].

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
	| domainURI fullURI fileURI |

	domainURI := self domain asXMLURI.
	fullURI := self fullURIString asXMLURI.
	fileURI := self fileURIString asXMLURI.
	self
		assert: domainURI / self fullURIString = fullURI;
		assert: domainURI / self domain = domainURI;
		assert: domainURI / self fileURIString = fileURI;
		assert: fullURI / self fullURIString = fullURI;
		assert: fullURI / self domain = domainURI;
		assert: fullURI / self fileURIString = fileURI;
		assert: fileURI / self fullURIString = fullURI;
		assert: fileURI / self domain = domainURI;
		assert: fileURI / self fileURIString = fileURI.
]

{ #category : #tests }
XMLURITest >> testCombiningDotPathURIs [
	| relativePathURI absolutePathURI fullURI |

	relativePathURI := self relative asXMLURI.
	self
		assert: relativePathURI / '.' = 'relative/' asXMLURI;
		assert: relativePathURI / './.' = 'relative/' asXMLURI;
		assert: relativePathURI / './path' = relativePathURI;
		assert: relativePathURI / ('.' , self absolute) = self relativeAbsoluteCombined asXMLURI.

	absolutePathURI := self absolute asXMLURI.
	self
		assert: absolutePathURI / '.' = '/absolute/' asXMLURI;
		assert: absolutePathURI / './.' = '/absolute/' asXMLURI;
		assert: absolutePathURI / './path' = absolutePathURI;
		assert: absolutePathURI / ('./' , self relative) = self absoluteRelativeCombined asXMLURI.

	fullURI := self fullURIString asXMLURI.
	self
		assert: fullURI / '.' = (self domain , '/absolute/') asXMLURI;
		assert: fullURI / './.' = (self domain , '/absolute/') asXMLURI;
		assert: fullURI / './path' = (self domain , self absolute) asXMLURI;
		assert: fullURI / ('./' , self relative) = (self domain , self absoluteRelativeCombined) asXMLURI.
]

{ #category : #tests }
XMLURITest >> testCombiningDoubleDotPathURIs [
	| relativePathURI absolutePathURI fullURI |

	relativePathURI := self relative asXMLURI.
	self
		assert: (relativePathURI / '..') isEmpty;
		assert: (relativePathURI / '../..') isEmpty;
		assert: relativePathURI / ('..' , self absolute) = 'absolute/path' asXMLURI;
		assert: relativePathURI / ('../..' , self absolute) = 'absolute/path' asXMLURI;
		assert: relativePathURI / ('../..' , self absolute , '/..') = 'absolute/' asXMLURI;
		assert: (relativePathURI / ('../..' , self absolute , '/../..')) isEmpty.

	absolutePathURI := self absolute asXMLURI.
	self
		assert: (absolutePathURI / '..') hasRootPath;
		assert: (absolutePathURI / '../..') isEmpty;
		assert: absolutePathURI / ('..' , self absolute) = absolutePathURI;
		assert: absolutePathURI / ('../..' , self absolute) = 'absolute/path' asXMLURI;
		assert: absolutePathURI / ('../..' , self absolute , '/..') = 'absolute/' asXMLURI;
		assert: (absolutePathURI / ('../..' , self absolute , '/../..')) isEmpty.

	fullURI := self fullURIString asXMLURI.
	self
		assert: (fullURI / '..') hasRootPath;
		deny: (fullURI / '../..') hasPath;
		assert: fullURI / ('..' , self absolute) = (self domain , self absolute) asXMLURI;
		assert: fullURI / ('../..' , self absolute) = (self domain , self absolute) asXMLURI;
		assert: fullURI / ('../..' , self absolute , '/..') = (self domain , '/absolute/') asXMLURI;
		assert: fullURI / ('../..' , self absolute , '/../') = (self domain , '/absolute/') asXMLURI.
]

{ #category : #tests }
XMLURITest >> testCombiningRelativeURIs [
	| domainURI domainURIWithPort absolutePathURI absoluteDirPathURI |

	domainURI := self domain asXMLURI.
	domainURIWithPort := self domainWithPort asXMLURI.
	absolutePathURI := (self domain , self absolute) asXMLURI.
	absoluteDirPathURI := (self domain , self absoluteDir) asXMLURI.
	self
		assert: domainURI / self relative = (self domain , '/' , self relative) asXMLURI;
		assert: domainURI / self absolute = (self domain , self absolute) asXMLURI;
		assert: domainURI / self absoluteDir = (self domain , self absoluteDir) asXMLURI;
		assert: domainURIWithPort / self relative = (self domainWithPort , '/' , self relative) asXMLURI;
		assert: domainURIWithPort / self absolute = (self domainWithPort , self absolute) asXMLURI;
		assert: domainURIWithPort / self absoluteDir = (self domainWithPort , self absoluteDir) asXMLURI;
		assert: absolutePathURI / self relative = (self domain , self absoluteRelativeCombined) asXMLURI;
		assert: absoluteDirPathURI / self relative = (self domain , self absoluteDirRelativeCombined) asXMLURI;
		assert: absolutePathURI / self queryString = (self domain , self absolute , self queryString) asXMLURI;
		assert: absolutePathURI / self fragment = (self domain , self absolute , self fragment) asXMLURI;
		assert: domainURI / self schemelessURIString = self fullURIString asXMLURI.
]

{ #category : #tests }
XMLURITest >> testConverting [
	| fullURI |

	fullURI := XMLURI fromString: self fullURIString.
	self
		assert: self fullURIString asXMLURI = fullURI;
		assert: fullURI asXMLURI == fullURI.
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
	| uri uppercaseURI |

	uri := self fullURIString asXMLURI.
	uppercaseURI := self fullURIString asUppercase asXMLURI.
	self
		assert: uri scheme = uppercaseURI scheme;
		assert: uri host = uppercaseURI host;
		deny: uri path = uppercaseURI path;
		deny: uri queryString = uppercaseURI queryString;
		deny: uri fragment = uppercaseURI fragment.
]

{ #category : #tests }
XMLURITest >> testStandardURICombining [
	| baseURI |

	baseURI := 'http://a/b/c/d;p?q' asXMLURI.
	self
		assert: (baseURI / 'g:h' asXMLURI) = 'g:h' asXMLURI;
		assert: (baseURI / 'g' asXMLURI) = 'http://a/b/c/g' asXMLURI;
		assert: (baseURI / './g' asXMLURI) = 'http://a/b/c/g' asXMLURI;
		assert: (baseURI / 'g/' asXMLURI) = 'http://a/b/c/g/' asXMLURI;
		assert: (baseURI / '/g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseURI / '//g' asXMLURI) = 'http://g' asXMLURI;
		assert: (baseURI / '?y' asXMLURI) = 'http://a/b/c/d;p?y' asXMLURI;
		assert: (baseURI / 'g?y' asXMLURI) = 'http://a/b/c/g?y' asXMLURI;
		assert: (baseURI / '#s' asXMLURI) = 'http://a/b/c/d;p?q#s' asXMLURI;
		assert: (baseURI / 'g#s' asXMLURI) = 'http://a/b/c/g#s' asXMLURI;
		assert: (baseURI / 'g?y#s' asXMLURI) = 'http://a/b/c/g?y#s' asXMLURI;
		assert: (baseURI / ';x' asXMLURI) = 'http://a/b/c/;x' asXMLURI;
		assert: (baseURI / 'g;x' asXMLURI) = 'http://a/b/c/g;x' asXMLURI;
		assert: (baseURI / 'g;x?y#s' asXMLURI) = 'http://a/b/c/g;x?y#s' asXMLURI;
		assert: (baseURI / '' asXMLURI) = 'http://a/b/c/d;p?q' asXMLURI;
		assert: (baseURI / '.' asXMLURI) = 'http://a/b/c/' asXMLURI;
		assert: (baseURI / './' asXMLURI) = 'http://a/b/c/' asXMLURI;
		assert: (baseURI / '..' asXMLURI) = 'http://a/b/' asXMLURI;
		assert: (baseURI / '../' asXMLURI) = 'http://a/b/' asXMLURI;
		assert: (baseURI / '../g' asXMLURI) = 'http://a/b/g' asXMLURI;
		assert: (baseURI / '../..' asXMLURI) = 'http://a/' asXMLURI;
		assert: (baseURI / '../../' asXMLURI) = 'http://a/' asXMLURI;
		assert: (baseURI / '../../g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseURI / '../../../g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseURI / '../../../../g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseURI / '/./g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseURI / '/../g' asXMLURI) = 'http://a/g' asXMLURI;
		assert: (baseURI / 'g.' asXMLURI) = 'http://a/b/c/g.' asXMLURI;
		assert: (baseURI / '.g' asXMLURI) = 'http://a/b/c/.g' asXMLURI;
		assert: (baseURI / 'g..' asXMLURI) = 'http://a/b/c/g..' asXMLURI;
		assert: (baseURI / '..g' asXMLURI) = 'http://a/b/c/..g' asXMLURI;
		assert: (baseURI / './../g' asXMLURI) = 'http://a/b/g' asXMLURI;
		assert: (baseURI / './g/.' asXMLURI) = 'http://a/b/c/g/' asXMLURI;
		assert: (baseURI / 'g/./h' asXMLURI) = 'http://a/b/c/g/h' asXMLURI;
		assert: (baseURI / 'g/../h' asXMLURI) = 'http://a/b/c/h' asXMLURI;
		assert: (baseURI / 'g;x=1/./y' asXMLURI) = 'http://a/b/c/g;x=1/y' asXMLURI;
		assert: (baseURI / 'g;x=1/../y' asXMLURI) = 'http://a/b/c/y' asXMLURI;
		assert: (baseURI / 'g?y/./x' asXMLURI) = 'http://a/b/c/g?y/./x' asXMLURI;
		assert: (baseURI / 'g?y/../x' asXMLURI) = 'http://a/b/c/g?y/../x' asXMLURI;
		assert: (baseURI / 'g#s/./x' asXMLURI) = 'http://a/b/c/g#s/./x' asXMLURI;
		assert: (baseURI / 'g#s/../x' asXMLURI) = 'http://a/b/c/g#s/../x' asXMLURI;
		assert: (baseURI / 'http:g' asXMLURI) = 'http:g' asXMLURI
]

{ #category : #tests }
XMLURITest >> testURIEquality [
	| fullURI string emailURI |

	string := self fullURIString.
	fullURI := string asXMLURI.
	self
		assert: fullURI = fullURI;
		assert: fullURI = string asXMLURI;
		deny: fullURI = (string copyReplaceAll: self scheme with: 'new') asXMLURI;
		deny: fullURI = (string copyReplaceAll: '://' with: ':') asXMLURI;
		deny: fullURI = (string copyReplaceAll: self host with: 'new') asXMLURI;
		deny: fullURI = (string copyReplaceAll: self absolute with: 'new') asXMLURI;
		deny: fullURI = (string copyReplaceAll: self queryString with: 'new') asXMLURI;
		deny: fullURI = (string copyReplaceAll: self fragment with: 'new') asXMLURI.

	string := self emailURIString.
	emailURI := string asXMLURI.
	self
		assert: emailURI = emailURI;
		assert: emailURI = string asXMLURI;
		deny: fullURI = (string copyReplaceAll: self userInfo with: 'new') asXMLURI.
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
		assert: '' asXMLURI printString isEmpty
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
