Class {
	#name : #XMLURITest,
	#superclass : #TestCase,
	#instVars : [
		'asciiCharacters',
		'reservedCharacters',
		'unreservedCharacters',
		'percentEncodedASCIICharacters',
		'percentEncodedReservedCharacters',
		'percentEncodedAlphaNumericCharacters'
	],
	#category : #'XML-Parser-Tests-URI'
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
		value: self fragmentURIString;
		value: self fullURIString;
		value: self fullURIWithPortString;
		value: self queryURIString;
		value: self relative;
		value: self relativeAbsoluteCombined;
		value: self schemelessURIString;
		value: self schemelessURIWithPortString
]

{ #category : #accessing }
XMLURITest >> alphaNumericCharacters [
	^ 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
]

{ #category : #accessing }
XMLURITest >> asciiCharacters [
	asciiCharacters ifNil: [
		asciiCharacters :=
			String streamContents: [:stream |
				"0 is ignored for GS compatibility, because it uses it as a string
				terminator"
				1 to: 127 do: [:i |
					stream nextPut: i asCharacter]]].
	^ asciiCharacters.
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
	^ self fragmentURIString allButFirst
]

{ #category : #accessing }
XMLURITest >> fragmentURIString [
	^ '#fragmentID'
]

{ #category : #accessing }
XMLURITest >> fullURIString [
	^ self domainURIString, self absolute, self queryURIString, self fragmentURIString
]

{ #category : #accessing }
XMLURITest >> fullURIWithPortString [
	^ self domainURIWithPortString, self absolute, self queryURIString, self fragmentURIString
]

{ #category : #accessing }
XMLURITest >> host [
	^ self domainURIString copyAfterLast: $/
]

{ #category : #accessing }
XMLURITest >> nonPercentEncodedPathCharacters [
	^ self unreservedCharacters, self subDelimiterCharacters, ':@'
]

{ #category : #converting }
XMLURITest >> percentEncodeCharacter: aCharacter [
	^ XMLStreamAdapterTest percentEncodeCharacter: aCharacter
]

{ #category : #converting }
XMLURITest >> percentEncodeCharacters: aCharacterCollection [
	^ XMLStreamAdapterTest percentEncodeCharacters: aCharacterCollection
]

{ #category : #accessing }
XMLURITest >> percentEncodedASCIICharacters [
	^ percentEncodedASCIICharacters
		ifNil: [
			percentEncodedASCIICharacters :=
				self percentEncodeCharacters: self asciiCharacters]
]

{ #category : #accessing }
XMLURITest >> percentEncodedAlphaNumericCharacters [
	^ percentEncodedAlphaNumericCharacters
		ifNil: [
			percentEncodedAlphaNumericCharacters :=
				self percentEncodeCharacters: self alphaNumericCharacters]
]

{ #category : #accessing }
XMLURITest >> percentEncodedReservedCharacters [
	percentEncodedReservedCharacters ifNil: [
		percentEncodedReservedCharacters :=
			String streamContents: [:stream |
				self reservedCharacters do: [:each |
					stream nextPutAll: (self percentEncodeCharacter: each)]]].
	^ percentEncodedReservedCharacters.
]

{ #category : #accessing }
XMLURITest >> query [
	^ OrderedCollection
		with: 'name1' -> 'value1'
		with: 'name2' -> 'value2'
		with: 'name1' -> 'value3'
]

{ #category : #accessing }
XMLURITest >> queryURIString [
	^ '?name1=value1&name2=value2&name1=value3'
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
XMLURITest >> reservedCharacters [
	reservedCharacters
		ifNil: [
			reservedCharacters :=
				String streamContents: [:stream |
					self asciiCharacters do: [:each |
						(self unreservedCharacters includes: each)
							ifFalse: [stream nextPut: each]]]].
	^ reservedCharacters.
]

{ #category : #accessing }
XMLURITest >> schemelessURIString [
	^ (self domainURIString copyAfter: $:), self absolute, self queryURIString, self fragmentURIString
]

{ #category : #accessing }
XMLURITest >> schemelessURIWithPortString [
	^ (self domainURIWithPortString copyAfter: $:), self absolute, self queryURIString, self fragmentURIString
]

{ #category : #accessing }
XMLURITest >> subDelimiterCharacters [
	^ '!$&''()*+,;='
]

{ #category : #tests }
XMLURITest >> testAsRetrievableResource [

	(XMLFileHandle hasSupportedImplementation and: [
		 XMLHTTPRequest hasSupportedImplementation ]) ifFalse: [ ^ self ].

	self allURIStringsDo: [ :each |
		| uri retrievableResource |
		uri := each asXMLURI.
		"other types of URIs may not be retrievable"
		(uri isLocal or: [ uri isHTTP ]) ifTrue: [
			retrievableResource := uri asRetrievableResource.
			uri isLocal
				ifTrue: [
					self
						assert: retrievableResource class
						identicalTo: XMLFileHandle implementation.
					self assert: retrievableResource path equals: uri path ]
				ifFalse: [
					self
						assert: retrievableResource class
						identicalTo: XMLHTTPRequest implementation.
					self assert: retrievableResource url equals: uri printString ] ] ]
]

{ #category : #tests }
XMLURITest >> testAsString [

	self allURIStringsDo: [ :each |
		| uri |
		uri := each asXMLURI.
		self assert: uri asString equals: uri printString ]
]

{ #category : #tests }
XMLURITest >> testAsXMLFileHandle [

	XMLFileHandle hasSupportedImplementation ifFalse: [ ^ self ].

	self allURIStringsDo: [ :each |
		| uri fileHandle |
		uri := each asXMLURI.
		uri isLocal
			ifTrue: [
				fileHandle := uri asXMLFileHandle.
				self
					assert: fileHandle class
					identicalTo: XMLFileHandle implementation;
					assert: fileHandle path equals: uri path ]
			ifFalse: [
			self should: [ uri asXMLFileHandle ] raise: XMLFileException ] ]
]

{ #category : #tests }
XMLURITest >> testAsXMLHTTPRequest [
	XMLHTTPRequest hasSupportedImplementation
		ifFalse: [^ self].

	self allURIStringsDo: [:each | | uri request |
		uri := each asXMLURI.
		(uri isRelative
			or: [uri isHTTP])
			ifTrue: [
				request := uri asXMLHTTPRequest.
				self
					assert: request class == XMLHTTPRequest implementation;
					assert: request url = uri printString]
			ifFalse: [
				"do not assume HTTPS is supported even if HTTP is"
				uri isHTTPS
					ifFalse: [
						self
							should: [uri asXMLHTTPRequest]
							raise: XMLHTTPException]]].
]

{ #category : #tests }
XMLURITest >> testAsXMLURI [

	self allURIStringsDo: [ :each |
		| uri |
		uri := XMLURI fromString: each.
		self
			assert: uri class identicalTo: XMLURI;
			assert: uri uriString equals: each;
			assert: uri asXMLURI identicalTo: uri ]
]

{ #category : #tests }
XMLURITest >> testCombining [

	self allURIStringsDo: [ :uriString |
		| uri |
		uri := uriString asXMLURI.
		self allURIStringsDo: [ :uriStringToCombineWith |
			| uriToCombineWith combinedURI |
			uriToCombineWith := uriStringToCombineWith asXMLURI.
			combinedURI := uri / uriToCombineWith.
			uriToCombineWith isRelative
				ifTrue: [
					self assert: combinedURI scheme equals: uri scheme.
					uriToCombineWith hasUserInfo
						ifTrue: [
						self assertURI: combinedURI atUserInfoEquals: uriToCombineWith ]
						ifFalse: [
							self assert: combinedURI userInfo equals: uri userInfo.
							uriToCombineWith hasHost
								ifTrue: [
								self assertURI: combinedURI atHostEquals: uriToCombineWith ]
								ifFalse: [
									self assert: combinedURI host equals: uri host.
									uriToCombineWith hasPort
										ifTrue: [
										self assertURI: combinedURI atPortEquals: uriToCombineWith ]
										ifFalse: [
											self assert: combinedURI port equals: uri port.
											uriToCombineWith hasPath
												ifTrue: [
													uriToCombineWith hasAbsolutePath
														ifTrue: [
														self
															assertURI: combinedURI
															atPathEquals: uriToCombineWith ]
														ifFalse: [ self deny: combinedURI equals: uri path ] ]
												ifFalse: [
													self
														assert: combinedURI pathSegments
														equals: uri pathSegments.
													uriToCombineWith hasQuery
														ifTrue: [
														self
															assertURI: combinedURI
															atQueryEquals: uriToCombineWith ]
														ifFalse: [
															self assert: combinedURI query equals: uri query.
															uriToCombineWith hasFragment
																ifTrue: [
																self
																	assert: combinedURI fragment
																	equals: uriToCombineWith fragment ]
																ifFalse: [
																self assert: combinedURI fragment equals: uri fragment ] ] ] ] ] ].
					uriToCombineWith isEmpty
						ifTrue: [ self assert: combinedURI identicalTo: uri ]
						ifFalse: [ self deny: combinedURI identicalTo: uri ] ]
				ifFalse: [ "if the arg was an absolute URI, it should have been returned"
					self assert: combinedURI identicalTo: uriToCombineWith ].
			"receiver and arg should be unchanged by combining"
			self
				assert: uri equals: uriString asXMLURI;
				assert: uriToCombineWith equals: uriStringToCombineWith asXMLURI ] ]
]

{ #category : #tests }
XMLURITest >> testCombiningAbsoluteURIs [

	| domainURI fullURI fileURI |
	domainURI := self domainURIString asXMLURI.
	fullURI := self fullURIString asXMLURI.
	fileURI := self fileURIString asXMLURI.
	self
		assert: domainURI / self fullURIString equals: fullURI;
		assert: domainURI / self domainURIString equals: domainURI;
		assert: domainURI / self fileURIString equals: fileURI;
		assert: fullURI / self fullURIString equals: fullURI;
		assert: fullURI / self domainURIString equals: domainURI;
		assert: fullURI / self fileURIString equals: fileURI;
		assert: fileURI / self fullURIString equals: fullURI;
		assert: fileURI / self domainURIString equals: domainURI;
		assert: fileURI / self fileURIString equals: fileURI
]

{ #category : #tests }
XMLURITest >> testCombiningDotPathURIs [

	| relativePathURI absolutePathURI fullURI |
	relativePathURI := self relative asXMLURI.
	self
		assert: relativePathURI / '.' equals: 'relative/' asXMLURI;
		assert: relativePathURI / './.' equals: 'relative/' asXMLURI;
		assert: relativePathURI / './path' equals: relativePathURI;
		assert: relativePathURI / ('.' , self absolute)
		equals: self relativeAbsoluteCombined asXMLURI.

	absolutePathURI := self absolute asXMLURI.
	self
		assert: absolutePathURI / '.' equals: '/absolute/' asXMLURI;
		assert: absolutePathURI / './.' equals: '/absolute/' asXMLURI;
		assert: absolutePathURI / './path' equals: absolutePathURI;
		assert: absolutePathURI / ('./' , self relative)
		equals: self absoluteRelativeCombined asXMLURI.

	fullURI := self fullURIString asXMLURI.
	self
		assert: fullURI / '.'
		equals: (self domainURIString , '/absolute/') asXMLURI;
		assert: fullURI / './.'
		equals: (self domainURIString , '/absolute/') asXMLURI;
		assert: fullURI / './path'
		equals: (self domainURIString , self absolute) asXMLURI;
		assert: fullURI / ('./' , self relative)
		equals:
			(self domainURIString , self absoluteRelativeCombined) asXMLURI
]

{ #category : #tests }
XMLURITest >> testCombiningDoubleDotPathURIs [

	| relativePathURI absolutePathURI fullURI |
	relativePathURI := self relative asXMLURI.
	self
		assert: (relativePathURI / '..') isEmpty;
		assert: (relativePathURI / '../..') isEmpty;
		assert: relativePathURI / ('..' , self absolute)
		equals: 'absolute/path' asXMLURI;
		assert: relativePathURI / ('../..' , self absolute)
		equals: 'absolute/path' asXMLURI;
		assert: relativePathURI / ('../..' , self absolute , '/..')
		equals: 'absolute/' asXMLURI;
		assert:
			(relativePathURI / ('../..' , self absolute , '/../..')) isEmpty.

	absolutePathURI := self absolute asXMLURI.
	self
		assert: (absolutePathURI / '..') hasRootPath;
		assert: (absolutePathURI / '../..') isEmpty;
		assert: absolutePathURI / ('..' , self absolute)
		equals: absolutePathURI;
		assert: absolutePathURI / ('../..' , self absolute)
		equals: 'absolute/path' asXMLURI;
		assert: absolutePathURI / ('../..' , self absolute , '/..')
		equals: 'absolute/' asXMLURI;
		assert:
			(absolutePathURI / ('../..' , self absolute , '/../..')) isEmpty.

	fullURI := self fullURIString asXMLURI.
	self
		assert: (fullURI / '..') hasRootPath;
		deny: (fullURI / '../..') hasPath;
		assert: fullURI / ('..' , self absolute)
		equals: (self domainURIString , self absolute) asXMLURI;
		assert: fullURI / ('../..' , self absolute)
		equals: (self domainURIString , self absolute) asXMLURI;
		assert: fullURI / ('../..' , self absolute , '/..')
		equals: (self domainURIString , '/absolute/') asXMLURI;
		assert: fullURI / ('../..' , self absolute , '/../')
		equals: (self domainURIString , '/absolute/') asXMLURI
]

{ #category : #tests }
XMLURITest >> testCombiningRelativeURIs [

	| domainURI domainURIWithPort absolutePathURI absoluteDirPathURI |
	domainURI := self domainURIString asXMLURI.
	domainURIWithPort := self domainURIWithPortString asXMLURI.
	absolutePathURI := (self domainURIString , self absolute) asXMLURI.
	absoluteDirPathURI := (self domainURIString , self absoluteDir)
		                      asXMLURI.
	self
		assert: domainURI / self relative
		equals: (self domainURIString , '/' , self relative) asXMLURI;
		assert: domainURI / self absolute
		equals: (self domainURIString , self absolute) asXMLURI;
		assert: domainURI / self absoluteDir
		equals: (self domainURIString , self absoluteDir) asXMLURI;
		assert: domainURIWithPort / self relative
		equals:
			(self domainURIWithPortString , '/' , self relative) asXMLURI;
		assert: domainURIWithPort / self absolute
		equals: (self domainURIWithPortString , self absolute) asXMLURI;
		assert: domainURIWithPort / self absoluteDir
		equals: (self domainURIWithPortString , self absoluteDir) asXMLURI;
		assert: absolutePathURI / self relative
		equals:
			(self domainURIString , self absoluteRelativeCombined) asXMLURI;
		assert: absoluteDirPathURI / self relative
		equals:
			(self domainURIString , self absoluteDirRelativeCombined) asXMLURI;
		assert: absolutePathURI / self queryURIString
		equals:
			(self domainURIString , self absolute , self queryURIString)
				asXMLURI;
		assert: absolutePathURI / self fragmentURIString
		equals:
			(self domainURIString , self absolute , self fragmentURIString)
				asXMLURI;
		assert: domainURI / self schemelessURIString
		equals: self fullURIString asXMLURI
]

{ #category : #tests }
XMLURITest >> testCopy [

	self allURIStringsDo: [ :each |
		| uri copy |
		uri := each asXMLURI.
		copy := uri copy.
		self
			assert: uri uriString equals: each;
			assert: copy uriString isNil;
			assert: uri equals: each asXMLURI;
			deny: uri identicalTo: copy;
			assert: uri equals: copy;
			assert: uri scheme equals: copy scheme;
			assert: uri hasAuthorityPrefix equals: copy hasAuthorityPrefix;
			assert: uri userInfo equals: copy userInfo;
			assert: uri host equals: copy host;
			assert: uri port equals: copy port;
			assert: uri pathSegments equals: copy pathSegments;
			assert: uri query equals: copy query;
			assert: uri fragment equals: copy fragment ]
]

{ #category : #tests }
XMLURITest >> testCopyWithFragment [

	self allURIStringsDo: [ :each |
		| uri oldFragment newFragment copy |
		uri := each asXMLURI.
		oldFragment := uri fragment.
		newFragment := oldFragment , 'new'.
		copy := uri copyWithFragment: newFragment.
		self
			assert: uri equals: each asXMLURI;
			assert: uri uriString equals: each;
			assert: copy uriString isNil;
			deny: uri identicalTo: copy;
			deny: uri equals: copy;
			assert: uri scheme equals: copy scheme;
			assert: uri hasAuthorityPrefix equals: copy hasAuthorityPrefix;
			assert: uri userInfo equals: copy userInfo;
			assert: uri host equals: copy host;
			assert: uri port equals: copy port;
			assert: uri pathSegments equals: copy pathSegments;
			assert: uri query equals: copy query;
			deny: uri fragment equals: copy fragment;
			assert: uri fragment equals: oldFragment;
			assert: copy fragment equals: newFragment ]
]

{ #category : #tests }
XMLURITest >> testCopyWithHost [

	self allURIStringsDo: [ :each |
		| uri oldHost newHost copy |
		uri := each asXMLURI.
		oldHost := uri host.
		newHost := oldHost , 'new'.
		copy := uri copyWithHost: newHost.
		self
			assert: uri equals: each asXMLURI;
			assert: uri uriString equals: each;
			assert: copy uriString isNil;
			deny: uri identicalTo: copy;
			deny: uri equals: copy;
			assert: uri scheme equals: copy scheme;
			assert: uri hasAuthorityPrefix equals: copy hasAuthorityPrefix;
			assert: uri userInfo equals: copy userInfo;
			deny: uri host equals: copy host;
			assert: uri host equals: oldHost;
			assert: copy host equals: newHost;
			assert: uri port equals: copy port;
			assert: uri pathSegments equals: copy pathSegments;
			assert: uri query equals: copy query;
			assert: uri fragment equals: copy fragment ]
]

{ #category : #tests }
XMLURITest >> testCopyWithPath [

	self allURIStringsDo: [ :each |
		| uri oldPath newPath copy |
		uri := each asXMLURI.
		oldPath := uri path.
		newPath := oldPath , '/new'.
		copy := uri copyWithPath: newPath.
		self
			assert: uri equals: each asXMLURI;
			assert: uri uriString equals: each;
			assert: copy uriString isNil;
			deny: uri identicalTo: copy;
			deny: uri equals: copy;
			assert: uri scheme equals: copy scheme;
			assert: uri hasAuthorityPrefix equals: copy hasAuthorityPrefix;
			assert: uri userInfo equals: copy userInfo;
			assert: uri host equals: copy host;
			assert: uri port equals: copy port;
			deny: uri path equals: copy path;
			assert: uri path equals: oldPath;
			assert: copy path equals: newPath;
			assert: uri query equals: copy query;
			assert: uri fragment equals: copy fragment ]
]

{ #category : #tests }
XMLURITest >> testCopyWithPathSegments [

	self allURIStringsDo: [ :each |
		| uri oldPathSegments oldRawPathSegments newPathSegments newRawPathSegments copy |
		uri := each asXMLURI.
		oldPathSegments := uri pathSegments.
		oldRawPathSegments := uri rawPathSegments.
		newPathSegments := oldPathSegments copyWith:
			                   'new' , self reservedCharacters.
		newRawPathSegments := oldRawPathSegments copyWith:
			                      'new' , self percentEncodedReservedCharacters.
		copy := uri copyWithPathSegments: newPathSegments.
		self
			assert: uri equals: each asXMLURI;
			assert: uri uriString equals: each;
			assert: copy uriString isNil;
			deny: uri identicalTo: copy;
			deny: uri equals: copy;
			assert: uri scheme equals: copy scheme;
			assert: uri hasAuthorityPrefix equals: copy hasAuthorityPrefix;
			assert: uri userInfo equals: copy userInfo;
			assert: uri host equals: copy host;
			assert: uri port equals: copy port;
			deny: uri pathSegments equals: copy pathSegments;
			deny: uri rawPathSegments equals: copy rawPathSegments;
			assert: uri pathSegments equals: oldPathSegments;
			assert: uri rawPathSegments equals: oldRawPathSegments;
			assert: copy pathSegments equals: newPathSegments;
			assert: copy rawPathSegments equals: newRawPathSegments;
			assert: uri query equals: copy query;
			assert: uri fragment equals: copy fragment ]
]

{ #category : #tests }
XMLURITest >> testCopyWithPort [

	self allURIStringsDo: [ :each |
		| uri oldPort newPort copy |
		uri := each asXMLURI.
		oldPort := uri port.
		newPort := (oldPort ifNil: [ 0 ]) + 1.
		copy := uri copyWithPort: newPort.
		self
			assert: uri equals: each asXMLURI;
			assert: uri uriString equals: each;
			assert: copy uriString isNil;
			deny: uri identicalTo: copy;
			deny: uri equals: copy;
			assert: uri scheme equals: copy scheme;
			assert: uri hasAuthorityPrefix equals: copy hasAuthorityPrefix;
			assert: uri userInfo equals: copy userInfo;
			assert: uri host equals: copy host;
			deny: uri port equals: copy port;
			assert: uri port equals: oldPort;
			assert: copy port equals: newPort;
			assert: uri pathSegments equals: copy pathSegments;
			assert: uri query equals: copy query;
			assert: uri fragment equals: copy fragment ]
]

{ #category : #tests }
XMLURITest >> testCopyWithQuery [

	self allURIStringsDo: [ :each |
		| uri oldQuery oldRawQuery newQuery newRawQuery copy |
		uri := each asXMLURI.
		oldQuery := uri query.
		oldRawQuery := uri rawQuery.
		newQuery := oldQuery copyWith: 'newKey' , self reservedCharacters
			            -> ('newValue' , self reservedCharacters).
		newRawQuery := oldRawQuery copyWith:
			               'newKey' , self percentEncodedReservedCharacters
			               ->
			               ('newValue' , self percentEncodedReservedCharacters).
		copy := uri copyWithQuery: newQuery.
		self
			assert: uri equals: each asXMLURI;
			assert: uri uriString equals: each;
			assert: copy uriString isNil;
			deny: uri identicalTo: copy;
			deny: uri equals: copy;
			assert: uri scheme equals: copy scheme;
			assert: uri hasAuthorityPrefix equals: copy hasAuthorityPrefix;
			assert: uri userInfo equals: copy userInfo;
			assert: uri host equals: copy host;
			assert: uri port equals: copy port;
			assert: uri pathSegments equals: copy pathSegments;
			deny: uri query equals: copy query;
			deny: uri rawQuery equals: copy rawQuery;
			assert: uri query equals: oldQuery;
			assert: uri rawQuery equals: oldRawQuery;
			assert: copy query equals: newQuery;
			assert: copy rawQuery equals: newRawQuery;
			assert: uri fragment equals: copy fragment ]
]

{ #category : #tests }
XMLURITest >> testCopyWithScheme [

	self allURIStringsDo: [ :each |
		| uri oldScheme oldHasAuthorityPrefix newScheme copy |
		uri := each asXMLURI.
		oldScheme := uri scheme.
		oldHasAuthorityPrefix := uri hasAuthorityPrefix.
		newScheme := oldScheme , 'new'.
		copy := uri copyWithScheme: newScheme.
		self
			assert: uri equals: each asXMLURI;
			assert: uri uriString equals: each;
			assert: copy uriString isNil;
			deny: uri identicalTo: copy;
			deny: uri equals: copy;
			deny: uri scheme equals: copy scheme;
			assert: uri scheme equals: oldScheme;
			assert: copy scheme equals: newScheme;
			assert: uri hasAuthorityPrefix equals: oldHasAuthorityPrefix.
		"If the original had no scheme and no // prefix, then the copy should
		gain one. Otherwise it should only have one if the original did."
		(oldScheme = '' and: [ oldHasAuthorityPrefix not ])
			ifTrue: [ self assert: copy hasAuthorityPrefix ]
			ifFalse: [
			self assert: copy hasAuthorityPrefix equals: oldHasAuthorityPrefix ].
		self
			assert: uri userInfo equals: copy userInfo;
			assert: uri host equals: copy host;
			assert: uri port equals: copy port;
			assert: uri pathSegments equals: copy pathSegments;
			assert: uri query equals: copy query;
			assert: uri fragment equals: copy fragment ]
]

{ #category : #tests }
XMLURITest >> testCopyWithUserInfo [

	self allURIStringsDo: [ :each |
		| uri oldUserInfo oldRawUserInfo newUserInfo newRawUserInfo copy |
		uri := each asXMLURI.
		oldUserInfo := uri userInfo.
		oldRawUserInfo := uri rawUserInfo.
		newUserInfo := oldUserInfo , 'new' , self reservedCharacters.
		newRawUserInfo := oldUserInfo , 'new'
		                  , self percentEncodedReservedCharacters.
		copy := uri copyWithUserInfo: newUserInfo.
		self
			assert: uri equals: each asXMLURI;
			assert: uri uriString equals: each;
			assert: copy uriString isNil;
			deny: uri identicalTo: copy;
			deny: uri equals: copy;
			assert: uri scheme equals: copy scheme;
			assert: uri hasAuthorityPrefix equals: copy hasAuthorityPrefix;
			deny: uri userInfo equals: copy userInfo;
			deny: uri rawUserInfo equals: copy rawUserInfo;
			assert: uri userInfo equals: oldUserInfo;
			assert: uri rawUserInfo equals: oldRawUserInfo;
			assert: copy userInfo equals: newUserInfo;
			assert: copy rawUserInfo equals: newRawUserInfo;
			assert: uri host equals: copy host;
			assert: uri port equals: copy port;
			assert: uri pathSegments equals: copy pathSegments;
			assert: uri query equals: copy query;
			assert: uri fragment equals: copy fragment ]
]

{ #category : #tests }
XMLURITest >> testDefaultAuthorityPrefixPrinting [

	| uri copy |
	uri := '' asXMLURI.

	copy := uri copyWithUserInfo: 'userInfo'.
	self assert: copy printString equals: '//userInfo@'.

	copy := uri copyWithHost: self host.
	self assert: copy printString equals: '//' , self host.

	copy := uri copyWithPort: 80.
	self assert: copy printString equals: '//:80'.

	copy := uri copyWithPath: self relative.
	self assert: copy printString equals: self relative.

	copy := uri copyWithPath: self absolute.
	self assert: copy printString equals: self absolute.

	copy := uri copyWithQuery: self query.
	self assert: copy printString equals: self queryURIString.

	copy := uri copyWithFragment: self fragment.
	self assert: copy printString equals: self fragmentURIString
]

{ #category : #tests }
XMLURITest >> testDefaultPathPrefixPrinting [

	| uri copy |
	uri := self relative asXMLURI.

	copy := uri copyWithUserInfo: 'userInfo'.
	self assert: copy printString equals: '//userInfo@/' , self relative.

	copy := uri copyWithHost: self host.
	self
		assert: copy printString
		equals: '//' , self host , '/' , self relative.

	copy := uri copyWithPort: 80.
	self assert: copy printString equals: '//:80/' , self relative.

	copy := uri copyWithScheme: 'http'.
	self assert: copy printString equals: 'http:///' , self relative.

	copy := uri copyWithQuery: self query.
	self
		assert: copy printString
		equals: self relative , self queryURIString.

	copy := uri copyWithFragment: self fragment.
	self
		assert: copy printString
		equals: self relative , self fragmentURIString
]

{ #category : #tests }
XMLURITest >> testEquals [

	self allURIStringsDo: [ :each |
		| uri otherURI |
		uri := each asXMLURI.

		otherURI := each asXMLURI.
		self
			assert: uri equals: otherURI;
			assert: otherURI equals: uri.
		otherURI scheme: uri scheme , 'new'.
		self
			deny: uri equals: otherURI;
			deny: otherURI equals: uri.

		otherURI := each asXMLURI.
		self
			assert: uri equals: otherURI;
			assert: otherURI equals: uri.
		otherURI rawUserInfo: uri userInfo , 'new'.
		self
			deny: uri equals: otherURI;
			deny: otherURI equals: uri.

		otherURI := each asXMLURI.
		self
			assert: uri equals: otherURI;
			assert: otherURI equals: uri.
		otherURI rawHost: uri host , 'new'.
		self
			deny: uri equals: otherURI;
			deny: otherURI equals: uri.

		otherURI := each asXMLURI.
		self
			assert: uri equals: otherURI;
			assert: otherURI equals: uri.
		otherURI rawPathSegments: (uri pathSegments copyWith: 'new').
		self
			deny: uri equals: otherURI;
			deny: otherURI equals: uri.

		otherURI := each asXMLURI.
		self
			assert: uri equals: otherURI;
			assert: otherURI equals: uri.
		otherURI rawQuery: (uri query copy
				 add: 'new' -> '';
				 yourself).
		self
			deny: uri equals: otherURI;
			deny: otherURI equals: uri.

		otherURI := each asXMLURI.
		self
			assert: uri equals: otherURI;
			assert: otherURI equals: uri.
		otherURI rawFragment: uri fragment , 'new'.
		self
			deny: uri equals: otherURI;
			deny: otherURI equals: uri ]
]

{ #category : #tests }
XMLURITest >> testFragment [

	self
		assert: '' asXMLURI fragment equals: '';
		assert: '/' asXMLURI fragment equals: '';
		assert: self absolute asXMLURI fragment equals: '';
		assert: self absoluteDir asXMLURI fragment equals: '';
		assert: self absoluteDirRelativeCombined asXMLURI fragment
		equals: '';
		assert: self absoluteRelativeCombined asXMLURI fragment equals: '';
		assert: self domainURIString asXMLURI fragment equals: '';
		assert: self domainURIWithPortString asXMLURI fragment equals: '';
		assert: self emailURIString asXMLURI fragment equals: '';
		assert: self fileURIWithHostString asXMLURI fragment equals: '';
		assert: self fileURIString asXMLURI fragment equals: '';
		assert: self fragmentURIString asXMLURI fragment
		equals: self fragment;
		assert: self fullURIString asXMLURI fragment equals: self fragment;
		assert: self fullURIWithPortString asXMLURI fragment
		equals: self fragment;
		assert: self queryURIString asXMLURI fragment equals: '';
		assert: self relative asXMLURI fragment equals: '';
		assert: self relativeAbsoluteCombined asXMLURI fragment equals: '';
		assert: self schemelessURIString asXMLURI fragment
		equals: self fragment;
		assert: self schemelessURIWithPortString asXMLURI fragment
		equals: self fragment
]

{ #category : #tests }
XMLURITest >> testFragmentNonPercentEncodedCharacters [

	| fragment uriString uri |
	fragment := self nonPercentEncodedPathCharacters , '/?'.
	uriString := '#' , fragment.
	uri := uriString asXMLURI.
	self
		assert: uri fragment equals: fragment;
		assert: uri rawFragment equals: fragment.

	uri uriString: nil.
	self assert: uri printString equals: uriString
]

{ #category : #tests }
XMLURITest >> testFragmentPercentEncodedCharacters [

	| encoded decoded encodedURIString uri |
	encoded := self percentEncodedASCIICharacters , '+'.
	decoded := self asciiCharacters , '+'.
	encodedURIString := '#' , encoded.
	uri := encodedURIString asXMLURI.
	self
		assert: uri fragment equals: decoded;
		assert: uri rawFragment equals: encoded.

	uri uriString: nil.
	self assert: uri printString equals: encodedURIString
]

{ #category : #tests }
XMLURITest >> testFromStream [

	self allURIStringsDo: [ :each |
		| stream uri |
		stream := each readStream.
		uri := XMLURI fromStream: stream.
		self
			assert: uri class identicalTo: XMLURI;
			assert: uri uriString isNil;
			assert: uri equals: each asXMLURI;
			assert: stream atEnd ]
]

{ #category : #tests }
XMLURITest >> testFromString [

	self allURIStringsDo: [ :each |
		| uri |
		uri := XMLURI fromString: each.
		self
			assert: uri class identicalTo: XMLURI;
			assert: uri uriString equals: each;
			assert: uri equals: each asXMLURI ]
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
		deny: self fragmentURIString asXMLURI hasAbsolutePath;
		assert: self fullURIString asXMLURI hasAbsolutePath;
		assert: self fullURIWithPortString asXMLURI hasAbsolutePath;
		deny: self queryURIString asXMLURI hasAbsolutePath;
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
		deny: self fragmentURIString asXMLURI hasAuthority;
		assert: self fullURIString asXMLURI hasAuthority;
		assert: self fullURIWithPortString asXMLURI hasAuthority;
		deny: self queryURIString asXMLURI hasAuthority;
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
		deny: self fragmentURIString asXMLURI hasAuthorityPrefix;
		assert: self fullURIString asXMLURI hasAuthorityPrefix;
		assert: self fullURIWithPortString asXMLURI hasAuthorityPrefix;
		deny: self queryURIString asXMLURI hasAuthorityPrefix;
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
		deny: self fragmentURIString asXMLURI hasDirectoryPath;
		deny: self fullURIString asXMLURI hasDirectoryPath;
		deny: self fullURIWithPortString asXMLURI hasDirectoryPath;
		deny: self queryURIString asXMLURI hasDirectoryPath;
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
		deny: self fragmentURIString asXMLURI hasHost;
		assert: self fullURIString asXMLURI hasHost;
		assert: self fullURIWithPortString asXMLURI hasHost;
		deny: self queryURIString asXMLURI hasHost;
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
		deny: self fragmentURIString asXMLURI hasNonDirectoryPath;
		assert: self fullURIString asXMLURI hasNonDirectoryPath;
		assert: self fullURIWithPortString asXMLURI hasNonDirectoryPath;
		deny: self queryURIString asXMLURI hasNonDirectoryPath;
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
		deny: self fragmentURIString asXMLURI hasPath;
		assert: self fullURIString asXMLURI hasPath;
		assert: self fullURIWithPortString asXMLURI hasPath;
		deny: self queryURIString asXMLURI hasPath;
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
		deny: self fragmentURIString asXMLURI hasPort;
		deny: self fullURIString asXMLURI hasPort;
		assert: self fullURIWithPortString asXMLURI hasPort;
		deny: self queryURIString asXMLURI hasPort;
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
		deny: self fragmentURIString asXMLURI hasScheme;
		assert: self fullURIString asXMLURI hasScheme;
		assert: self fullURIWithPortString asXMLURI hasScheme;
		deny: self queryURIString asXMLURI hasScheme;
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
XMLURITest >> testHash [
	"We can only safely test that equal objects have the same hash; testing
	that different objects have different hashes would be unreliable
	because #hash is non-cryptographic and has collisions."

	self allURIStringsDo: [ :each |
		self assert: each asXMLURI hash equals: each asXMLURI hash ]
]

{ #category : #tests }
XMLURITest >> testHashPercentEncoding [

	| uriTemplate unencodedURI encodedURI |
	uriTemplate := 'http://{1}@{1}:80/{1}/{1}?{1}={1}&{1}={1}#{1}'.
	unencodedURI := (uriTemplate format:
		                 (Array with: self alphaNumericCharacters)) asXMLURI.
	encodedURI := (uriTemplate format:
		               (Array with:
			                self percentEncodedAlphaNumericCharacters))
		              asXMLURI.
	self assert: unencodedURI hash equals: unencodedURI hash
]

{ #category : #tests }
XMLURITest >> testHost [

	self
		assert: '' asXMLURI host equals: '';
		assert: '/' asXMLURI host equals: '';
		assert: self absolute asXMLURI host equals: '';
		assert: self absoluteDir asXMLURI host equals: '';
		assert: self absoluteDirRelativeCombined asXMLURI host equals: '';
		assert: self absoluteRelativeCombined asXMLURI host equals: '';
		assert: self domainURIString asXMLURI host equals: self host;
		assert: self domainURIWithPortString asXMLURI host
		equals: self host;
		assert: self emailURIString asXMLURI host equals: self host;
		assert: self fileURIWithHostString asXMLURI host equals: self host;
		assert: self fileURIString asXMLURI host equals: '';
		assert: self fragmentURIString asXMLURI host equals: '';
		assert: self fullURIString asXMLURI host equals: self host;
		assert: self fullURIWithPortString asXMLURI host equals: self host;
		assert: self queryURIString asXMLURI host equals: '';
		assert: self relative asXMLURI host equals: '';
		assert: self relativeAbsoluteCombined asXMLURI host equals: '';
		assert: self schemelessURIString asXMLURI host equals: self host;
		assert: self schemelessURIWithPortString asXMLURI host
		equals: self host
]

{ #category : #tests }
XMLURITest >> testHostNonPercentEncodedCharacters [

	| host uriString uri |
	host := self unreservedCharacters , self subDelimiterCharacters.
	uriString := 'http://' , host.
	uri := uriString asXMLURI.
	self
		assert: uri scheme equals: 'http';
		assert: uri host equals: host asLowercase;
		assert: uri rawHost equals: host.

	uri uriString: nil.
	self assert: uri printString equals: uriString
]

{ #category : #tests }
XMLURITest >> testHostPercentEncodedCharacters [

	| prefix encoded decoded encodedURIString uri |
	prefix := 'http://'.
	encoded := self percentEncodedASCIICharacters , '+'.
	decoded := self asciiCharacters , '+'.
	encodedURIString := prefix , encoded.
	uri := encodedURIString asXMLURI.
	self
		assert: uri scheme equals: 'http';
		assert: uri host equals: decoded asLowercase;
		assert: uri rawHost equals: encoded.

	uri uriString: nil.
	self assert: uri printString equals: encodedURIString
]

{ #category : #tests }
XMLURITest >> testIPv6Hosts [

	| ipv6Host uriString uri |
	ipv6Host := '[FEDC:BA98:7654:3210:FEDC:BA98:7654:3210]'.
	uriString := 'http://' , ipv6Host , ':80' , self absolute.
	uri := uriString asXMLURI.
	self
		assert: uri scheme equals: 'http';
		assert: uri host equals: ipv6Host;
		assert: uri port equals: 80;
		assert: uri path equals: self absolute;
		assert: uri query isEmpty;
		assert: uri fragment equals: ''.
	uri uriString: nil.
	self assert: uri printString equals: uriString.

	uriString := 'http://' , ipv6Host , self absolute.
	uri := uriString asXMLURI.
	self
		assert: uri scheme equals: 'http';
		assert: uri host equals: ipv6Host;
		assert: uri port isNil;
		assert: uri path equals: self absolute;
		assert: uri query isEmpty;
		assert: uri fragment equals: ''.
	uri uriString: nil.
	self assert: uri printString equals: uriString
]

{ #category : #tests }
XMLURITest >> testInvalidPort [

	| uri |
	uri := (self domainURIString , ':invalid' , self absolute) asXMLURI.
	self
		assert: uri host equals: self host;
		assert: uri port isNil;
		assert: uri path equals: self absolute.

	uri := (self domainURIString , ':invalid' , self queryURIString)
		       asXMLURI.
	self
		assert: uri host equals: self host;
		assert: uri port isNil;
		assert: uri pathSegments isEmpty.

	uri := (self domainURIString , ':invalid' , self fragmentURIString)
		       asXMLURI.
	self
		assert: uri host equals: self host;
		assert: uri port isNil;
		assert: uri pathSegments isEmpty
]

{ #category : #tests }
XMLURITest >> testInvalidPortSuffix [

	| uri |
	uri := (self domainURIWithPortString , 'invalid' , self absolute)
		       asXMLURI.
	self
		assert: uri host equals: self host;
		assert: uri port equals: 80;
		assert: uri path equals: self absolute.

	uri := (self domainURIWithPortString , 'invalid'
	        , self queryURIString) asXMLURI.
	self
		assert: uri host equals: self host;
		assert: uri port equals: 80;
		assert: uri pathSegments isEmpty.

	uri := (self domainURIWithPortString , 'invalid'
	        , self fragmentURIString) asXMLURI.
	self
		assert: uri host equals: self host;
		assert: uri port equals: 80;
		assert: uri pathSegments isEmpty
]

{ #category : #tests }
XMLURITest >> testIsEmpty [
	| uri |

	self allURIStringsDo: [:each |
		uri := each asXMLURI.
		each = ''
			ifTrue: [self assert: uri isEmpty]
			ifFalse: [self deny: uri isEmpty].

		uri
			parseURIStringIfUnparsed;
			uriString: nil.
		each isEmpty
			ifTrue: [self assert: uri isEmpty]
			ifFalse: [self deny: uri isEmpty]].

	uri := '//:?#' asXMLURI.
	self assert: uri isEmpty.
	uri
		parseURIStringIfUnparsed;
		uriString: nil.
	self assert: uri isEmpty.
]

{ #category : #tests }
XMLURITest >> testIsFile [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		uri scheme = 'file'
			ifTrue: [self assert: uri isFile]
			ifFalse: [self deny: uri isFile]]
]

{ #category : #tests }
XMLURITest >> testIsHTTP [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		uri scheme = 'http'
			ifTrue: [self assert: uri isHTTP]
			ifFalse: [self deny: uri isHTTP]]
]

{ #category : #tests }
XMLURITest >> testIsHTTPS [
	self allURIStringsDo: [:each | | uri |
		uri := each asXMLURI.
		uri scheme = 'https'
			ifTrue: [self assert: uri isHTTPS]
			ifFalse: [self deny: uri isHTTPS]]
]

{ #category : #tests }
XMLURITest >> testIsLocal [
	self
		assert: '' asXMLURI isLocal;
		assert: '/' asXMLURI isLocal;
		assert: self absolute asXMLURI isLocal;
		assert: self absoluteDir asXMLURI isLocal;
		assert: self absoluteDirRelativeCombined asXMLURI isLocal;
		assert: self absoluteRelativeCombined asXMLURI isLocal;
		deny: self domainURIString asXMLURI isLocal;
		deny: self domainURIWithPortString asXMLURI isLocal;
		deny: self emailURIString asXMLURI isLocal;
		assert: self fileURIWithHostString asXMLURI isLocal;
		assert: self fileURIString asXMLURI isLocal;
		assert: self fragmentURIString asXMLURI isLocal;
		deny: self fullURIString asXMLURI isLocal;
		deny: self fullURIWithPortString asXMLURI isLocal;
		assert: self queryURIString asXMLURI isLocal;
		assert: self relative asXMLURI isLocal;
		assert: self relativeAbsoluteCombined asXMLURI isLocal;
		deny: self schemelessURIString asXMLURI isLocal;
		deny: self schemelessURIWithPortString asXMLURI isLocal
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
		assert: self fragmentURIString asXMLURI isRelative;
		deny: self fullURIString asXMLURI isRelative;
		deny: self fullURIWithPortString asXMLURI isRelative;
		assert: self queryURIString asXMLURI isRelative;
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
		assert: uri uriString equals: '';
		assert: uri isEmpty
]

{ #category : #tests }
XMLURITest >> testNotEmpty [
	| uri |

	self allURIStringsDo: [:each |
		uri := each asXMLURI.
		each notEmpty
			ifTrue: [self assert: uri notEmpty]
			ifFalse: [self deny: uri notEmpty].

		uri
			parseURIStringIfUnparsed;
			uriString: nil.
		each notEmpty
			ifTrue: [self assert: uri notEmpty]
			ifFalse: [self deny: uri notEmpty]].

	uri := '//:?#' asXMLURI.
	self deny: uri notEmpty.
	uri
		parseURIStringIfUnparsed;
		uriString: nil.
	self deny: uri notEmpty.
]

{ #category : #tests }
XMLURITest >> testParsingQueryString [

	#( '' '?' '?&' '?&&' ) do: [ :each |
		self assert: each asXMLURI query equals: OrderedCollection new ].

	#( '?a=b' '?&a=b&' '?&&a=b&&' ) do: [ :each |
		self
			assert: each asXMLURI query
			equals: (OrderedCollection with: 'a' -> 'b') ].

	#( '?=&a=b' '?&=&a=b' '?&&=&&a=b' ) do: [ :each |
		self
			assert: each asXMLURI query
			equals: (OrderedCollection with: '' -> '' with: 'a' -> 'b') ].

	#( '?a=b&=' '?a=b&=&' '?a=b&&=&&' ) do: [ :each |
		self
			assert: each asXMLURI query
			equals: (OrderedCollection with: 'a' -> 'b' with: '' -> '') ].

	#( '?c=&a=b' '?&c=&a=b' '?&&c=&&a=b' ) do: [ :each |
		self
			assert: each asXMLURI query
			equals: (OrderedCollection with: 'c' -> '' with: 'a' -> 'b') ].

	#( '?a=b&c=' '?a=b&c=&' '?a=b&&c=&&' ) do: [ :each |
		self
			assert: each asXMLURI query
			equals: (OrderedCollection with: 'a' -> 'b' with: 'c' -> '') ]
]

{ #category : #tests }
XMLURITest >> testPath [

	self
		assert: '' asXMLURI path equals: '';
		assert: '/' asXMLURI path equals: '/';
		assert: self absolute asXMLURI path equals: self absolute;
		assert: self absoluteDir asXMLURI path equals: self absoluteDir;
		assert: self absoluteDirRelativeCombined asXMLURI path
		equals: self absoluteDirRelativeCombined;
		assert: self absoluteRelativeCombined asXMLURI path
		equals: self absoluteRelativeCombined;
		assert: self domainURIString asXMLURI path equals: '';
		assert: self domainURIWithPortString asXMLURI path equals: '';
		assert: self emailURIString asXMLURI path equals: '';
		assert: self fileURIWithHostString asXMLURI path
		equals: self absolute;
		assert: self fileURIString asXMLURI path equals: self absolute;
		assert: self fragmentURIString asXMLURI path equals: '';
		assert: self fullURIString asXMLURI path equals: self absolute;
		assert: self fullURIWithPortString asXMLURI path
		equals: self absolute;
		assert: self queryURIString asXMLURI path equals: '';
		assert: self relative asXMLURI path equals: self relative;
		assert: self relativeAbsoluteCombined asXMLURI path
		equals: self relativeAbsoluteCombined;
		assert: self schemelessURIString asXMLURI path
		equals: self absolute;
		assert: self schemelessURIWithPortString asXMLURI path
		equals: self absolute
]

{ #category : #tests }
XMLURITest >> testPathNonPercentEncodedCharacters [

	| firstSegment secondSegment uriString uri |
	firstSegment := self nonPercentEncodedPathCharacters copyWithout: $:.
	secondSegment := self nonPercentEncodedPathCharacters.
	uriString := firstSegment , '/' , secondSegment.
	uri := uriString asXMLURI.
	self assert: uri path equals: firstSegment , '/' , secondSegment.
	self
		assert: uri pathSegments
		equals: (OrderedCollection with: firstSegment with: secondSegment).
	self
		assert: uri rawPathSegments
		equals: (OrderedCollection with: firstSegment with: secondSegment).

	uri uriString: nil.
	self assert: uri printString equals: uriString
]

{ #category : #tests }
XMLURITest >> testPathPercentEncodedCharacters [

	| encoded decoded encodedURIString uri |
	encoded := self percentEncodedASCIICharacters , '+'.
	decoded := self asciiCharacters , '+'.
	encodedURIString := encoded , '/' , encoded.
	uri := encodedURIString asXMLURI.
	self assert: uri path equals: decoded , '/' , decoded.
	self
		assert: uri pathSegments
		equals: (OrderedCollection with: decoded with: decoded).
	self
		assert: uri rawPathSegments
		equals: (OrderedCollection with: encoded with: encoded).

	uri uriString: nil.
	self assert: uri printString equals: encodedURIString
]

{ #category : #tests }
XMLURITest >> testPathSegments [

	self
		assert: '' asXMLURI pathSegments isEmpty;
		assert: '/' asXMLURI pathSegments
		equals: #( '' '' ) asOrderedCollection;
		assert: self absolute asXMLURI pathSegments
		equals: self absoluteSegments;
		assert: self absoluteDir asXMLURI pathSegments
		equals: self absoluteDirSegments;
		assert: self absoluteDirRelativeCombined asXMLURI pathSegments
		equals: self absoluteDirRelativeCombinedSegments;
		assert: self absoluteRelativeCombined asXMLURI pathSegments
		equals: self absoluteRelativeCombinedSegments;
		assert: self domainURIString asXMLURI pathSegments isEmpty;
		assert: self domainURIWithPortString asXMLURI pathSegments isEmpty;
		assert: self emailURIString asXMLURI pathSegments isEmpty;
		assert: self fileURIWithHostString asXMLURI pathSegments
		equals: self absoluteSegments;
		assert: self fileURIString asXMLURI pathSegments
		equals: self absoluteSegments;
		assert: self fragmentURIString asXMLURI pathSegments isEmpty;
		assert: self fullURIString asXMLURI pathSegments
		equals: self absoluteSegments;
		assert: self fullURIWithPortString asXMLURI pathSegments
		equals: self absoluteSegments;
		assert: self queryURIString asXMLURI pathSegments isEmpty;
		assert: self relative asXMLURI pathSegments
		equals: self relativeSegments;
		assert: self relativeAbsoluteCombined asXMLURI pathSegments
		equals: self relativeAbsoluteCombinedSegments;
		assert: self schemelessURIString asXMLURI pathSegments
		equals: self absoluteSegments;
		assert: self schemelessURIWithPortString asXMLURI pathSegments
		equals: self absoluteSegments
]

{ #category : #tests }
XMLURITest >> testPathSegmentsDo [

	self allURIStringsDo: [ :uriString |
		| uri visited |
		uri := uriString asXMLURI.
		visited := OrderedCollection new.
		uri pathSegmentsDo: [ :each | visited addLast: each ].
		self assert: visited equals: uri pathSegments ]
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
		assert: self domainURIWithPortString asXMLURI port equals: 80;
		assert: self emailURIString asXMLURI port isNil;
		assert: self fileURIWithHostString asXMLURI port isNil;
		assert: self fileURIString asXMLURI port isNil;
		assert: self fragmentURIString asXMLURI port isNil;
		assert: self fullURIString asXMLURI port isNil;
		assert: self fullURIWithPortString asXMLURI port equals: 80;
		assert: self queryURIString asXMLURI port isNil;
		assert: self relative asXMLURI port isNil;
		assert: self relativeAbsoluteCombined asXMLURI port isNil;
		assert: self schemelessURIString asXMLURI port isNil;
		assert: self schemelessURIWithPortString asXMLURI port equals: 80
]

{ #category : #tests }
XMLURITest >> testPrintOn [

	self allURIStringsDo: [ :each |
		| uri |
		uri := each asXMLURI.
		self assert: uri printString equals: each.

		uri
			parseURIStringIfUnparsed;
			uriString: nil.
		self
			assert: uri uriString isNil;
			assert: uri printString equals: each;
			assert: uri uriString equals: each ]
]

{ #category : #tests }
XMLURITest >> testQuery [

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
		assert: self fragmentURIString asXMLURI query isEmpty;
		assert: self fullURIString asXMLURI query equals: self query;
		assert: self fullURIWithPortString asXMLURI query
		equals: self query;
		assert: self queryURIString asXMLURI query equals: self query;
		assert: self relative asXMLURI query isEmpty;
		assert: self relativeAbsoluteCombined asXMLURI query isEmpty;
		assert: self schemelessURIString asXMLURI query equals: self query;
		assert: self schemelessURIWithPortString asXMLURI query
		equals: self query
]

{ #category : #tests }
XMLURITest >> testQueryAt [

	self allURIStringsDo: [ :uriString |
		| uri visitedKeys |
		uri := uriString asXMLURI.
		visitedKeys := Set new.
		uri query do: [ :each |
			(visitedKeys includes: each key) ifFalse: [
				self assert: (uri queryAt: each key) equals: each value.
				visitedKeys add: each key ] ].
		self assert: (uri queryAt: 'absent') equals: '' ]
]

{ #category : #tests }
XMLURITest >> testQueryAtIfAbsent [

	self allURIStringsDo: [ :uriString |
		| uri visitedKeys |
		uri := uriString asXMLURI.
		visitedKeys := Set new.
		uri query do: [ :each |
			(visitedKeys includes: each key) ifFalse: [
				self
					assert: (uri queryAt: each key ifAbsent: [ self fail ])
					equals: each value.
				visitedKeys add: each key ] ].
		self
			assert: (uri queryAt: 'absentKey' ifAbsent: [ 'absentValue' ])
			equals: 'absentValue' ]
]

{ #category : #tests }
XMLURITest >> testQueryIncludesKey [
	self allURIStringsDo: [:uriString | | uri |
		uri := uriString asXMLURI.
		uri query do: [:each |
			self assert: (uri queryIncludesKey: each key)].
		self deny: (uri queryIncludesKey: 'absent')]
]

{ #category : #tests }
XMLURITest >> testQueryKeys [

	self allURIStringsDo: [ :uriString |
		| uri |
		uri := uriString asXMLURI.
		self
			assert: uri queryKeys
			equals: (uri query collect: [ :each | each key ]) ]
]

{ #category : #tests }
XMLURITest >> testQueryKeysAndValuesDo [

	self allURIStringsDo: [ :each |
		| uri visited |
		uri := each asXMLURI.
		visited := OrderedCollection new.
		self
			assert: (uri queryKeysAndValuesDo: [ :key :value |
					 visited addLast: key -> value ])
			identicalTo: uri.
		self assert: visited equals: uri query ]
]

{ #category : #tests }
XMLURITest >> testQueryKeysDo [

	self allURIStringsDo: [ :uriString |
		| uri visited |
		uri := uriString asXMLURI.
		visited := OrderedCollection new.
		self
			assert: (uri queryKeysDo: [ :each | visited addLast: each ])
			identicalTo: uri.
		self assert: visited equals: uri queryKeys ]
]

{ #category : #tests }
XMLURITest >> testQueryNonPercentOrPlusEncodedCharacters [

	| queryKey queryValue uriString uri |
	queryKey := (self nonPercentEncodedPathCharacters copyWithoutAll:
		             '=&+') , '/?'.
	queryValue := (self nonPercentEncodedPathCharacters copyWithoutAll:
		               '&+') , '/?'.
	uriString := '?' , queryKey , '=' , queryValue.
	uri := uriString asXMLURI.
	self
		assert: uri query
		equals: (OrderedCollection with: queryKey -> queryValue);
		assert: (uri queryAt: queryKey) equals: queryValue;
		assert: (uri queryAt: queryKey ifAbsent: [ 'absent' ])
		equals: queryValue;
		assert: (uri queryValuesAt: queryKey)
		equals: (OrderedCollection with: queryValue);
		assert: (uri queryValuesAt: queryKey ifAbsent: [ #( 'absent' ) ])
		equals: (OrderedCollection with: queryValue);
		assert: uri queryKeys equals: (OrderedCollection with: queryKey);
		assert: (uri queryIncludesKey: queryKey);
		assert: uri rawQuery
		equals: (OrderedCollection with: queryKey -> queryValue).

	uri uriString: nil.
	self assert: uri printString equals: uriString
]

{ #category : #tests }
XMLURITest >> testQueryPercentOrPlusEncodedCharacters [

	| encoded decoded encodedURIString uri |
	encoded := self percentEncodedASCIICharacters , '+'.
	decoded := self asciiCharacters , ' '.
	encodedURIString := '?' , encoded , '=' , encoded.
	uri := encodedURIString asXMLURI.
	self
		assert: uri query
		equals: (OrderedCollection with: decoded -> decoded);
		assert: (uri queryAt: decoded) equals: decoded;
		assert: (uri queryAt: decoded ifAbsent: [ 'absent' ])
		equals: decoded;
		assert: (uri queryValuesAt: decoded)
		equals: (OrderedCollection with: decoded);
		assert: (uri queryValuesAt: decoded ifAbsent: [ #(  ) ])
		equals: (OrderedCollection with: decoded);
		assert: uri queryKeys equals: (OrderedCollection with: decoded);
		assert: (uri queryIncludesKey: decoded);
		assert: uri rawQuery
		equals: (OrderedCollection with: encoded -> encoded).

	uri uriString: nil.
	self assert: uri printString equals: encodedURIString
]

{ #category : #tests }
XMLURITest >> testQueryValuesAt [

	self allURIStringsDo: [ :uriString |
		| uri valuesForKeys |
		uri := uriString asXMLURI.
		valuesForKeys := Dictionary new.
		uri query do: [ :each |
			(valuesForKeys at: each key ifAbsentPut: [ OrderedCollection new ])
				addLast: each value ].
		valuesForKeys keysAndValuesDo: [ :key :values |
			self assert: (uri queryValuesAt: key) equals: values ].
		self
			assert: (uri queryValuesAt: 'absent')
			equals: OrderedCollection new ]
]

{ #category : #tests }
XMLURITest >> testQueryValuesAtDo [

	self allURIStringsDo: [ :uriString |
		| uri valuesForKeys |
		uri := uriString asXMLURI.
		valuesForKeys := Dictionary new.
		uri query do: [ :each |
			(valuesForKeys at: each key ifAbsentPut: [ OrderedCollection new ])
				addLast: each value ].
		valuesForKeys keysAndValuesDo: [ :key :values |
			| enumerated |
			enumerated := OrderedCollection new.
			self
				assert:
				(uri queryValuesAt: key do: [ :each | enumerated addLast: each ])
				identicalTo: uri.
			self assert: enumerated equals: values ] ]
]

{ #category : #tests }
XMLURITest >> testQueryValuesAtIfAbsent [
	self allURIStringsDo: [:uriString | | uri valuesForKeys |
		uri := uriString asXMLURI.
		valuesForKeys := Dictionary new.
		uri query do: [:each |
			(valuesForKeys
				at: each key
				ifAbsentPut: [OrderedCollection new])
					addLast: each value].
		valuesForKeys keysAndValuesDo: [:key :values |
			self assert:
				(uri
					queryValuesAt: key
					ifAbsent: [self fail]) = values].
		self assert:
			(uri
				queryValuesAt: 'absent'
				ifAbsent: [#absent]) = #absent]
]

{ #category : #tests }
XMLURITest >> testReadFrom [
	self allURIStringsDo: [:each | | stream uri |
		stream := each readStream.
		uri := XMLURI readFrom: stream.
		self
			assert: uri class == XMLURI;
			assert: uri uriString isNil;
			assert: uri = each asXMLURI;
			assert: stream atEnd.

		uri := XMLURI readFrom: each.
		self
			assert: uri class == XMLURI;
			assert: uri uriString = each;
			assert: uri = each asXMLURI]
]

{ #category : #tests }
XMLURITest >> testScheme [
	self
		assert: '' asXMLURI scheme = '';
		assert: '/' asXMLURI scheme = '';
		assert: self absolute asXMLURI scheme = '';
		assert: self absoluteDir asXMLURI scheme = '';
		assert: self absoluteDirRelativeCombined asXMLURI scheme = '';
		assert: self absoluteRelativeCombined asXMLURI scheme = '';
		assert: self domainURIString asXMLURI scheme = 'http';
		assert: self domainURIWithPortString asXMLURI scheme = 'http';
		assert: self emailURIString asXMLURI scheme = 'mailto';
		assert: self fileURIWithHostString asXMLURI scheme = 'file';
		assert: self fileURIString asXMLURI scheme  = 'file';
		assert: self fragmentURIString asXMLURI scheme = '';
		assert: self fullURIString asXMLURI scheme = 'http';
		assert: self fullURIWithPortString asXMLURI scheme = 'http';
		assert: self queryURIString asXMLURI scheme = '';
		assert: self relative asXMLURI scheme = '';
		assert: self relativeAbsoluteCombined asXMLURI scheme = '';
		assert: self schemelessURIString asXMLURI scheme = '';
		assert: self schemelessURIWithPortString asXMLURI scheme = ''
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
			ifFalse: [self assert: uri userInfo = '']]
]

{ #category : #tests }
XMLURITest >> testUserInfoNonPercentEncodedCharacters [
	| userInfo uriString uri |

	userInfo := self unreservedCharacters, self subDelimiterCharacters, ':'.
	uriString := 'mailto:', userInfo, '@', self host.
	uri := uriString asXMLURI.
	self
		assert: uri scheme = 'mailto';
		assert: uri userInfo = userInfo;
		assert: uri host = self host.

	uri uriString: nil.
	self assert: uri printString = uriString.
]

{ #category : #tests }
XMLURITest >> testUserInfoPercentEncodedCharacters [
	| prefix encoded decoded suffix encodedURIString uri |

	prefix := 'mailto:'.
	encoded := self percentEncodedASCIICharacters, '+'.
	decoded := self asciiCharacters, '+'.
	suffix := '@', self host.
	encodedURIString := prefix, encoded, suffix.
	uri := encodedURIString asXMLURI.
	self
		assert: uri scheme = 'mailto';
		assert: uri userInfo = decoded;
		assert: uri rawUserInfo = encoded.

	uri uriString: nil.
	self assert: uri printString = encodedURIString.
]

{ #category : #accessing }
XMLURITest >> unreservedCharacters [
	^ unreservedCharacters
		ifNil: [unreservedCharacters := self alphaNumericCharacters, '-._~']
]
