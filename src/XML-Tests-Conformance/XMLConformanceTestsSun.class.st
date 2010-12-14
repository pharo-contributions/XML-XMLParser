Class {
	#name : #XMLConformanceTestsSun,
	#superclass : #XMLConformanceTests,
	#category : #'XML-Tests-Conformance'
}

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> allTestsToSkip [
	"XMLParserTestsSun sunTestsToSkip size"
	"return the ID (see the XML file listing all tests) of the tests you do not want to be run"
	^#( "Cincom parser does not include NOTATION elements in its tree structure"
		'notation01' 'not-sa01' 'sa02' 'sa04' 'not-sa04' 'sa03' 'not-sa03' 'not-sa02' 'sa05'
		
		"Cincom parser does not check for valid language identification"
		'lang05' 'lang01' 'lang06' 'lang03' 'lang04' 'lang02'

		"Cincom parser does not check for validity constraints to make a document standalone"
		'inv-not-sa07' 'inv-not-sa08' 'inv-not-sa12' 'inv-not-sa09' 'inv-not-sa01' 'inv-not-sa13' 
		'inv-not-sa10' 'inv-not-sa04' 'inv-not-sa14' 'inv-not-sa11' 'inv-not-sa05' 'inv-not-sa03'
		'inv-not-sa06' 

		"Cincom parser does not complain when there are no spaces between attributes"
		'attlist11' 'attlist10' 

		"Parser does not check name of the top level element"
		'root'

		"Parser does not check for encoding declaration in Text declarations"
		'encoding07' 'dtd07'

		"cr-lf problem"
	"	'sa068'  'sa107' "

		"Parser does not check for uri fragements"
		'uri01'

		"problem with external PE"
		'pe01'

		"Character encoding problem"
		'v-pe00')
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesuninvaliddtd06xml [
	^ '<!DOCTYPE root [
    <!-- reference to undefined PE -->
    %undefined;
]>

