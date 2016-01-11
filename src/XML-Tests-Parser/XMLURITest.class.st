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
XMLURITest >> absoluteDirRelativeCombinedSegments [
	^ #('' 'absolute' 'path' 'relative' 'path') asOrderedCollection
]

{ #category : #accessing }
XMLURITest >> absoluteDirSegments [
	^ #('' 'absolute' 'path' '') asOrderedCollection
]

{ #category : #accessing }
XMLURITest >> absoluteRelativeCombined [
	^ '/absolute/relative/path'
]

{ #category : #accessing }
XMLURITest >> absoluteRelativeCombinedSegments [
	^ #('' 'absolute' 'relative' 'path') asOrderedCollection
]

{ #category : #accessing }
XMLURITest >> absoluteSegments [
	^ #('' 'absolute' 'path') asOrderedCollection
]

{ #category : #enumerating }
XMLURITest >> allURIStringsDo: aBlock [
	aBlock
		value: '';
		value: '/';
		value: self absolute;
		value: self absoluteDir;
		value: self absoluteDirRelativeCombined;
		value: self absoluteRelativeCombined;
		value: self domainURIString;
		value: self domainURIWithPortString;
		value: self emailURIString;
		value: self fileURIWithHostString;
		value: self fileURIString;
		value: self fragment;
		value: self fullURIString;
		value: self fullURIWithPortString;
		value: self queryString;
		value: self relative;
		value: self relativeAbsoluteCombined;
		value: self schemelessURIString;
		value: self schemelessURIWithPortString
]

{ #category : #accessing }
XMLURITest >> alphaNumericCharacters [
	^ 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
]

{ #category : #enumerating }
XMLURITest >> asciiCharactersDo: aBlock [
	0 to: 127 do: [:each | aBlock value: each asCharacter]
]

{ #category : #asserting }
XMLURITest >> assertURI: aFirstURI atHostEquals: aSecondURI [
	self assert: aFirstURI host = aSecondURI host.
	self
		assertURI: aFirstURI
		atPortEquals: aSecondURI.
]

{ #category : #asserting }
XMLURITest >> assertURI: aFirstURI atPathEquals: aSecondURI [
	self assert: aFirstURI pathSegments = aSecondURI pathSegments.
	self
		assertURI: aFirstURI
		atQueryEquals: aSecondURI.
]

{ #category : #asserting }
XMLURITest >> assertURI: aFirstURI atPortEquals: aSecondURI [
	self assert: aFirstURI port = aSecondURI port.
	self
		assertURI: aFirstURI
		atPathEquals: aSecondURI.
]

{ #category : #asserting }
XMLURITest >> assertURI: aFirstURI atQueryEquals: aSecondURI [
	self
		assert: aFirstURI query = aSecondURI query;
		assert: aFirstURI fragment = aSecondURI fragment
]

{ #category : #asserting }
XMLURITest >> assertURI: aFirstURI atUserInfoEquals: aSecondURI [
	self  assert: aFirstURI userInfo = aSecondURI userInfo.
	self
		assertURI: aFirstURI
		atHostEquals: aSecondURI.
]

{ #category : #accessing }
XMLURITest >> domainURIString [
	^ 'http://www.example.com'
]

{ #category : #accessing }
XMLURITest >> domainURIWithPortString [
	^ self domainURIString, ':80'
]

{ #category : #accessing }
XMLURITest >> emailURIString [
	^ 'mailto:userName@', self host
]

{ #category : #accessing }
XMLURITest >> fileURIString [
	^ 'file://', self absolute
]

{ #category : #accessing }
XMLURITest >> fileURIWithHostString [
	^ 'file://', self host, self absolute
]

{ #category : #accessing }
XMLURITest >> fragment [
	^ '#fragmentID'
]

{ #category : #accessing }
XMLURITest >> fullURIString [
	^ self domainURIString, self absolute, self queryString, self fragment
]

{ #category : #accessing }
XMLURITest >> fullURIWithPortString [
	^ self domainURIWithPortString, self absolute, self queryString, self fragment
]

{ #category : #accessing }
XMLURITest >> host [
	^ self domainURIString copyAfterLast: $/
]

{ #category : #testing }
XMLURITest >> isUnreservedCharacter: aCharacter [
	^ self unreservedCharacters includes: aCharacter
]

{ #category : #accessing }
XMLURITest >> nonPercentEncodedPathCharacters [
	^ self unreservedCharacters, self subDelimiterCharacters, ':@'
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
XMLURITest >> relativeAbsoluteCombinedSegments [
	^ #('relative' 'absolute' 'path') asOrderedCollection
]

{ #category : #accessing }
XMLURITest >> relativeSegments [
	^ #('relative' 'path') asOrderedCollection
]

{ #category : #accessing }
XMLURITest >> schemelessURIString [
	^ (self domainURIString copyAfter: $:), self absolute, self queryString, self fragment
]

{ #category : #accessing }
XMLURITest >> schemelessURIWithPortString [
	^ (self domainURIWithPortString copyAfter: $:), self absolute, self queryString, self fragment
]

{ #category : #accessing }
XMLURITest >> subDelimiterCharacters [
	^ '!$&''()*+,;='
]

{ #category : #tests }
XMLURITest >> testAsRetrievableResource [
	self allURIStringsDo: [:each | | uri retrievableResource |
		uri := each asXMLURI.
		retrievableResource := uri asRetrievableResource.
		uri isLocalURI
			ifTrue: [
				self
					assert: (retrievableResource isKindOf: XMLFileHandle);
					assert: (retrievableResource path = uri path)]
			ifFalse: [
				self
					assert: (retrievableResource isKindOf: XMLHTTPRequest);
					assert: (retrievableResource url = uri printString)]]
]

{ #category : #tests }
XMLURITest >> testAsString [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		self assert: uri asString = uri printString]
]

{ #category : #tests }
XMLURITest >> testAsXMLURI [
	self allURIStringsDo: [:each | | uri |
		uri := XMLURI fromString: each.
		self
			assert: uri class == XMLURI;
			assert: uri uriString = each;
			assert: uri asXMLURI == uri]
]

{ #category : #tests }
XMLURITest >> testCombining [
	self allURIStringsDo: [:uriString | | uri |
		uri := uriString asXMLURI.
		self allURIStringsDo: [:uriStringToCombineWith | | uriToCombineWith combinedURI |
			uriToCombineWith := uriStringToCombineWith asXMLURI.
			combinedURI := uri / uriToCombineWith.
			uriToCombineWith isRelative
				ifTrue: [
					self assert: combinedURI scheme = uri scheme.
					uriToCombineWith hasUserInfo
						ifTrue: [
							self
								assertURI: combinedURI
								atUserInfoEquals: uriToCombineWith]
						ifFalse: [
							self assert: combinedURI userInfo = uri userInfo.
							uriToCombineWith hasHost
								ifTrue: [
									self
										assertURI: combinedURI
										atHostEquals: uriToCombineWith]
								ifFalse: [
									self assert: combinedURI host = uri host.
									uriToCombineWith hasPort
										ifTrue: [
											self
												assertURI: combinedURI
												atPortEquals: uriToCombineWith]
										ifFalse: [
											self assert: combinedURI port = uri port.
											uriToCombineWith hasPath
												ifTrue: [
													uriToCombineWith hasAbsolutePath
														ifTrue: [
															self
																assertURI: combinedURI
																atPathEquals: uriToCombineWith]
														ifFalse: [self deny: combinedURI = uri path]]
												ifFalse: [
													self assert: combinedURI pathSegments = uri pathSegments.
													uriToCombineWith hasQuery
														ifTrue: [
															self
																assertURI: combinedURI
																atQueryEquals: uriToCombineWith]
														ifFalse: [
															self assert: combinedURI query = uri query.
															uriToCombineWith hasFragment
																ifTrue: [
																	self assert:
																		combinedURI fragment =
																			uriToCombineWith fragment]
																ifFalse: [
																	self assert:
																		combinedURI fragment =
																			uri fragment]]]]]].
					uriToCombineWith isEmpty
						ifTrue: [self assert: combinedURI == uri]
						ifFalse: [self deny: combinedURI == uri]]
				ifFalse: [
					"if the arg was an absolute URI, it should have been returned"
					self assert: combinedURI == uriToCombineWith].
			"receiver and arg should be unchanged by combining"
			self
				assert: uri = uriString asXMLURI;
				assert: uriToCombineWith = uriStringToCombineWith asXMLURI]]
]

{ #category : #tests }
XMLURITest >> testCombiningAbsoluteURIs [
	| domainURI fullURI fileURI |

	domainURI := self domainURIString asXMLURI.
	fullURI := self fullURIString asXMLURI.
	fileURI := self fileURIString asXMLURI.
	self
		assert: domainURI / self fullURIString = fullURI;
		assert: domainURI / self domainURIString = domainURI;
		assert: domainURI / self fileURIString = fileURI;
		assert: fullURI / self fullURIString = fullURI;
		assert: fullURI / self domainURIString = domainURI;
		assert: fullURI / self fileURIString = fileURI;
		assert: fileURI / self fullURIString = fullURI;
		assert: fileURI / self domainURIString = domainURI;
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
		assert: fullURI / '.' = (self domainURIString , '/absolute/') asXMLURI;
		assert: fullURI / './.' = (self domainURIString , '/absolute/') asXMLURI;
		assert: fullURI / './path' = (self domainURIString , self absolute) asXMLURI;
		assert: fullURI / ('./' , self relative) = (self domainURIString , self absoluteRelativeCombined) asXMLURI.
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
		assert: fullURI / ('..' , self absolute) = (self domainURIString , self absolute) asXMLURI;
		assert: fullURI / ('../..' , self absolute) = (self domainURIString , self absolute) asXMLURI;
		assert: fullURI / ('../..' , self absolute , '/..') = (self domainURIString , '/absolute/') asXMLURI;
		assert: fullURI / ('../..' , self absolute , '/../') = (self domainURIString , '/absolute/') asXMLURI.
]

{ #category : #tests }
XMLURITest >> testCombiningRelativeURIs [
	| domainURI domainURIWithPort absolutePathURI absoluteDirPathURI |

	domainURI := self domainURIString asXMLURI.
	domainURIWithPort := self domainURIWithPortString asXMLURI.
	absolutePathURI := (self domainURIString , self absolute) asXMLURI.
	absoluteDirPathURI := (self domainURIString , self absoluteDir) asXMLURI.
	self
		assert: domainURI / self relative = (self domainURIString , '/' , self relative) asXMLURI;
		assert: domainURI / self absolute = (self domainURIString , self absolute) asXMLURI;
		assert: domainURI / self absoluteDir = (self domainURIString , self absoluteDir) asXMLURI;
		assert: domainURIWithPort / self relative = (self domainURIWithPortString , '/' , self relative) asXMLURI;
		assert: domainURIWithPort / self absolute = (self domainURIWithPortString , self absolute) asXMLURI;
		assert: domainURIWithPort / self absoluteDir = (self domainURIWithPortString , self absoluteDir) asXMLURI;
		assert: absolutePathURI / self relative = (self domainURIString , self absoluteRelativeCombined) asXMLURI;
		assert: absoluteDirPathURI / self relative = (self domainURIString , self absoluteDirRelativeCombined) asXMLURI;
		assert: absolutePathURI / self queryString = (self domainURIString , self absolute , self queryString) asXMLURI;
		assert: absolutePathURI / self fragment = (self domainURIString , self absolute , self fragment) asXMLURI;
		assert: domainURI / self schemelessURIString = self fullURIString asXMLURI.
]

{ #category : #tests }
XMLURITest >> testCopy [
	self allURIStringsDo: [:each | | uri copy |
		uri := each asXMLURI.
		copy := uri copy.
		self
			assert: uri uriString = each;
			assert: copy uriString isNil;
			assert: uri = each asXMLURI;
			deny: uri == copy;
			assert: uri = copy;
			assert: uri scheme = copy scheme;
			assert: uri hasAuthorityPrefix = copy hasAuthorityPrefix;
			assert: uri userInfo = copy userInfo;
			assert: uri host = copy host;
			assert: uri port = copy port;
			assert: uri pathSegments = copy pathSegments;
			assert: uri query = copy query;
			assert: uri fragment = copy fragment]
]

{ #category : #tests }
XMLURITest >> testCopyWithFragment [
	self allURIStringsDo: [:each | | uri oldFragment newFragment copy |
		uri := each asXMLURI.
		oldFragment := uri fragment.
		newFragment := oldFragment, 'new'.
		copy := uri copyWithFragment: newFragment.
		self
			assert: uri = each asXMLURI;
			assert: uri uriString = each;
			assert: copy uriString isNil;
			deny: uri == copy;
			deny: uri = copy;
			assert: uri scheme = copy scheme;
			assert: uri hasAuthorityPrefix = copy hasAuthorityPrefix;
			assert: uri userInfo = copy userInfo;
			assert: uri host = copy host;
			assert: uri port = copy port;
			assert: uri pathSegments = copy pathSegments;
			assert: uri query = copy query;
			deny: uri fragment = copy fragment;
			assert: uri fragment = oldFragment;
			assert: copy fragment = newFragment]
]

{ #category : #tests }
XMLURITest >> testCopyWithHost [
	self allURIStringsDo: [:each | | uri oldHost newHost copy |
		uri := each asXMLURI.
		oldHost := uri host.
		newHost := oldHost, 'new'.
		copy := uri copyWithHost: newHost.
		self
			assert: uri = each asXMLURI;
			assert: uri uriString = each;
			assert: copy uriString isNil;
			deny: uri == copy;
			deny: uri = copy;
			assert: uri scheme = copy scheme;
			assert: uri hasAuthorityPrefix = copy hasAuthorityPrefix;
			assert: uri userInfo = copy userInfo;
			deny: uri host = copy host;
			assert: uri host = oldHost;
			assert: copy host = newHost;
			assert: uri port = copy port;
			assert: uri pathSegments = copy pathSegments;
			assert: uri query = copy query;
			assert: uri fragment = copy fragment]
]

{ #category : #tests }
XMLURITest >> testCopyWithPathSegments [
	self allURIStringsDo: [:each | | uri oldPathSegments newPathSegments copy |
		uri := each asXMLURI.
		oldPathSegments := uri pathSegments.
		newPathSegments := oldPathSegments copyWith: 'new'.
		copy := uri copyWithPathSegments: newPathSegments.
		self
			assert: uri = each asXMLURI;
			assert: uri uriString = each;
			assert: copy uriString isNil;
			deny: uri == copy;
			deny: uri = copy;
			assert: uri scheme = copy scheme;
			assert: uri hasAuthorityPrefix = copy hasAuthorityPrefix;
			assert: uri userInfo = copy userInfo;
			assert: uri host = copy host;
			assert: uri port = copy port;
			deny: uri pathSegments = copy pathSegments;
			assert: uri pathSegments = oldPathSegments;
			assert: copy pathSegments = newPathSegments;
			assert: uri query = copy query;
			assert: uri fragment = copy fragment]
]

{ #category : #tests }
XMLURITest >> testCopyWithPort [
	self allURIStringsDo: [:each | | uri oldPort newPort copy |
		uri := each asXMLURI.
		oldPort := uri port.
		newPort := (oldPort ifNil: [0]) + 1.
		copy := uri copyWithPort: newPort.
		self
			assert: uri = each asXMLURI;
			assert: uri uriString = each;
			assert: copy uriString isNil;
			deny: uri == copy;
			deny: uri = copy;
			assert: uri scheme = copy scheme;
			assert: uri hasAuthorityPrefix = copy hasAuthorityPrefix;
			assert: uri userInfo = copy userInfo;
			assert: uri host = copy host;
			deny: uri port = copy port;
			assert: uri port = oldPort;
			assert: copy port = newPort;
			assert: uri pathSegments = copy pathSegments;
			assert: uri query = copy query;
			assert: uri fragment = copy fragment]
]

{ #category : #tests }
XMLURITest >> testCopyWithQuery [
	self allURIStringsDo: [:each | | uri oldQuery newQuery copy |
		uri := each asXMLURI.
		oldQuery := uri query.
		(newQuery := oldQuery copy) add: 'new' -> 'new'.
		copy := uri copyWithQuery: newQuery.
		self
			assert: uri = each asXMLURI;
			assert: uri uriString = each;
			assert: copy uriString isNil;
			deny: uri == copy;
			deny: uri = copy;
			assert: uri scheme = copy scheme;
			assert: uri hasAuthorityPrefix = copy hasAuthorityPrefix;
			assert: uri userInfo = copy userInfo;
			assert: uri host = copy host;
			assert: uri port = copy port;
			assert: uri pathSegments = copy pathSegments;
			deny: uri query = copy query;
			assert: uri query = oldQuery;
			assert: copy query = newQuery;
			assert: uri fragment = copy fragment]
]

{ #category : #tests }
XMLURITest >> testCopyWithScheme [
	self allURIStringsDo: [:each | | uri oldScheme newScheme copy |
		uri := each asXMLURI.
		oldScheme := uri scheme.
		newScheme := oldScheme, 'new'.
		copy := uri copyWithScheme: newScheme.
		self
			assert: uri = each asXMLURI;
			assert: uri uriString = each;
			assert: copy uriString isNil;
			deny: uri == copy;
			deny: uri = copy;
			deny: uri scheme = copy scheme;
			assert: uri scheme = oldScheme;
			assert: copy scheme = newScheme;
			assert: uri hasAuthorityPrefix = copy hasAuthorityPrefix;
			assert: uri userInfo = copy userInfo;
			assert: uri host = copy host;
			assert: uri port = copy port;
			assert: uri pathSegments = copy pathSegments;
			assert: uri query = copy query;
			assert: uri fragment = copy fragment]
]

{ #category : #tests }
XMLURITest >> testCopyWithUserInfo [
	self allURIStringsDo: [:each | | uri oldUserInfo newUserInfo copy |
		uri := each asXMLURI.
		oldUserInfo := uri userInfo.
		newUserInfo := oldUserInfo, 'new'.
		copy := uri copyWithUserInfo: newUserInfo.
		self
			assert: uri = each asXMLURI;
			assert: uri uriString = each;
			assert: copy uriString isNil;
			deny: uri == copy;
			deny: uri = copy;
			assert: uri scheme = copy scheme;
			assert: uri hasAuthorityPrefix = copy hasAuthorityPrefix;
			deny: uri userInfo = copy userInfo;
			assert: uri userInfo = oldUserInfo;
			assert: copy userInfo = newUserInfo;
			assert: uri host = copy host;
			assert: uri port = copy port;
			assert: uri pathSegments = copy pathSegments;
			assert: uri query = copy query;
			assert: uri fragment = copy fragment]
]

{ #category : #tests }
XMLURITest >> testEquality [
	self allURIStringsDo: [:each | | uri otherURI |
		uri := each asXMLURI.

		otherURI := each asXMLURI.
		self
			assert: uri = otherURI;
			assert: otherURI = uri.
		otherURI scheme: uri scheme, 'new'.
		self
			deny: uri = otherURI;
			deny: otherURI = uri.

		otherURI := each asXMLURI.
		self
			assert: uri = otherURI;
			assert: otherURI = uri.
		otherURI userInfo: uri userInfo, 'new'.
		self
			deny: uri = otherURI;
			deny: otherURI = uri.

		otherURI := each asXMLURI.
		self
			assert: uri = otherURI;
			assert: otherURI = uri.
		otherURI host: uri host, 'new'.
		self
			deny: uri = otherURI;
			deny: otherURI = uri.

		otherURI := each asXMLURI.
		self
			assert: uri = otherURI;
			assert: otherURI = uri.
		otherURI pathSegments: (uri pathSegments copyWith: 'new').
		self
			deny: uri = otherURI;
			deny: otherURI = uri.

		otherURI := each asXMLURI.
		self
			assert: uri = otherURI;
			assert: otherURI = uri.
		otherURI query:
			(uri query copy
				add: 'new' -> '';
				yourself).
		self
			deny: uri = otherURI;
			deny: otherURI = uri.

		otherURI := each asXMLURI.
		self
			assert: uri = otherURI;
			assert: otherURI = uri.
		otherURI fragment: uri fragment, 'new'.
		self
			deny: uri = otherURI;
			deny: otherURI = uri]
]

{ #category : #tests }
XMLURITest >> testFragment [
	self
		assert: '' asXMLURI fragment isEmpty;
		assert: '/' asXMLURI fragment isEmpty;
		assert: self absolute asXMLURI fragment isEmpty;
		assert: self absoluteDir asXMLURI fragment isEmpty;
		assert: self absoluteDirRelativeCombined asXMLURI fragment isEmpty;
		assert: self absoluteRelativeCombined asXMLURI fragment isEmpty;
		assert: self domainURIString asXMLURI fragment isEmpty;
		assert: self domainURIWithPortString asXMLURI fragment isEmpty;
		assert: self emailURIString asXMLURI fragment isEmpty;
		assert: self fileURIWithHostString asXMLURI fragment isEmpty;
		assert: self fileURIString asXMLURI fragment isEmpty;
		assert: self fragment asXMLURI fragment = self fragment allButFirst;
		assert: self fullURIString asXMLURI fragment = self fragment allButFirst;
		assert: self fullURIWithPortString asXMLURI fragment = self fragment allButFirst;
		assert: self queryString asXMLURI fragment isEmpty;
		assert: self relative asXMLURI fragment isEmpty;
		assert: self relativeAbsoluteCombined asXMLURI fragment isEmpty;
		assert: self schemelessURIString asXMLURI fragment = self fragment allButFirst;
		assert: self schemelessURIWithPortString asXMLURI fragment = self fragment allButFirst
]

{ #category : #tests }
XMLURITest >> testFragmentNonPercentEncodedCharacters [
	| fragment uri |

	fragment := self nonPercentEncodedPathCharacters , '/?'.
	uri := ('#', fragment) asXMLURI.
	self assert: uri fragment = fragment.
]

{ #category : #tests }
XMLURITest >> testFragmentPercentEncodedCharacters [
	| uri |

	self asciiCharactersDo: [:each | | encodedURIString |
		encodedURIString := '#', (XMLURI percentEncodeCharacter: each).
		uri := encodedURIString asXMLURI.
		self assert: uri fragment = each asString.

		uri uriString: nil.
		(self isUnreservedCharacter: each)
			ifTrue: [self assert: uri printString = ('#' copyWith: each)]
			ifFalse: [self assert: uri printString = encodedURIString]].

	uri := '#+' asXMLURI.
	self assert: uri fragment = '+'.
]

{ #category : #tests }
XMLURITest >> testFromStream [
	self allURIStringsDo: [:each | | readStream uri |
		readStream := each readStream.
		uri := XMLURI fromStream: readStream.
		self
			assert: uri class == XMLURI;
			assert: readStream atEnd;
			assert: uri = each asXMLURI]
]

{ #category : #tests }
XMLURITest >> testFromString [
	self allURIStringsDo: [:each | | uri |
		uri := XMLURI fromString: each.
		self
			assert: uri class == XMLURI;
			assert: uri uriString = each;
			assert: uri = each asXMLURI]
]

{ #category : #tests }
XMLURITest >> testHasAbsolutePath [
	self
		deny: '' asXMLURI hasAbsolutePath;
		assert: '/' asXMLURI hasAbsolutePath;
		assert: self absolute asXMLURI hasAbsolutePath;
		assert: self absoluteDir asXMLURI hasAbsolutePath;
		assert: self absoluteDirRelativeCombined asXMLURI hasAbsolutePath;
		assert: self absoluteRelativeCombined asXMLURI hasAbsolutePath;
		deny: self domainURIString asXMLURI hasAbsolutePath;
		deny: self domainURIWithPortString asXMLURI hasAbsolutePath;
		deny: self emailURIString asXMLURI hasAbsolutePath;
		assert: self fileURIWithHostString asXMLURI hasAbsolutePath;
		assert: self fileURIString asXMLURI hasAbsolutePath;
		deny: self fragment asXMLURI hasAbsolutePath;
		assert: self fullURIString asXMLURI hasAbsolutePath;
		assert: self fullURIWithPortString asXMLURI hasAbsolutePath;
		deny: self queryString asXMLURI hasAbsolutePath;
		deny: self relative asXMLURI hasAbsolutePath;
		deny: self relativeAbsoluteCombined asXMLURI hasAbsolutePath;
		assert: self schemelessURIString asXMLURI hasAbsolutePath;
		assert: self schemelessURIWithPortString asXMLURI hasAbsolutePath
]

{ #category : #tests }
XMLURITest >> testHasAuthority [
	self
		deny: '' asXMLURI hasAuthority;
		deny: '/' asXMLURI hasAuthority;
		deny: self absolute asXMLURI hasAuthority;
		deny: self absoluteDir asXMLURI hasAuthority;
		deny: self absoluteDirRelativeCombined asXMLURI hasAuthority;
		deny: self absoluteRelativeCombined asXMLURI hasAuthority;
		assert: self domainURIString asXMLURI hasAuthority;
		assert: self domainURIWithPortString asXMLURI hasAuthority;
		assert: self emailURIString asXMLURI hasAuthority;
		assert: self fileURIWithHostString asXMLURI hasAuthority;
		deny: self fileURIString asXMLURI hasAuthority;
		deny: self fragment asXMLURI hasAuthority;
		assert: self fullURIString asXMLURI hasAuthority;
		assert: self fullURIWithPortString asXMLURI hasAuthority;
		deny: self queryString asXMLURI hasAuthority;
		deny: self relative asXMLURI hasAuthority;
		deny: self relativeAbsoluteCombined asXMLURI hasAuthority;
		assert: self schemelessURIString asXMLURI hasAuthority;
		assert: self schemelessURIWithPortString asXMLURI hasAuthority
]

{ #category : #tests }
XMLURITest >> testHasAuthorityPrefix [
	self
		deny: '' asXMLURI hasAuthorityPrefix;
		deny: '/' asXMLURI hasAuthorityPrefix;
		deny: self absolute asXMLURI hasAuthorityPrefix;
		deny: self absoluteDir asXMLURI hasAuthorityPrefix;
		deny: self absoluteDirRelativeCombined asXMLURI hasAuthorityPrefix;
		deny: self absoluteRelativeCombined asXMLURI hasAuthorityPrefix;
		assert: self domainURIString asXMLURI hasAuthorityPrefix;
		assert: self domainURIWithPortString asXMLURI hasAuthorityPrefix;
		deny: self emailURIString asXMLURI hasAuthorityPrefix;
		assert: self fileURIWithHostString asXMLURI hasAuthorityPrefix;
		assert: self fileURIString asXMLURI hasAuthorityPrefix;
		deny: self fragment asXMLURI hasAuthorityPrefix;
		assert: self fullURIString asXMLURI hasAuthorityPrefix;
		assert: self fullURIWithPortString asXMLURI hasAuthorityPrefix;
		deny: self queryString asXMLURI hasAuthorityPrefix;
		deny: self relative asXMLURI hasAuthorityPrefix;
		deny: self relativeAbsoluteCombined asXMLURI hasAuthorityPrefix;
		assert: self schemelessURIString asXMLURI hasAuthorityPrefix;
		assert: self schemelessURIWithPortString asXMLURI hasAuthorityPrefix
]

{ #category : #tests }
XMLURITest >> testHasDirectoryPath [
	self
		deny: '' asXMLURI hasDirectoryPath;
		assert: '/' asXMLURI hasDirectoryPath;
		deny: self absolute asXMLURI hasDirectoryPath;
		assert: self absoluteDir asXMLURI hasDirectoryPath;
		deny: self absoluteDirRelativeCombined asXMLURI hasDirectoryPath;
		deny: self absoluteRelativeCombined asXMLURI hasDirectoryPath;
		deny: self domainURIString asXMLURI hasDirectoryPath;
		deny: self domainURIWithPortString asXMLURI hasDirectoryPath;
		deny: self emailURIString asXMLURI hasDirectoryPath;
		deny: self fileURIWithHostString asXMLURI hasDirectoryPath;
		deny: self fileURIString asXMLURI hasDirectoryPath;
		deny: self fragment asXMLURI hasDirectoryPath;
		deny: self fullURIString asXMLURI hasDirectoryPath;
		deny: self fullURIWithPortString asXMLURI hasDirectoryPath;
		deny: self queryString asXMLURI hasDirectoryPath;
		deny: self relative asXMLURI hasDirectoryPath;
		deny: self relativeAbsoluteCombined asXMLURI hasDirectoryPath;
		deny: self schemelessURIString asXMLURI hasDirectoryPath;
		deny: self schemelessURIWithPortString asXMLURI hasDirectoryPath
]

{ #category : #tests }
XMLURITest >> testHasFragment [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		(each includes: $#)
			ifTrue: [self assert: uri hasFragment]
			ifFalse: [self deny: uri hasFragment]]
]

{ #category : #tests }
XMLURITest >> testHasHost [
	self
		deny: '' asXMLURI hasHost;
		deny: '/' asXMLURI hasHost;
		deny: self absolute asXMLURI hasHost;
		deny: self absoluteDir asXMLURI hasHost;
		deny: self absoluteDirRelativeCombined asXMLURI hasHost;
		deny: self absoluteRelativeCombined asXMLURI hasHost;
		assert: self domainURIString asXMLURI hasHost;
		assert: self domainURIWithPortString asXMLURI hasHost;
		assert: self emailURIString asXMLURI hasHost;
		assert: self fileURIWithHostString asXMLURI hasHost;
		deny: self fileURIString asXMLURI hasHost;
		deny: self fragment asXMLURI hasHost;
		assert: self fullURIString asXMLURI hasHost;
		assert: self fullURIWithPortString asXMLURI hasHost;
		deny: self queryString asXMLURI hasHost;
		deny: self relative asXMLURI hasHost;
		deny: self relativeAbsoluteCombined asXMLURI hasHost;
		assert: self schemelessURIString asXMLURI hasHost;
		assert: self schemelessURIWithPortString asXMLURI hasHost
]

{ #category : #tests }
XMLURITest >> testHasNonDirectoryPath [
	self
		deny: '' asXMLURI hasNonDirectoryPath;
		deny: '/' asXMLURI hasNonDirectoryPath;
		assert: self absolute asXMLURI hasNonDirectoryPath;
		deny: self absoluteDir asXMLURI hasNonDirectoryPath;
		assert: self absoluteDirRelativeCombined asXMLURI hasNonDirectoryPath;
		assert: self absoluteRelativeCombined asXMLURI hasNonDirectoryPath;
		deny: self domainURIString asXMLURI hasNonDirectoryPath;
		deny: self domainURIWithPortString asXMLURI hasNonDirectoryPath;
		deny: self emailURIString asXMLURI hasNonDirectoryPath;
		assert: self fileURIWithHostString asXMLURI hasNonDirectoryPath;
		assert: self fileURIString asXMLURI hasNonDirectoryPath;
		deny: self fragment asXMLURI hasNonDirectoryPath;
		assert: self fullURIString asXMLURI hasNonDirectoryPath;
		assert: self fullURIWithPortString asXMLURI hasNonDirectoryPath;
		deny: self queryString asXMLURI hasNonDirectoryPath;
		assert: self relative asXMLURI hasNonDirectoryPath;
		assert: self relativeAbsoluteCombined asXMLURI hasNonDirectoryPath;
		assert: self schemelessURIString asXMLURI hasNonDirectoryPath;
		assert: self schemelessURIWithPortString asXMLURI hasNonDirectoryPath
]

{ #category : #tests }
XMLURITest >> testHasPath [
	self
		deny: '' asXMLURI hasPath;
		assert: '/' asXMLURI hasPath;
		assert: self absolute asXMLURI hasPath;
		assert: self absoluteDir asXMLURI hasPath;
		assert: self absoluteDirRelativeCombined asXMLURI hasPath;
		assert: self absoluteRelativeCombined asXMLURI hasPath;
		deny: self domainURIString asXMLURI hasPath;
		deny: self domainURIWithPortString asXMLURI hasPath;
		deny: self emailURIString asXMLURI hasPath;
		assert: self fileURIWithHostString asXMLURI hasPath;
		assert: self fileURIString asXMLURI hasPath;
		deny: self fragment asXMLURI hasPath;
		assert: self fullURIString asXMLURI hasPath;
		assert: self fullURIWithPortString asXMLURI hasPath;
		deny: self queryString asXMLURI hasPath;
		assert: self relative asXMLURI hasPath;
		assert: self relativeAbsoluteCombined asXMLURI hasPath;
		assert: self schemelessURIString asXMLURI hasPath;
		assert: self schemelessURIWithPortString asXMLURI hasPath
]

{ #category : #tests }
XMLURITest >> testHasPort [
	self
		deny: '' asXMLURI hasPort;
		deny: '/' asXMLURI hasPort;
		deny: self absolute asXMLURI hasPort;
		deny: self absoluteDir asXMLURI hasPort;
		deny: self absoluteDirRelativeCombined asXMLURI hasPort;
		deny: self absoluteRelativeCombined asXMLURI hasPort;
		deny: self domainURIString asXMLURI hasPort;
		assert: self domainURIWithPortString asXMLURI hasPort;
		deny: self emailURIString asXMLURI hasPort;
		deny: self fileURIWithHostString asXMLURI hasPort;
		deny: self fileURIString asXMLURI hasPort;
		deny: self fragment asXMLURI hasPort;
		deny: self fullURIString asXMLURI hasPort;
		assert: self fullURIWithPortString asXMLURI hasPort;
		deny: self queryString asXMLURI hasPort;
		deny: self relative asXMLURI hasPort;
		deny: self relativeAbsoluteCombined asXMLURI hasPort;
		deny: self schemelessURIString asXMLURI hasPort;
		assert: self schemelessURIWithPortString asXMLURI hasPort
]

{ #category : #tests }
XMLURITest >> testHasQuery [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		(each includes: $?)
			ifTrue: [self assert: uri hasQuery]
			ifFalse: [self deny: uri hasQuery]]
]

{ #category : #tests }
XMLURITest >> testHasRootPath [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		each = '/'
			ifTrue: [self assert: uri hasRootPath]
			ifFalse: [self deny: uri hasRootPath]]
]

{ #category : #tests }
XMLURITest >> testHasScheme [
	self
		deny: '' asXMLURI hasScheme;
		deny: '/' asXMLURI hasScheme;
		deny: self absolute asXMLURI hasScheme;
		deny: self absoluteDir asXMLURI hasScheme;
		deny: self absoluteDirRelativeCombined asXMLURI hasScheme;
		deny: self absoluteRelativeCombined asXMLURI hasScheme;
		assert: self domainURIString asXMLURI hasScheme;
		assert: self domainURIWithPortString asXMLURI hasScheme;
		assert: self emailURIString asXMLURI hasScheme;
		assert: self fileURIWithHostString asXMLURI hasScheme;
		assert: self fileURIString asXMLURI hasScheme;
		deny: self fragment asXMLURI hasScheme;
		assert: self fullURIString asXMLURI hasScheme;
		assert: self fullURIWithPortString asXMLURI hasScheme;
		deny: self queryString asXMLURI hasScheme;
		deny: self relative asXMLURI hasScheme;
		deny: self relativeAbsoluteCombined asXMLURI hasScheme;
		deny: self schemelessURIString asXMLURI hasScheme;
		deny: self schemelessURIWithPortString asXMLURI hasScheme
]

{ #category : #tests }
XMLURITest >> testHasUserInfo [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		uri scheme = 'mailto'
			ifTrue: [self assert: uri hasUserInfo]
			ifFalse: [self deny: uri hasUserInfo]]
]

{ #category : #tests }
XMLURITest >> testHost [
	self
		assert: '' asXMLURI host isEmpty;
		assert: '/' asXMLURI host isEmpty;
		assert: self absolute asXMLURI host isEmpty;
		assert: self absoluteDir asXMLURI host isEmpty;
		assert: self absoluteDirRelativeCombined asXMLURI host isEmpty;
		assert: self absoluteRelativeCombined asXMLURI host isEmpty;
		assert: self domainURIString asXMLURI host = self host;
		assert: self domainURIWithPortString asXMLURI host = self host;
		assert: self emailURIString asXMLURI host = self host;
		assert: self fileURIWithHostString asXMLURI host = self host;
		assert: self fileURIString asXMLURI host isEmpty;
		assert: self fragment asXMLURI host isEmpty;
		assert: self fullURIString asXMLURI host = self host;
		assert: self fullURIWithPortString asXMLURI host = self host;
		assert: self queryString asXMLURI host isEmpty;
		assert: self relative asXMLURI host isEmpty;
		assert: self relativeAbsoluteCombined asXMLURI host isEmpty;
		assert: self schemelessURIString asXMLURI host = self host;
		assert: self schemelessURIWithPortString asXMLURI host = self host
]

{ #category : #tests }
XMLURITest >> testHostNonPercentEncodedCharacters [
	| host uri |

	host := self unreservedCharacters, self subDelimiterCharacters.
	uri := ('http://', host) asXMLURI.
	self
		assert: uri scheme = 'http';
		assert: uri host = host asLowercase.
]

{ #category : #tests }
XMLURITest >> testHostPercentEncodedCharacters [
	| prefix uri |

	prefix := 'http://'.
	self asciiCharactersDo: [:each | | lowercasedChar |
		uri := (prefix, (XMLURI percentEncodeCharacter: each)) asXMLURI.
		lowercasedChar := each asLowercase.
		self assert: uri host = lowercasedChar asString.

		uri uriString: nil.
		(self isUnreservedCharacter: each)
			ifTrue: [
				self assert:
					uri printString =
						(prefix copyWith: lowercasedChar)]
			ifFalse: [
				self assert:
					uri printString =
						(prefix, (XMLURI percentEncodeCharacter: lowercasedChar))]].

	uri := (prefix, '+') asXMLURI.
	self assert: uri host = '+'.
]

{ #category : #tests }
XMLURITest >> testIPv6Hosts [
	| ipv6Host uriString uri |

	ipv6Host := '[FEDC:BA98:7654:3210:FEDC:BA98:7654:3210]'.
	uriString := 'http://', ipv6Host, ':80', self absolute.
	uri := uriString asXMLURI.
	self
		assert: uri scheme = 'http';
		assert: uri host = ipv6Host asLowercase;
		assert: uri port = 80;
		assert: uri path = self absolute;
		assert: uri query isEmpty;
		assert: uri fragment isEmpty.
	uri uriString: nil.
	self assert: uri printString = uriString asLowercase.

	uriString := 'http://', ipv6Host, self absolute.
	uri := uriString asXMLURI.
	self
		assert: uri scheme = 'http';
		assert: uri host = ipv6Host asLowercase;
		assert: uri port isNil;
		assert: uri path = self absolute;
		assert: uri query isEmpty;
		assert: uri fragment isEmpty.
	uri uriString: nil.
	self assert: uri printString = uriString asLowercase.
]

{ #category : #tests }
XMLURITest >> testInvalidPort [
	| uri |

	uri := (self domainURIString, ':invalid', self absolute) asXMLURI.
	self
		assert: uri host = self host;
		assert: uri port isNil;
		assert: uri path = self absolute.

	uri := (self domainURIString, ':invalid', self queryString) asXMLURI.
	self
		assert: uri host = self host;
		assert: uri port isNil;
		assert: uri pathSegments isEmpty.

	uri := (self domainURIString, ':invalid', self fragment) asXMLURI.
	self
		assert: uri host = self host;
		assert: uri port isNil;
		assert: uri pathSegments isEmpty.
]

{ #category : #tests }
XMLURITest >> testInvalidPortSuffix [
	| uri |

	uri := (self domainURIWithPortString, 'invalid', self absolute) asXMLURI.
	self
		assert: uri host = self host;
		assert: uri port = 80;
		assert: uri path = self absolute.

	uri := (self domainURIWithPortString, 'invalid', self queryString) asXMLURI.
	self
		assert: uri host = self host;
		assert: uri port = 80;
		assert: uri pathSegments isEmpty.

	uri := (self domainURIWithPortString, 'invalid', self fragment) asXMLURI.
	self
		assert: uri host = self host;
		assert: uri port = 80;
		assert: uri pathSegments isEmpty.
]

{ #category : #tests }
XMLURITest >> testIsEmpty [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		each isEmpty
			ifTrue: [self assert: uri isEmpty]
			ifFalse: [self deny: uri isEmpty]]
]

{ #category : #tests }
XMLURITest >> testIsFileURI [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		uri scheme = 'file'
			ifTrue: [self assert: uri isFileURI]
			ifFalse: [self deny: uri isFileURI]]
]

{ #category : #tests }
XMLURITest >> testIsLocalURI [
	self
		assert: '' asXMLURI isLocalURI;
		assert: '/' asXMLURI isLocalURI;
		assert: self absolute asXMLURI isLocalURI;
		assert: self absoluteDir asXMLURI isLocalURI;
		assert: self absoluteDirRelativeCombined asXMLURI isLocalURI;
		assert: self absoluteRelativeCombined asXMLURI isLocalURI;
		deny: self domainURIString asXMLURI isLocalURI;
		deny: self domainURIWithPortString asXMLURI isLocalURI;
		deny: self emailURIString asXMLURI isLocalURI;
		assert: self fileURIWithHostString asXMLURI isLocalURI;
		assert: self fileURIString asXMLURI isLocalURI;
		assert: self fragment asXMLURI isLocalURI;
		deny: self fullURIString asXMLURI isLocalURI;
		deny: self fullURIWithPortString asXMLURI isLocalURI;
		assert: self queryString asXMLURI isLocalURI;
		assert: self relative asXMLURI isLocalURI;
		assert: self relativeAbsoluteCombined asXMLURI isLocalURI;
		deny: self schemelessURIString asXMLURI isLocalURI;
		deny: self schemelessURIWithPortString asXMLURI isLocalURI
]

{ #category : #tests }
XMLURITest >> testIsRelative [
	self
		assert: '' asXMLURI isRelative;
		assert: '/' asXMLURI isRelative;
		assert: self absolute asXMLURI isRelative;
		assert: self absoluteDir asXMLURI isRelative;
		assert: self absoluteDirRelativeCombined asXMLURI isRelative;
		assert: self absoluteRelativeCombined asXMLURI isRelative;
		deny: self domainURIString asXMLURI isRelative;
		deny: self domainURIWithPortString asXMLURI isRelative;
		deny: self emailURIString asXMLURI isRelative;
		deny: self fileURIWithHostString asXMLURI isRelative;
		deny: self fileURIString asXMLURI isRelative;
		assert: self fragment asXMLURI isRelative;
		deny: self fullURIString asXMLURI isRelative;
		deny: self fullURIWithPortString asXMLURI isRelative;
		assert: self queryString asXMLURI isRelative;
		assert: self relative asXMLURI isRelative;
		assert: self relativeAbsoluteCombined asXMLURI isRelative;
		assert: self schemelessURIString asXMLURI isRelative;
		assert: self schemelessURIWithPortString asXMLURI isRelative
]

{ #category : #tests }
XMLURITest >> testNew [
	| uri |

	uri := XMLURI new.
	self
		assert: uri uriString = '';
		assert: uri isEmpty.
]

{ #category : #tests }
XMLURITest >> testNotEmpty [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		each notEmpty
			ifTrue: [self assert: uri notEmpty]
			ifFalse: [self deny: uri notEmpty]]
]

{ #category : #tests }
XMLURITest >> testParsingQueryString [
	#('' '?' '?&' '?&&') do: [:each |
		self assert:
			each asXMLURI query =
				OrderPreservingStringDictionary new].

	#('?a=b' '?&a=b&' '?&&a=b&&') do: [:each |
		self assert:
			each asXMLURI query =
				(OrderPreservingStringDictionary with: 'a' -> 'b')].

	#('?=&a=b' '?&=&a=b' '?&&=&&a=b' '?a=b&=' '?a=b&=&' '?a=b&&=&&') do: [:each |
		self assert:
			each asXMLURI query =
				(OrderPreservingStringDictionary with: '' -> '' with: 'a' -> 'b')].

	#('?c=&a=b' '?&c=&a=b' '?&&c=&&a=b' '?a=b&c=' '?a=b&c=&' '?a=b&&c=&&') do: [:each |
		self assert:
			each asXMLURI query =
				(OrderPreservingStringDictionary with: 'c' -> '' with: 'a' -> 'b')].
]

{ #category : #tests }
XMLURITest >> testPath [
	self
		assert: '' asXMLURI path isEmpty;
		assert: '/' asXMLURI path = '/';
		assert: self absolute asXMLURI path = self absolute;
		assert: self absoluteDir asXMLURI path = self absoluteDir;
		assert: self absoluteDirRelativeCombined asXMLURI path = self absoluteDirRelativeCombined;
		assert: self absoluteRelativeCombined asXMLURI path = self absoluteRelativeCombined;
		assert: self domainURIString asXMLURI path isEmpty;
		assert: self domainURIWithPortString asXMLURI path isEmpty;
		assert: self emailURIString asXMLURI path isEmpty;
		assert: self fileURIWithHostString asXMLURI path = self absolute;
		assert: self fileURIString asXMLURI path = self absolute;
		assert: self fragment asXMLURI path isEmpty;
		assert: self fullURIString asXMLURI path = self absolute;
		assert: self fullURIWithPortString asXMLURI path = self absolute;
		assert: self queryString asXMLURI path isEmpty;
		assert: self relative asXMLURI path = self relative;
		assert: self relativeAbsoluteCombined asXMLURI path = self relativeAbsoluteCombined;
		assert: self schemelessURIString asXMLURI path = self absolute;
		assert: self schemelessURIWithPortString asXMLURI path = self absolute
]

{ #category : #tests }
XMLURITest >> testPathNonPercentEncodedCharacters [
	| firstSegment secondSegment uri |

	firstSegment := self nonPercentEncodedPathCharacters copyWithout: $:.
	secondSegment := self nonPercentEncodedPathCharacters.
	uri := (firstSegment, '/', secondSegment) asXMLURI.
	self assert:
		uri pathSegments =
			(OrderedCollection with: firstSegment with: secondSegment).
]

{ #category : #tests }
XMLURITest >> testPathPercentEncodedCharacters [
	| uri |

	self asciiCharactersDo: [:each | | encodedURIString |
		encodedURIString := XMLURI percentEncodeCharacter: each.
		uri := encodedURIString asXMLURI.
		self assert: uri path = each asString.

		uri uriString: nil.
		(self isUnreservedCharacter: each)
			ifTrue: [self assert: uri printString = each asString]
			ifFalse: [self assert: uri printString = encodedURIString]].

	uri := '+' asXMLURI.
	self assert: uri path = '+'.
]

{ #category : #tests }
XMLURITest >> testPathSegments [
	self
		assert: '' asXMLURI pathSegments isEmpty;
		assert: '/' asXMLURI pathSegments = #('' '') asOrderedCollection;
		assert: self absolute asXMLURI pathSegments = self absoluteSegments;
		assert: self absoluteDir asXMLURI pathSegments = self absoluteDirSegments;
		assert: self absoluteDirRelativeCombined asXMLURI pathSegments = self absoluteDirRelativeCombinedSegments;
		assert: self absoluteRelativeCombined asXMLURI pathSegments = self absoluteRelativeCombinedSegments;
		assert: self domainURIString asXMLURI pathSegments isEmpty;
		assert: self domainURIWithPortString asXMLURI pathSegments isEmpty;
		assert: self emailURIString asXMLURI pathSegments isEmpty;
		assert: self fileURIWithHostString asXMLURI pathSegments = self absoluteSegments;
		assert: self fileURIString asXMLURI pathSegments = self absoluteSegments;
		assert: self fragment asXMLURI pathSegments isEmpty;
		assert: self fullURIString asXMLURI pathSegments = self absoluteSegments;
		assert: self fullURIWithPortString asXMLURI pathSegments = self absoluteSegments;
		assert: self queryString asXMLURI pathSegments isEmpty;
		assert: self relative asXMLURI pathSegments = self relativeSegments;
		assert: self relativeAbsoluteCombined asXMLURI pathSegments = self relativeAbsoluteCombinedSegments;
		assert: self schemelessURIString asXMLURI pathSegments = self absoluteSegments;
		assert: self schemelessURIWithPortString asXMLURI pathSegments = self absoluteSegments
]

{ #category : #tests }
XMLURITest >> testPathSegmentsDo [
	self allURIStringsDo: [:uriString | | uri visited |
		uri := uriString asXMLURI.
		visited := OrderedCollection new.
		uri pathSegmentsDo: [:each | visited addLast: each].
		self assert: visited = uri pathSegments]
]

{ #category : #tests }
XMLURITest >> testPercentEncodeCharacter [
	self asciiCharactersDo: [:each | | encoded |
		encoded := XMLURI percentEncodeCharacter: each.
		self
			assert: encoded size = 3;
			assert: encoded first == $%;
			assert:
				(XMLIntegerReader
					readFrom: encoded allButFirst
					withBase: 16) = each asciiValue]
]

{ #category : #tests }
XMLURITest >> testPercentOrPlusEncodeCharacter [
	self asciiCharactersDo: [:each | | encoded |
		encoded := XMLURI percentOrPlusEncodeCharacter: each.
		each = Character space
			ifTrue: [self assert: encoded = '+']
			ifFalse: [
				self
					assert: encoded size = 3;
					assert: encoded first == $%;
					assert:
						(XMLIntegerReader
							readFrom: encoded allButFirst
							withBase: 16) = each asciiValue]]
]

{ #category : #tests }
XMLURITest >> testPort [
	self
		assert: '' asXMLURI port isNil;
		assert: '/' asXMLURI port isNil;
		assert: self absolute asXMLURI port isNil;
		assert: self absoluteDir asXMLURI port isNil;
		assert: self absoluteDirRelativeCombined asXMLURI port isNil;
		assert: self absoluteRelativeCombined asXMLURI port isNil;
		assert: self domainURIString asXMLURI port isNil;
		assert: self domainURIWithPortString asXMLURI port = 80;
		assert: self emailURIString asXMLURI port isNil;
		assert: self fileURIWithHostString asXMLURI port isNil;
		assert: self fileURIString asXMLURI port isNil;
		assert: self fragment asXMLURI port isNil;
		assert: self fullURIString asXMLURI port isNil;
		assert: self fullURIWithPortString asXMLURI port = 80;
		assert: self queryString asXMLURI port isNil;
		assert: self relative asXMLURI port isNil;
		assert: self relativeAbsoluteCombined asXMLURI port isNil;
		assert: self schemelessURIString asXMLURI port isNil;
		assert: self schemelessURIWithPortString asXMLURI port = 80
]

{ #category : #tests }
XMLURITest >> testPrintOn [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		self assert: uri printString = each.

		uri
			parseURIStringIfUnparsed;
			uriString: nil.
		self
			assert: uri uriString isNil;
			assert: uri printString = each;
			assert: uri uriString = each]
]

{ #category : #tests }
XMLURITest >> testQuery [
	| query |

	query :=
		OrderPreservingStringDictionary
			with: 'name1' -> 'value1'
			with: 'name2' -> 'value2'.
	self
		assert: '' asXMLURI query isEmpty;
		assert: '/' asXMLURI query isEmpty;
		assert: self absolute asXMLURI query isEmpty;
		assert: self absoluteDir asXMLURI query isEmpty;
		assert: self absoluteDirRelativeCombined asXMLURI query isEmpty;
		assert: self absoluteRelativeCombined asXMLURI query isEmpty;
		assert: self domainURIString asXMLURI query isEmpty;
		assert: self domainURIWithPortString asXMLURI query isEmpty;
		assert: self emailURIString asXMLURI query isEmpty;
		assert: self fileURIWithHostString asXMLURI query isEmpty;
		assert: self fileURIString asXMLURI query isEmpty;
		assert: self fragment asXMLURI query isEmpty;
		assert: self fullURIString asXMLURI query = query;
		assert: self fullURIWithPortString asXMLURI query = query;
		assert: self queryString asXMLURI query = query;
		assert: self relative asXMLURI query isEmpty;
		assert: self relativeAbsoluteCombined asXMLURI query isEmpty;
		assert: self schemelessURIString asXMLURI query = query;
		assert: self schemelessURIWithPortString asXMLURI query = query.
]

{ #category : #tests }
XMLURITest >> testQueryAt [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		uri query keysAndValuesDo: [:key :value |
			self assert: (uri queryAt: key) = value].
		self assert: (uri queryAt: 'absent') = '']
]

{ #category : #tests }
XMLURITest >> testQueryAtIfAbsent [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		uri query keysAndValuesDo: [:key :value |
			self assert: (uri queryAt: key) = value.
			self assert:
				(uri
					queryAt: key
					ifAbsent: ['absentValue']) = value].
		self assert:
			(uri
				queryAt: 'absentKey'
				ifAbsent: ['absentValue']) = 'absentValue']
]

{ #category : #tests }
XMLURITest >> testQueryIncludesKey [
	self allURIStringsDo: [:uriString | | uri |
		uri := uriString asXMLURI.
		uri query keysDo: [:each |
			self assert: (uri queryIncludesKey: each)].
		self deny: (uri queryIncludesKey: 'absent')]
]

{ #category : #tests }
XMLURITest >> testQueryKeys [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		self assert: uri queryKeys asArray = uri query keys asArray]
]

{ #category : #tests }
XMLURITest >> testQueryKeysAndValuesDo [
	self allURIStringsDo: [:each | | uri visited |
		uri := each asXMLURI.
		visited := OrderedCollection new.
		uri queryKeysAndValuesDo: [:key :value |
			visited addLast: key -> value].
		self assert: visited = uri query associations asOrderedCollection]
]

{ #category : #tests }
XMLURITest >> testQueryNonPercentOrPlusEncodedCharacters [
	| queryKey queryValue uri |

	queryKey := (self nonPercentEncodedPathCharacters copyWithoutAll: '=&+'), '/?'.
	queryValue :=  (self nonPercentEncodedPathCharacters copyWithoutAll: '&+'), '/?'.
	uri := ('?', queryKey, '=', queryValue) asXMLURI.
	self assert:
		uri query =
			(OrderPreservingStringDictionary with: queryKey -> queryValue).
]

{ #category : #tests }
XMLURITest >> testQueryPercentOrPlusEncodedCharacters [
	| uri |

	self asciiCharactersDo: [:each | | encodedURIString |
		encodedURIString :=
			'?', (XMLURI percentEncodeCharacter: each), '=', (XMLURI percentEncodeCharacter: each).
		uri := encodedURIString asXMLURI.
		self assert:
			uri query =
				(OrderPreservingStringDictionary with: each asString -> each asString).

		uri uriString: nil.
		(self isUnreservedCharacter: each)
			ifTrue: [self assert: uri printString = ('?', each asString, '=', each asString)]
			ifFalse: [
				each = Character space
					ifTrue: [self assert: uri printString = '?+=+']
					ifFalse: [self assert: uri printString = encodedURIString]]].

	uri := '?+=+' asXMLURI.
	self assert: uri query = (OrderPreservingStringDictionary with: ' ' -> ' ').
]

{ #category : #tests }
XMLURITest >> testQueryWithEmptyKeysOrValues [
	#('?' '?&' '?&&') do: [:each |
		self assert: each asXMLURI query isEmpty].

	#('?a=b' '?&a=b&' '?&&a=b&&') do: [:each |
		self assert:
			each asXMLURI query =
				(OrderPreservingStringDictionary with: 'a' -> 'b')].

	#('?=&a=b' '?&=&a=b' '?&&=&&a=b' '?a=b&=' '?a=b&=&' '?a=b&&=&&') do: [:each |
		self assert:
			each asXMLURI query =
				(OrderPreservingStringDictionary with: '' -> '' with: 'a' -> 'b')].

	#('?c=&a=b' '?&c=&a=b' '?&&c=&&a=b' '?a=b&c=' '?a=b&c=&' '?a=b&&c=&&') do: [:each |
		self assert:
			each asXMLURI query =
				(OrderPreservingStringDictionary with: 'c' -> '' with: 'a' -> 'b')].
]

{ #category : #tests }
XMLURITest >> testScheme [
	self
		assert: '' asXMLURI scheme isEmpty;
		assert: '/' asXMLURI scheme isEmpty;
		assert: self absolute asXMLURI scheme isEmpty;
		assert: self absoluteDir asXMLURI scheme isEmpty;
		assert: self absoluteDirRelativeCombined asXMLURI scheme isEmpty;
		assert: self absoluteRelativeCombined asXMLURI scheme isEmpty;
		assert: self domainURIString asXMLURI scheme = 'http';
		assert: self domainURIWithPortString asXMLURI scheme = 'http';
		assert: self emailURIString asXMLURI scheme = 'mailto';
		assert: self fileURIWithHostString asXMLURI scheme = 'file';
		assert: self fileURIString asXMLURI scheme  = 'file';
		assert: self fragment asXMLURI scheme isEmpty;
		assert: self fullURIString asXMLURI scheme = 'http';
		assert: self fullURIWithPortString asXMLURI scheme = 'http';
		assert: self queryString asXMLURI scheme isEmpty;
		assert: self relative asXMLURI scheme isEmpty;
		assert: self relativeAbsoluteCombined asXMLURI scheme isEmpty;
		assert: self schemelessURIString asXMLURI scheme isEmpty;
		assert: self schemelessURIWithPortString asXMLURI scheme isEmpty
]

{ #category : #tests }
XMLURITest >> testSchemeAndHostCaseInsensitivity [
	self allURIStringsDo: [:each | | uri uppercaseURI |
		uri := each asXMLURI.
		uppercaseURI := each asUppercase asXMLURI.
		self
			assert: uri scheme = uppercaseURI scheme;
			assert: uri hasAuthorityPrefix = uppercaseURI hasAuthorityPrefix.
		uri hasUserInfo
			ifTrue: [self deny: uri userInfo = uppercaseURI userInfo].
		self
			assert: uri host = uppercaseURI host;
			assert: uri port = uppercaseURI port.
		(uri hasPath
			and: [uri hasRootPath not])
			ifTrue: [self deny: uri pathSegments = uppercaseURI pathSegments].
		uri hasQuery
			ifTrue: [self deny: uri query = uppercaseURI query].
		uri hasFragment
			ifTrue: [self deny: uri fragment = uppercaseURI fragment]]
]

{ #category : #tests }
XMLURITest >> testSchemeCharacters [
	| scheme uri |

	scheme := self alphaNumericCharacters, '+-.'.
	uri := (scheme, '://', self host) asXMLURI.
	self
		assert: uri scheme = scheme asLowercase;
		assert: uri host = self host.
]

{ #category : #tests }
XMLURITest >> testStandardURICombining [
	"Generated from RFC 3986, page 34-36"

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
XMLURITest >> testUserInfo [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		uri scheme = 'mailto'
			ifTrue: [self assert: uri userInfo = 'userName']
			ifFalse: [self assert: uri userInfo isEmpty]]
]

{ #category : #tests }
XMLURITest >> testUserInfoNonPercentEncodedCharacters [
	| userInfo uri |

	userInfo := self unreservedCharacters, self subDelimiterCharacters, ':'.
	uri := ('mailto:', userInfo, '@', self host) asXMLURI.
	self
		assert: uri scheme = 'mailto';
		assert: uri userInfo = userInfo;
		assert: uri host = self host.
]

{ #category : #tests }
XMLURITest >> testUserInfoPercentEncodedCharacters [
	| prefix suffix uri |

	prefix := 'mailto:'.
	suffix := '@', self host.
	self asciiCharactersDo: [:each | | encodedURIString |
		encodedURIString := prefix, (XMLURI percentEncodeCharacter: each), suffix.
		uri := encodedURIString asXMLURI.
		self assert: uri userInfo = each asString.

		uri uriString: nil.
		(self isUnreservedCharacter: each)
			ifTrue: [self assert: uri printString = (prefix, each asString, suffix)]
			ifFalse: [self assert: uri printString = encodedURIString]].

	uri := (prefix, '+', suffix) asXMLURI.
	self assert: uri userInfo = '+'.
]

{ #category : #accessing }
XMLURITest >> unreservedCharacters [
	^ self alphaNumericCharacters, '-._~'
]
