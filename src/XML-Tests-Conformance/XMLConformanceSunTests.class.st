Class {
	#name : #XMLConformanceSunTests,
	#superclass : #XMLConformanceTests,
	#category : #'XML-Tests-Conformance'
}

{ #category : #accessing }
XMLConformanceSunTests class >> skippableTests [
	^ #( testinvalidattr04xml testinvalidattr13xml testinvalidattr14xml testinvalidattr15xml testinvalidattr16xml testinvaliddtd02xml testinvalidel04xml testinvalidid05xml testinvalidnotsa01xml testinvalidnotsa04xml testinvalidnotsa05xml testinvalidnotsa06xml testinvalidnotsa07xml testinvalidnotsa09xml testinvalidnotsa10xml testinvalidnotsa11xml testinvalidnotsa12xml testinvalidnotsa13xml testnotwfnotsa03xml )
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidattr01xml [
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
XMLConformanceSunTests class >> sourceinvalidattr02xml [
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
XMLConformanceSunTests class >> sourceinvalidattr03xml [
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
XMLConformanceSunTests class >> sourceinvalidattr04xml [
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
XMLConformanceSunTests class >> sourceinvalidattr05xml [
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
XMLConformanceSunTests class >> sourceinvalidattr06xml [
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
XMLConformanceSunTests class >> sourceinvalidattr07xml [
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
XMLConformanceSunTests class >> sourceinvalidattr08xml [
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
XMLConformanceSunTests class >> sourceinvalidattr09xml [
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
XMLConformanceSunTests class >> sourceinvalidattr10xml [
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
XMLConformanceSunTests class >> sourceinvalidattr11xml [
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
XMLConformanceSunTests class >> sourceinvalidattr12xml [
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
XMLConformanceSunTests class >> sourceinvalidattr13xml [
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
XMLConformanceSunTests class >> sourceinvalidattr14xml [
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
XMLConformanceSunTests class >> sourceinvalidattr15xml [
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
XMLConformanceSunTests class >> sourceinvalidattr16xml [
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
XMLConformanceSunTests class >> sourceinvaliddtd01xml [
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
XMLConformanceSunTests class >> sourceinvaliddtd02xml [
	"Source file: sun/invalid/dtd02.xml"

	^ '<!DOCTYPE paper [
<!ELEMENT paper EMPTY>
<!ENTITY Brittannica SYSTEM "http://www.eb.com" NDATA Encyclopaedia>
]>
<paper/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvaliddtd03xml [
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
XMLConformanceSunTests class >> sourceinvaliddtd06xml [
	"Source file: sun/invalid/dtd06.xml"

	^ '<!DOCTYPE root [
    <!-- reference to undefined PE -->
    %undefined;
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidel01xml [
	"Source file: sun/invalid/el01.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root ANY>
]>
<root> <undeclared/> </root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidel02xml [
	"Source file: sun/invalid/el02.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
]>
<root><root/></root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidel03xml [
	"Source file: sun/invalid/el03.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root (#PCDATA|root)*>
<!ELEMENT exception (#PCDATA)>
]>
<root>this is ok <exception>this isn''t</exception> </root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidel04xml [
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
XMLConformanceSunTests class >> sourceinvalidel05xml [
	"Source file: sun/invalid/el05.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root (#PCDATA|repeat-till-done|repeat-till-done)*>
<!ELEMENT repeat-till-done (#PCDATA)>
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidel06xml [
	"Source file: sun/invalid/el06.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
    <!-- in case parsers special-case builtin entities incorrectly -->
]>
<root>&amp;</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidemptyxml [
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
XMLConformanceSunTests class >> sourceinvalidid01xml [
	"Source file: sun/invalid/id01.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/sa.dtd">

<!-- values of type ID must match "name" -->

<root>
    <attributes id="42a"/>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidid02xml [
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
XMLConformanceSunTests class >> sourceinvalidid03xml [
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
XMLConformanceSunTests class >> sourceinvalidid04xml [
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
XMLConformanceSunTests class >> sourceinvalidid05xml [
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
XMLConformanceSunTests class >> sourceinvalidid06xml [
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
XMLConformanceSunTests class >> sourceinvalidid07xml [
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
XMLConformanceSunTests class >> sourceinvalidid08xml [
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
XMLConformanceSunTests class >> sourceinvalidid09xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa01xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa02xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa04xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa05xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa06xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa07xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa08xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa09xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa10xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa11xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa12xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa13xml [
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
XMLConformanceSunTests class >> sourceinvalidnotsa14xml [
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
XMLConformanceSunTests class >> sourceinvalidoptional01xml [
	"Source file: sun/invalid/optional01.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once></once>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional02xml [
	"Source file: sun/invalid/optional02.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once><e/><e/></once>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional03xml [
	"Source file: sun/invalid/optional03.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <twice></twice>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional04xml [
	"Source file: sun/invalid/optional04.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <twice><e/><e/><e/></twice>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional05xml [
	"Source file: sun/invalid/optional05.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-a></once-or-twice-a>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional06xml [
	"Source file: sun/invalid/optional06.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-b></once-or-twice-b>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional07xml [
	"Source file: sun/invalid/optional07.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-c></once-or-twice-c>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional08xml [
	"Source file: sun/invalid/optional08.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-d></once-or-twice-d>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional09xml [
	"Source file: sun/invalid/optional09.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-e></once-or-twice-e>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional10xml [
	"Source file: sun/invalid/optional10.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-a><e/><e/><e/></once-or-twice-a>
</root>


'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional11xml [
	"Source file: sun/invalid/optional11.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-b><e/><e/><e/></once-or-twice-b>
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional12xml [
	"Source file: sun/invalid/optional12.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-c><e/><e/><e/></once-or-twice-c>
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional13xml [
	"Source file: sun/invalid/optional13.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-d><e/><e/><e/></once-or-twice-d>
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional14xml [
	"Source file: sun/invalid/optional14.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-e><e/><e/><e/></once-or-twice-e>
</root>



'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional20xml [
	"Source file: sun/invalid/optional20.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-a></once-or-twice-a>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional21xml [
	"Source file: sun/invalid/optional21.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-b></once-or-twice-b>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional22xml [
	"Source file: sun/invalid/optional22.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-c></once-or-twice-c>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional23xml [
	"Source file: sun/invalid/optional23.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-d></once-or-twice-d>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional24xml [
	"Source file: sun/invalid/optional24.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-e></once-or-twice-e>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidoptional25xml [
	"Source file: sun/invalid/optional25.xml"

	^ '<!DOCTYPE root SYSTEM "../valid/dtdtest.dtd">
<root>
    <once-or-twice-e>No text allowed!</once-or-twice-e>
</root>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidrequired00xml [
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
XMLConformanceSunTests class >> sourceinvalidrequired01xml [
	"Source file: sun/invalid/required01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
]>

<root xml:space=''preserve''/>

    <!-- all attributes must be declared -->
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidrequired02xml [
	"Source file: sun/invalid/required02.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>
]>

<root xml:lang=''en''/>

    <!-- all attributes must be declared -->

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourceinvalidrootxml [
	"Source file: sun/invalid/root.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE attributes SYSTEM "../valid/sa.dtd">

<!-- the name in the dtd must match the element type of the root element -->
    
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfattlist01xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist02xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist03xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist04xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist05xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist06xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist07xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist08xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist09xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist10xml [
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
XMLConformanceSunTests class >> sourcenotwfattlist11xml [
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
XMLConformanceSunTests class >> sourcenotwfcond01xml [
	"Source file: sun/not-wf/cond01.xml"

	^ '<!DOCTYPE root SYSTEM "cond.dtd" [
    <!ENTITY % MAYBE "CDATA">
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfcond02xml [
	"Source file: sun/not-wf/cond02.xml"

	^ '<!DOCTYPE root SYSTEM "cond.dtd" [
    <!ENTITY % MAYBE "">
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfconddtd [
	"Source file: sun/not-wf/cond.dtd"

	^ '<!-- test conditional sections -->
<!ENTITY % MAYBE "IGNORE">
<![%MAYBE;[ <!ENTITY root EMTPY> ]]>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfcontent01xml [
	"Source file: sun/not-wf/content01.xml"

	^ '<!DOCTYPE root [
    <!-- no whitespace before ''?'', ''*'', ''+'' -->
    <!ELEMENT root ((root) ?)>
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfcontent02xml [
	"Source file: sun/not-wf/content02.xml"

	^ '<!DOCTYPE root [
    <!-- no whitespace before ''?'', ''*'', ''+'' -->
    <!ELEMENT root ((root) *)>
]>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfcontent03xml [
	"Source file: sun/not-wf/content03.xml"

	^ '<!DOCTYPE root [
    <!-- no whitespace before ''?'', ''*'', ''+'' -->
    <!ELEMENT root (root +)>
]>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfdecl01ent [
	"Source file: sun/not-wf/decl01.ent"

	^ '<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<!-- only documents may have standalone decls -->
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfdecl01xml [
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
XMLConformanceSunTests class >> sourcenotwfdtd00xml [
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
XMLConformanceSunTests class >> sourcenotwfdtd01xml [
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
XMLConformanceSunTests class >> sourcenotwfdtd02xml [
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
XMLConformanceSunTests class >> sourcenotwfdtd03xml [
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
XMLConformanceSunTests class >> sourcenotwfdtd04xml [
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
XMLConformanceSunTests class >> sourcenotwfdtd05xml [
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
XMLConformanceSunTests class >> sourcenotwfdtd07dtd [
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
XMLConformanceSunTests class >> sourcenotwfdtd07xml [
	"Source file: sun/not-wf/dtd07.xml"

	^ '<!DOCTYPE root SYSTEM "dtd07.dtd" [
    <!ELEMENT root EMPTY>
]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfelement00xml [
	"Source file: sun/not-wf/element00.xml"

	^ '<root>
    Incomplete end tag.
</ro'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfelement01xml [
	"Source file: sun/not-wf/element01.xml"

	^ '<root>
    Incomplete end tag.
</root'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfelement02xml [
	"Source file: sun/not-wf/element02.xml"

	^ '<!DOCTYPE html [ <!ELEMENT html ANY> ]>
<html>
    <% @ LANGUAGE="VBSCRIPT" %>
</html>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfelement03xml [
	"Source file: sun/not-wf/element03.xml"

	^ '<!DOCTYPE html [ <!ELEMENT html ANY> ]>
<html>
    <% document.println ("hello, world"); %>
</html>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfelement04xml [
	"Source file: sun/not-wf/element04.xml"

	^ '<!DOCTYPE root [ <!ELEMENT root ANY> ]>
<root>
    <!ELEMENT foo EMPTY>
</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfencoding01xml [
	"Source file: sun/not-wf/encoding01.xml"

	^ '<?xml version="1.0" encoding=" utf-8"?>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfencoding02xml [
	"Source file: sun/not-wf/encoding02.xml"

	^ '<?xml version="1.0" encoding="a/b"?>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfencoding03xml [
	"Source file: sun/not-wf/encoding03.xml"

	^ '<?xml version="1.0" encoding="just&#41;word"?>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfencoding04xml [
	"Source file: sun/not-wf/encoding04.xml"

	^ '<?xml version="1.0" encoding="utf:8"?>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfencoding05xml [
	"Source file: sun/not-wf/encoding05.xml"

	^ '<?xml version="1.0" encoding="@import(sys-encoding)"?>
<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfencoding06xml [
	"Source file: sun/not-wf/encoding06.xml"

	^ '<?xml version="1.0" encoding="XYZ+999"?>

<!-- WF ... but illegal encoding name, also a fatal error --> 

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfencoding07xml [
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
XMLConformanceSunTests class >> sourcenotwfnotsa03xml [
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
XMLConformanceSunTests class >> sourcenotwfpixml [
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
XMLConformanceSunTests class >> sourcenotwfpubid01xml [
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
XMLConformanceSunTests class >> sourcenotwfpubid02xml [
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
XMLConformanceSunTests class >> sourcenotwfpubid03xml [
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
XMLConformanceSunTests class >> sourcenotwfpubid04xml [
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
XMLConformanceSunTests class >> sourcenotwfpubid05xml [
	"Source file: sun/not-wf/pubid05.xml"

	^ '<!DOCTYPE root [

    <!-- SGML-ism: publid ID without system ID -->

    <!ENTITY e PUBLIC "this is not allowed">
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml01xml [
	"Source file: sun/not-wf/sgml01.xml"

	^ '<!DOCTYPE root [
    <!ELEMENT root EMPTY>

    <!-- SGML-ism:  omitted end tag -->
]>

<root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml02xml [
	"Source file: sun/not-wf/sgml02.xml"

	^ ' <?xml version="1.0"?>
    <!-- SGML-ism:  XML PI not at beginning -->
<!DOCTYPE root [ <!ELEMENT root EMPTY> ]>
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml03xml [
	"Source file: sun/not-wf/sgml03.xml"

	^ '<!DOCTYPE root [ <!ELEMENT root EMPTY> ]>

    <!-- SGML-ism:  -- inside comment -->
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml04xml [
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
XMLConformanceSunTests class >> sourcenotwfsgml05xml [
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
XMLConformanceSunTests class >> sourcenotwfsgml06xml [
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
XMLConformanceSunTests class >> sourcenotwfsgml07xml [
	"Source file: sun/not-wf/sgml07.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  omitted tag minimzation spec -->
    <!ELEMENT root - o EMPTY>
]>

<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml08xml [
	"Source file: sun/not-wf/sgml08.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  omitted tag minimzation spec -->
    <!ELEMENT root - - EMPTY>
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml09xml [
	"Source file: sun/not-wf/sgml09.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  exception spec -->

    <!ELEMENT footnote (para*) -footnote>
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml10xml [
	"Source file: sun/not-wf/sgml10.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  exception spec -->
    <!ELEMENT section (header,(para|section))* +(annotation|todo)>
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml11xml [
	"Source file: sun/not-wf/sgml11.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  CDATA content type -->
    <!ELEMENT ROOT CDATA>
]>

<root/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml12xml [
	"Source file: sun/not-wf/sgml12.xml"

	^ '<!DOCTYPE root [
    <!-- SGML-ism:  RCDATA content type -->
    <!ELEMENT ROOT RCDATA>
]>

<root/>


'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcenotwfsgml13xml [
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
XMLConformanceSunTests class >> sourcenotwfuri01xml [
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
XMLConformanceSunTests class >> sourcevaliddtd00xml [
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
XMLConformanceSunTests class >> sourcevaliddtd01xml [
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
XMLConformanceSunTests class >> sourcevaliddtdtestdtd [
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
XMLConformanceSunTests class >> sourcevalidelementxml [
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
XMLConformanceSunTests class >> sourcevalidext01ent [
	"Source file: sun/valid/ext01.ent"

	^ '<?xml encoding="UTF-8"?>
<!-- this is really ascii ... ;- -->
<foo/>

<bar/>

<is> "dumber than a bag full of hammers" </is>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidext01xml [
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
XMLConformanceSunTests class >> sourcevalidext02xml [
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
XMLConformanceSunTests class >> sourcevalidnotation01dtd [
	"Source file: sun/valid/notation01.dtd"

	^ '<?xml version="1.0" encoding="UTF-8"?>

<!NOTATION GIF PUBLIC
    "+//ISBN 0-7923-9432-1::Graphic Notation//NOTATION
     CompuServe Graphic Interchange Format//EN">

<!ELEMENT test (#PCDATA) >

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidnotation01xml [
	"Source file: sun/valid/notation01.xml"

	^ '<?xml version="1.0"?>
<!DOCTYPE test SYSTEM "notation01.dtd" [
    <!ENTITY applydsssl SYSTEM "applydsssl.gif" NDATA GIF>
]>
<test>test</test>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidnotsa01xml [
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
XMLConformanceSunTests class >> sourcevalidnotsa02xml [
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
XMLConformanceSunTests class >> sourcevalidnotsa03xml [
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
XMLConformanceSunTests class >> sourcevalidnotsa04xml [
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
XMLConformanceSunTests class >> sourcevalidnullent [
	"Source file: sun/valid/null.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidoptionalxml [
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
XMLConformanceSunTests class >> sourcevalidpe00dtd [
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
XMLConformanceSunTests class >> sourcevalidpe00xml [
	"Source file: sun/valid/pe00.xml"

	^ '<!DOCTYPE root SYSTEM "pe00.dtd">
<root>&book;</root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidpe01dtd [
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
XMLConformanceSunTests class >> sourcevalidpe01ent [
	"Source file: sun/valid/pe01.ent"

	^ 'This is not a legal parameter entity, because
it does not match the "markupdecl" production.
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidpe01xml [
	"Source file: sun/valid/pe01.xml"

	^ '<!DOCTYPE root SYSTEM "pe01.dtd">
<root/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidpe02xml [
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
XMLConformanceSunTests class >> sourcevalidpe03xml [
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
XMLConformanceSunTests class >> sourcevalidrequired00xml [
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
XMLConformanceSunTests class >> sourcevalidsa01xml [
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
XMLConformanceSunTests class >> sourcevalidsa02xml [
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
XMLConformanceSunTests class >> sourcevalidsa03xml [
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
XMLConformanceSunTests class >> sourcevalidsa04xml [
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
XMLConformanceSunTests class >> sourcevalidsa05xml [
	"Source file: sun/valid/sa05.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>

<!DOCTYPE root SYSTEM "sa.dtd">

<root><child>
    No whitespace before or after this standalone element.
</child></root>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidsadtd [
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
XMLConformanceSunTests class >> sourcevalidsgml01xml [
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
XMLConformanceSunTests class >> sourcevalidvlang01xml [
	"Source file: sun/valid/v-lang01.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="en"/>
'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidvlang02xml [
	"Source file: sun/valid/v-lang02.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="en-IN"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidvlang03xml [
	"Source file: sun/valid/v-lang03.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="i-klingon-whorf"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidvlang04xml [
	"Source file: sun/valid/v-lang04.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="x-dialect-valleygirl"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidvlang05xml [
	"Source file: sun/valid/v-lang05.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="DE"/>

'
]

{ #category : #'xml source' }
XMLConformanceSunTests class >> sourcevalidvlang06xml [
	"Source file: sun/valid/v-lang06.xml"

	^ '<!DOCTYPE root [
<!ELEMENT root EMPTY>
<!ATTLIST root xml:lang CDATA #IMPLIED>
]>
<root xml:lang="X-Java"/>

'
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr01xml [
	"Source file: sun/invalid/attr01.xml"

	(self isSkippableTest: #testinvalidattr01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr01xml
				documentURI: 'invalid/attr01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr02xml [
	"Source file: sun/invalid/attr02.xml"

	(self isSkippableTest: #testinvalidattr02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr02xml
				documentURI: 'invalid/attr02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr03xml [
	"Source file: sun/invalid/attr03.xml"

	(self isSkippableTest: #testinvalidattr03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr03xml
				documentURI: 'invalid/attr03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr04xml [
	"Source file: sun/invalid/attr04.xml"

	(self isSkippableTest: #testinvalidattr04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr04xml
				documentURI: 'invalid/attr04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr05xml [
	"Source file: sun/invalid/attr05.xml"

	(self isSkippableTest: #testinvalidattr05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr05xml
				documentURI: 'invalid/attr05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr06xml [
	"Source file: sun/invalid/attr06.xml"

	(self isSkippableTest: #testinvalidattr06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr06xml
				documentURI: 'invalid/attr06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr07xml [
	"Source file: sun/invalid/attr07.xml"

	(self isSkippableTest: #testinvalidattr07xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr07xml
				documentURI: 'invalid/attr07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr08xml [
	"Source file: sun/invalid/attr08.xml"

	(self isSkippableTest: #testinvalidattr08xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr08xml
				documentURI: 'invalid/attr08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr09xml [
	"Source file: sun/invalid/attr09.xml"

	(self isSkippableTest: #testinvalidattr09xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr09xml
				documentURI: 'invalid/attr09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr10xml [
	"Source file: sun/invalid/attr10.xml"

	(self isSkippableTest: #testinvalidattr10xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr10xml
				documentURI: 'invalid/attr10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr11xml [
	"Source file: sun/invalid/attr11.xml"

	(self isSkippableTest: #testinvalidattr11xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr11xml
				documentURI: 'invalid/attr11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr12xml [
	"Source file: sun/invalid/attr12.xml"

	(self isSkippableTest: #testinvalidattr12xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr12xml
				documentURI: 'invalid/attr12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr13xml [
	"Source file: sun/invalid/attr13.xml"

	(self isSkippableTest: #testinvalidattr13xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr13xml
				documentURI: 'invalid/attr13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr14xml [
	"Source file: sun/invalid/attr14.xml"

	(self isSkippableTest: #testinvalidattr14xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr14xml
				documentURI: 'invalid/attr14.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr15xml [
	"Source file: sun/invalid/attr15.xml"

	(self isSkippableTest: #testinvalidattr15xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr15xml
				documentURI: 'invalid/attr15.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidattr16xml [
	"Source file: sun/invalid/attr16.xml"

	(self isSkippableTest: #testinvalidattr16xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidattr16xml
				documentURI: 'invalid/attr16.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvaliddtd01xml [
	"Source file: sun/invalid/dtd01.xml"

	(self isSkippableTest: #testinvaliddtd01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvaliddtd01xml
				documentURI: 'invalid/dtd01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvaliddtd02xml [
	"Source file: sun/invalid/dtd02.xml"

	(self isSkippableTest: #testinvaliddtd02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvaliddtd02xml
				documentURI: 'invalid/dtd02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvaliddtd03xml [
	"Source file: sun/invalid/dtd03.xml"

	(self isSkippableTest: #testinvaliddtd03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvaliddtd03xml
				documentURI: 'invalid/dtd03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvaliddtd06xml [
	"Source file: sun/invalid/dtd06.xml"

	(self isSkippableTest: #testinvaliddtd06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvaliddtd06xml
				documentURI: 'invalid/dtd06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidel01xml [
	"Source file: sun/invalid/el01.xml"

	(self isSkippableTest: #testinvalidel01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidel01xml
				documentURI: 'invalid/el01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidel02xml [
	"Source file: sun/invalid/el02.xml"

	(self isSkippableTest: #testinvalidel02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidel02xml
				documentURI: 'invalid/el02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidel03xml [
	"Source file: sun/invalid/el03.xml"

	(self isSkippableTest: #testinvalidel03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidel03xml
				documentURI: 'invalid/el03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidel04xml [
	"Source file: sun/invalid/el04.xml"

	(self isSkippableTest: #testinvalidel04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidel04xml
				documentURI: 'invalid/el04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidel05xml [
	"Source file: sun/invalid/el05.xml"

	(self isSkippableTest: #testinvalidel05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidel05xml
				documentURI: 'invalid/el05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidel06xml [
	"Source file: sun/invalid/el06.xml"

	(self isSkippableTest: #testinvalidel06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidel06xml
				documentURI: 'invalid/el06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidemptyxml [
	"Source file: sun/invalid/empty.xml"

	(self isSkippableTest: #testinvalidemptyxml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidemptyxml
				documentURI: 'invalid/empty.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidid01xml [
	"Source file: sun/invalid/id01.xml"

	(self isSkippableTest: #testinvalidid01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidid01xml
				documentURI: 'invalid/id01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidid02xml [
	"Source file: sun/invalid/id02.xml"

	(self isSkippableTest: #testinvalidid02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidid02xml
				documentURI: 'invalid/id02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidid03xml [
	"Source file: sun/invalid/id03.xml"

	(self isSkippableTest: #testinvalidid03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidid03xml
				documentURI: 'invalid/id03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidid04xml [
	"Source file: sun/invalid/id04.xml"

	(self isSkippableTest: #testinvalidid04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidid04xml
				documentURI: 'invalid/id04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidid05xml [
	"Source file: sun/invalid/id05.xml"

	(self isSkippableTest: #testinvalidid05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidid05xml
				documentURI: 'invalid/id05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidid06xml [
	"Source file: sun/invalid/id06.xml"

	(self isSkippableTest: #testinvalidid06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidid06xml
				documentURI: 'invalid/id06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidid07xml [
	"Source file: sun/invalid/id07.xml"

	(self isSkippableTest: #testinvalidid07xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidid07xml
				documentURI: 'invalid/id07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidid08xml [
	"Source file: sun/invalid/id08.xml"

	(self isSkippableTest: #testinvalidid08xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidid08xml
				documentURI: 'invalid/id08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidid09xml [
	"Source file: sun/invalid/id09.xml"

	(self isSkippableTest: #testinvalidid09xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidid09xml
				documentURI: 'invalid/id09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa01xml [
	"Source file: sun/invalid/not-sa01.xml"

	(self isSkippableTest: #testinvalidnotsa01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa01xml
				documentURI: 'invalid/not-sa01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa02xml [
	"Source file: sun/invalid/not-sa02.xml"

	(self isSkippableTest: #testinvalidnotsa02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa02xml
				documentURI: 'invalid/not-sa02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa04xml [
	"Source file: sun/invalid/not-sa04.xml"

	(self isSkippableTest: #testinvalidnotsa04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa04xml
				documentURI: 'invalid/not-sa04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa05xml [
	"Source file: sun/invalid/not-sa05.xml"

	(self isSkippableTest: #testinvalidnotsa05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa05xml
				documentURI: 'invalid/not-sa05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa06xml [
	"Source file: sun/invalid/not-sa06.xml"

	(self isSkippableTest: #testinvalidnotsa06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa06xml
				documentURI: 'invalid/not-sa06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa07xml [
	"Source file: sun/invalid/not-sa07.xml"

	(self isSkippableTest: #testinvalidnotsa07xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa07xml
				documentURI: 'invalid/not-sa07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa08xml [
	"Source file: sun/invalid/not-sa08.xml"

	(self isSkippableTest: #testinvalidnotsa08xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa08xml
				documentURI: 'invalid/not-sa08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa09xml [
	"Source file: sun/invalid/not-sa09.xml"

	(self isSkippableTest: #testinvalidnotsa09xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa09xml
				documentURI: 'invalid/not-sa09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa10xml [
	"Source file: sun/invalid/not-sa10.xml"

	(self isSkippableTest: #testinvalidnotsa10xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa10xml
				documentURI: 'invalid/not-sa10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa11xml [
	"Source file: sun/invalid/not-sa11.xml"

	(self isSkippableTest: #testinvalidnotsa11xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa11xml
				documentURI: 'invalid/not-sa11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa12xml [
	"Source file: sun/invalid/not-sa12.xml"

	(self isSkippableTest: #testinvalidnotsa12xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa12xml
				documentURI: 'invalid/not-sa12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa13xml [
	"Source file: sun/invalid/not-sa13.xml"

	(self isSkippableTest: #testinvalidnotsa13xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa13xml
				documentURI: 'invalid/not-sa13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidnotsa14xml [
	"Source file: sun/invalid/not-sa14.xml"

	(self isSkippableTest: #testinvalidnotsa14xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa14xml
				documentURI: 'invalid/not-sa14.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional01xml [
	"Source file: sun/invalid/optional01.xml"

	(self isSkippableTest: #testinvalidoptional01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional01xml
				documentURI: 'invalid/optional01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional02xml [
	"Source file: sun/invalid/optional02.xml"

	(self isSkippableTest: #testinvalidoptional02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional02xml
				documentURI: 'invalid/optional02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional03xml [
	"Source file: sun/invalid/optional03.xml"

	(self isSkippableTest: #testinvalidoptional03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional03xml
				documentURI: 'invalid/optional03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional04xml [
	"Source file: sun/invalid/optional04.xml"

	(self isSkippableTest: #testinvalidoptional04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional04xml
				documentURI: 'invalid/optional04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional05xml [
	"Source file: sun/invalid/optional05.xml"

	(self isSkippableTest: #testinvalidoptional05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional05xml
				documentURI: 'invalid/optional05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional06xml [
	"Source file: sun/invalid/optional06.xml"

	(self isSkippableTest: #testinvalidoptional06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional06xml
				documentURI: 'invalid/optional06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional07xml [
	"Source file: sun/invalid/optional07.xml"

	(self isSkippableTest: #testinvalidoptional07xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional07xml
				documentURI: 'invalid/optional07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional08xml [
	"Source file: sun/invalid/optional08.xml"

	(self isSkippableTest: #testinvalidoptional08xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional08xml
				documentURI: 'invalid/optional08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional09xml [
	"Source file: sun/invalid/optional09.xml"

	(self isSkippableTest: #testinvalidoptional09xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional09xml
				documentURI: 'invalid/optional09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional10xml [
	"Source file: sun/invalid/optional10.xml"

	(self isSkippableTest: #testinvalidoptional10xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional10xml
				documentURI: 'invalid/optional10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional11xml [
	"Source file: sun/invalid/optional11.xml"

	(self isSkippableTest: #testinvalidoptional11xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional11xml
				documentURI: 'invalid/optional11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional12xml [
	"Source file: sun/invalid/optional12.xml"

	(self isSkippableTest: #testinvalidoptional12xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional12xml
				documentURI: 'invalid/optional12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional13xml [
	"Source file: sun/invalid/optional13.xml"

	(self isSkippableTest: #testinvalidoptional13xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional13xml
				documentURI: 'invalid/optional13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional14xml [
	"Source file: sun/invalid/optional14.xml"

	(self isSkippableTest: #testinvalidoptional14xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional14xml
				documentURI: 'invalid/optional14.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional20xml [
	"Source file: sun/invalid/optional20.xml"

	(self isSkippableTest: #testinvalidoptional20xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional20xml
				documentURI: 'invalid/optional20.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional21xml [
	"Source file: sun/invalid/optional21.xml"

	(self isSkippableTest: #testinvalidoptional21xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional21xml
				documentURI: 'invalid/optional21.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional22xml [
	"Source file: sun/invalid/optional22.xml"

	(self isSkippableTest: #testinvalidoptional22xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional22xml
				documentURI: 'invalid/optional22.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional23xml [
	"Source file: sun/invalid/optional23.xml"

	(self isSkippableTest: #testinvalidoptional23xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional23xml
				documentURI: 'invalid/optional23.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional24xml [
	"Source file: sun/invalid/optional24.xml"

	(self isSkippableTest: #testinvalidoptional24xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional24xml
				documentURI: 'invalid/optional24.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidoptional25xml [
	"Source file: sun/invalid/optional25.xml"

	(self isSkippableTest: #testinvalidoptional25xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidoptional25xml
				documentURI: 'invalid/optional25.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidrequired00xml [
	"Source file: sun/invalid/required00.xml"

	(self isSkippableTest: #testinvalidrequired00xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidrequired00xml
				documentURI: 'invalid/required00.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidrequired01xml [
	"Source file: sun/invalid/required01.xml"

	(self isSkippableTest: #testinvalidrequired01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidrequired01xml
				documentURI: 'invalid/required01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidrequired02xml [
	"Source file: sun/invalid/required02.xml"

	(self isSkippableTest: #testinvalidrequired02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidrequired02xml
				documentURI: 'invalid/required02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testinvalidrootxml [
	"Source file: sun/invalid/root.xml"

	(self isSkippableTest: #testinvalidrootxml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidrootxml
				documentURI: 'invalid/root.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist01xml [
	"Source file: sun/not-wf/attlist01.xml"

	(self isSkippableTest: #testnotwfattlist01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist01xml
				documentURI: 'not-wf/attlist01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist02xml [
	"Source file: sun/not-wf/attlist02.xml"

	(self isSkippableTest: #testnotwfattlist02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist02xml
				documentURI: 'not-wf/attlist02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist03xml [
	"Source file: sun/not-wf/attlist03.xml"

	(self isSkippableTest: #testnotwfattlist03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist03xml
				documentURI: 'not-wf/attlist03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist04xml [
	"Source file: sun/not-wf/attlist04.xml"

	(self isSkippableTest: #testnotwfattlist04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist04xml
				documentURI: 'not-wf/attlist04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist05xml [
	"Source file: sun/not-wf/attlist05.xml"

	(self isSkippableTest: #testnotwfattlist05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist05xml
				documentURI: 'not-wf/attlist05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist06xml [
	"Source file: sun/not-wf/attlist06.xml"

	(self isSkippableTest: #testnotwfattlist06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist06xml
				documentURI: 'not-wf/attlist06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist07xml [
	"Source file: sun/not-wf/attlist07.xml"

	(self isSkippableTest: #testnotwfattlist07xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist07xml
				documentURI: 'not-wf/attlist07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist08xml [
	"Source file: sun/not-wf/attlist08.xml"

	(self isSkippableTest: #testnotwfattlist08xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist08xml
				documentURI: 'not-wf/attlist08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist09xml [
	"Source file: sun/not-wf/attlist09.xml"

	(self isSkippableTest: #testnotwfattlist09xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist09xml
				documentURI: 'not-wf/attlist09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist10xml [
	"Source file: sun/not-wf/attlist10.xml"

	(self isSkippableTest: #testnotwfattlist10xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist10xml
				documentURI: 'not-wf/attlist10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfattlist11xml [
	"Source file: sun/not-wf/attlist11.xml"

	(self isSkippableTest: #testnotwfattlist11xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfattlist11xml
				documentURI: 'not-wf/attlist11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfcond01xml [
	"Source file: sun/not-wf/cond01.xml"

	(self isSkippableTest: #testnotwfcond01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfcond01xml
				documentURI: 'not-wf/cond01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfcond02xml [
	"Source file: sun/not-wf/cond02.xml"

	(self isSkippableTest: #testnotwfcond02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfcond02xml
				documentURI: 'not-wf/cond02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfcontent01xml [
	"Source file: sun/not-wf/content01.xml"

	(self isSkippableTest: #testnotwfcontent01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfcontent01xml
				documentURI: 'not-wf/content01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfcontent02xml [
	"Source file: sun/not-wf/content02.xml"

	(self isSkippableTest: #testnotwfcontent02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfcontent02xml
				documentURI: 'not-wf/content02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfcontent03xml [
	"Source file: sun/not-wf/content03.xml"

	(self isSkippableTest: #testnotwfcontent03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfcontent03xml
				documentURI: 'not-wf/content03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfdecl01xml [
	"Source file: sun/not-wf/decl01.xml"

	(self isSkippableTest: #testnotwfdecl01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfdecl01xml
				documentURI: 'not-wf/decl01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfdtd00xml [
	"Source file: sun/not-wf/dtd00.xml"

	(self isSkippableTest: #testnotwfdtd00xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfdtd00xml
				documentURI: 'not-wf/dtd00.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfdtd01xml [
	"Source file: sun/not-wf/dtd01.xml"

	(self isSkippableTest: #testnotwfdtd01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfdtd01xml
				documentURI: 'not-wf/dtd01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfdtd02xml [
	"Source file: sun/not-wf/dtd02.xml"

	(self isSkippableTest: #testnotwfdtd02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfdtd02xml
				documentURI: 'not-wf/dtd02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfdtd03xml [
	"Source file: sun/not-wf/dtd03.xml"

	(self isSkippableTest: #testnotwfdtd03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfdtd03xml
				documentURI: 'not-wf/dtd03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfdtd04xml [
	"Source file: sun/not-wf/dtd04.xml"

	(self isSkippableTest: #testnotwfdtd04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfdtd04xml
				documentURI: 'not-wf/dtd04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfdtd05xml [
	"Source file: sun/not-wf/dtd05.xml"

	(self isSkippableTest: #testnotwfdtd05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfdtd05xml
				documentURI: 'not-wf/dtd05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfdtd07xml [
	"Source file: sun/not-wf/dtd07.xml"

	(self isSkippableTest: #testnotwfdtd07xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfdtd07xml
				documentURI: 'not-wf/dtd07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfelement00xml [
	"Source file: sun/not-wf/element00.xml"

	(self isSkippableTest: #testnotwfelement00xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfelement00xml
				documentURI: 'not-wf/element00.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfelement01xml [
	"Source file: sun/not-wf/element01.xml"

	(self isSkippableTest: #testnotwfelement01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfelement01xml
				documentURI: 'not-wf/element01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfelement02xml [
	"Source file: sun/not-wf/element02.xml"

	(self isSkippableTest: #testnotwfelement02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfelement02xml
				documentURI: 'not-wf/element02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfelement03xml [
	"Source file: sun/not-wf/element03.xml"

	(self isSkippableTest: #testnotwfelement03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfelement03xml
				documentURI: 'not-wf/element03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfelement04xml [
	"Source file: sun/not-wf/element04.xml"

	(self isSkippableTest: #testnotwfelement04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfelement04xml
				documentURI: 'not-wf/element04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfencoding01xml [
	"Source file: sun/not-wf/encoding01.xml"

	(self isSkippableTest: #testnotwfencoding01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfencoding01xml
				documentURI: 'not-wf/encoding01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfencoding02xml [
	"Source file: sun/not-wf/encoding02.xml"

	(self isSkippableTest: #testnotwfencoding02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfencoding02xml
				documentURI: 'not-wf/encoding02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfencoding03xml [
	"Source file: sun/not-wf/encoding03.xml"

	(self isSkippableTest: #testnotwfencoding03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfencoding03xml
				documentURI: 'not-wf/encoding03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfencoding04xml [
	"Source file: sun/not-wf/encoding04.xml"

	(self isSkippableTest: #testnotwfencoding04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfencoding04xml
				documentURI: 'not-wf/encoding04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfencoding05xml [
	"Source file: sun/not-wf/encoding05.xml"

	(self isSkippableTest: #testnotwfencoding05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfencoding05xml
				documentURI: 'not-wf/encoding05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfencoding06xml [
	"Source file: sun/not-wf/encoding06.xml"

	(self isSkippableTest: #testnotwfencoding06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfencoding06xml
				documentURI: 'not-wf/encoding06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfencoding07xml [
	"Source file: sun/not-wf/encoding07.xml"

	(self isSkippableTest: #testnotwfencoding07xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfencoding07xml
				documentURI: 'not-wf/encoding07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfnotsa03xml [
	"Source file: sun/not-wf/not-sa03.xml"

	(self isSkippableTest: #testnotwfnotsa03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa03xml
				documentURI: 'not-wf/not-sa03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfpixml [
	"Source file: sun/not-wf/pi.xml"

	(self isSkippableTest: #testnotwfpixml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfpixml
				documentURI: 'not-wf/pi.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfpubid01xml [
	"Source file: sun/not-wf/pubid01.xml"

	(self isSkippableTest: #testnotwfpubid01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfpubid01xml
				documentURI: 'not-wf/pubid01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfpubid02xml [
	"Source file: sun/not-wf/pubid02.xml"

	(self isSkippableTest: #testnotwfpubid02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfpubid02xml
				documentURI: 'not-wf/pubid02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfpubid03xml [
	"Source file: sun/not-wf/pubid03.xml"

	(self isSkippableTest: #testnotwfpubid03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfpubid03xml
				documentURI: 'not-wf/pubid03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfpubid04xml [
	"Source file: sun/not-wf/pubid04.xml"

	(self isSkippableTest: #testnotwfpubid04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfpubid04xml
				documentURI: 'not-wf/pubid04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfpubid05xml [
	"Source file: sun/not-wf/pubid05.xml"

	(self isSkippableTest: #testnotwfpubid05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfpubid05xml
				documentURI: 'not-wf/pubid05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml01xml [
	"Source file: sun/not-wf/sgml01.xml"

	(self isSkippableTest: #testnotwfsgml01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml01xml
				documentURI: 'not-wf/sgml01.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml02xml [
	"Source file: sun/not-wf/sgml02.xml"

	(self isSkippableTest: #testnotwfsgml02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml02xml
				documentURI: 'not-wf/sgml02.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml03xml [
	"Source file: sun/not-wf/sgml03.xml"

	(self isSkippableTest: #testnotwfsgml03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml03xml
				documentURI: 'not-wf/sgml03.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml04xml [
	"Source file: sun/not-wf/sgml04.xml"

	(self isSkippableTest: #testnotwfsgml04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml04xml
				documentURI: 'not-wf/sgml04.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml05xml [
	"Source file: sun/not-wf/sgml05.xml"

	(self isSkippableTest: #testnotwfsgml05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml05xml
				documentURI: 'not-wf/sgml05.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml06xml [
	"Source file: sun/not-wf/sgml06.xml"

	(self isSkippableTest: #testnotwfsgml06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml06xml
				documentURI: 'not-wf/sgml06.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml07xml [
	"Source file: sun/not-wf/sgml07.xml"

	(self isSkippableTest: #testnotwfsgml07xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml07xml
				documentURI: 'not-wf/sgml07.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml08xml [
	"Source file: sun/not-wf/sgml08.xml"

	(self isSkippableTest: #testnotwfsgml08xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml08xml
				documentURI: 'not-wf/sgml08.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml09xml [
	"Source file: sun/not-wf/sgml09.xml"

	(self isSkippableTest: #testnotwfsgml09xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml09xml
				documentURI: 'not-wf/sgml09.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml10xml [
	"Source file: sun/not-wf/sgml10.xml"

	(self isSkippableTest: #testnotwfsgml10xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml10xml
				documentURI: 'not-wf/sgml10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml11xml [
	"Source file: sun/not-wf/sgml11.xml"

	(self isSkippableTest: #testnotwfsgml11xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml11xml
				documentURI: 'not-wf/sgml11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml12xml [
	"Source file: sun/not-wf/sgml12.xml"

	(self isSkippableTest: #testnotwfsgml12xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml12xml
				documentURI: 'not-wf/sgml12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfsgml13xml [
	"Source file: sun/not-wf/sgml13.xml"

	(self isSkippableTest: #testnotwfsgml13xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsgml13xml
				documentURI: 'not-wf/sgml13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceSunTests >> testnotwfuri01xml [
	"Source file: sun/not-wf/uri01.xml"

	(self isSkippableTest: #testnotwfuri01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfuri01xml
				documentURI: 'not-wf/uri01.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvaliddtd00xml [
	"Source file: sun/valid/dtd00.xml"

	(self isSkippableTest: #testvaliddtd00xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevaliddtd00xml
				documentURI: 'valid/dtd00.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvaliddtd01xml [
	"Source file: sun/valid/dtd01.xml"

	(self isSkippableTest: #testvaliddtd01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevaliddtd01xml
				documentURI: 'valid/dtd01.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidelementxml [
	"Source file: sun/valid/element.xml"

	(self isSkippableTest: #testvalidelementxml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidelementxml
				documentURI: 'valid/element.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidext01xml [
	"Source file: sun/valid/ext01.xml"

	(self isSkippableTest: #testvalidext01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidext01xml
				documentURI: 'valid/ext01.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidext02xml [
	"Source file: sun/valid/ext02.xml"

	(self isSkippableTest: #testvalidext02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidext02xml
				documentURI: 'valid/ext02.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidnotation01xml [
	"Source file: sun/valid/notation01.xml"

	(self isSkippableTest: #testvalidnotation01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotation01xml
				documentURI: 'valid/notation01.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidnotsa01xml [
	"Source file: sun/valid/not-sa01.xml"

	(self isSkippableTest: #testvalidnotsa01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa01xml
				documentURI: 'valid/not-sa01.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidnotsa02xml [
	"Source file: sun/valid/not-sa02.xml"

	(self isSkippableTest: #testvalidnotsa02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa02xml
				documentURI: 'valid/not-sa02.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidnotsa03xml [
	"Source file: sun/valid/not-sa03.xml"

	(self isSkippableTest: #testvalidnotsa03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa03xml
				documentURI: 'valid/not-sa03.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidnotsa04xml [
	"Source file: sun/valid/not-sa04.xml"

	(self isSkippableTest: #testvalidnotsa04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa04xml
				documentURI: 'valid/not-sa04.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidoptionalxml [
	"Source file: sun/valid/optional.xml"

	(self isSkippableTest: #testvalidoptionalxml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidoptionalxml
				documentURI: 'valid/optional.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidpe00xml [
	"Source file: sun/valid/pe00.xml"

	(self isSkippableTest: #testvalidpe00xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidpe00xml
				documentURI: 'valid/pe00.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidpe01xml [
	"Source file: sun/valid/pe01.xml"

	(self isSkippableTest: #testvalidpe01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidpe01xml
				documentURI: 'valid/pe01.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidpe02xml [
	"Source file: sun/valid/pe02.xml"

	(self isSkippableTest: #testvalidpe02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidpe02xml
				documentURI: 'valid/pe02.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidpe03xml [
	"Source file: sun/valid/pe03.xml"

	(self isSkippableTest: #testvalidpe03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidpe03xml
				documentURI: 'valid/pe03.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidrequired00xml [
	"Source file: sun/valid/required00.xml"

	(self isSkippableTest: #testvalidrequired00xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidrequired00xml
				documentURI: 'valid/required00.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidsa01xml [
	"Source file: sun/valid/sa01.xml"

	(self isSkippableTest: #testvalidsa01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa01xml
				documentURI: 'valid/sa01.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidsa02xml [
	"Source file: sun/valid/sa02.xml"

	(self isSkippableTest: #testvalidsa02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa02xml
				documentURI: 'valid/sa02.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidsa03xml [
	"Source file: sun/valid/sa03.xml"

	(self isSkippableTest: #testvalidsa03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa03xml
				documentURI: 'valid/sa03.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidsa04xml [
	"Source file: sun/valid/sa04.xml"

	(self isSkippableTest: #testvalidsa04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa04xml
				documentURI: 'valid/sa04.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidsa05xml [
	"Source file: sun/valid/sa05.xml"

	(self isSkippableTest: #testvalidsa05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa05xml
				documentURI: 'valid/sa05.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidsgml01xml [
	"Source file: sun/valid/sgml01.xml"

	(self isSkippableTest: #testvalidsgml01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsgml01xml
				documentURI: 'valid/sgml01.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidvlang01xml [
	"Source file: sun/valid/v-lang01.xml"

	(self isSkippableTest: #testvalidvlang01xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidvlang01xml
				documentURI: 'valid/v-lang01.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidvlang02xml [
	"Source file: sun/valid/v-lang02.xml"

	(self isSkippableTest: #testvalidvlang02xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidvlang02xml
				documentURI: 'valid/v-lang02.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidvlang03xml [
	"Source file: sun/valid/v-lang03.xml"

	(self isSkippableTest: #testvalidvlang03xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidvlang03xml
				documentURI: 'valid/v-lang03.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidvlang04xml [
	"Source file: sun/valid/v-lang04.xml"

	(self isSkippableTest: #testvalidvlang04xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidvlang04xml
				documentURI: 'valid/v-lang04.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidvlang05xml [
	"Source file: sun/valid/v-lang05.xml"

	(self isSkippableTest: #testvalidvlang05xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidvlang05xml
				documentURI: 'valid/v-lang05.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceSunTests >> testvalidvlang06xml [
	"Source file: sun/valid/v-lang06.xml"

	(self isSkippableTest: #testvalidvlang06xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidvlang06xml
				documentURI: 'valid/v-lang06.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]
