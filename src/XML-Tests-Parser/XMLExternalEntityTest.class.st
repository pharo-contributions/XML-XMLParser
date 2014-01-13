Class {
	#name : #XMLExternalEntityTest,
	#superclass : #TestCase,
	#instVars : [
		'isSkipping'
	],
	#category : #'XML-Tests-Parser'
}

{ #category : #'instance creation' }
XMLExternalEntityTest class >> isSkipping: aBoolean [
	^ self new isSkipping: aBoolean
]

{ #category : #source }
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

{ #category : #testing }
XMLExternalEntityTest >> isSkipping [
	^ isSkipping ifNil: [isSkipping := true]
]

{ #category : #accessing }
XMLExternalEntityTest >> isSkipping: aBoolean [
	isSkipping := aBoolean
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
XMLExternalEntityTest >> testParsingExternalEntities [
	"This test uses HTTP and takes time to run so it is skipped by default.

	(self isSkipping: false) testParsingExternalEntities
	"
	| entityCache entityCacheCopy |

	self isSkipping
		ifTrue: [self skip].

	DTDCachingEntityResolver clearEntityCache.
	entityCache := DTDCachingEntityResolver entityCache.
	self deny:
		(self externalEntityURLs anySatisfy: [:each |
			entityCache includesKey: each asXMLURI]).

	SAXHandler parse: self sourceXML.
	self assert:
		(self externalEntityURLs allSatisfy: [:each |
			(entityCache at: each asXMLURI ifAbsent: ['']) notEmpty]).

	"check for re-requesting"
	entityCacheCopy := entityCache copy.
	SAXHandler parse: self sourceXML.
	self assert:
		(self externalEntityURLs allSatisfy: [:each |
			(entityCache at: each asXMLURI) == (entityCacheCopy at: each asXMLURI)]).
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingFile [
	"This test creates/deletes a file so is skipped by default

	(self isSkipping: false) testParsingFile
	"
	| fileName doc |

	self isSkipping
		ifTrue: [self skip].

	fileName := 'testParsingFile.xml'.
	self
		should: [XMLDOMParser parseFileNamed: fileName]
		raise: XMLFileException.

	(fileName asFileReference writeStream)
		nextPutAll: self sourceXML;
		close.
	self
		shouldnt: [doc := XMLDOMParser parseFileNamed: fileName]
		raise: [XMLFileException].
	self assert: (doc root isNamed: 'score-partwise').

	fileName asFileReference delete.
]

{ #category : #tests }
XMLExternalEntityTest >> testParsingURL [
	"This uses HTTP so is skipped by default

	(self isSkipping: false) testParsingURL
	"
	| url doc |

	self isSkipping
		ifTrue: [self skip].

	url := 'http://www.pharo-project.org/news?rss'.
	self
		shouldnt: [doc := XMLDOMParser parseURL: url]
		raise: [XMLFileException].
	self assert: (doc root isNamed: 'rss').
]
