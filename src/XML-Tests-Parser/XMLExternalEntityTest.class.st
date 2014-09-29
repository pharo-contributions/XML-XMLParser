Class {
	#name : #XMLExternalEntityTest,
	#superclass : #TestCase,
	#instVars : [
		'isSkipping'
	],
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
	"
	XMLExternalEntityTest isSkipping: false.
	XMLExternalEntityTest isSkipping: true.
	"
	IsSkipping := aBoolean
]

{ #category : #files }
XMLExternalEntityTest >> deleteFileNamed: aFileName [
	(XMLFileHandle path: aFileName) delete
]

{ #category : #source }
XMLExternalEntityTest >> doctypeWithDeclarationsForEntityURIs: aUrlCollection [
	^  '<!DOCTYPE test [',
		('' join: (aUrlCollection collectWithIndex: [:each :i |
			'<!ENTITY entity', i printString, ' SYSTEM "', each, '">'])),
		']>'
]

{ #category : #urls }
XMLExternalEntityTest >> externalEntityURLs [
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

{ #category : #urls }
XMLExternalEntityTest >> feedURL [
	^ 'http://pharo.org/news/atom.xml'
]

{ #category : #files }
XMLExternalEntityTest >> fileNamed: aFileName write: aString [
	(XMLFileHandle path: aFileName) writeStream
		nextPutAll: aString;
		close.
]

{ #category : #accessing }
XMLExternalEntityTest >> isSkipping [
	^ self class isSkipping
]

{ #category : #source }
XMLExternalEntityTest >> sourceXML [
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

{ #category : #tests }
XMLExternalEntityTest >> testOnFileNamed [
	| parser fileName |

	self isSkipping
		ifTrue: [self skip].

	fileName := 'testOnFileNamed.xml'.
	self fileNamed: fileName write: ''.
	self
		shouldnt: [parser := SAXHandler onFileNamed: fileName]
		raise: XMLFileException.
	self
		assert: parser documentURI = fileName;
		assert: parser documentURI asXMLURI isLocalURI.

	self deleteFileNamed: fileName.
]

{ #category : #tests }
XMLExternalEntityTest >> testOnURL [
	| parser |

	self isSkipping
		ifTrue: [self skip].

	self
		shouldnt: [parser := SAXHandler onURL: self feedURL]
		raise: XMLHTTPException.
	self
		assert: parser documentURI = self feedURL;
		deny: parser documentURI asXMLURI isLocalURI.
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingExternalEntities [
	"This test uses HTTP so is skipped by default."
	| entityCache entityCacheCopy |

	self isSkipping
		ifTrue: [self skip].

	DTDCachingEntityResolver clearEntityCache.
	entityCache := DTDCachingEntityResolver entityCache.
	self externalEntityURLs do: [:each |
		self deny: (entityCache includesKey: each asXMLURI)].

	SAXHandler
		parse: self sourceXML
		usingNamespaces: true
		validation: true
		externalEntities: true.
	self externalEntityURLs do: [:each |
		self assert: (entityCache at: each asXMLURI ifAbsent: ['']) notEmpty].

	"check for re-requesting"
	entityCacheCopy := entityCache copy.
	SAXHandler
		parse: self sourceXML
		usingNamespaces: true
		validation: true
		externalEntities: true.
	self externalEntityURLs do: [:each |
		self assert: (entityCache at: each asXMLURI) == (entityCacheCopy at: each asXMLURI)].
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingFile [
	"This test creates/deletes a file so is skipped by default"
	| fileName doc |

	self isSkipping
		ifTrue: [self skip].

	fileName := 'testParsingFile.xml'.
	self
		should: [XMLDOMParser parseFileNamed: fileName]
		raise: XMLFileException.
	self
		fileNamed: fileName
		write: self sourceXML.
	self
		shouldnt: [doc := XMLDOMParser parseFileNamed: fileName]
		raise: XMLFileException.
	self assert: (doc root isNamed: 'score-partwise').

	self deleteFileNamed: fileName.
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingURL [
	"This uses HTTP so is skipped by default"
	| doc |

	self isSkipping
		ifTrue: [self skip].

	self
		shouldnt: [doc := XMLDOMParser parseURL: self feedURL]
		raise: XMLHTTPException.
	self assert: (doc root isNamed: 'feed').
]
