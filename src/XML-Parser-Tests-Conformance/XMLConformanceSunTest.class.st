Class {
	#name : #XMLConformanceSunTest,
	#superclass : #XMLConformanceTest,
	#category : #'XML-Parser-Tests-Conformance'
}

{ #category : #accessing }
XMLConformanceSunTest class >> skippableTests [
	^ #( testinvalidutf16bxml testinvalidutf16lxml )
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr01xml [
	"Source file: sun/invalid/attr01.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root
    affiliated	ENTITY	#REQUIRED
    >
    <!-- tests the "entity name" VC ... the "entity declared" clause,
	as applied to attributes of type ENTITY -->
]>
<root affiliated="food"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr02xml [
	"Source file: sun/invalid/attr02.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root
    affiliated	ENTITIES	#REQUIRED
    >
    <!-- tests the "entity name" VC ... the "entity declared" clause,
	as applied to attributes of type ENTITIES -->
<!NOTATION fruit
    PUBLIC "-//International Grocery Consortium//Edible//Healthy//EN">
<!ENTITY apple SYSTEM "http://www.apple.com" NDATA fruit>
]>
<root affiliated="apple apple food"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr03xml [
	"Source file: sun/invalid/attr03.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root
    type	NOTATION	(fruit | vegetable)	#REQUIRED
    >
<!NOTATION fruit
    PUBLIC "-//International Grocery Consortium//Edible//Healthy//EN">
<!NOTATION vegetable
    PUBLIC "-//International Grocery Consortium//Edible//Yucky//EN">
<!NOTATION candy
    PUBLIC "-//International Grocery Consortium//Edible//Yummy//EN">

    <!-- tests the ''must match one of the names included in the
	declaration'' part of the "Notation Attributes" VC -->
]>
<root type="candy"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr04xml [
	"Source file: sun/invalid/attr04.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root
    type	NOTATION	(fruit | vegetable)	#REQUIRED
    >
<!NOTATION fruit
    PUBLIC "-//International Grocery Consortium//Edible//Healthy//EN">

    <!-- tests the ''all notation names in the declaration must
	be declared'' part of the "Notation Attributes" VC -->
]>
<root type="fruit"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr05xml [
	"Source file: sun/invalid/attr05.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root
    token	NMTOKEN		#REQUIRED
    >

    <!-- tests the "name token'' VC for an NMTOKEN value -->
]>
<root token="dev@null"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr06xml [
	"Source file: sun/invalid/attr06.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root
    token	NMTOKEN		#REQUIRED
    >

    <!-- tests the "name token'' VC for an NMTOKENS value -->
]>
<root token="now is the time!?"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr07xml [
	"Source file: sun/invalid/attr07.xml"

	^ '<!DOCTYPE arbor [
<!ELEMENT arbor EMPTY>
<!ATTLIST arbor
    type	(fruit | vegetable)	"fruit"
    >
    <!-- tests the ''must match one of the nmtokens included in the
	declaration'' part of the "Enumeration" VC -->
]>
<arbor type="money"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr08xml [
	"Source file: sun/invalid/attr08.xml"

	^ '<!DOCTYPE palimpest [
<!ELEMENT palimpest EMPTY>
<!ATTLIST palimpest
    xmlns CDATA #FIXED "http://java.sun.com/historical"
    >
    <!-- tests the "fixed attribute default" vc -->
]>

<palimpest xmlns="http://over.the.rainbow.com/somewhere"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr09xml [
	"Source file: sun/invalid/attr09.xml"

	^ '<!DOCTYPE collection [

<!ELEMENT collection ANY>

<!ELEMENT identifier EMPTY>
<!ATTLIST identifier
    value	IDREF	"42"
    >
    <!-- tests the "attribute default legal" vc -->

<!ELEMENT identified EMPTY>
<!ATTLIST identified
    id		ID	#REQUIRED
    >
]>

<collection>
    <identifier name="i-am-not-a-number"/>
    <identified id="i-am-not-a-number"/>
</collection>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr10xml [
	"Source file: sun/invalid/attr10.xml"

	^ '<!DOCTYPE collection [

<!ELEMENT collection ANY>

<!ELEMENT identifier EMPTY>
<!ATTLIST identifier
    value	IDREFS	"i-am-not-a-number 42"
    >
    <!-- tests the "attribute default legal" vc -->

<!ELEMENT identified EMPTY>
<!ATTLIST identified
    id		ID	#REQUIRED
    >
]>

<collection>
    <identifier name="i-am-not-a-number"/>
    <identified id="i-am-not-a-number"/>
</collection>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr11xml [
	"Source file: sun/invalid/attr11.xml"

	^ '<!DOCTYPE reference [

<!ELEMENT reference EMPTY>
<!ATTLIST reference
    value	ENTITY	"2orldbook"
    >
    <!-- tests the "attribute default legal" vc -->

<!NOTATION encyclopaedia PUBLIC "-//fooCorp Inc//NOTATION something//EN">
<!ENTITY brittannica SYSTEM "http://www.eb.com/" NDATA encyclopaedia>
<!ENTITY worldbook SYSTEM "http://www.worldbook.com">

]>

<reference value="brittannica"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr12xml [
	"Source file: sun/invalid/attr12.xml"

	^ '<!DOCTYPE references [

<!ELEMENT references EMPTY>
<!ATTLIST references
    value	ENTITIES	"brittannica 2orldbook"
    >
    <!-- tests the "attribute default legal" vc -->

<!NOTATION encyclopaedia PUBLIC "-//fooCorp Inc//NOTATION something//EN">
<!ENTITY brittannica SYSTEM "http://www.eb.com/" NDATA encyclopaedia>
<!ENTITY worldbook SYSTEM "http://www.worldbook.com">

]>

<references value="brittannica"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr13xml [
	"Source file: sun/invalid/attr13.xml"

	^ '<!DOCTYPE root [

<!ELEMENT root EMPTY>
<!ATTLIST root
    value	NMTOKEN	"alpha/beta"
    >
    <!-- tests the "attribute default legal" vc -->
]>

<root value="brittannica"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr14xml [
	"Source file: sun/invalid/attr14.xml"

	^ '<!DOCTYPE root [

<!ELEMENT root EMPTY>
<!ATTLIST root
    value	NMTOKENS	"alpha beta $gamma"
    >
    <!-- tests the "attribute default legal" vc -->
]>

<root value="zeta eta iota"/>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr15xml [
	"Source file: sun/invalid/attr15.xml"

	^ '<!DOCTYPE reference [

<!ELEMENT reference EMPTY>
<!ATTLIST reference
    source	NOTATION	(brittannica | worldbook) "encarta"
    >
    <!-- tests the "attribute default legal" vc -->

<!NOTATION brittannica SYSTEM "http://www.eb.com/">
<!NOTATION worldbook SYSTEM "http://www.worldbook.com">

]>

<reference source="brittannica"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidattr16xml [
	"Source file: sun/invalid/attr16.xml"

	^ '<!DOCTYPE root [

<!ELEMENT root EMPTY>
<!ATTLIST root
    value	(brittannica | worldbook) "encarta"
    >
    <!-- tests the "attribute default legal" vc -->
]>

<root value="brittannica"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvaliddtd01xml [
	"Source file: sun/invalid/dtd01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT y (#PCDATA|x|x)*>
    <!-- element types can''t repeat in mixed content -->
    <!ELEMENT root ANY>
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvaliddtd02xml [
	"Source file: sun/invalid/dtd02.xml"

	^ '<!DOCTYPE paper [
<!ELEMENT paper EMPTY>
<!ENTITY Brittannica SYSTEM "http://www.eb.com" NDATA Encyclopaedia>
]>
<paper/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvaliddtd03xml [
	"Source file: sun/invalid/dtd03.xml"

	^ '<!DOCTYPE violation [
<!ELEMENT violation (a,a,a,b)>
<!ELEMENT a EMPTY>
<!ELEMENT b EMPTY>
    <!-- tests the "element valid" constraint for content
	which doesn''t match the declared content model.
	(there can be an infinite number of such tests...)
	-->
]>
<violation>
    <a/>
    <a/>
    <b/>
</violation>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvaliddtd06xml [
	"Source file: sun/invalid/dtd06.xml"

	^ '<!DOCTYPE root [
    <!-- reference to undefined PE -->
    %undefined;
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidel01xml [
	"Source file: sun/invalid/el01.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root ANY>
]>
<root> <undeclared/> </root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidel02xml [
	"Source file: sun/invalid/el02.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
]>
<root><root/></root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidel03xml [
	"Source file: sun/invalid/el03.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root (#PCDATA|root)*>
<!ELEMENT exception (#PCDATA)>
]>
<root>this is ok <exception>this isn''t</exception> </root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidel04xml [
	"Source file: sun/invalid/el04.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root ANY>
<!ELEMENT exception (#PCDATA)>
<!ELEMENT exception (#PCDATA)>
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidel05xml [
	"Source file: sun/invalid/el05.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root (#PCDATA|repeat-till-done|repeat-till-done)*>
<!ELEMENT repeat-till-done (#PCDATA)>
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidel06xml [
	"Source file: sun/invalid/el06.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
    <!-- in case parsers special-case builtin entities incorrectly -->
]>
<root>&amp;</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidemptyxml [
	"Source file: sun/invalid/empty.xml"

	^ '<!--
    From: "Henry S. Thompson" <ht@cogsci.ed.ac.uk>

    I''d be interested in reports from validating parsers wrt the
    following:
-->

<!DOCTYPE foo [
<!ELEMENT foo (a+)>
<!ENTITY empty ''''>
<!ENTITY space '' ''>
<!ELEMENT a EMPTY>]>
<foo>
&empty;
<a/>
&space;
<a/>
<![CDATA[]]>
<a/>
<![CDATA[ ]]>
<a/>
</foo>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidid01xml [
	"Source file: sun/invalid/id01.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/sa.dtd">

<!-- values of type ID must match "name" -->

<root>
    <attributes id="42a"/>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidid02xml [
	"Source file: sun/invalid/id02.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/sa.dtd">

<!-- a name must not appear more than once as a value of type id -->

<root>
    <attributes id="a42"/>
    <attributes id="a42"/>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidid03xml [
	"Source file: sun/invalid/id03.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/sa.dtd" [
    <!ATTLIST attributes
	id2	ID	#IMPLIED
	>
]>

<!-- no element type may have more than one ID attribute specified -->

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidid04xml [
	"Source file: sun/invalid/id04.xml"

	^ '<!DOCTYPE root [
    <!ATTLIST root
	id2	ID	"x23"
	>
]>

<!-- an ID attribute must have a declared default
    of #IMPLIED or #REQUIRED
-->

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidid05xml [
	"Source file: sun/invalid/id05.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root ANY>
    <!ATTLIST root
	id2	ID	#FIXED "x23"
	>
]>

<!-- an ID attribute must have a declared default
    of #IMPLIED or #REQUIRED
-->

<root/>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidid06xml [
	"Source file: sun/invalid/id06.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root ANY>
    <!ATTLIST root
	id	ID	#IMPLIED
	idref	IDREF	#IMPLIED
	>
]>

<!-- Values of type IDREF must match the name production -->

<root idref="36d">
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidid07xml [
	"Source file: sun/invalid/id07.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root ANY>
    <!ATTLIST root
	id	ID	#IMPLIED
	idref	IDREF	#IMPLIED
	idrefs	IDREFS	#IMPLIED
	>
]>

<!-- Values of type IDREFS must match the names production -->

<root idrefs="d36 36d">
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidid08xml [
	"Source file: sun/invalid/id08.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root ANY>
    <!ATTLIST root
	id	ID	#IMPLIED
	idref	IDREF	#IMPLIED
	>
]>

<!-- each name must match the value of an id attribute on some element -->

<root idref="d36d">
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidid09xml [
	"Source file: sun/invalid/id09.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root ANY>
    <!ATTLIST root
	id	ID	#IMPLIED
	idref	IDREF	#IMPLIED
	idrefs	IDREFS	#IMPLIED
	>
]>

<!-- each name must match the value of an id attribute on some element -->

<root idrefs="d36 ee38">
    <root id="d36"/>
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa01xml [
	"Source file: sun/invalid/not-sa01.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE root SYSTEM "../valid/sa.dtd">
    
<root>
    <child>
    The whitespace before and after this element keeps
    this from being standalone.
    </child>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa02xml [
	"Source file: sun/invalid/not-sa02.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!ENTITY internal " number99">
]>

    <!-- sync with ../valid/not-sa02.xml -->

    <!--
	LOTS of normalized/defaulted attributes
	keep this from being standalone

	XXX not the best of tests!!
	... each type of normalization/defaulting
	needs separate testing
    -->

<attributes
    notation =	" nonce "
    nmtoken =	" this-gets-normalized "
    nmtokens =	" this&#x0d;&#x0a; also	 gets&#x20; normalized "
    id =	"	&internal; "
    idref =	" &internal;
    "
    idrefs =	" &internal;  &internal;    &internal;"
    entity =	" unparsed-1 "
    entities =	"unparsed-1
    unparsed-2		
"
    cdata =	"nothing happens to this one!"
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa04xml [
	"Source file: sun/invalid/not-sa04.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	attribute needs defaulting
    -->
]>

<attributes/>

<?pi equals three?>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa05xml [
	"Source file: sun/invalid/not-sa05.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	TOKEN needs normalization
    -->
]>

<attributes
    token =	" c "
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa06xml [
	"Source file: sun/invalid/not-sa06.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	NOTATION needs normalization
    -->
]>

<attributes
    token =	"b"
    notation =	" nonce "
    />

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa07xml [
	"Source file: sun/invalid/not-sa07.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	NMTOKEN needs normalization
    -->
]>

<attributes
    token =	"b"
    nmtoken =	" this-gets-normalized "
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa08xml [
	"Source file: sun/invalid/not-sa08.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	NMTOKENS needs normalization
    -->
]>

<attributes
    token =	"b"
    nmtokens =	" this&#x0d;&#x0a; also	 gets&#x20; normalized "
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa09xml [
	"Source file: sun/invalid/not-sa09.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	ID needs normalization
    -->
]>

<attributes
    token =	"b"
    id =	"	cindy "
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa10xml [
	"Source file: sun/invalid/not-sa10.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	IDREF needs normalization
    -->
]>

<attributes
    token =	"b"
    id =	"id43"
    idref =	" id43
    "
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa11xml [
	"Source file: sun/invalid/not-sa11.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	IDREFS needs normalization
    -->
]>

<attributes
    token =	"b"
    id =	"date28"
    idrefs =	" date28   date28
    date28	"
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa12xml [
	"Source file: sun/invalid/not-sa12.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	ENTITY needs normalization
    -->
]>

<attributes
    token =	"b"
    entity =	" unparsed-1 "
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa13xml [
	"Source file: sun/invalid/not-sa13.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	ENTITIES needs normalization
    -->
]>

<attributes
    token =	"b"
    entities =	"
    unparsed-1
    
    unparsed-2
		  "
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidnotsa14xml [
	"Source file: sun/invalid/not-sa14.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE root SYSTEM "../valid/sa.dtd">
    
<root><![CDATA[
    ]]><child>
    The whitespace before and after this element keeps
    this from being standalone.  (CDATA is just another
    way to represent text...)
    </child><![CDATA[
]]></root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional01xml [
	"Source file: sun/invalid/optional01.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once></once>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional02xml [
	"Source file: sun/invalid/optional02.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once><e/><e/></once>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional03xml [
	"Source file: sun/invalid/optional03.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <twice></twice>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional04xml [
	"Source file: sun/invalid/optional04.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <twice><e/><e/><e/></twice>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional05xml [
	"Source file: sun/invalid/optional05.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-a></once-or-twice-a>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional06xml [
	"Source file: sun/invalid/optional06.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-b></once-or-twice-b>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional07xml [
	"Source file: sun/invalid/optional07.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-c></once-or-twice-c>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional08xml [
	"Source file: sun/invalid/optional08.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-d></once-or-twice-d>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional09xml [
	"Source file: sun/invalid/optional09.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-e></once-or-twice-e>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional10xml [
	"Source file: sun/invalid/optional10.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-a><e/><e/><e/></once-or-twice-a>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional11xml [
	"Source file: sun/invalid/optional11.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-b><e/><e/><e/></once-or-twice-b>
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional12xml [
	"Source file: sun/invalid/optional12.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-c><e/><e/><e/></once-or-twice-c>
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional13xml [
	"Source file: sun/invalid/optional13.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-d><e/><e/><e/></once-or-twice-d>
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional14xml [
	"Source file: sun/invalid/optional14.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-e><e/><e/><e/></once-or-twice-e>
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional20xml [
	"Source file: sun/invalid/optional20.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-a></once-or-twice-a>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional21xml [
	"Source file: sun/invalid/optional21.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-b></once-or-twice-b>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional22xml [
	"Source file: sun/invalid/optional22.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-c></once-or-twice-c>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional23xml [
	"Source file: sun/invalid/optional23.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-d></once-or-twice-d>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional24xml [
	"Source file: sun/invalid/optional24.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-e></once-or-twice-e>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidoptional25xml [
	"Source file: sun/invalid/optional25.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-e>No text allowed!</once-or-twice-e>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidrequired00xml [
	"Source file: sun/invalid/required00.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!ATTLIST root
	req CDATA #REQUIRED
	>
]>

<root/>

<!-- doesn''t include required ''req'' attribute -->
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidrequired01xml [
	"Source file: sun/invalid/required01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
]>

<root xml:space=''preserve''/>

    <!-- all attributes must be declared -->
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidrequired02xml [
	"Source file: sun/invalid/required02.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
]>

<root xml:lang=''en''/>

    <!-- all attributes must be declared -->

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidrootxml [
	"Source file: sun/invalid/root.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd">

<!-- the name in the dtd must match the element type of the root element -->
    
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidutf16bxml [
	"Source file: sun/invalid/utf16b.xml"

	^ '<?xml version=''1.0'' encoding=''UTF-16''?>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourceinvalidutf16lxml [
	"Source file: sun/invalid/utf16l.xml"

	^ '<?xml version=''1.0'' encoding=''UTF-16''?>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist01xml [
	"Source file: sun/not-wf/attlist01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  illegal attribute types -->

    <!ATTLIST root
	number	NUTOKEN	"1"
	>

]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist02xml [
	"Source file: sun/not-wf/attlist02.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  illegal attribute types -->

    <!ATTLIST root
	number	NUTOKENS	"1 2 3"
	>

]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist03xml [
	"Source file: sun/not-wf/attlist03.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  illegal attribute types -->

    <!ATTLIST root
	choice	(a,b,c)	"a"
	>

]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist04xml [
	"Source file: sun/not-wf/attlist04.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  illegal attribute types -->

    <!ATTLIST root
	number	NUMBER	"1"
	>

]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist05xml [
	"Source file: sun/not-wf/attlist05.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  illegal attribute types -->

    <!ATTLIST root
	numbers	NUMBERS	"1 2 3 4"
	>

]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist06xml [
	"Source file: sun/not-wf/attlist06.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  illegal attribute types -->

    <!ATTLIST root
	number	NAME	"Elvis"
	>

]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist07xml [
	"Source file: sun/not-wf/attlist07.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  illegal attribute types -->

    <!ATTLIST root
	number	NAMES	"The King"
	>

]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist08xml [
	"Source file: sun/not-wf/attlist08.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  illegal attribute default -->

    <!ATTLIST root
	language	CDATA	#CURRENT
	>

]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist09xml [
	"Source file: sun/not-wf/attlist09.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  illegal attribute default -->

    <!ATTLIST root
	language	CDATA	#CONREF
	>

]>

<root language="Dutch"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist10xml [
	"Source file: sun/not-wf/attlist10.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root ANY>
<!ATTLIST root att1 CDATA #IMPLIED>
<!ATTLIST root att2 CDATA #IMPLIED>
]>
<root att1="value1"att2="value2">
    <!-- whitespace required between attributes -->
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfattlist11xml [
	"Source file: sun/not-wf/attlist11.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root ANY>
<!ATTLIST root att1 CDATA #IMPLIED>
<!ATTLIST root att2 CDATA #IMPLIED>
]>
<root att1="value1"att2="value2"/>
    <!-- whitespace required between attributes -->
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfcond01xml [
	"Source file: sun/not-wf/cond01.xml"

	^ '<!DOCTYPE root SYSTEM "cond.dtd" [
    <!ENTITY % MAYBE "CDATA">
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfcond02xml [
	"Source file: sun/not-wf/cond02.xml"

	^ '<!DOCTYPE root SYSTEM "cond.dtd" [
    <!ENTITY % MAYBE "">
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfconddtd [
	"Source file: sun/not-wf/cond.dtd"

	^ '<!-- test conditional sections -->
<!ENTITY % MAYBE "IGNORE">
<![%MAYBE;[ <!ENTITY root EMTPY> ]]>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfcontent01xml [
	"Source file: sun/not-wf/content01.xml"

	^ '<!DOCTYPE root [
    <!-- no whitespace before ''?'', ''*'', ''+'' -->
    <!ELEMENT root ((root) ?)>
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfcontent02xml [
	"Source file: sun/not-wf/content02.xml"

	^ '<!DOCTYPE root [
    <!-- no whitespace before ''?'', ''*'', ''+'' -->
    <!ELEMENT root ((root) *)>
]>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfcontent03xml [
	"Source file: sun/not-wf/content03.xml"

	^ '<!DOCTYPE root [
    <!-- no whitespace before ''?'', ''*'', ''+'' -->
    <!ELEMENT root (root +)>
]>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdecl01ent [
	"Source file: sun/not-wf/decl01.ent"

	^ '<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<!-- only documents may have standalone decls -->
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdecl01xml [
	"Source file: sun/not-wf/decl01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!ENTITY % ent01 SYSTEM "decl01.ent">

    <!-- the entity is an illegal PE -->
    %ent01;
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdtd00xml [
	"Source file: sun/not-wf/dtd00.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root (foo, bar? foo)>
	<!-- comma omitted -->
    <!ELEMENT foo EMPTY>
    <!ELEMENT bar EMPTY>
]>

<root> <foo/> <foo/> </root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdtd01xml [
	"Source file: sun/not-wf/dtd01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root (foo, bar? | foo)>
	<!-- comma swapped for vertical bar -->
    <!ELEMENT foo EMPTY>
    <!ELEMENT bar EMPTY>
]>

<root> <foo/> <foo/> </root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdtd02xml [
	"Source file: sun/not-wf/dtd02.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!-- correct PE ref syntax -->
    <!ENTITY % foo "<!ATTLIST root>">
    % foo;
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdtd03xml [
	"Source file: sun/not-wf/dtd03.xml"

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

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdtd04xml [
	"Source file: sun/not-wf/dtd04.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!-- PUBLIC id must be quoted -->
    <!ENTITY foo PUBLIC -//BadCorp//DTD-foo-1.0//EN "elvis.ent">
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdtd05xml [
	"Source file: sun/not-wf/dtd05.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!-- SYSTEM id must be quoted -->
    <!ENTITY foo SYSTEM elvis.ent>
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdtd07dtd [
	"Source file: sun/not-wf/dtd07.dtd"

	^ '<?xml version="1.0"?>
<!--
    "encoding=..." is mandatory in text declarations.

    All external entities (parameter, general) have optional text
    declarations; only the document entity may omit this declaration.
-->
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfdtd07xml [
	"Source file: sun/not-wf/dtd07.xml"

	^ '<!DOCTYPE root SYSTEM "dtd07.dtd" [
    <!ELEMENT root EMPTY>
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfelement00xml [
	"Source file: sun/not-wf/element00.xml"

	^ '<root>
    Incomplete end tag.
</ro'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfelement01xml [
	"Source file: sun/not-wf/element01.xml"

	^ '<root>
    Incomplete end tag.
</root'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfelement02xml [
	"Source file: sun/not-wf/element02.xml"

	^ '<!DOCTYPE html [ <!ELEMENT html ANY> ]>
<html>
    <% @ LANGUAGE="VBSCRIPT" %>
</html>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfelement03xml [
	"Source file: sun/not-wf/element03.xml"

	^ '<!DOCTYPE html [ <!ELEMENT html ANY> ]>
<html>
    <% document.println ("hello, world"); %>
</html>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfelement04xml [
	"Source file: sun/not-wf/element04.xml"

	^ '<!DOCTYPE root [ <!ELEMENT root ANY> ]>
<root>
    <!ELEMENT foo EMPTY>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfencoding01xml [
	"Source file: sun/not-wf/encoding01.xml"

	^ '<?xml version="1.0" encoding=" utf-8"?>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfencoding02xml [
	"Source file: sun/not-wf/encoding02.xml"

	^ '<?xml version="1.0" encoding="a/b"?>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfencoding03xml [
	"Source file: sun/not-wf/encoding03.xml"

	^ '<?xml version="1.0" encoding="just&#41;word"?>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfencoding04xml [
	"Source file: sun/not-wf/encoding04.xml"

	^ '<?xml version="1.0" encoding="utf:8"?>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfencoding05xml [
	"Source file: sun/not-wf/encoding05.xml"

	^ '<?xml version="1.0" encoding="@import(sys-encoding)"?>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfencoding06xml [
	"Source file: sun/not-wf/encoding06.xml"

	^ '<?xml version="1.0" encoding="XYZ+999"?>

<!-- WF ... but illegal encoding name, also a fatal error --> 

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfencoding07xml [
	"Source file: sun/not-wf/encoding07.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!--
	reusing this entity; it''s got no markup decls,
	so it''s legal except for a missing "encoding=...".
    -->
    <!ENTITY empty SYSTEM "dtd07.dtd">
]>
<root>&empty;</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfnotsa03xml [
	"Source file: sun/not-wf/not-sa03.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!--
	External entity ref
    -->
]>

<attributes
    token =	"b"
    id =	"external-&number;"
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfpixml [
	"Source file: sun/not-wf/pi.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!-- space before PI data and ?> -->
<?bad-pi+?>
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfpubid01xml [
	"Source file: sun/not-wf/pubid01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- illegal public ID characters -->

    <!ENTITY e PUBLIC "this isn&apos;t allowed" "ignored">
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfpubid02xml [
	"Source file: sun/not-wf/pubid02.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- illegal public ID characters -->

    <!ENTITY e PUBLIC "<illegal>" "ignored">
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfpubid03xml [
	"Source file: sun/not-wf/pubid03.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- illegal public ID characters -->

    <!ENTITY e PUBLIC "[illegal]" "ignored">
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfpubid04xml [
	"Source file: sun/not-wf/pubid04.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- illegal public ID characters -->

    <!ENTITY e PUBLIC "{ illegal }" "ignored">
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfpubid05xml [
	"Source file: sun/not-wf/pubid05.xml"

	^ '<!DOCTYPE root [

    <!-- SGML-ism: publid ID without system ID -->

    <!ENTITY e PUBLIC "this is not allowed">
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml01xml [
	"Source file: sun/not-wf/sgml01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  omitted end tag -->
]>

<root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml02xml [
	"Source file: sun/not-wf/sgml02.xml"

	^ ' <?xml version="1.0"?>
    <!-- SGML-ism:  XML PI not at beginning -->
<!DOCTYPE root [ <!ELEMENT root EMPTY> ]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml03xml [
	"Source file: sun/not-wf/sgml03.xml"

	^ '<!DOCTYPE root [ <!ELEMENT root EMPTY> ]>

    <!-- SGML-ism:  -- inside comment -->
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml04xml [
	"Source file: sun/not-wf/sgml04.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  multiple attlist types -->

    <!ELEMENT root EMPTY>
    <!ELEMENT branch EMPTY>

    <!ATTLIST (root|branch)
	TreeType CDATA #REQUIRED
	>
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml05xml [
	"Source file: sun/not-wf/sgml05.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  multiple element types -->

    <!ELEMENT root EMPTY>
    <!ELEMENT leaves EMPTY>
    <!ELEMENT branch EMPTY>

    <!ELEMENT (bush|tree) (root,leaves,branch)>
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml06xml [
	"Source file: sun/not-wf/sgml06.xml"

	^ '<!DOCTYPE root [
    <!-- Web-SGML-ism:  global attlist types -->

    <!ELEMENT root EMPTY>

    <!ATTLIST #ALL
	TreeType CDATA #REQUIRED
	>
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml07xml [
	"Source file: sun/not-wf/sgml07.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  omitted tag minimzation spec -->
    <!ELEMENT root - o EMPTY>
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml08xml [
	"Source file: sun/not-wf/sgml08.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  omitted tag minimzation spec -->
    <!ELEMENT root - - EMPTY>
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml09xml [
	"Source file: sun/not-wf/sgml09.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  exception spec -->

    <!ELEMENT footnote (para*) -footnote>
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml10xml [
	"Source file: sun/not-wf/sgml10.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  exception spec -->
    <!ELEMENT section (header,(para|section))* +(annotation|todo)>
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml11xml [
	"Source file: sun/not-wf/sgml11.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  CDATA content type -->
    <!ELEMENT ROOT CDATA>
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml12xml [
	"Source file: sun/not-wf/sgml12.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  RCDATA content type -->
    <!ELEMENT ROOT RCDATA>
]>

<root/>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfsgml13xml [
	"Source file: sun/not-wf/sgml13.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  unordered content type -->
    <!ELEMENT ROOT (a & b & c)>
    <!ELEMENT a EMPTY>
    <!ELEMENT b EMPTY>
    <!ELEMENT c EMPTY>
]>

<root><b/><c/><a/></root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcenotwfuri01xml [
	"Source file: sun/not-wf/uri01.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!-- URI fragments disallowed -->
<!ENTITY foo SYSTEM "foo#bar">
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevaliddtd00xml [
	"Source file: sun/valid/dtd00.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!ELEMENT x (#PCDATA)>
    <!ELEMENT y (#PCDATA)*>
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevaliddtd01xml [
	"Source file: sun/valid/dtd01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!ENTITY % PE "this is a PE">
    <!-- %these; %are; %not; %PEs; -->
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevaliddtdtestdtd [
	"Source file: sun/valid/dtdtest.dtd"

	^ '<?xml version="1.0" encoding="UTF-8"?>

<!ELEMENT root ANY>

<!ELEMENT e EMPTY>

<!ELEMENT once (e)>
<!ELEMENT twice (e,e)>

<!ENTITY % once-or-twice-a "(e,(e)?)">
<!ENTITY % once-or-twice-b "((e),e?)">
<!ENTITY % once-or-twice-c "((e),(e)?)">
<!ENTITY % once-or-twice-d "(((e)),e?)">
<!ENTITY % once-or-twice-e "(e,(((e)))?)">

<!-- disallowed by spec; a document error, parser needn''t report -->
<!-- (e?,e) -->

<!ELEMENT once-or-twice-a %once-or-twice-a;>
<!ELEMENT once-or-twice-b %once-or-twice-b;>
<!ELEMENT once-or-twice-c %once-or-twice-c;>
<!ELEMENT once-or-twice-d %once-or-twice-d;>
<!ELEMENT once-or-twice-e %once-or-twice-e;>

<!-- disallowed by spec; a document error, parser needn''t report -->
<!--
    <!ELEMENT once-or-twice-X (Xonce;|Xtwice)>
	... above, ''X'' should be a percent sign but this comment
	is being nice to those parsers that try to parse comments
	(they shouldn''t)
-->

<!ENTITY % once-or-more-a "(e+)">
<!ENTITY % once-or-more-b "(e,e*)">
<!ENTITY % once-or-more-c "((e)+)">
<!ENTITY % once-or-more-d "((e),e*)">
<!ENTITY % once-or-more-e "(e,(e)*)">

<!ELEMENT once-or-more-a  %once-or-more-a;>
<!ELEMENT once-or-more-b  %once-or-more-b;>
<!ELEMENT once-or-more-c  %once-or-more-c;>
<!ELEMENT once-or-more-d  %once-or-more-d;>
<!ELEMENT once-or-more-e  %once-or-more-e;>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidelementxml [
	"Source file: sun/valid/element.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root ANY>
<!ELEMENT empty EMPTY>
<!ELEMENT mixed1 (#PCDATA)>
<!ELEMENT mixed2 (#PCDATA)*>
<!ELEMENT mixed3 (#PCDATA|empty)*>
]>

<root>
    <empty/>

    <mixed1/>
    <mixed1></mixed1>

    <mixed2/>
    <mixed2></mixed2>

    <mixed3/>
    <mixed3></mixed3>

    <mixed1>allowed</mixed1>
    <mixed1><![CDATA[<allowed>]]></mixed1>

    <mixed2>also</mixed2>
    <mixed2><![CDATA[<% illegal otherwise %>]]></mixed2>

    <mixed3>moreover</mixed3>

    <mixed1>allowed &amp; stuff</mixed1>

    <mixed2>also</mixed2>

    <mixed3>moreover <empty></empty> </mixed3>
    <mixed3>moreover <empty/> </mixed3>
    <mixed3><empty/> </mixed3>
    <mixed3><empty/> too</mixed3>

</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidext01ent [
	"Source file: sun/valid/ext01.ent"

	^ '<?xml encoding="UTF-8"?>
<!-- this is really ascii ... ;- -->
<foo/>

<bar/>

<is> "dumber than a bag full of hammers" </is>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidext01xml [
	"Source file: sun/valid/ext01.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root ANY>
<!ELEMENT foo ANY>
<!ELEMENT bar ANY>
<!ELEMENT is ANY>
<!ENTITY root SYSTEM "ext01.ent">
<!ENTITY null SYSTEM "null.ent">
]>
<root> &root; &root; &null; &null; </root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidext02xml [
	"Source file: sun/valid/ext02.xml"

	^ '<!DOCTYPE foo [
<!ELEMENT foo (root*)>
<!ELEMENT root EMPTY>
<!ENTITY utf16b SYSTEM "../invalid/utf16b.xml">
<!ENTITY utf16l SYSTEM "../invalid/utf16l.xml">
]>

<foo> &utf16b; &utf16l; </foo>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidnotation01dtd [
	"Source file: sun/valid/notation01.dtd"

	^ '<?xml version="1.0" encoding="UTF-8"?>

<!NOTATION GIF PUBLIC
    "+//ISBN 0-7923-9432-1::Graphic Notation//NOTATION
     CompuServe Graphic Interchange Format//EN">

<!ELEMENT test (#PCDATA) >

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidnotation01xml [
	"Source file: sun/valid/notation01.xml"

	^ '<?xml version="1.0"?>
<!DOCTYPE test SYSTEM "notation01.dtd" [
    <!ENTITY applydsssl SYSTEM "applydsssl.gif" NDATA GIF>
]>
<test>test</test>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidnotsa01xml [
	"Source file: sun/valid/not-sa01.xml"

	^ '<?xml version=''1.0'' standalone=''no''?>

<!DOCTYPE root SYSTEM "sa.dtd">

<root>
    <child>
    The whitespace before and after this element keeps
    this from being standalone.
    </child>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidnotsa02xml [
	"Source file: sun/valid/not-sa02.xml"

	^ '<?xml version=''1.0'' standalone=''no''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd" [
    <!ENTITY internal " number99">
]>

    <!-- sync with ../invalid/not-sa02.xml -->

    <!--
	lots of normalized/defaulted attributes
	keep this from being standalone

	XXX not the best basis for negative tests!!
    -->

<attributes
    notation =	" nonce "
    nmtoken =	" this-gets-normalized "
    nmtokens =	" this 	
 also	 gets normalized "
    id =	"	&internal; "
    idref =	" &internal;
    "
    idrefs =	" &internal;  &internal;    &internal;"
    entity =	" unparsed-1 "
    entities =	"unparsed-1
    unparsed-2		
"
    cdata =	"nothing happens to this one!"
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidnotsa03xml [
	"Source file: sun/valid/not-sa03.xml"

	^ '<?xml version=''1.0'' standalone=''no''?>

<!DOCTYPE attributes SYSTEM "sa.dtd" [
    <!--
	This one is almost standalone since the values
	are pre-normalized in this document, and the
	defaulted attribute is explicit.
    
	BUT the entity refs are both external and need
	normalization.
    -->
]>

<attributes
    token =	"b"
    notation =	"foo"
    nmtoken =	"this-gets-normalized"
    nmtokens =	"this also gets normalized"
    id =	"&internal;"
    idref =	"&internal;"
    idrefs =	"&internal; &internal; &internal;"
    entity =	"unparsed-1"
    entities =	"unparsed-1 unparsed-2"
    cdata =	"nothing happens to this one!"
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidnotsa04xml [
	"Source file: sun/valid/not-sa04.xml"

	^ '<?xml version=''1.0'' standalone=''no''?>

<!DOCTYPE attributes SYSTEM "sa.dtd" [
    <!--
	This one isn''t standalone since it''s got a defaulted
	attribute (token) and one needing normalization
	(notation).
    -->

    <!ATTLIST attributes
	token		(a|b|c)		"a"
	notation	(nonce|foo|bar)	#IMPLIED
	>
    <!ENTITY internal "internal&number;">
    <!ENTITY number "42">
]>

<attributes
    notation =	" nonce "
    nmtoken =	"this-gets-normalized"
    nmtokens =	"this also gets normalized"
    id =	"&internal;"
    idref =	"&internal;"
    idrefs =	"&internal; &internal; &internal;"
    entity =	"unparsed-1"
    entities =	"unparsed-1 unparsed-2"
    cdata =	"nothing happens to this one!"
    />

<?pi equals three?>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidnullent [
	"Source file: sun/valid/null.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoptionalxml [
	"Source file: sun/valid/optional.xml"

	^ '<!DOCTYPE root SYSTEM "dtdtest.dtd">
<root>
    <!--
	This primarily bangs on different ways of expressing
	optionality in content models.
    -->
    <once><e/></once>

    <twice><e/><e/></twice>


    <once-or-twice-a><e/></once-or-twice-a>
    <once-or-twice-b><e/></once-or-twice-b>
    <once-or-twice-c><e/></once-or-twice-c>
    <once-or-twice-d><e/></once-or-twice-d>
    <once-or-twice-e><e/></once-or-twice-e>

    <once-or-twice-a><e/><e/></once-or-twice-a>
    <once-or-twice-b><e/><e/></once-or-twice-b>
    <once-or-twice-c><e/><e/></once-or-twice-c>
    <once-or-twice-d><e/><e/></once-or-twice-d>
    <once-or-twice-e><e/><e/></once-or-twice-e>


    <once-or-more-a><e/></once-or-more-a>
    <once-or-more-b><e/></once-or-more-b>
    <once-or-more-c><e/></once-or-more-c>
    <once-or-more-d><e/></once-or-more-d>
    <once-or-more-e><e/></once-or-more-e>

    <once-or-more-a><e/><e/></once-or-more-a>
    <once-or-more-b><e/><e/></once-or-more-b>
    <once-or-more-c><e/><e/></once-or-more-c>
    <once-or-more-d><e/><e/></once-or-more-d>
    <once-or-more-e><e/><e/></once-or-more-e>

    <once-or-more-a><e/><e/><e/></once-or-more-a>
    <once-or-more-b><e/><e/><e/></once-or-more-b>
    <once-or-more-c><e/><e/><e/></once-or-more-c>
    <once-or-more-d><e/><e/><e/></once-or-more-d>
    <once-or-more-e><e/><e/><e/></once-or-more-e>

    <once-or-more-a><e/><e/><e/><e/></once-or-more-a>
    <once-or-more-b><e/><e/><e/><e/></once-or-more-b>
    <once-or-more-c><e/><e/><e/><e/></once-or-more-c>
    <once-or-more-d><e/><e/><e/><e/></once-or-more-d>
    <once-or-more-e><e/><e/><e/><e/></once-or-more-e>


</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutdtd00xml [
	"Source file: sun/valid/out/dtd00.xml"

	^ '<root></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutdtd01xml [
	"Source file: sun/valid/out/dtd01.xml"

	^ '<root></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutelementxml [
	"Source file: sun/valid/out/element.xml"

	^ '<root>&#10;    <empty></empty>&#10;&#10;    <mixed1></mixed1>&#10;    <mixed1></mixed1>&#10;&#10;    <mixed2></mixed2>&#10;    <mixed2></mixed2>&#10;&#10;    <mixed3></mixed3>&#10;    <mixed3></mixed3>&#10;&#10;    <mixed1>allowed</mixed1>&#10;    <mixed1>&lt;allowed&gt;</mixed1>&#10;&#10;    <mixed2>also</mixed2>&#10;    <mixed2>&lt;% illegal otherwise %&gt;</mixed2>&#10;&#10;    <mixed3>moreover</mixed3>&#10;&#10;    <mixed1>allowed &amp; stuff</mixed1>&#10;&#10;    <mixed2>also</mixed2>&#10;&#10;    <mixed3>moreover <empty></empty> </mixed3>&#10;    <mixed3>moreover <empty></empty> </mixed3>&#10;    <mixed3><empty></empty> </mixed3>&#10;    <mixed3><empty></empty> too</mixed3>&#10;&#10;</root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutext01xml [
	"Source file: sun/valid/out/ext01.xml"

	^ '<root> &#10;&#10;<foo></foo>&#10;&#10;<bar></bar>&#10;&#10;<is> &quot;dumber than a bag full of hammers&quot; </is>&#10; &#10;&#10;<foo></foo>&#10;&#10;<bar></bar>&#10;&#10;<is> &quot;dumber than a bag full of hammers&quot; </is>&#10;   </root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutext02xml [
	"Source file: sun/valid/out/ext02.xml"

	^ '<foo> &#10;<root></root>&#10; &#10;<root></root>&#10; </foo>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutnotation01xml [
	"Source file: sun/valid/out/notation01.xml"

	^ '<!DOCTYPE test [
<!NOTATION GIF PUBLIC ''+//ISBN 0-7923-9432-1::Graphic Notation//NOTATION CompuServe Graphic Interchange Format//EN''>
]>
<test>test</test>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutnotsa01xml [
	"Source file: sun/valid/out/not-sa01.xml"

	^ '<!DOCTYPE root [
<!NOTATION bar SYSTEM ''file:/dev/tty''>
<!NOTATION foo PUBLIC ''-//public id//foo'' ''file:/dev/null''>
<!NOTATION nonce SYSTEM ''file:/dev/null''>
]>
<root>&#10;    <child>&#10;    The whitespace before and after this element keeps&#10;    this from being standalone.&#10;    </child>&#10;</root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutnotsa02xml [
	"Source file: sun/valid/out/not-sa02.xml"

	^ '<!DOCTYPE attributes [
<!NOTATION bar SYSTEM ''file:/dev/tty''>
<!NOTATION foo PUBLIC ''-//public id//foo'' ''file:/dev/null''>
<!NOTATION nonce SYSTEM ''file:/dev/null''>
]>
<attributes cdata="nothing happens to this one!" entities="unparsed-1 unparsed-2" entity="unparsed-1" id="number99" idref="number99" idrefs="number99 number99 number99" nmtoken="this-gets-normalized" nmtokens="this also gets normalized" notation="nonce" token="a"></attributes>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutnotsa03xml [
	"Source file: sun/valid/out/not-sa03.xml"

	^ '<!DOCTYPE attributes [
<!NOTATION bar SYSTEM ''file:/dev/tty''>
<!NOTATION foo PUBLIC ''-//public id//foo'' ''file:/dev/null''>
<!NOTATION nonce SYSTEM ''file:/dev/null''>
]>
<attributes cdata="nothing happens to this one!" entities="unparsed-1 unparsed-2" entity="unparsed-1" id="internal42" idref="internal42" idrefs="internal42 internal42 internal42" nmtoken="this-gets-normalized" nmtokens="this also gets normalized" notation="foo" token="b"></attributes>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutnotsa04xml [
	"Source file: sun/valid/out/not-sa04.xml"

	^ '<!DOCTYPE attributes [
<!NOTATION bar SYSTEM ''file:/dev/tty''>
<!NOTATION foo PUBLIC ''-//public id//foo'' ''file:/dev/null''>
<!NOTATION nonce SYSTEM ''file:/dev/null''>
]>
<attributes cdata="nothing happens to this one!" entities="unparsed-1 unparsed-2" entity="unparsed-1" id="internal42" idref="internal42" idrefs="internal42 internal42 internal42" nmtoken="this-gets-normalized" nmtokens="this also gets normalized" notation="nonce" token="a"></attributes><?pi equals three?>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutoptionalxml [
	"Source file: sun/valid/out/optional.xml"

	^ '<root>&#10;    &#10;    <once><e></e></once>&#10;&#10;    <twice><e></e><e></e></twice>&#10;&#10;&#10;    <once-or-twice-a><e></e></once-or-twice-a>&#10;    <once-or-twice-b><e></e></once-or-twice-b>&#10;    <once-or-twice-c><e></e></once-or-twice-c>&#10;    <once-or-twice-d><e></e></once-or-twice-d>&#10;    <once-or-twice-e><e></e></once-or-twice-e>&#10;&#10;    <once-or-twice-a><e></e><e></e></once-or-twice-a>&#10;    <once-or-twice-b><e></e><e></e></once-or-twice-b>&#10;    <once-or-twice-c><e></e><e></e></once-or-twice-c>&#10;    <once-or-twice-d><e></e><e></e></once-or-twice-d>&#10;    <once-or-twice-e><e></e><e></e></once-or-twice-e>&#10;&#10;&#10;    <once-or-more-a><e></e></once-or-more-a>&#10;    <once-or-more-b><e></e></once-or-more-b>&#10;    <once-or-more-c><e></e></once-or-more-c>&#10;    <once-or-more-d><e></e></once-or-more-d>&#10;    <once-or-more-e><e></e></once-or-more-e>&#10;&#10;    <once-or-more-a><e></e><e></e></once-or-more-a>&#10;    <once-or-more-b><e></e><e></e></once-or-more-b>&#10;    <once-or-more-c><e></e><e></e></once-or-more-c>&#10;    <once-or-more-d><e></e><e></e></once-or-more-d>&#10;    <once-or-more-e><e></e><e></e></once-or-more-e>&#10;&#10;    <once-or-more-a><e></e><e></e><e></e></once-or-more-a>&#10;    <once-or-more-b><e></e><e></e><e></e></once-or-more-b>&#10;    <once-or-more-c><e></e><e></e><e></e></once-or-more-c>&#10;    <once-or-more-d><e></e><e></e><e></e></once-or-more-d>&#10;    <once-or-more-e><e></e><e></e><e></e></once-or-more-e>&#10;&#10;    <once-or-more-a><e></e><e></e><e></e><e></e></once-or-more-a>&#10;    <once-or-more-b><e></e><e></e><e></e><e></e></once-or-more-b>&#10;    <once-or-more-c><e></e><e></e><e></e><e></e></once-or-more-c>&#10;    <once-or-more-d><e></e><e></e><e></e><e></e></once-or-more-d>&#10;    <once-or-more-e><e></e><e></e><e></e><e></e></once-or-more-e>&#10;&#10;&#10;</root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutpe00xml [
	"Source file: sun/valid/out/pe00.xml"

	^ '<root>La Peste: Albert Camus,&#10;', 16rA9 asCharacter asString, ' 1947 ', 16rC9 asCharacter asString, 'ditions Gallimard. All rights reserved</root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutpe02xml [
	"Source file: sun/valid/out/pe02.xml"

	^ '<test>This sample shows a error-prone method.</test>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutpe03xml [
	"Source file: sun/valid/out/pe03.xml"

	^ '<root><p>An ampersand (&amp;) may be escaped&#10;numerically (&amp;#38) or with a general entity (&amp;amp;).</p></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutrequired00xml [
	"Source file: sun/valid/out/required00.xml"

	^ '<root req="foo"></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutsa01xml [
	"Source file: sun/valid/out/sa01.xml"

	^ '<root>&#10;    <child>&#10;    The whitespace around this element would be&#10;    invalid as standalone were the DTD external.&#10;    </child>&#10;</root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutsa02xml [
	"Source file: sun/valid/out/sa02.xml"

	^ '<!DOCTYPE attributes [
<!NOTATION bar SYSTEM ''file:/dev/tty''>
<!NOTATION foo PUBLIC ''-//public id//foo'' ''file:/dev/null''>
<!NOTATION nonce SYSTEM ''file:/dev/null''>
]>
<attributes cdata="nothing happens to this one!" entities="unparsed-1 unparsed-2" entity="unparsed-1" id="internal42" idref="internal42" idrefs="internal42 internal42 internal42" nmtoken="this-gets-normalized" nmtokens="this also gets normalized" notation="nonce" token="a"></attributes>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutsa03xml [
	"Source file: sun/valid/out/sa03.xml"

	^ '<!DOCTYPE attributes [
<!NOTATION bar SYSTEM ''file:/dev/tty''>
<!NOTATION foo PUBLIC ''-//public id//foo'' ''file:/dev/null''>
<!NOTATION nonce SYSTEM ''file:/dev/null''>
]>
<attributes cdata="nothing happens to this one!" entities="unparsed-1 unparsed-2" entity="unparsed-1" id="internal42" idref="internal42" idrefs="internal42 internal42 internal42" nmtoken="this-gets-normalized" nmtokens="this also gets normalized" notation="foo" token="b"></attributes>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutsa04xml [
	"Source file: sun/valid/out/sa04.xml"

	^ '<!DOCTYPE attributes [
<!NOTATION bar SYSTEM ''file:/dev/tty''>
<!NOTATION foo PUBLIC ''-//public id//foo'' ''file:/dev/null''>
<!NOTATION nonce SYSTEM ''file:/dev/null''>
]>
<attributes cdata="nothing happens to this one!" entities="unparsed-1 unparsed-2" entity="unparsed-1" id="internal42" idref="internal42" idrefs="internal42 internal42 internal42" nmtoken="this-gets-normalized" nmtokens="this also gets normalized" notation="nonce" token="a"></attributes><?pi equals three?>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutsa05xml [
	"Source file: sun/valid/out/sa05.xml"

	^ '<!DOCTYPE root [
<!NOTATION bar SYSTEM ''file:/dev/tty''>
<!NOTATION foo PUBLIC ''-//public id//foo'' ''file:/dev/null''>
<!NOTATION nonce SYSTEM ''file:/dev/null''>
]>
<root><child>&#10;    No whitespace before or after this standalone element.&#10;</child></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutsgml01xml [
	"Source file: sun/valid/out/sgml01.xml"

	^ '<root position="first" status="initial-draft"></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutvlang01xml [
	"Source file: sun/valid/out/v-lang01.xml"

	^ '<root xml:lang="en"></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutvlang02xml [
	"Source file: sun/valid/out/v-lang02.xml"

	^ '<root xml:lang="en-IN"></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutvlang03xml [
	"Source file: sun/valid/out/v-lang03.xml"

	^ '<root xml:lang="i-klingon-whorf"></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutvlang04xml [
	"Source file: sun/valid/out/v-lang04.xml"

	^ '<root xml:lang="x-dialect-valleygirl"></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutvlang05xml [
	"Source file: sun/valid/out/v-lang05.xml"

	^ '<root xml:lang="DE"></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidoutvlang06xml [
	"Source file: sun/valid/out/v-lang06.xml"

	^ '<root xml:lang="X-Java"></root>'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidpe00dtd [
	"Source file: sun/valid/pe00.dtd"

	^ '<!ELEMENT root (#PCDATA)>
<!-- Example from XML spec 1.0 section 4.5 -->
<!ENTITY % pub "&#xc9;ditions Gallimard">
<!ENTITY rights "All rights reserved">
<!ENTITY book "La Peste: Albert Camus,
&#xa9; 1947 %pub;. &rights;">
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidpe00xml [
	"Source file: sun/valid/pe00.xml"

	^ '<!DOCTYPE root SYSTEM "pe00.dtd">
<root>&book;</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidpe01dtd [
	"Source file: sun/valid/pe01.dtd"

	^ '<!ENTITY % bad-pe SYSTEM "pe01.ent">
<!ELEMENT root EMPTY>
<!ATTLIST root
    something	CDATA			"%not-pe;"
    evil	(doctor | scott)	"doctor"
    >
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidpe01ent [
	"Source file: sun/valid/pe01.ent"

	^ 'This is not a legal parameter entity, because
it does not match the "markupdecl" production.
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidpe01xml [
	"Source file: sun/valid/pe01.xml"

	^ '<!DOCTYPE root SYSTEM "pe01.dtd">
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidpe02xml [
	"Source file: sun/valid/pe02.xml"

	^ '<?xml version=''1.0''?>
<!DOCTYPE test [
<!ELEMENT test (#PCDATA) >
<!ENTITY % xx ''&#37;zz;''>
<!ENTITY % zz ''&#60;!ENTITY tricky "error-prone" >'' >
%xx;
]>
<test>This sample shows a &tricky; method.</test>
<!-- Example 2 from XML spec 1.0 Appendix D -->
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidpe03xml [
	"Source file: sun/valid/pe03.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root (p)>
<!ELEMENT p (#PCDATA)>
<!-- Example 1 from XML spec 1.0 Appendix D -->
<!ENTITY example "<p>An ampersand (&#38;#38;) may be escaped
numerically (&#38;#38;#38) or with a general entity (&amp;amp;).</p>" >
]>
<root>&example;</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidrequired00xml [
	"Source file: sun/valid/required00.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!ATTLIST root
	req CDATA #REQUIRED
	>
]>

<root req="foo"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidsa01xml [
	"Source file: sun/valid/sa01.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE root [
    <!ELEMENT root (child)*>
    <!ELEMENT child (#PCDATA)>
]>

<root>
    <child>
    The whitespace around this element would be
    invalid as standalone were the DTD external.
    </child>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidsa02xml [
	"Source file: sun/valid/sa02.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes [
    <!ELEMENT attributes EMPTY>

    <!--
	2.9 gives validity constraints applying to attributes
	in standalone docs:  no external defaults or decls
	causing normalization.

	3.3.3 describes the normalization rules
    -->

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
    
    <!ENTITY internal " internal&number; ">
    <!ENTITY number "42">

    <!NOTATION nonce SYSTEM "file:/dev/null">
    <!NOTATION foo PUBLIC "-//public id//foo" "file:/dev/null">
    <!NOTATION bar SYSTEM "file:/dev/tty">

    <!ENTITY unparsed-1 PUBLIC "-//some public//ID" "file:/dev/console"
			NDATA nonce>
    <!ENTITY unparsed-2 SYSTEM "scheme://host/data"
			NDATA foo>
]>

<attributes
    notation =	" nonce "
    nmtoken =	" this-gets-normalized "
    nmtokens =	" this	
 also	 gets normalized "
    id =	"	&internal; "
    idref =	" &internal;
    "
    idrefs =	" &internal;  &internal;    &internal;"
    entity =	" unparsed-1 "
    entities =	"unparsed-1 unparsed-2"
    cdata =	"nothing happens to this one!"
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidsa03xml [
	"Source file: sun/valid/sa03.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "sa.dtd" [
    <!--
	This one is standalone since the values are
	pre-normalized in this document, and the
	defaulted attribute is explicit.
    
	Similarly the entity refs are internal and
	don''t need normalization ... the unparsed
	entities (and entities) aren''t "references"
    -->
    <!ENTITY internal "internal&number;">
    <!ENTITY number "42">
]>

<attributes
    token =	"b"
    notation =	"foo"
    nmtoken =	"this-gets-normalized"
    nmtokens =	"this also gets normalized"
    id =	"&internal;"
    idref =	"&internal;"
    idrefs =	"&internal; &internal; &internal;"
    entity =	"unparsed-1"
    entities =	"unparsed-1 unparsed-2"
    cdata =	"nothing happens to this one!"
    />
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidsa04xml [
	"Source file: sun/valid/sa04.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "sa.dtd" [
    <!--
	This one is standalone since the values are
	pre-normalized in this document, except that
	one defaulted attribute is (re)defined internally
	and so is one normalized one.
    
        Similarly the entity refs are internal.  Unparsed
        entities and notations are not listed among the
        items that must not be externally declared in
        standalone documents, even though processors must
        in theory report their identifiers.

    -->

    <!ATTLIST attributes
	token		(a|b|c)		"a"
	notation	(nonce|foo|bar)	#IMPLIED
	>
    <!ENTITY internal "internal&number;">
    <!ENTITY number "42">
]>

<attributes
    notation =	" nonce "
    nmtoken =	"this-gets-normalized"
    nmtokens =	"this also gets normalized"
    id =	"&internal;"
    idref =	"&internal;"
    idrefs =	"&internal; &internal; &internal;"
    entity =	"unparsed-1"
    entities =	"unparsed-1 unparsed-2"
    cdata =	"nothing happens to this one!"
    />

<?pi equals three?>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidsa05xml [
	"Source file: sun/valid/sa05.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE root SYSTEM "sa.dtd">

<root><child>
    No whitespace before or after this standalone element.
</child></root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidsadtd [
	"Source file: sun/valid/sa.dtd"

	^ '<?xml version="1.0" encoding="UTF-8"?>

    <!ELEMENT root (child|attributes)*>
    <!ELEMENT child (#PCDATA)>
    <!ELEMENT attributes EMPTY>

    <!--
	2.9 gives validity constraints applying to attributes
	in standalone docs:  no external defaults or decls
	causing normalization.

	3.3.3 describes the normalization rules
    -->

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
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidsgml01xml [
	"Source file: sun/valid/sgml01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
    <!--
	SGML dislikes token reuse.  It''s legal XML, so any
	XML parser must accept it, though it''s discouraged
	in documents "for interoperability"
    -->
    <!ATTLIST root
	status		(initial-draft|revision|final) "initial-draft"
	position	(first|intermediate|final) "first"
	>
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidvlang01xml [
	"Source file: sun/valid/v-lang01.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="en"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidvlang02xml [
	"Source file: sun/valid/v-lang02.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="en-IN"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidvlang03xml [
	"Source file: sun/valid/v-lang03.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="i-klingon-whorf"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidvlang04xml [
	"Source file: sun/valid/v-lang04.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="x-dialect-valleygirl"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidvlang05xml [
	"Source file: sun/valid/v-lang05.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="DE"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTest class >> sourcevalidvlang06xml [
	"Source file: sun/valid/v-lang06.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="X-Java"/>

'
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr01xml [
	"Source file: sun/invalid/attr01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr01xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr01xml
				documentURI: 'invalid/attr01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr02xml [
	"Source file: sun/invalid/attr02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr02xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr02xml
				documentURI: 'invalid/attr02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr03xml [
	"Source file: sun/invalid/attr03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr03xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr03xml
				documentURI: 'invalid/attr03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr04xml [
	"Source file: sun/invalid/attr04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr04xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr04xml
				documentURI: 'invalid/attr04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr05xml [
	"Source file: sun/invalid/attr05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr05xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr05xml
				documentURI: 'invalid/attr05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr06xml [
	"Source file: sun/invalid/attr06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr06xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr06xml
				documentURI: 'invalid/attr06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr07xml [
	"Source file: sun/invalid/attr07.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr07xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr07xml
				documentURI: 'invalid/attr07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr08xml [
	"Source file: sun/invalid/attr08.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr08xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr08xml
				documentURI: 'invalid/attr08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr09xml [
	"Source file: sun/invalid/attr09.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr09xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr09xml
				documentURI: 'invalid/attr09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr10xml [
	"Source file: sun/invalid/attr10.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr10xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr10xml
				documentURI: 'invalid/attr10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr11xml [
	"Source file: sun/invalid/attr11.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr11xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr11xml
				documentURI: 'invalid/attr11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr12xml [
	"Source file: sun/invalid/attr12.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr12xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr12xml
				documentURI: 'invalid/attr12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr13xml [
	"Source file: sun/invalid/attr13.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr13xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr13xml
				documentURI: 'invalid/attr13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr14xml [
	"Source file: sun/invalid/attr14.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr14xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr14xml
				documentURI: 'invalid/attr14.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr15xml [
	"Source file: sun/invalid/attr15.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr15xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr15xml
				documentURI: 'invalid/attr15.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidattr16xml [
	"Source file: sun/invalid/attr16.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidattr16xml.
	self
		should: [
			self
				parse: self class sourceinvalidattr16xml
				documentURI: 'invalid/attr16.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvaliddtd01xml [
	"Source file: sun/invalid/dtd01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvaliddtd01xml.
	self
		should: [
			self
				parse: self class sourceinvaliddtd01xml
				documentURI: 'invalid/dtd01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvaliddtd02xml [
	"Source file: sun/invalid/dtd02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvaliddtd02xml.
	self
		should: [
			self
				parse: self class sourceinvaliddtd02xml
				documentURI: 'invalid/dtd02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvaliddtd03xml [
	"Source file: sun/invalid/dtd03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvaliddtd03xml.
	self
		should: [
			self
				parse: self class sourceinvaliddtd03xml
				documentURI: 'invalid/dtd03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvaliddtd06xml [
	"Source file: sun/invalid/dtd06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvaliddtd06xml.
	self
		should: [
			self
				parse: self class sourceinvaliddtd06xml
				documentURI: 'invalid/dtd06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidel01xml [
	"Source file: sun/invalid/el01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidel01xml.
	self
		should: [
			self
				parse: self class sourceinvalidel01xml
				documentURI: 'invalid/el01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidel02xml [
	"Source file: sun/invalid/el02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidel02xml.
	self
		should: [
			self
				parse: self class sourceinvalidel02xml
				documentURI: 'invalid/el02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidel03xml [
	"Source file: sun/invalid/el03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidel03xml.
	self
		should: [
			self
				parse: self class sourceinvalidel03xml
				documentURI: 'invalid/el03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidel04xml [
	"Source file: sun/invalid/el04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidel04xml.
	self
		should: [
			self
				parse: self class sourceinvalidel04xml
				documentURI: 'invalid/el04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidel05xml [
	"Source file: sun/invalid/el05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidel05xml.
	self
		should: [
			self
				parse: self class sourceinvalidel05xml
				documentURI: 'invalid/el05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidel06xml [
	"Source file: sun/invalid/el06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidel06xml.
	self
		should: [
			self
				parse: self class sourceinvalidel06xml
				documentURI: 'invalid/el06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidemptyxml [
	"Source file: sun/invalid/empty.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidemptyxml.
	self
		should: [
			self
				parse: self class sourceinvalidemptyxml
				documentURI: 'invalid/empty.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidid01xml [
	"Source file: sun/invalid/id01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidid01xml.
	self
		should: [
			self
				parse: self class sourceinvalidid01xml
				documentURI: 'invalid/id01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidid02xml [
	"Source file: sun/invalid/id02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidid02xml.
	self
		should: [
			self
				parse: self class sourceinvalidid02xml
				documentURI: 'invalid/id02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidid03xml [
	"Source file: sun/invalid/id03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidid03xml.
	self
		should: [
			self
				parse: self class sourceinvalidid03xml
				documentURI: 'invalid/id03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidid04xml [
	"Source file: sun/invalid/id04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidid04xml.
	self
		should: [
			self
				parse: self class sourceinvalidid04xml
				documentURI: 'invalid/id04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidid05xml [
	"Source file: sun/invalid/id05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidid05xml.
	self
		should: [
			self
				parse: self class sourceinvalidid05xml
				documentURI: 'invalid/id05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidid06xml [
	"Source file: sun/invalid/id06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidid06xml.
	self
		should: [
			self
				parse: self class sourceinvalidid06xml
				documentURI: 'invalid/id06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidid07xml [
	"Source file: sun/invalid/id07.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidid07xml.
	self
		should: [
			self
				parse: self class sourceinvalidid07xml
				documentURI: 'invalid/id07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidid08xml [
	"Source file: sun/invalid/id08.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidid08xml.
	self
		should: [
			self
				parse: self class sourceinvalidid08xml
				documentURI: 'invalid/id08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidid09xml [
	"Source file: sun/invalid/id09.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidid09xml.
	self
		should: [
			self
				parse: self class sourceinvalidid09xml
				documentURI: 'invalid/id09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa01xml [
	"Source file: sun/invalid/not-sa01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa01xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa01xml
				documentURI: 'invalid/not-sa01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa02xml [
	"Source file: sun/invalid/not-sa02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa02xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa02xml
				documentURI: 'invalid/not-sa02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa04xml [
	"Source file: sun/invalid/not-sa04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa04xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa04xml
				documentURI: 'invalid/not-sa04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa05xml [
	"Source file: sun/invalid/not-sa05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa05xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa05xml
				documentURI: 'invalid/not-sa05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa06xml [
	"Source file: sun/invalid/not-sa06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa06xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa06xml
				documentURI: 'invalid/not-sa06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa07xml [
	"Source file: sun/invalid/not-sa07.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa07xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa07xml
				documentURI: 'invalid/not-sa07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa08xml [
	"Source file: sun/invalid/not-sa08.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa08xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa08xml
				documentURI: 'invalid/not-sa08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa09xml [
	"Source file: sun/invalid/not-sa09.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa09xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa09xml
				documentURI: 'invalid/not-sa09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa10xml [
	"Source file: sun/invalid/not-sa10.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa10xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa10xml
				documentURI: 'invalid/not-sa10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa11xml [
	"Source file: sun/invalid/not-sa11.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa11xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa11xml
				documentURI: 'invalid/not-sa11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa12xml [
	"Source file: sun/invalid/not-sa12.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa12xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa12xml
				documentURI: 'invalid/not-sa12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa13xml [
	"Source file: sun/invalid/not-sa13.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa13xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa13xml
				documentURI: 'invalid/not-sa13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidnotsa14xml [
	"Source file: sun/invalid/not-sa14.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa14xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa14xml
				documentURI: 'invalid/not-sa14.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional01xml [
	"Source file: sun/invalid/optional01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional01xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional01xml
				documentURI: 'invalid/optional01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional02xml [
	"Source file: sun/invalid/optional02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional02xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional02xml
				documentURI: 'invalid/optional02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional03xml [
	"Source file: sun/invalid/optional03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional03xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional03xml
				documentURI: 'invalid/optional03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional04xml [
	"Source file: sun/invalid/optional04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional04xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional04xml
				documentURI: 'invalid/optional04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional05xml [
	"Source file: sun/invalid/optional05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional05xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional05xml
				documentURI: 'invalid/optional05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional06xml [
	"Source file: sun/invalid/optional06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional06xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional06xml
				documentURI: 'invalid/optional06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional07xml [
	"Source file: sun/invalid/optional07.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional07xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional07xml
				documentURI: 'invalid/optional07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional08xml [
	"Source file: sun/invalid/optional08.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional08xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional08xml
				documentURI: 'invalid/optional08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional09xml [
	"Source file: sun/invalid/optional09.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional09xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional09xml
				documentURI: 'invalid/optional09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional10xml [
	"Source file: sun/invalid/optional10.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional10xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional10xml
				documentURI: 'invalid/optional10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional11xml [
	"Source file: sun/invalid/optional11.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional11xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional11xml
				documentURI: 'invalid/optional11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional12xml [
	"Source file: sun/invalid/optional12.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional12xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional12xml
				documentURI: 'invalid/optional12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional13xml [
	"Source file: sun/invalid/optional13.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional13xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional13xml
				documentURI: 'invalid/optional13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional14xml [
	"Source file: sun/invalid/optional14.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional14xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional14xml
				documentURI: 'invalid/optional14.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional20xml [
	"Source file: sun/invalid/optional20.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional20xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional20xml
				documentURI: 'invalid/optional20.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional21xml [
	"Source file: sun/invalid/optional21.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional21xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional21xml
				documentURI: 'invalid/optional21.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional22xml [
	"Source file: sun/invalid/optional22.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional22xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional22xml
				documentURI: 'invalid/optional22.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional23xml [
	"Source file: sun/invalid/optional23.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional23xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional23xml
				documentURI: 'invalid/optional23.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional24xml [
	"Source file: sun/invalid/optional24.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional24xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional24xml
				documentURI: 'invalid/optional24.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidoptional25xml [
	"Source file: sun/invalid/optional25.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidoptional25xml.
	self
		should: [
			self
				parse: self class sourceinvalidoptional25xml
				documentURI: 'invalid/optional25.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidrequired00xml [
	"Source file: sun/invalid/required00.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidrequired00xml.
	self
		should: [
			self
				parse: self class sourceinvalidrequired00xml
				documentURI: 'invalid/required00.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidrequired01xml [
	"Source file: sun/invalid/required01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidrequired01xml.
	self
		should: [
			self
				parse: self class sourceinvalidrequired01xml
				documentURI: 'invalid/required01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidrequired02xml [
	"Source file: sun/invalid/required02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidrequired02xml.
	self
		should: [
			self
				parse: self class sourceinvalidrequired02xml
				documentURI: 'invalid/required02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidrootxml [
	"Source file: sun/invalid/root.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidrootxml.
	self
		should: [
			self
				parse: self class sourceinvalidrootxml
				documentURI: 'invalid/root.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidutf16bxml [
	"Source file: sun/invalid/utf16b.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidutf16bxml.
	self
		should: [
			self
				parse: self class sourceinvalidutf16bxml
				documentURI: 'invalid/utf16b.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testinvalidutf16lxml [
	"Source file: sun/invalid/utf16l.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidutf16lxml.
	self
		should: [
			self
				parse: self class sourceinvalidutf16lxml
				documentURI: 'invalid/utf16l.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist01xml [
	"Source file: sun/not-wf/attlist01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist01xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist01xml
				documentURI: 'not-wf/attlist01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist02xml [
	"Source file: sun/not-wf/attlist02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist02xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist02xml
				documentURI: 'not-wf/attlist02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist03xml [
	"Source file: sun/not-wf/attlist03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist03xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist03xml
				documentURI: 'not-wf/attlist03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist04xml [
	"Source file: sun/not-wf/attlist04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist04xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist04xml
				documentURI: 'not-wf/attlist04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist05xml [
	"Source file: sun/not-wf/attlist05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist05xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist05xml
				documentURI: 'not-wf/attlist05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist06xml [
	"Source file: sun/not-wf/attlist06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist06xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist06xml
				documentURI: 'not-wf/attlist06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist07xml [
	"Source file: sun/not-wf/attlist07.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist07xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist07xml
				documentURI: 'not-wf/attlist07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist08xml [
	"Source file: sun/not-wf/attlist08.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist08xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist08xml
				documentURI: 'not-wf/attlist08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist09xml [
	"Source file: sun/not-wf/attlist09.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist09xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist09xml
				documentURI: 'not-wf/attlist09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist10xml [
	"Source file: sun/not-wf/attlist10.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist10xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist10xml
				documentURI: 'not-wf/attlist10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfattlist11xml [
	"Source file: sun/not-wf/attlist11.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfattlist11xml.
	self
		should: [
			self
				parse: self class sourcenotwfattlist11xml
				documentURI: 'not-wf/attlist11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfcond01xml [
	"Source file: sun/not-wf/cond01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfcond01xml.
	self
		should: [
			self
				parse: self class sourcenotwfcond01xml
				documentURI: 'not-wf/cond01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfcond02xml [
	"Source file: sun/not-wf/cond02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfcond02xml.
	self
		should: [
			self
				parse: self class sourcenotwfcond02xml
				documentURI: 'not-wf/cond02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfcontent01xml [
	"Source file: sun/not-wf/content01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfcontent01xml.
	self
		should: [
			self
				parse: self class sourcenotwfcontent01xml
				documentURI: 'not-wf/content01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfcontent02xml [
	"Source file: sun/not-wf/content02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfcontent02xml.
	self
		should: [
			self
				parse: self class sourcenotwfcontent02xml
				documentURI: 'not-wf/content02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfcontent03xml [
	"Source file: sun/not-wf/content03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfcontent03xml.
	self
		should: [
			self
				parse: self class sourcenotwfcontent03xml
				documentURI: 'not-wf/content03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfdecl01xml [
	"Source file: sun/not-wf/decl01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfdecl01xml.
	self
		should: [
			self
				parse: self class sourcenotwfdecl01xml
				documentURI: 'not-wf/decl01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfdtd00xml [
	"Source file: sun/not-wf/dtd00.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfdtd00xml.
	self
		should: [
			self
				parse: self class sourcenotwfdtd00xml
				documentURI: 'not-wf/dtd00.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfdtd01xml [
	"Source file: sun/not-wf/dtd01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfdtd01xml.
	self
		should: [
			self
				parse: self class sourcenotwfdtd01xml
				documentURI: 'not-wf/dtd01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfdtd02xml [
	"Source file: sun/not-wf/dtd02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfdtd02xml.
	self
		should: [
			self
				parse: self class sourcenotwfdtd02xml
				documentURI: 'not-wf/dtd02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfdtd03xml [
	"Source file: sun/not-wf/dtd03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfdtd03xml.
	self
		should: [
			self
				parse: self class sourcenotwfdtd03xml
				documentURI: 'not-wf/dtd03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfdtd04xml [
	"Source file: sun/not-wf/dtd04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfdtd04xml.
	self
		should: [
			self
				parse: self class sourcenotwfdtd04xml
				documentURI: 'not-wf/dtd04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfdtd05xml [
	"Source file: sun/not-wf/dtd05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfdtd05xml.
	self
		should: [
			self
				parse: self class sourcenotwfdtd05xml
				documentURI: 'not-wf/dtd05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfdtd07xml [
	"Source file: sun/not-wf/dtd07.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfdtd07xml.
	self
		should: [
			self
				parse: self class sourcenotwfdtd07xml
				documentURI: 'not-wf/dtd07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfelement00xml [
	"Source file: sun/not-wf/element00.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfelement00xml.
	self
		should: [
			self
				parse: self class sourcenotwfelement00xml
				documentURI: 'not-wf/element00.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfelement01xml [
	"Source file: sun/not-wf/element01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfelement01xml.
	self
		should: [
			self
				parse: self class sourcenotwfelement01xml
				documentURI: 'not-wf/element01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfelement02xml [
	"Source file: sun/not-wf/element02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfelement02xml.
	self
		should: [
			self
				parse: self class sourcenotwfelement02xml
				documentURI: 'not-wf/element02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfelement03xml [
	"Source file: sun/not-wf/element03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfelement03xml.
	self
		should: [
			self
				parse: self class sourcenotwfelement03xml
				documentURI: 'not-wf/element03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfelement04xml [
	"Source file: sun/not-wf/element04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfelement04xml.
	self
		should: [
			self
				parse: self class sourcenotwfelement04xml
				documentURI: 'not-wf/element04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfencoding01xml [
	"Source file: sun/not-wf/encoding01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfencoding01xml.
	self
		should: [
			self
				parse: self class sourcenotwfencoding01xml
				documentURI: 'not-wf/encoding01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfencoding02xml [
	"Source file: sun/not-wf/encoding02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfencoding02xml.
	self
		should: [
			self
				parse: self class sourcenotwfencoding02xml
				documentURI: 'not-wf/encoding02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfencoding03xml [
	"Source file: sun/not-wf/encoding03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfencoding03xml.
	self
		should: [
			self
				parse: self class sourcenotwfencoding03xml
				documentURI: 'not-wf/encoding03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfencoding04xml [
	"Source file: sun/not-wf/encoding04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfencoding04xml.
	self
		should: [
			self
				parse: self class sourcenotwfencoding04xml
				documentURI: 'not-wf/encoding04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfencoding05xml [
	"Source file: sun/not-wf/encoding05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfencoding05xml.
	self
		should: [
			self
				parse: self class sourcenotwfencoding05xml
				documentURI: 'not-wf/encoding05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfencoding06xml [
	"Source file: sun/not-wf/encoding06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfencoding06xml.
	self
		should: [
			self
				parse: self class sourcenotwfencoding06xml
				documentURI: 'not-wf/encoding06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfencoding07xml [
	"Source file: sun/not-wf/encoding07.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfencoding07xml.
	self
		should: [
			self
				parse: self class sourcenotwfencoding07xml
				documentURI: 'not-wf/encoding07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfnotsa03xml [
	"Source file: sun/not-wf/not-sa03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa03xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa03xml
				documentURI: 'not-wf/not-sa03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfpixml [
	"Source file: sun/not-wf/pi.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfpixml.
	self
		should: [
			self
				parse: self class sourcenotwfpixml
				documentURI: 'not-wf/pi.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfpubid01xml [
	"Source file: sun/not-wf/pubid01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfpubid01xml.
	self
		should: [
			self
				parse: self class sourcenotwfpubid01xml
				documentURI: 'not-wf/pubid01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfpubid02xml [
	"Source file: sun/not-wf/pubid02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfpubid02xml.
	self
		should: [
			self
				parse: self class sourcenotwfpubid02xml
				documentURI: 'not-wf/pubid02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfpubid03xml [
	"Source file: sun/not-wf/pubid03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfpubid03xml.
	self
		should: [
			self
				parse: self class sourcenotwfpubid03xml
				documentURI: 'not-wf/pubid03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfpubid04xml [
	"Source file: sun/not-wf/pubid04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfpubid04xml.
	self
		should: [
			self
				parse: self class sourcenotwfpubid04xml
				documentURI: 'not-wf/pubid04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfpubid05xml [
	"Source file: sun/not-wf/pubid05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfpubid05xml.
	self
		should: [
			self
				parse: self class sourcenotwfpubid05xml
				documentURI: 'not-wf/pubid05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml01xml [
	"Source file: sun/not-wf/sgml01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml01xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml01xml
				documentURI: 'not-wf/sgml01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml02xml [
	"Source file: sun/not-wf/sgml02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml02xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml02xml
				documentURI: 'not-wf/sgml02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml03xml [
	"Source file: sun/not-wf/sgml03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml03xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml03xml
				documentURI: 'not-wf/sgml03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml04xml [
	"Source file: sun/not-wf/sgml04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml04xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml04xml
				documentURI: 'not-wf/sgml04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml05xml [
	"Source file: sun/not-wf/sgml05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml05xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml05xml
				documentURI: 'not-wf/sgml05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml06xml [
	"Source file: sun/not-wf/sgml06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml06xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml06xml
				documentURI: 'not-wf/sgml06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml07xml [
	"Source file: sun/not-wf/sgml07.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml07xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml07xml
				documentURI: 'not-wf/sgml07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml08xml [
	"Source file: sun/not-wf/sgml08.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml08xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml08xml
				documentURI: 'not-wf/sgml08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml09xml [
	"Source file: sun/not-wf/sgml09.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml09xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml09xml
				documentURI: 'not-wf/sgml09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml10xml [
	"Source file: sun/not-wf/sgml10.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml10xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml10xml
				documentURI: 'not-wf/sgml10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml11xml [
	"Source file: sun/not-wf/sgml11.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml11xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml11xml
				documentURI: 'not-wf/sgml11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml12xml [
	"Source file: sun/not-wf/sgml12.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml12xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml12xml
				documentURI: 'not-wf/sgml12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfsgml13xml [
	"Source file: sun/not-wf/sgml13.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsgml13xml.
	self
		should: [
			self
				parse: self class sourcenotwfsgml13xml
				documentURI: 'not-wf/sgml13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTest >> testnotwfuri01xml [
	"Source file: sun/not-wf/uri01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfuri01xml.
	self
		should: [
			self
				parse: self class sourcenotwfuri01xml
				documentURI: 'not-wf/uri01.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvaliddtd00xml [
	"Source file: sun/valid/dtd00.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvaliddtd00xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevaliddtd00xml
						documentURI: 'valid/dtd00.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutdtd00xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvaliddtd01xml [
	"Source file: sun/valid/dtd01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvaliddtd01xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevaliddtd01xml
						documentURI: 'valid/dtd01.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutdtd01xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidelementxml [
	"Source file: sun/valid/element.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidelementxml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidelementxml
						documentURI: 'valid/element.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutelementxml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidext01xml [
	"Source file: sun/valid/ext01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidext01xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidext01xml
						documentURI: 'valid/ext01.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutext01xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidext02xml [
	"Source file: sun/valid/ext02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidext02xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidext02xml
						documentURI: 'valid/ext02.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutext02xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidnotation01xml [
	"Source file: sun/valid/notation01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotation01xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotation01xml
						documentURI: 'valid/notation01.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutnotation01xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidnotsa01xml [
	"Source file: sun/valid/not-sa01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa01xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa01xml
						documentURI: 'valid/not-sa01.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutnotsa01xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidnotsa02xml [
	"Source file: sun/valid/not-sa02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa02xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa02xml
						documentURI: 'valid/not-sa02.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutnotsa02xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidnotsa03xml [
	"Source file: sun/valid/not-sa03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa03xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa03xml
						documentURI: 'valid/not-sa03.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutnotsa03xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidnotsa04xml [
	"Source file: sun/valid/not-sa04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa04xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa04xml
						documentURI: 'valid/not-sa04.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutnotsa04xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidoptionalxml [
	"Source file: sun/valid/optional.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidoptionalxml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidoptionalxml
						documentURI: 'valid/optional.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutoptionalxml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidpe00xml [
	"Source file: sun/valid/pe00.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidpe00xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidpe00xml
						documentURI: 'valid/pe00.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutpe00xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidpe01xml [
	"Source file: sun/valid/pe01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidpe01xml.
	self
		shouldnt: [
			[self
				parse: self class sourcevalidpe01xml
				documentURI: 'valid/pe01.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidpe02xml [
	"Source file: sun/valid/pe02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidpe02xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidpe02xml
						documentURI: 'valid/pe02.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutpe02xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidpe03xml [
	"Source file: sun/valid/pe03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidpe03xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidpe03xml
						documentURI: 'valid/pe03.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutpe03xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidrequired00xml [
	"Source file: sun/valid/required00.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidrequired00xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidrequired00xml
						documentURI: 'valid/required00.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutrequired00xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidsa01xml [
	"Source file: sun/valid/sa01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa01xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa01xml
						documentURI: 'valid/sa01.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutsa01xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidsa02xml [
	"Source file: sun/valid/sa02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa02xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa02xml
						documentURI: 'valid/sa02.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutsa02xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidsa03xml [
	"Source file: sun/valid/sa03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa03xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa03xml
						documentURI: 'valid/sa03.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutsa03xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidsa04xml [
	"Source file: sun/valid/sa04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa04xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa04xml
						documentURI: 'valid/sa04.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutsa04xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidsa05xml [
	"Source file: sun/valid/sa05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa05xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa05xml
						documentURI: 'valid/sa05.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutsa05xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidsgml01xml [
	"Source file: sun/valid/sgml01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsgml01xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsgml01xml
						documentURI: 'valid/sgml01.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutsgml01xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidvlang01xml [
	"Source file: sun/valid/v-lang01.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidvlang01xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidvlang01xml
						documentURI: 'valid/v-lang01.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutvlang01xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidvlang02xml [
	"Source file: sun/valid/v-lang02.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidvlang02xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidvlang02xml
						documentURI: 'valid/v-lang02.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutvlang02xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidvlang03xml [
	"Source file: sun/valid/v-lang03.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidvlang03xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidvlang03xml
						documentURI: 'valid/v-lang03.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutvlang03xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidvlang04xml [
	"Source file: sun/valid/v-lang04.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidvlang04xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidvlang04xml
						documentURI: 'valid/v-lang04.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutvlang04xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidvlang05xml [
	"Source file: sun/valid/v-lang05.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidvlang05xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidvlang05xml
						documentURI: 'valid/v-lang05.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutvlang05xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTest >> testvalidvlang06xml [
	"Source file: sun/valid/v-lang06.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidvlang06xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidvlang06xml
						documentURI: 'valid/v-lang06.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidoutvlang06xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]