<root/>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa01xml [
	^'
<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa03xml [
	^'<!ELEMENT doc EMPTY>

<!ATTLIST doc a1 CDATA %e; "v1">

<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa04xml [
	^'<!ELEMENT doc EMPTY>
<!ATTLIST doc a1 CDATA "value">
<!ENTITY % e2 "%e1;">
%e1;
<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa05xml [
	^'<!ELEMENT doc EMPTY>
<!ATTLIST doc a1 CDATA "v1">
%e;

<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa06xml [
	^'<!ELEMENT doc EMPTY>
<!ATTLIST doc a1 CDATA "w1" a2 CDATA "w2">
<!ATTLIST doc a1 CDATA "v1">
<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa07xml [
	^'<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa08xml [
	^'<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa09xml [
	^'<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">

<!ATTLIST doc a2 CDATA "v2">

<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa10xml [
	^'<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v2">

<!ATTLIST doc a1 CDATA "v1">

<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa11xml [
	^'<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">

%e;
]>
<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa12xml [
	^'<!DOCTYPE doc [
<?xml version="1.0" encoding="UTF-8"?>
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">

%e;
]>
<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa13xml [
	^'<!ELEMENT doc (#PCDATA)>
<![ INCLUDE [
<!ATTLIST doc a1 CDATA "v1">
]]>

<doc></doc>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesuninvalidnotsa14xml [
	^'<!ELEMENT doc (#PCDATA)>
<![ %e; [
<!ATTLIST doc a1 CDATA "v1">
]]>

<!ENTITY % e "INCLUDE">
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesuninvalidrequired01xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
]>

<root xml:space=''preserve''/>

    <!-- all attributes must be declared -->
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesuninvalidrequired02xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
]>

<root xml:lang=''en''/>

    <!-- all attributes must be declared -->

'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwfattlist10xml [
^'<!DOCTYPE root [
<!ELEMENT root ANY>
<!ATTLIST root att1 CDATA #IMPLIED>
<!ATTLIST root att2 CDATA #IMPLIED>
]>
<root att1="value1"att2="value2">
    <!-- whitespace required between attributes -->
</root>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwfattlist11xml [
	^'<!DOCTYPE root [
<!ELEMENT root ANY>
<!ATTLIST root att1 CDATA #IMPLIED>
<!ATTLIST root att2 CDATA #IMPLIED>
]>
<root att1="value1"att2="value2"/>
    <!-- whitespace required between attributes -->
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfdecl01xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!ENTITY % ent01 SYSTEM "decl01.ent">

    <!-- the entity is an illegal PE -->
    %ent01;
]>
<root/>
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfdtd02xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!-- correct PE ref syntax -->
    <!ENTITY % foo "<!ATTLIST root>">
    % foo;
]>

<root/>
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfdtd03xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!-- correct PE ref syntax -->
    <!ENTITY % foo "<!ATTLIST root>">
    %foo
    ;
]>

<root/>
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfdtd04xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!-- PUBLIC id must be quoted -->
    <!ENTITY foo PUBLIC -//BadCorp//DTD-foo-1.0//EN "elvis.ent">
]>

<root/>
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfdtd05xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!-- SYSTEM id must be quoted -->
    <!ENTITY foo SYSTEM elvis.ent>
]>

<root/>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwfdtd07xml [
	^'<?xml version="1.0"?>
<!--
    "encoding=..." is mandatory in text declarations.

    All external entities (parameter, general) have optional text
    declarations; only the document entity may omit this declaration.
-->
<!ELEMENT root EMPTY>

<root/>'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfelement00xml [
	^ '<root>
    Incomplete end tag.
</ro'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfelement01xml [
	^ '<root>
    Incomplete end tag.
</root'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfelement02xml [
	^ '<!DOCTYPE html [ <!ELEMENT html ANY> ]>
<html>
    <% @ LANGUAGE="VBSCRIPT" %>
</html>
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfelement03xml [
	^ '<!DOCTYPE html [ <!ELEMENT html ANY> ]>
<html>
    <% document.println ("hello, world"); %>
</html>

'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfelement04xml [
	^ '<!DOCTYPE root [ <!ELEMENT root ANY> ]>
<root>
    <!ELEMENT foo EMPTY>
</root>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwfencoding07xml [
	^'<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <?xml version="1.0"?>
]>
<root>&empty;</root>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwflang01xml [
	^'<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="en"/>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwflang02xml [
	^'<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="en-IN"/>

'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwflang03xml [
	^'<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="i-klingon-whorf"/>

'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwflang04xml [
	^'<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="x-dialect-valleygirl"/>

'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwflang05xml [
	^'<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="DE"/>

'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunnotwflang06xml [
	^'<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="X-Java"/>

'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunnotwfsgml01xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  omitted end tag -->
]>

<root>
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunvaliddtd00xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!ELEMENT x (#PCDATA)>
    <!ELEMENT y (#PCDATA)*>
]>

<root/>
'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunvaliddtd01xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!ENTITY % PE "this is a PE">
    <!-- %these; %are; %not; %PEs; -->
]>
<root/>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunvalidnotation01xml [
	^'<?xml version="1.0"?>
<?xml version="1.0" encoding="UTF-8"?>

<!NOTATION GIF PUBLIC
    "+//ISBN 0-7923-9432-1::Graphic Notation//NOTATION
     CompuServe Graphic Interchange Format//EN">

<!ELEMENT test (#PCDATA) >
    <!ENTITY applydsssl SYSTEM "applydsssl.gif" NDATA GIF>
]>
<test>test</test>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunvalidnotsa01xml [
	^'<?xml version="1.0" standalone="no"?>

<?xml version="1.0" encoding="UTF-8"?>

    <!ELEMENT root (child|attributes)*>
    <!ELEMENT child (#PCDATA)>
    <!ELEMENT attributes EMPTY>
    <!ATTLIST attributes
	token		(a|b|c)		"a"
	notation	(nonce|foo|bar)	#IMPLIED
	nmtoken		NMTOKEN		#IMPLIED
	nmtokens	NMTOKENS	#IMPLIED
	id		ID		#IMPLIED
	idref		IDREF		#IMPLIED
	idrefs		IDREFS		#IMPLIED
	entity		ENTITY		#IMPLIED
	entities	ENTITIES	#IMPLIED
	cdata		CDATA		#IMPLIED
	>
    
    <!-- this needs normalization when used as an ID -->
    <!ENTITY internal	" internal&number; ">
    <!ENTITY number	"42">

    <!NOTATION nonce	SYSTEM "file:/dev/null">
    <!NOTATION foo	PUBLIC "-//public id//foo" "file:/dev/null">
    <!NOTATION bar	SYSTEM "file:/dev/tty">

    <!ENTITY unparsed-1 PUBLIC "-//some public//ID" "file:/dev/console"
			NDATA nonce>
    <!ENTITY unparsed-2 SYSTEM "scheme://host/data"
			NDATA foo>

<root>
    <child>
    The whitespace before and after this element keeps
    this from being standalone.
    </child>
</root>'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunvalidoutdtd00xml [
	^ '<root></root>'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunvalidoutdtd01xml [
	^ '<root></root>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunvalidoutnotation01xml [


	^'<!DOCTYPE test [
<!NOTATION GIF PUBLIC "+//ISBN 0-7923-9432-1::Graphic Notation//NOTATION CompuServe Graphic Interchange Format//EN">
]>
<test>test</test>'

]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun class >> sourcesunvalidoutnotsa01xml [
	^'<!DOCTYPE root [
<!NOTATION bar SYSTEM "file:/dev/tty">
<!NOTATION foo PUBLIC "-//public id//foo" "file:/dev/null">
<!NOTATION nonce SYSTEM "file:/dev/null">
]>
<root>&#10;    <child>&#10;    The whitespace before and after this element keeps&#10;    this from being standalone.&#10;    </child>&#10;</root>'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunvalidoutrequired00xml [
	^ '<root req="foo"></root>'
]

{ #category : #source }
XMLConformanceTestsSun class >> sourcesunvalidrequired00xml [
	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!ATTLIST root
	req CDATA #REQUIRED
	>
]>

<root req="foo"/>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunattlist10 [
	"
    Whitespace required between attributes
	 See XML Spec. 1.0 section: 3.1 [40]"

	(self class shouldSkipTests and: [testsToSkip includes: 'attlist10'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfattlist10xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunattlist11 [
	"
    Whitespace required between attributes
	 See XML Spec. 1.0 section: 3.1 [44]"

	(self class shouldSkipTests and: [testsToSkip includes: 'attlist11'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfattlist11xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsundecl01 [
	"
    External entities may not have standalone decls. 
	 See XML Spec. 1.0 section: 4.3.1 [77]"

	(self class shouldSkipTests and: [testsToSkip includes: 'decl01'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfdecl01xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsundtd00 [
	"
    Tests parsing of alternative forms of text-only mixed
	content declaration.
	 See XML Spec. 1.0 section: 3.2.2 [51]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'dtd00'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutdtd00xml) .

	[result := self runTest: self class sourcesunvaliddtd00xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsundtd01 [
	"
    Comments don't get parameter entity expansion
	 See XML Spec. 1.0 section: 2.5 [15]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'dtd01'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutdtd01xml) .

	[result := self runTest: self class sourcesunvaliddtd01xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsundtd02 [
	"
    PE name immediately after  % 
	 See XML Spec. 1.0 section: 4.1 [69]"

	(self class shouldSkipTests and: [testsToSkip includes: 'dtd02'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfdtd02xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsundtd03 [
	"
    PE name immediately followed by  ; 
	 See XML Spec. 1.0 section: 4.1 [69]"

	(self class shouldSkipTests and: [testsToSkip includes: 'dtd03'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfdtd03xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsundtd04 [
	"
    PUBLIC literal must be quoted
	 See XML Spec. 1.0 section: 4.2.2 [75]"

	(self class shouldSkipTests and: [testsToSkip includes: 'dtd04'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfdtd04xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsundtd05 [
	"
    SYSTEM identifier must be quoted
	 See XML Spec. 1.0 section: 4.2.2 [75]"

	(self class shouldSkipTests and: [testsToSkip includes: 'dtd05'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfdtd05xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsundtd07 [
	"
    Text declarations (which optionally begin any external entity)
    are required to have  encoding=... . 
	 See XML Spec. 1.0 section: 4.3.1 [77]"

	(self class shouldSkipTests and: [testsToSkip includes: 'dtd07'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfdtd07xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunelement00 [
	"
    EOF in middle of incomplete ETAG
	 See XML Spec. 1.0 section: 3.1 [42]"

	(self class shouldSkipTests and: [testsToSkip includes: 'element00'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfelement00xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunelement01 [
	"
    EOF in middle of incomplete ETAG
	 See XML Spec. 1.0 section: 3.1 [42]"

	(self class shouldSkipTests and: [testsToSkip includes: 'element01'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfelement01xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunelement02 [
	"
    Illegal markup (<%@ ... %>)
	 See XML Spec. 1.0 section: 3.1 [43]"

	(self class shouldSkipTests and: [testsToSkip includes: 'element02'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfelement02xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunelement03 [
	"
    Illegal markup (<% ... %>)
	 See XML Spec. 1.0 section: 3.1 [43]"

	(self class shouldSkipTests and: [testsToSkip includes: 'element03'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfelement03xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunelement04 [
	"
    Illegal markup (<!ELEMENT ... >)
	 See XML Spec. 1.0 section: 3.1 [43]"

	(self class shouldSkipTests and: [testsToSkip includes: 'element04'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfelement04xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunencoding07 [
	"
    Text declarations (which optionally begin any external entity)
    are required to have  encoding=... . 
	 See XML Spec. 1.0 section: 4.3.1 [77]"

	(self class shouldSkipTests and: [testsToSkip includes: 'encoding07'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfencoding07xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvdtd06 [
	"
    Tests  Entity Declared  VC for a parameter entity.  NOTE:  there
    are both VCs and WFCs with this name, which is a specification issue
    in that it is both confusing and in some ways self-contradictory.
    The WFC does not apply to PEs, and even the clause which might
    seem to suggest it could is ruled out in this test.
	 See XML Spec. 1.0 section: 4.1"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-dtd06'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvaliddtd06xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa01 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    optional whitespace causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa01'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa01xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa03 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    a reference to externally defined entity causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa03'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa03xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa04 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    attributes needing defaulting cause a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa04'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa04xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa05 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    a token attribute that needs normalization causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa05'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa05xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa06 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    a NOTATION attribute that needs normalization
    causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa06'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa06xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa07 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    an NMTOKEN attribute needing normalization
    causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa07'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa07xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa08 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    an NMTOKENS attribute needing normalization
    causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa08'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa08xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa09 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    an ID attribute needing normalization causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa09'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa09xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa10 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    an IDREF attribute needing normalization causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa10'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa10xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa11 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    an IDREFS attribute needing normalization causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa11'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa11xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa12 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    an ENTITY attribute needing normalization causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa12'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa12xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa13 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    an ENTITIES attribute needing normalization causes a validity error.
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa13'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa13xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvnotsa14 [
	"
    Tests the Standalone Document Declaration VC, ensuring that
    optional whitespace causes
    a validity error (even if it's CDATA whitespace).
	 See XML Spec. 1.0 section: 2.9"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-not-sa14'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidnotsa14xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvrequired01 [
	"
    Tests the Attribute Value Type (declared)
    VC for the xml:space attribute
	 See XML Spec. 1.0 section: 3.1 2.10"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-required01'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidrequired01xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsuninvrequired02 [
	"
    Tests the Attribute Value Type (declared)
    VC for the xml:lang attribute
	 See XML Spec. 1.0 section: 3.1 2.12"

	(self class shouldSkipTests and: [testsToSkip includes: 'inv-required02'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidrequired02xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunlang01 [
	"
    Illegal language identification
	 See XML Spec. 1.0 section: 2.11 [33]"

	(self class shouldSkipTests and: [testsToSkip includes: 'lang01'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwflang01xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunlang02 [
	"
    Illegal language identification
	 See XML Spec. 1.0 section: 2.11 [33]"

	(self class shouldSkipTests and: [testsToSkip includes: 'lang02'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwflang02xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunlang03 [
	"
    Illegal language identification
	 See XML Spec. 1.0 section: 2.11 [33]"

	(self class shouldSkipTests and: [testsToSkip includes: 'lang03'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwflang03xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunlang04 [
	"
    Illegal language identification
	 See XML Spec. 1.0 section: 2.11 [33]"

	(self class shouldSkipTests and: [testsToSkip includes: 'lang04'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwflang04xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunlang05 [
	"
    Illegal language identification
	 See XML Spec. 1.0 section: 2.11 [33]"

	(self class shouldSkipTests and: [testsToSkip includes: 'lang05'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwflang05xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunlang06 [
	"
    Illegal language identification
	 See XML Spec. 1.0 section: 2.11 [33]"

	(self class shouldSkipTests and: [testsToSkip includes: 'lang06'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwflang06xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunnotation01 [
	"
    N testsToSkip | testsToSkip |
OTATION declarations don't need SYSTEM IDs; and
    externally declared notations may be used to declare
    unparsed entities in the internal DTD subset.
    The notation must be reported to the application.
    
	 See XML Spec. 1.0 section: 4.7 [82]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'notation01'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutnotation01xml).

	[result := self runTest: self class sourcesunvalidnotation01xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunnotsa01 [
	"
    A non-standalone document is valid if declared as such.
	 See XML Spec. 1.0 section: 2.9"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'not-sa01'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutnotsa01xml).

	[result := self runTest:self class sourcesunvalidnotsa01xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunnotsa02 [
	"
    A non-standalone document is valid if declared as such.
	 See XML Spec. 1.0 section: 2.9"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'not-sa02'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutnotsa02xml).

	[result := self runTest:self class sourcesunvalidnotsa02xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunnotsa03 [
	"
    A non-standalone document is valid if declared as such.
	 See XML Spec. 1.0 section: 2.9"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'not-sa03'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutnotsa03xml).

	[result := self runTest:self class sourcesunvalidnotsa03xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunnotsa04 [
	"
    A non-standalone document is valid if declared as such. 
	 See XML Spec. 1.0 section: 2.9"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'not-sa04'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutnotsa04xml).

	[result := self runTest:self class sourcesunvalidnotsa04xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunpe01 [
	"
    Parameter entities must consist of a series of complete markup
    declarations of the types allowed by the nonterminal
    markupdecl, interespersed with whitespace or PERefs.
	 See XML Spec. 1.0 section: 2.8"

	(self class shouldSkipTests and: [testsToSkip includes: 'pe01'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidpe01xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunrequired00 [
	"
    Tests the #REQUIRED attribute declaration syntax, and
	the associated validity constraint. 
	 See XML Spec. 1.0 section: 3.3.2 [60]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'required00'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutrequired00xml)  .

	[result := self runTest:self class sourcesunvalidrequired00xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunroot [
	"
    Tests the Root Element Type VC
	 See XML Spec. 1.0 section: 2.8"

	(self class shouldSkipTests and: [testsToSkip includes: 'root'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidrootxml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunsa02 [
	"
    A document may be marked 'standalone' if any
	attributes that need normalization are
	defined within the internal DTD subset.
	 See XML Spec. 1.0 section: 2.9 [32]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'sa02'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutsa02xml).

	[result := self runTest:self class sourcesunvalidsa02xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunsa03 [
	"
    A document may be marked 'standalone' if any
    the defined entities need expanding are internal,
    and no attributes need defaulting or normalization.
    On output, requires notations to be correctly reported.
    
	 See XML Spec. 1.0 section: 2.9 [32]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'sa03'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutsa03xml).

	[result := self runTest:self class sourcesunvalidsa03xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunsa04 [
	"
    Like sa03 but relies on attribute
    defaulting defined in the internal subset.
    On output, requires notations to be correctly reported.
    
	 See XML Spec. 1.0 section: 2.9 [32]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'sa04'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutsa04xml).

	[result := self runTest:self class sourcesunvalidsa04xml ]
		on: self warningSignal
		do: [:warn | warn resume].
	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunsa05 [
	"
    Like sa01 but this document is standalone
    since it has no optional whitespace.
    On output, requires notations to be correctly reported.
    
	 See XML Spec. 1.0 section: 2.9 [32]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'sa05'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutsa05xml).

	[result := self runTest:self class sourcesunvalidsa05xml ]
		on: self warningSignal
		do: [:warn | warn resume].
	self assert: correctAnswer = result.
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunsgml01 [
	"
    SGML-ism: omitted end tag for EMPTY content
	 See XML Spec. 1.0 section: 3 [39]"

	(self class shouldSkipTests and: [testsToSkip includes: 'sgml01'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfsgml01xml ]
		raise: self exceptionSet2
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunuri01 [
	"
    SYSTEM ids may not have URI fragments
	 See XML Spec. 1.0 section: 4.2.2 [75]"

	(self class shouldSkipTests and: [testsToSkip includes: 'uri01'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesunnotwfuri01xml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunutf16b [
	"
    Tests reading an invalid  big endian  UTF-16 document
	 See XML Spec. 1.0 section: 4.3.3 2.8"

	(self class shouldSkipTests and: [testsToSkip includes: 'utf16b'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidutf16bxml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunutf16l [
	"
    Tests reading an invalid  little endian  UTF-16 document
	 See XML Spec. 1.0 section: 4.3.3 2.8"

	(self class shouldSkipTests and: [testsToSkip includes: 'utf16l'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourcesuninvalidutf16lxml]
		raise: self exceptionSet
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsSun >> testsunvpe00 [
	"
    Tests construction of internal entity replacement text, using
    an example in the XML specification.  
	 See XML Spec. 1.0 section: 4.5"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'v-pe00'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcesunvalidoutpe00xml).

	[result := self runTest:self class sourcesunvalidpe00xml ]
		on: self warningSignal
		do: [:warn | warn resume].
	self assert: correctAnswer = result.
]
