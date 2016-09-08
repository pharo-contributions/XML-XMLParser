"
These tests use HTTP and the file system and are skipped by default. This enables them:

self isSkipping: false.
"
Class {
	#name : #XMLExternalEntityTest,
	#superclass : #TestCase,
	#classVars : [
		'IsSkipping'
	],
	#category : #'XML-Tests-Parser'
}

{ #category : #testing }
XMLExternalEntityTest class >> isSkipping [
	"HTTP/file tests are skipped by default"
	^ IsSkipping ifNil: [IsSkipping := true]
]

{ #category : #testing }
XMLExternalEntityTest class >> isSkipping: aBoolean [
	"HTTP/file tests are skipped by default.

	self isSkipping: false.
	self isSkipping: true.
	"
	IsSkipping := aBoolean
]

{ #category : #accessing }
XMLExternalEntityTest class >> startSkipping [
	^ self isSkipping: true
]

{ #category : #accessing }
XMLExternalEntityTest class >> stopSkipping [
	^ self isSkipping: false
]

{ #category : #accessing }
XMLExternalEntityTest >> defaultTimeout [
	"this is needed for Squeak to prevent it from timing out
	these long-running tests when skipping is disabled"
	^ 60 * 10
]

{ #category : #source }
XMLExternalEntityTest >> docBookArticleSource [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN" "http://docbook.org/xml/4.5/docbookx.dtd">
<article>
	<articleinfo>
		<title>About Pharo</title>
		<author>
			<honorific>Dr.</honorific>
			<firstname>Stephane</firstname>
			<surname>Ducasse</surname>
		</author>
	</articleinfo>
	<section>
		<title>Mission</title>
		<para>Pharo''s goal is to deliver a clean, innovative, free open-source environment. Here is the to be revised Pharo vision document.</para>
		<para>By providing a stable and small core system, excellent developing tools, and maintained releases, Pharo is an attractive platform to build and deploy mission critical applications.</para>
		<para>Pharo fosters a healthy ecosystem of both private and commercial contributors who advance and maintain the core system and its external packages.</para>
	</section>
	<section>
		<title>Pharo features</title>
		<para>A dynamic, pure object-oriented programming language in the tradition of Smalltalk</para>
		<para>An IDE (integrated development environment)</para>
		<para>A huge library and set of external packages</para>
	</section>
	<section>
		<title>Pharo and Business</title>
		<para>The goal of Pharo is to sustain and grow business.</para>
		<para>Pharo is supported by the industrial Pharo consortium.</para>
		<para>Pharo has also an association of users: Pharo association</para>
    </section>
</article>'
]

{ #category : #source }
XMLExternalEntityTest >> docBookExampleSource [
	^ '<!DOCTYPE example
	PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd">
	<example>
		<title>An Example</title>
		<programlisting>
		XMLDocument root:
			((XMLElement named: ''test'')
				addNode: ''An example'' asXMLString;
				yourself)
		</programlisting>
	</example>'
]

{ #category : #urls }
XMLExternalEntityTest >> feedURL [
	^ 'http://pharo.org/news/atom.xml'
]

{ #category : #files }
XMLExternalEntityTest >> fileHandleForNewFileSuffixed: aFileSuffix [
	| fileHandle |
	
	fileHandle := (self class name asString, '-', aFileSuffix) asXMLFileHandle.
	fileHandle exists
		ifTrue: [fileHandle delete].
	^ fileHandle.
]

{ #category : #accessing }
XMLExternalEntityTest >> isSkipping [
	^ self class isSkipping
]

{ #category : #source }
XMLExternalEntityTest >> musicXMLDocument [
	^ '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE score-partwise PUBLIC
    "-//Recordare//DTD MusicXML 3.0 Partwise//EN"
    "http://www.musicxml.org/dtds/partwise.dtd">
<score-partwise version="3.0">
  <part-list>
    <score-part id="P1">
      <part-name>Music</part-name>
    </score-part>
  </part-list>
  <part id="P1">
    <measure number="1">
      <attributes>
        <divisions>1</divisions>
        <key>
          <fifths>0</fifths>
        </key>
        <time>
          <beats>4</beats>
          <beat-type>4</beat-type>
        </time>
        <clef>
          <sign>G</sign>
          <line>2</line>
        </clef>
      </attributes>
      <note>
        <pitch>
          <step>C</step>
          <octave>4</octave>
        </pitch>
        <duration>4</duration>
        <type>whole</type>
      </note>
    </measure>
  </part>
</score-partwise>
'.
]

{ #category : #urls }
XMLExternalEntityTest >> musicXMLExternalEntityURLs [
	^  #('http://www.musicxml.org/dtds/note.mod'
		'http://www.musicxml.org/dtds/isolat1.ent'
		'http://www.musicxml.org/dtds/isolat2.ent'
		'http://www.musicxml.org/dtds/layout.mod'
		'http://www.musicxml.org/dtds/identity.mod'
		'http://www.musicxml.org/dtds/attributes.mod'
		'http://www.musicxml.org/dtds/partwise.dtd'
		'http://www.musicxml.org/dtds/barline.mod'
		'http://www.musicxml.org/dtds/direction.mod'
		'http://www.musicxml.org/dtds/score.mod'
		'http://www.musicxml.org/dtds/link.mod'
		'http://www.musicxml.org/dtds/common.mod')
]

{ #category : #private }
XMLExternalEntityTest >> skipOrReturnWith: aBlock [
	"skip is not portable to squeak"
	(self respondsTo: #skip)
		ifTrue: [self skip]
		ifFalse: [aBlock value]
]

{ #category : #tests }
XMLExternalEntityTest >> testExternalSubsetReadLimit [
	| xml fileHandle externalSubset parser |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	fileHandle := self fileHandleForNewFileSuffixed: 'externalSubset.dtd'.
	externalSubset := '<?xml encoding="UTF-8"?><!ELEMENT test EMPTY>'.
	fileHandle writeStreamDo: [:writeStream |
		writeStream nextPutAll: externalSubset].
	xml := '<!DOCTYPE test SYSTEM "', fileHandle path, '"><test/>'.

	self
		shouldnt: [
			(parser := SAXHandler on: xml)
				externalEntityResolver externalSubsetReadLimit: externalSubset size.
			parser
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLLimitException.

	self
		should: [
			(parser := SAXHandler on: xml)
				externalEntityResolver externalSubsetReadLimit: externalSubset size - 1.
			parser
				resolvesExternalEntities: true;
				parseDocument]
		raise: XMLLimitException.

	fileHandle delete.
]

{ #category : #tests }
XMLExternalEntityTest >> testOnFileNamed [
	| parser fileHandle |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	fileHandle := self fileHandleForNewFileSuffixed: 'testOnFileNamed.xml'.
	fileHandle writeStreamDo: [:writeStream |
		writeStream nextPutAll: '<test/>'].
	self
		shouldnt: [parser := SAXHandler onFileNamed: fileHandle path]
		raise: XMLFileException.
	self
		assert: parser documentURI = fileHandle path;
		assert: parser documentURI asXMLURI isLocalURI.

	fileHandle delete.
]

{ #category : #tests }
XMLExternalEntityTest >> testOnURL [
	| parser |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	self
		shouldnt: [parser := SAXHandler onURL: self feedURL]
		raise: XMLHTTPException.
	self
		assert: parser documentURI = self feedURL;
		deny: parser documentURI asXMLURI isLocalURI.
]

{ #category : #tests }
XMLExternalEntityTest >> testOnURLUpToLimit [
	| parser size |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	size :=
		(self feedURL asXMLURI
			getUpToLimit: nil
			decoding: false) size.
	self
		shouldnt: [
			parser :=
				SAXHandler
					onURL: self feedURL
					upToLimit: size]
		raise: XMLLimitException.
	self assert: parser documentReadLimit = size.

	self
		should: [
			(SAXHandler
				onURL: self feedURL
				upToLimit: size - 1)
				parseDocument]
		raise: XMLLimitException.
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingDocBookArticle [
	"This uses HTTP so is skipped by default"

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	self
		shouldnt: [
			(SAXHandler on: self docBookArticleSource)
				resolvesExternalEntities: true;
				removeLimits;
				parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingDocBookExample [
	"This uses HTTP so is skipped by default"

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	self
		shouldnt: [
			(SAXHandler on: self docBookExampleSource)
				resolvesExternalEntities: true;
				removeLimits;
				parseDocument]
		raise: XMLParserException.
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingEncodedFile [
	"This test creates/deletes a file so is skipped by default"
	| fileHandle doc docFromFile |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	fileHandle := self fileHandleForNewFileSuffixed: 'testParsingEncodedFile.xml'.
	doc := XMLDOMParser parse: self docBookArticleSource.
	doc
		encoding: 'UTF-16BE';
		printToFileNamed: fileHandle path.
	self
		shouldnt: [docFromFile := XMLDOMParser parseFileNamed: fileHandle path]
		raise: XMLFileException.
	self
		assert: docFromFile encoding = 'UTF-16BE';
		assert: doc printString = docFromFile printString.

	fileHandle delete.
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingExternalEntities [
	"This test uses HTTP so is skipped by default."
	| entityCache entityCacheCopy |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	DTDCachingExternalEntityResolver clearEntityCache.
	entityCache := DTDCachingExternalEntityResolver entityCache.
	self musicXMLExternalEntityURLs do: [:each |
		self deny: (entityCache includesKey: each)].

	SAXHandler
		parse: self musicXMLDocument
		usingNamespaces: true
		validation: true
		externalEntities: true.
	self musicXMLExternalEntityURLs do: [:each |
		self assert: (entityCache at: each asXMLURI ifAbsent: ['']) notEmpty].

	"check for re-requesting"
	entityCacheCopy := entityCache copy.
	SAXHandler
		parse: self musicXMLDocument
		usingNamespaces: true
		validation: true
		externalEntities: true.
	self musicXMLExternalEntityURLs do: [:each |
		self assert: (entityCache at: each asXMLURI) == (entityCacheCopy at: each asXMLURI)].
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingFile [
	"This test creates/deletes a file so is skipped by default"
	| fileHandle doc |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	fileHandle := self fileHandleForNewFileSuffixed: 'testParsingFile.xml'.
	self
		should: [XMLDOMParser parseFileNamed: fileHandle path]
		raise: XMLFileException.

	fileHandle writeStreamDo: [:writeStream |
		writeStream nextPutAll: self musicXMLDocument].
	self
		shouldnt: [doc := XMLDOMParser parseFileNamed: fileHandle path]
		raise: XMLFileException.
	self assert: (doc root isNamed: 'score-partwise').

	fileHandle delete.
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingRetrievedURL [
	| source |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	source := self feedURL asXMLURI get.
	self assert: source isString.
	self
		shouldnt: [SAXHandler parse: source]
		raise: XMLParserException.

	source := self feedURL asXMLURI streamGet.
	self
		assert: source isStream;
		assert: source peek isCharacter.
	self
		shouldnt: [SAXHandler parse: source]
		raise: XMLParserException.
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingURL [
	"This uses HTTP so is skipped by default"
	| doc |

	self isSkipping
		ifTrue: [self skipOrReturnWith: [^ self]].

	self
		shouldnt: [doc := XMLDOMParser parseURL: self feedURL]
		raise: XMLHTTPException.
	self assert: (doc root isNamed: 'feed').
]
