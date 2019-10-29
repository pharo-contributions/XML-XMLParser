Class {
	#name : #XMLConformanceExpatTest,
	#superclass : #XMLConformanceTest,
	#category : #'XML-Parser-Tests-Conformance'
}

{ #category : #accessing }
XMLConformanceExpatTest class >> skippableTests [
	^ #( testnotwfsa140xml testnotwfsa141xml )
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourceinvalid002ent [
	"Source file: xmltest/invalid/002.ent"

	^ '<!ENTITY % e "(#PCDATA">
<!ELEMENT doc %e;)>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourceinvalid002xml [
	"Source file: xmltest/invalid/002.xml"

	^ '<!DOCTYPE doc SYSTEM "002.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourceinvalid005ent [
	"Source file: xmltest/invalid/005.ent"

	^ '<!ENTITY % e ">">
<!ELEMENT doc (#PCDATA) %e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourceinvalid005xml [
	"Source file: xmltest/invalid/005.xml"

	^ '<!DOCTYPE doc SYSTEM "005.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourceinvalid006ent [
	"Source file: xmltest/invalid/006.ent"

	^ '<!ENTITY % e "(#PCDATA)>">
<!ELEMENT doc %e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourceinvalid006xml [
	"Source file: xmltest/invalid/006.xml"

	^ '<!DOCTYPE doc SYSTEM "006.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourceinvalidnotsa022ent [
	"Source file: xmltest/invalid/not-sa/022.ent"

	^ '<!ENTITY % e "INCLUDE[">
<!ELEMENT doc (#PCDATA)>
<![ %e; <!ATTLIST doc a1 CDATA "v1"> ]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourceinvalidnotsa022xml [
	"Source file: xmltest/invalid/not-sa/022.xml"

	^ '<!DOCTYPE doc SYSTEM "022.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfextsa001ent [
	"Source file: xmltest/not-wf/ext-sa/001.ent"

	^ '&e;'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfextsa001xml [
	"Source file: xmltest/not-wf/ext-sa/001.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e SYSTEM "001.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfextsa002ent [
	"Source file: xmltest/not-wf/ext-sa/002.ent"

	^ '<?xml version="1.0" standalone="yes"?>
data

'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfextsa002xml [
	"Source file: xmltest/not-wf/ext-sa/002.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "002.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfextsa003ent [
	"Source file: xmltest/not-wf/ext-sa/003.ent"

	^ '<?xml version="1.0" encoding="UTF-8"?><?xml version="1.0" encoding="UTF-8"?>
data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfextsa003xml [
	"Source file: xmltest/not-wf/ext-sa/003.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "003.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa001ent [
	"Source file: xmltest/not-wf/not-sa/001.ent"

	^ '<![ INCLUDE [
<!ELEMENT doc (#PCDATA)>
]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa001xml [
	"Source file: xmltest/not-wf/not-sa/001.xml"

	^ '<!DOCTYPE doc SYSTEM "001.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa002xml [
	"Source file: xmltest/not-wf/not-sa/002.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "<?xml version=''1.0'' encoding=''UTF-8''?>">
%e;
]>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa003ent [
	"Source file: xmltest/not-wf/not-sa/003.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ IGNORE [
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa003xml [
	"Source file: xmltest/not-wf/not-sa/003.xml"

	^ '<!DOCTYPE doc SYSTEM "003.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa004ent [
	"Source file: xmltest/not-wf/not-sa/004.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ INCLUDE [
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa004xml [
	"Source file: xmltest/not-wf/not-sa/004.xml"

	^ '<!DOCTYPE doc SYSTEM "004.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa005ent [
	"Source file: xmltest/not-wf/not-sa/005.ent"

	^ '<!ELEMENT doc (#PCDATA)>
%e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa005xml [
	"Source file: xmltest/not-wf/not-sa/005.xml"

	^ '<!DOCTYPE doc SYSTEM "005.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa006ent [
	"Source file: xmltest/not-wf/not-sa/006.ent"

	^ '<![INCLUDE
<!ELEMENT doc (#PCDATA)>
]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa006xml [
	"Source file: xmltest/not-wf/not-sa/006.xml"

	^ '<!DOCTYPE doc SYSTEM "006.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa007ent [
	"Source file: xmltest/not-wf/not-sa/007.ent"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa007xml [
	"Source file: xmltest/not-wf/not-sa/007.xml"

	^ '<!DOCTYPE doc SYSTEM "007.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa008ent [
	"Source file: xmltest/not-wf/not-sa/008.ent"

	^ '<!ELEMENT doc ANY>
<!ENTITY e "100%">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa008xml [
	"Source file: xmltest/not-wf/not-sa/008.xml"

	^ '<!DOCTYPE doc SYSTEM "008.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa009ent [
	"Source file: xmltest/not-wf/not-sa/009.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e "<!--">
%e; -->
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa009xml [
	"Source file: xmltest/not-wf/not-sa/009.xml"

	^ '<!DOCTYPE doc SYSTEM "009.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa010ent [
	"Source file: xmltest/not-wf/not-sa/010.ent"

	^ '<!ENTITY % e "<!ELEMENT ">
%e; doc (#PCDATA)>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa010xml [
	"Source file: xmltest/not-wf/not-sa/010.xml"

	^ '<!DOCTYPE doc SYSTEM "010.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa011ent [
	"Source file: xmltest/not-wf/not-sa/011.ent"

	^ '<!ENTITY % e1 "<!ELEMENT ">
<!ENTITY % e2 ">">
%e1; doc (#PCDATA) %e2;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfnotsa011xml [
	"Source file: xmltest/not-wf/not-sa/011.xml"

	^ '<!DOCTYPE doc SYSTEM "011.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa001xml [
	"Source file: xmltest/not-wf/sa/001.xml"

	^ '<doc>
<doc
?
<a</a>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa002xml [
	"Source file: xmltest/not-wf/sa/002.xml"

	^ '<doc>
<.doc></.doc>
</doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa003xml [
	"Source file: xmltest/not-wf/sa/003.xml"

	^ '<doc><? ?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa004xml [
	"Source file: xmltest/not-wf/sa/004.xml"

	^ '<doc><?target some data></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa005xml [
	"Source file: xmltest/not-wf/sa/005.xml"

	^ '<doc><?target some data?</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa006xml [
	"Source file: xmltest/not-wf/sa/006.xml"

	^ '<doc><!-- a comment -- another --></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa007xml [
	"Source file: xmltest/not-wf/sa/007.xml"

	^ '<doc>&amp no refc</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa008xml [
	"Source file: xmltest/not-wf/sa/008.xml"

	^ '<doc>&.entity;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa009xml [
	"Source file: xmltest/not-wf/sa/009.xml"

	^ '<doc>&#RE;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa010xml [
	"Source file: xmltest/not-wf/sa/010.xml"

	^ '<doc>A & B</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa011xml [
	"Source file: xmltest/not-wf/sa/011.xml"

	^ '<doc a1></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa012xml [
	"Source file: xmltest/not-wf/sa/012.xml"

	^ '<doc a1=v1></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa013xml [
	"Source file: xmltest/not-wf/sa/013.xml"

	^ '<doc a1="v1''></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa014xml [
	"Source file: xmltest/not-wf/sa/014.xml"

	^ '<doc a1="<foo>"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa015xml [
	"Source file: xmltest/not-wf/sa/015.xml"

	^ '<doc a1=></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa016xml [
	"Source file: xmltest/not-wf/sa/016.xml"

	^ '<doc a1="v1" "v2"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa017xml [
	"Source file: xmltest/not-wf/sa/017.xml"

	^ '<doc><![CDATA[</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa018xml [
	"Source file: xmltest/not-wf/sa/018.xml"

	^ '<doc><![CDATA [ stuff]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa019xml [
	"Source file: xmltest/not-wf/sa/019.xml"

	^ '<doc></>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa020xml [
	"Source file: xmltest/not-wf/sa/020.xml"

	^ '<doc a1="A & B"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa021xml [
	"Source file: xmltest/not-wf/sa/021.xml"

	^ '<doc a1="a&b"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa022xml [
	"Source file: xmltest/not-wf/sa/022.xml"

	^ '<doc a1="&#123:"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa023xml [
	"Source file: xmltest/not-wf/sa/023.xml"

	^ '<doc 12="34"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa024xml [
	"Source file: xmltest/not-wf/sa/024.xml"

	^ '<doc>
<123></123>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa025xml [
	"Source file: xmltest/not-wf/sa/025.xml"

	^ '<doc>]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa026xml [
	"Source file: xmltest/not-wf/sa/026.xml"

	^ '<doc>]]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa027xml [
	"Source file: xmltest/not-wf/sa/027.xml"

	^ '<doc>
<!-- abc
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa028xml [
	"Source file: xmltest/not-wf/sa/028.xml"

	^ '<doc>
<?a pi that is not closed
</doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa029xml [
	"Source file: xmltest/not-wf/sa/029.xml"

	^ '<doc>abc]]]>def</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa030xml [
	"Source file: xmltest/not-wf/sa/030.xml"

	^ '<doc>A form feed () is not legal in data</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa031xml [
	"Source file: xmltest/not-wf/sa/031.xml"

	^ '<doc><?pi a form feed () is not allowed in a pi?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa032xml [
	"Source file: xmltest/not-wf/sa/032.xml"

	^ '<doc><!-- a form feed () is not allowed in a comment --></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa033xml [
	"Source file: xmltest/not-wf/sa/033.xml"

	^ '<doc>abc', 16r1B asCharacter asString, 'def</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa034xml [
	"Source file: xmltest/not-wf/sa/034.xml"

	^ '<doc>A form-feed is not white space or a name character</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa035xml [
	"Source file: xmltest/not-wf/sa/035.xml"

	^ '<doc>1 < 2 but not in XML</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa036xml [
	"Source file: xmltest/not-wf/sa/036.xml"

	^ '<doc></doc>
Illegal data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa037xml [
	"Source file: xmltest/not-wf/sa/037.xml"

	^ '<doc></doc>
&#32;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa038xml [
	"Source file: xmltest/not-wf/sa/038.xml"

	^ '<doc x="foo" y="bar" x="baz"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa039xml [
	"Source file: xmltest/not-wf/sa/039.xml"

	^ '<doc><a></aa></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa040xml [
	"Source file: xmltest/not-wf/sa/040.xml"

	^ '<doc></doc>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa041xml [
	"Source file: xmltest/not-wf/sa/041.xml"

	^ '<doc/>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa042xml [
	"Source file: xmltest/not-wf/sa/042.xml"

	^ '<doc/></doc/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa043xml [
	"Source file: xmltest/not-wf/sa/043.xml"

	^ '<doc/>
Illegal data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa044xml [
	"Source file: xmltest/not-wf/sa/044.xml"

	^ '<doc/><doc/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa045xml [
	"Source file: xmltest/not-wf/sa/045.xml"

	^ '<doc>
<a/
</doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa046xml [
	"Source file: xmltest/not-wf/sa/046.xml"

	^ '<doc>
<a/</a>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa047xml [
	"Source file: xmltest/not-wf/sa/047.xml"

	^ '<doc>
<a / >
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa048xml [
	"Source file: xmltest/not-wf/sa/048.xml"

	^ '<doc>
</doc>
<![CDATA[]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa049xml [
	"Source file: xmltest/not-wf/sa/049.xml"

	^ '<doc>
<a><![CDATA[xyz]]]></a>
<![CDATA[]]></a>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa050xml [
	"Source file: xmltest/not-wf/sa/050.xml"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa051xml [
	"Source file: xmltest/not-wf/sa/051.xml"

	^ '<!-- a comment -->
<![CDATA[]]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa052xml [
	"Source file: xmltest/not-wf/sa/052.xml"

	^ '<!-- a comment -->
&#32;
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa053xml [
	"Source file: xmltest/not-wf/sa/053.xml"

	^ '<doc></DOC>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa054xml [
	"Source file: xmltest/not-wf/sa/054.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo PUBLIC "some public id">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa055xml [
	"Source file: xmltest/not-wf/sa/055.xml"

	^ '<!DOCTYPE doc [
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa056xml [
	"Source file: xmltest/not-wf/sa/056.xml"

	^ '<!DOCTYPE doc -- a comment -- []>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa057xml [
	"Source file: xmltest/not-wf/sa/057.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "whatever" -- a comment -->
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa058xml [
	"Source file: xmltest/not-wf/sa/058.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 (foo,bar) #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa059xml [
	"Source file: xmltest/not-wf/sa/059.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 NMTOKEN v1>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa060xml [
	"Source file: xmltest/not-wf/sa/060.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 NAME #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa061xml [
	"Source file: xmltest/not-wf/sa/061.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e PUBLIC "whatever""e.ent">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa062xml [
	"Source file: xmltest/not-wf/sa/062.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo"some text">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa063xml [
	"Source file: xmltest/not-wf/sa/063.xml"

	^ '<!DOCTYPE doc [
<![INCLUDE[ ]]>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa064xml [
	"Source file: xmltest/not-wf/sa/064.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST e a1 CDATA"foo">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa065xml [
	"Source file: xmltest/not-wf/sa/065.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1(foo|bar) #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa066xml [
	"Source file: xmltest/not-wf/sa/066.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 (foo|bar)#IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa067xml [
	"Source file: xmltest/not-wf/sa/067.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 (foo)"foo">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa068xml [
	"Source file: xmltest/not-wf/sa/068.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 NOTATION(foo) #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa069xml [
	"Source file: xmltest/not-wf/sa/069.xml"

	^ '<!DOCTYPE doc [
<!NOTATION eps SYSTEM "eps.exe">
<!-- missing space before NDATA -->
<!ENTITY foo SYSTEM "foo.eps"NDATA eps>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa070xml [
	"Source file: xmltest/not-wf/sa/070.xml"

	^ '<!-- a comment ending with three dashes --->
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa071xml [
	"Source file: xmltest/not-wf/sa/071.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e1 "&e2;">
<!ENTITY e2 "&e3;">
<!ENTITY e3 "&e1;">
]>
<doc>&e1;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa072xml [
	"Source file: xmltest/not-wf/sa/072.xml"

	^ '<doc>&foo;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa073xml [
	"Source file: xmltest/not-wf/sa/073.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "whatever">
]>
<doc>&f;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa074xml [
	"Source file: xmltest/not-wf/sa/074.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "</foo><foo>">
]>
<doc>
<foo>&e;</foo>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa075xml [
	"Source file: xmltest/not-wf/sa/075.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e1 "&e2;">
<!ENTITY e2 "&e3;">
<!ENTITY e3 "&e1;">
]>
<doc a="&e1;"></doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa076xml [
	"Source file: xmltest/not-wf/sa/076.xml"

	^ '<doc a="&foo;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa077xml [
	"Source file: xmltest/not-wf/sa/077.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo "&bar;">
]>
<doc a="&foo;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa078xml [
	"Source file: xmltest/not-wf/sa/078.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA "&foo;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa079xml [
	"Source file: xmltest/not-wf/sa/079.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e1 "&e2;">
<!ENTITY e2 "&e3;">
<!ENTITY e3 "&e1;">
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA "&e1;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa080xml [
	"Source file: xmltest/not-wf/sa/080.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e1 "&e2;">
<!ENTITY e2 "&e3;">
<!ENTITY e3 "&e1;">
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #FIXED "&e1;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa081xml [
	"Source file: xmltest/not-wf/sa/081.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e SYSTEM "nul">
]>
<doc a="&e;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa082xml [
	"Source file: xmltest/not-wf/sa/082.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e SYSTEM "nul">
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA "&e;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa083xml [
	"Source file: xmltest/not-wf/sa/083.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e SYSTEM "nul" NDATA n>
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa084xml [
	"Source file: xmltest/not-wf/sa/084.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e SYSTEM "nul" NDATA n>
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA "&e;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa085xml [
	"Source file: xmltest/not-wf/sa/085.xml"

	^ '<!DOCTYPE doc PUBLIC "[" "null.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa086xml [
	"Source file: xmltest/not-wf/sa/086.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo PUBLIC "[" "null.xml">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa087xml [
	"Source file: xmltest/not-wf/sa/087.xml"

	^ '<!DOCTYPE doc [
<!NOTATION foo PUBLIC "[" "null.ent">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa088xml [
	"Source file: xmltest/not-wf/sa/088.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
<!ENTITY e ''"''>
]>
<doc a="&e;></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa089xml [
	"Source file: xmltest/not-wf/sa/089.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % foo SYSTEM "foo.xml" NDATA bar>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa090xml [
	"Source file: xmltest/not-wf/sa/090.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<foo a=''&#60;''></foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa091xml [
	"Source file: xmltest/not-wf/sa/091.xml"

	^ '<!DOCTYPE doc [
<!NOTATION n SYSTEM "n">
<!ENTITY % foo SYSTEM "foo.xml" NDATA n>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa092xml [
	"Source file: xmltest/not-wf/sa/092.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<foo a=''&#38;''></foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa093xml [
	"Source file: xmltest/not-wf/sa/093.xml"

	^ '<doc>&#X58;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa094xml [
	"Source file: xmltest/not-wf/sa/094.xml"

	^ '<?xml VERSION="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa095xml [
	"Source file: xmltest/not-wf/sa/095.xml"

	^ '<?xml encoding="UTF-8" version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa096xml [
	"Source file: xmltest/not-wf/sa/096.xml"

	^ '<?xml version="1.0"encoding="UTF-8" ?>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa097xml [
	"Source file: xmltest/not-wf/sa/097.xml"

	^ '<?xml version="1.0'' encoding="UTF-8" ?>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa098xml [
	"Source file: xmltest/not-wf/sa/098.xml"

	^ '<?xml version="1.0" version="1.0"?>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa099xml [
	"Source file: xmltest/not-wf/sa/099.xml"

	^ '<?xml version="1.0" valid="no" ?>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa100xml [
	"Source file: xmltest/not-wf/sa/100.xml"

	^ '<?xml version="1.0" standalone="YES" ?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa101xml [
	"Source file: xmltest/not-wf/sa/101.xml"

	^ '<?xml version="1.0" encoding=" UTF-8"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa102xml [
	"Source file: xmltest/not-wf/sa/102.xml"

	^ '<?xml version="1.0 " ?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa103xml [
	"Source file: xmltest/not-wf/sa/103.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa104xml [
	"Source file: xmltest/not-wf/sa/104.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<foo>">
]>
<doc>&e;</foo></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa105xml [
	"Source file: xmltest/not-wf/sa/105.xml"

	^ '<?pi stuff?>
<![CDATA[]]>
<doc>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa106xml [
	"Source file: xmltest/not-wf/sa/106.xml"

	^ '<?pi data?>
&#32;<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa107xml [
	"Source file: xmltest/not-wf/sa/107.xml"

	^ '<!DOCTYPE doc [
<![CDATA[]]>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa108xml [
	"Source file: xmltest/not-wf/sa/108.xml"

	^ '<doc>
<![CDATA [  ]]>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa109xml [
	"Source file: xmltest/not-wf/sa/109.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<doc></doc>">
]>
&e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa110xml [
	"Source file: xmltest/not-wf/sa/110.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "">
]>
<doc></doc>
&e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa111xml [
	"Source file: xmltest/not-wf/sa/111.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "foo=''bar''">
]>
<doc &e;></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa112xml [
	"Source file: xmltest/not-wf/sa/112.xml"

	^ '<doc>
<![cdata[data]]>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa113xml [
	"Source file: xmltest/not-wf/sa/113.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % foo "&">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa114xml [
	"Source file: xmltest/not-wf/sa/114.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo "&">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa115xml [
	"Source file: xmltest/not-wf/sa/115.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#38;">
]>
<doc a="&e;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa116xml [
	"Source file: xmltest/not-wf/sa/116.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#38;#9">
]>
<doc>&e;7;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa117xml [
	"Source file: xmltest/not-wf/sa/117.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#38;">
]>
<doc>&e;#97;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa118xml [
	"Source file: xmltest/not-wf/sa/118.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "#">
]>
<doc>&&e;97;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa119xml [
	"Source file: xmltest/not-wf/sa/119.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#38;">
]>
<doc>
&e;#38;
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa120xml [
	"Source file: xmltest/not-wf/sa/120.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#38;">
]>
<doc>
&e;
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa121xml [
	"Source file: xmltest/not-wf/sa/121.xml"

	^ '<!DOCTYPE doc [
<!ENTITY #DEFAULT "default">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa122xml [
	"Source file: xmltest/not-wf/sa/122.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a, (b) | c)?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa123xml [
	"Source file: xmltest/not-wf/sa/123.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc ((doc?)))>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa124xml [
	"Source file: xmltest/not-wf/sa/124.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (doc|#PCDATA)*>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa125xml [
	"Source file: xmltest/not-wf/sa/125.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc ((#PCDATA))>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa126xml [
	"Source file: xmltest/not-wf/sa/126.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)+>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa127xml [
	"Source file: xmltest/not-wf/sa/127.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa128xml [
	"Source file: xmltest/not-wf/sa/128.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc CDATA>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa129xml [
	"Source file: xmltest/not-wf/sa/129.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc - - (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa130xml [
	"Source file: xmltest/not-wf/sa/130.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (doc?) +(foo)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa131xml [
	"Source file: xmltest/not-wf/sa/131.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (doc?) -(foo)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa132xml [
	"Source file: xmltest/not-wf/sa/132.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a, (b, c), (d, (e, f) | g))?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa133xml [
	"Source file: xmltest/not-wf/sa/133.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a *)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa134xml [
	"Source file: xmltest/not-wf/sa/134.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a) *>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa135xml [
	"Source file: xmltest/not-wf/sa/135.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a & b)?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa136xml [
	"Source file: xmltest/not-wf/sa/136.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc O O (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa137xml [
	"Source file: xmltest/not-wf/sa/137.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc(#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa138xml [
	"Source file: xmltest/not-wf/sa/138.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (doc*?)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa139xml [
	"Source file: xmltest/not-wf/sa/139.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc ()>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa140xml [
	"Source file: xmltest/not-wf/sa/140.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<&#x309a;></&#x309a;>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa141xml [
	"Source file: xmltest/not-wf/sa/141.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<X&#xe5c;></X&#xe5c;>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa142xml [
	"Source file: xmltest/not-wf/sa/142.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#0;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa143xml [
	"Source file: xmltest/not-wf/sa/143.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#31;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa144xml [
	"Source file: xmltest/not-wf/sa/144.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#xFFFF;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa145xml [
	"Source file: xmltest/not-wf/sa/145.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#xD800;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa146xml [
	"Source file: xmltest/not-wf/sa/146.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x110000;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa147xml [
	"Source file: xmltest/not-wf/sa/147.xml"

	^ '
<?xml version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa148xml [
	"Source file: xmltest/not-wf/sa/148.xml"

	^ '<!-- -->
<?xml version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa149xml [
	"Source file: xmltest/not-wf/sa/149.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<?xml version="1.0"?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa150xml [
	"Source file: xmltest/not-wf/sa/150.xml"

	^ '<doc>
<?xml version="1.0"?>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa151xml [
	"Source file: xmltest/not-wf/sa/151.xml"

	^ '<doc>
</doc>
<?xml version="1.0"?>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa152xml [
	"Source file: xmltest/not-wf/sa/152.xml"

	^ '<?xml encoding="UTF-8"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa153xml [
	"Source file: xmltest/not-wf/sa/153.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "<?xml encoding=''UTF-8''?>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa154xml [
	"Source file: xmltest/not-wf/sa/154.xml"

	^ '<?XML version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa155xml [
	"Source file: xmltest/not-wf/sa/155.xml"

	^ '<?xmL version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa156xml [
	"Source file: xmltest/not-wf/sa/156.xml"

	^ '<doc>
<?xMl version="1.0"?>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa157xml [
	"Source file: xmltest/not-wf/sa/157.xml"

	^ '<doc>
<?xmL?>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa158xml [
	"Source file: xmltest/not-wf/sa/158.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!NOTATION gif PUBLIC "image/gif" "">
<!ATTLIST #NOTATION gif a1 CDATA #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa159xml [
	"Source file: xmltest/not-wf/sa/159.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "<![CDATA[Tim & Michael]]>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa160xml [
	"Source file: xmltest/not-wf/sa/160.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "">
<!ENTITY foo "%e;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa161xml [
	"Source file: xmltest/not-wf/sa/161.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e "#PCDATA">
<!ELEMENT doc (%e;)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa162xml [
	"Source file: xmltest/not-wf/sa/162.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e1 "">
<!ENTITY % e2 "%e1;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa163xml [
	"Source file: xmltest/not-wf/sa/163.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "">
]>
%e;
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa164xml [
	"Source file: xmltest/not-wf/sa/164.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "">
] %e; >
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa165xml [
	"Source file: xmltest/not-wf/sa/165.xml"

	^ '<!DOCTYPE doc [
<!ENTITY% e "">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa166xml [
	"Source file: xmltest/not-wf/sa/166.xml"

	^ '<doc>', 16rFFFF asCharacter asString, '</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa167xml [
	"Source file: xmltest/not-wf/sa/167.xml"

	^ '<doc>', 16rFFFE asCharacter asString, '</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa168xml [
	"Source file: xmltest/not-wf/sa/168.xml"

	^ '<doc>', 16rD800 asCharacter asString, '</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa169xml [
	"Source file: xmltest/not-wf/sa/169.xml"

	^ '<doc>', 16rDC00 asCharacter asString, '</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa171xml [
	"Source file: xmltest/not-wf/sa/171.xml"

	^ '<!-- ', 16rFFFF asCharacter asString, ' -->
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa172xml [
	"Source file: xmltest/not-wf/sa/172.xml"

	^ '<?pi ', 16rFFFF asCharacter asString, '?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa173xml [
	"Source file: xmltest/not-wf/sa/173.xml"

	^ '<doc a="', 16rFFFF asCharacter asString, '"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa174xml [
	"Source file: xmltest/not-wf/sa/174.xml"

	^ '<doc><![CDATA[', 16rFFFF asCharacter asString, ']]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa175xml [
	"Source file: xmltest/not-wf/sa/175.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "', 16rFFFF asCharacter asString, '">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa176xml [
	"Source file: xmltest/not-wf/sa/176.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa177xml [
	"Source file: xmltest/not-wf/sa/177.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>A', 16rFFFF asCharacter asString, '</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa178xml [
	"Source file: xmltest/not-wf/sa/178.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="&#34;></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa179xml [
	"Source file: xmltest/not-wf/sa/179.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#34;>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa180xml [
	"Source file: xmltest/not-wf/sa/180.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA "&e;">
<!ENTITY e "v">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa181xml [
	"Source file: xmltest/not-wf/sa/181.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;![CDATA[">
<!ELEMENT doc (#PCDATA)>
]>
<doc>&e;]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa182xml [
	"Source file: xmltest/not-wf/sa/182.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;!--">
<!ELEMENT doc (#PCDATA)>
]>
<doc>&e;--></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa183xml [
	"Source file: xmltest/not-wf/sa/183.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA | foo*)* >
<!ELEMENT foo EMPTY>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa184xml [
	"Source file: xmltest/not-wf/sa/184.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA | (foo))* >
<!ELEMENT foo EMPTY>
]>
<doc></doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa185ent [
	"Source file: xmltest/not-wf/sa/185.ent"

	^ '<!ELEMENT doc (#PCDATA)>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa185xml [
	"Source file: xmltest/not-wf/sa/185.xml"

	^ '<?xml version="1.0" standalone="yes"?>
<!DOCTYPE doc SYSTEM "185.ent">
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsa186xml [
	"Source file: xmltest/not-wf/sa/186.xml"

	^ '<!DOCTYPE a [
<!ELEMENT a EMPTY>
<!ATTLIST a b CDATA #IMPLIED d CDATA #IMPLIED>
]>
<a b="c"d="e"/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcenotwfsanullent [
	"Source file: xmltest/not-wf/sa/null.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa001ent [
	"Source file: xmltest/valid/ext-sa/001.ent"

	^ 'Data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa001xml [
	"Source file: xmltest/valid/ext-sa/001.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "001.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa002ent [
	"Source file: xmltest/valid/ext-sa/002.ent"

	^ 'Data'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa002xml [
	"Source file: xmltest/valid/ext-sa/002.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "002.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa003ent [
	"Source file: xmltest/valid/ext-sa/003.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa003xml [
	"Source file: xmltest/valid/ext-sa/003.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "003.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa004ent [
	"Source file: xmltest/valid/ext-sa/004.ent"

	^ 'Data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa004xml [
	"Source file: xmltest/valid/ext-sa/004.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "004.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa005ent [
	"Source file: xmltest/valid/ext-sa/005.ent"

	^ '<e/><e/><e/>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa005xml [
	"Source file: xmltest/valid/ext-sa/005.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (e*)>
<!ELEMENT e EMPTY>
<!ENTITY e SYSTEM "005.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa006ent [
	"Source file: xmltest/valid/ext-sa/006.ent"

	^ 'Data
<e/>
More data
<e/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa006xml [
	"Source file: xmltest/valid/ext-sa/006.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA|e)*>
<!ELEMENT e EMPTY>
<!ENTITY e SYSTEM "006.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa007ent [
	"Source file: xmltest/valid/ext-sa/007.ent"

	^ 'Y'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa007xml [
	"Source file: xmltest/valid/ext-sa/007.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "007.ent">
]>
<doc>X&e;Z</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa008ent [
	"Source file: xmltest/valid/ext-sa/008.ent"

	^ '<?xml encoding="UTF-16"?>Y'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa008xml [
	"Source file: xmltest/valid/ext-sa/008.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "008.ent">
]>
<doc>X&e;Z</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa009ent [
	"Source file: xmltest/valid/ext-sa/009.ent"

	^ '
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa009xml [
	"Source file: xmltest/valid/ext-sa/009.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "009.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa010ent [
	"Source file: xmltest/valid/ext-sa/010.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa010xml [
	"Source file: xmltest/valid/ext-sa/010.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "010.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa011ent [
	"Source file: xmltest/valid/ext-sa/011.ent"

	^ 'xyzzy
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa011xml [
	"Source file: xmltest/valid/ext-sa/011.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e PUBLIC "a not very interesting file" "011.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa012ent [
	"Source file: xmltest/valid/ext-sa/012.ent"

	^ '&e4;'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa012xml [
	"Source file: xmltest/valid/ext-sa/012.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e1 "&e2;">
<!ENTITY e2 "&e3;">
<!ENTITY e3 SYSTEM "012.ent">
<!ENTITY e4 "&e5;">
<!ENTITY e5 "(e5)">
<!ELEMENT doc (#PCDATA)>
]>
<doc>&e1;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa013ent [
	"Source file: xmltest/valid/ext-sa/013.ent"

	^ '<e/>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa013xml [
	"Source file: xmltest/valid/ext-sa/013.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (e)>
<!ELEMENT e (#PCDATA)>
<!ATTLIST e
  a1 CDATA "a1 default"
  a2 NMTOKENS "a2 default"
>
<!ENTITY x SYSTEM "013.ent">
]>
<doc>&x;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa014ent [
	"Source file: xmltest/valid/ext-sa/014.ent"

	^ '', 16rFEFF asCharacter asString, 'data'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsa014xml [
	"Source file: xmltest/valid/ext-sa/014.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "014.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout001xml [
	"Source file: xmltest/valid/ext-sa/out/001.xml"

	^ '<doc>Data&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout002xml [
	"Source file: xmltest/valid/ext-sa/out/002.xml"

	^ '<doc>Data</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout003xml [
	"Source file: xmltest/valid/ext-sa/out/003.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout004xml [
	"Source file: xmltest/valid/ext-sa/out/004.xml"

	^ '<doc>Data&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout005xml [
	"Source file: xmltest/valid/ext-sa/out/005.xml"

	^ '<doc><e></e><e></e><e></e></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout006xml [
	"Source file: xmltest/valid/ext-sa/out/006.xml"

	^ '<doc>Data&#10;<e></e>&#10;More data&#10;<e></e>&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout007xml [
	"Source file: xmltest/valid/ext-sa/out/007.xml"

	^ '<doc>XYZ</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout008xml [
	"Source file: xmltest/valid/ext-sa/out/008.xml"

	^ '<doc>XYZ</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout009xml [
	"Source file: xmltest/valid/ext-sa/out/009.xml"

	^ '<doc>&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout010xml [
	"Source file: xmltest/valid/ext-sa/out/010.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout011xml [
	"Source file: xmltest/valid/ext-sa/out/011.xml"

	^ '<doc>xyzzy&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout012xml [
	"Source file: xmltest/valid/ext-sa/out/012.xml"

	^ '<doc>(e5)</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout013xml [
	"Source file: xmltest/valid/ext-sa/out/013.xml"

	^ '<doc><e a1="a1 default" a2="a2 default"></e></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidextsaout014xml [
	"Source file: xmltest/valid/ext-sa/out/014.xml"

	^ '<doc>', 16rFEFF asCharacter asString, 'data</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa001ent [
	"Source file: xmltest/valid/not-sa/001.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa001xml [
	"Source file: xmltest/valid/not-sa/001.xml"

	^ '<!DOCTYPE doc SYSTEM "001.ent" [
<!ELEMENT doc EMPTY>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa002ent [
	"Source file: xmltest/valid/not-sa/002.ent"

	^ '
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa002xml [
	"Source file: xmltest/valid/not-sa/002.xml"

	^ '<!DOCTYPE doc SYSTEM "002.ent" [
<!ELEMENT doc EMPTY>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa0031ent [
	"Source file: xmltest/valid/not-sa/003-1.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e SYSTEM "003-2.ent">
<!ATTLIST doc a1 CDATA %e; "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa0032ent [
	"Source file: xmltest/valid/not-sa/003-2.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa003xml [
	"Source file: xmltest/valid/not-sa/003.xml"

	^ '<!DOCTYPE doc SYSTEM "003-1.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa0041ent [
	"Source file: xmltest/valid/not-sa/004-1.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e1 SYSTEM "004-2.ent">
<!ENTITY % e2 "%e1;">
%e1;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa0042ent [
	"Source file: xmltest/valid/not-sa/004-2.ent"

	^ '<!ATTLIST doc a1 CDATA "value">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa004xml [
	"Source file: xmltest/valid/not-sa/004.xml"

	^ '<!DOCTYPE doc SYSTEM "004-1.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa0051ent [
	"Source file: xmltest/valid/not-sa/005-1.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e SYSTEM "005-2.ent">
%e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa0052ent [
	"Source file: xmltest/valid/not-sa/005-2.ent"

	^ '<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa005xml [
	"Source file: xmltest/valid/not-sa/005.xml"

	^ '<!DOCTYPE doc SYSTEM "005-1.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa006ent [
	"Source file: xmltest/valid/not-sa/006.ent"

	^ '<!ELEMENT doc EMPTY>
<!ATTLIST doc a1 CDATA "w1" a2 CDATA "w2">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa006xml [
	"Source file: xmltest/valid/not-sa/006.xml"

	^ '<!DOCTYPE doc SYSTEM "006.ent" [
<!ATTLIST doc a1 CDATA "v1">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa007ent [
	"Source file: xmltest/valid/not-sa/007.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa007xml [
	"Source file: xmltest/valid/not-sa/007.xml"

	^ '<!DOCTYPE doc SYSTEM "007.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa008ent [
	"Source file: xmltest/valid/not-sa/008.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa008xml [
	"Source file: xmltest/valid/not-sa/008.xml"

	^ '<!DOCTYPE doc PUBLIC "whatever" "008.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa009ent [
	"Source file: xmltest/valid/not-sa/009.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa009xml [
	"Source file: xmltest/valid/not-sa/009.xml"

	^ '<!DOCTYPE doc PUBLIC "whatever" "009.ent" [
<!ATTLIST doc a2 CDATA "v2">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa010ent [
	"Source file: xmltest/valid/not-sa/010.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v2">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa010xml [
	"Source file: xmltest/valid/not-sa/010.xml"

	^ '<!DOCTYPE doc SYSTEM "010.ent" [
<!ATTLIST doc a1 CDATA "v1">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa011ent [
	"Source file: xmltest/valid/not-sa/011.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa011xml [
	"Source file: xmltest/valid/not-sa/011.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e SYSTEM "011.ent">
%e;
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa012ent [
	"Source file: xmltest/valid/not-sa/012.ent"

	^ '<?xml version="1.0" encoding="UTF-8"?>
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa012xml [
	"Source file: xmltest/valid/not-sa/012.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e SYSTEM "012.ent">
%e;
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa013ent [
	"Source file: xmltest/valid/not-sa/013.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ INCLUDE [
<!ATTLIST doc a1 CDATA "v1">
]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa013xml [
	"Source file: xmltest/valid/not-sa/013.xml"

	^ '<!DOCTYPE doc SYSTEM "013.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa014ent [
	"Source file: xmltest/valid/not-sa/014.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ %e; [
<!ATTLIST doc a1 CDATA "v1">
]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa014xml [
	"Source file: xmltest/valid/not-sa/014.xml"

	^ '<!DOCTYPE doc SYSTEM "014.ent" [
<!ENTITY % e "INCLUDE">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa015ent [
	"Source file: xmltest/valid/not-sa/015.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ %e; [
<!ATTLIST doc a1 CDATA "v1">
]]>
<!ATTLIST doc a2 CDATA "v2">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa015xml [
	"Source file: xmltest/valid/not-sa/015.xml"

	^ '<!DOCTYPE doc SYSTEM "015.ent" [
<!ENTITY % e "IGNORE">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa016ent [
	"Source file: xmltest/valid/not-sa/016.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![%e;[
<!ATTLIST doc a1 CDATA "v1">
]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa016xml [
	"Source file: xmltest/valid/not-sa/016.xml"

	^ '<!DOCTYPE doc SYSTEM "016.ent" [
<!ENTITY % e "INCLUDE">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa017ent [
	"Source file: xmltest/valid/not-sa/017.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "<!ATTLIST doc a1 CDATA ''v1''>">
%e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa017xml [
	"Source file: xmltest/valid/not-sa/017.xml"

	^ '<!DOCTYPE doc SYSTEM "017.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa018ent [
	"Source file: xmltest/valid/not-sa/018.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "''v1''">
<!ATTLIST doc a1 CDATA %e;>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa018xml [
	"Source file: xmltest/valid/not-sa/018.xml"

	^ '<!DOCTYPE doc SYSTEM "018.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa019ent [
	"Source file: xmltest/valid/not-sa/019.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "''v1''">
<!ATTLIST doc a1 CDATA%e;>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa019xml [
	"Source file: xmltest/valid/not-sa/019.xml"

	^ '<!DOCTYPE doc SYSTEM "019.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa020ent [
	"Source file: xmltest/valid/not-sa/020.ent"

	^ '<!ENTITY % e "doc">
<!ELEMENT doc (#PCDATA)>
<!ATTLIST%e;a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa020xml [
	"Source file: xmltest/valid/not-sa/020.xml"

	^ '<!DOCTYPE doc SYSTEM "020.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa021ent [
	"Source file: xmltest/valid/not-sa/021.ent"

	^ '<!ENTITY % e "doc a1 CDATA">
<!ELEMENT doc (#PCDATA)>
<!ATTLIST %e; "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa021xml [
	"Source file: xmltest/valid/not-sa/021.xml"

	^ '<!DOCTYPE doc SYSTEM "021.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa023ent [
	"Source file: xmltest/valid/not-sa/023.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e1 "do">
<!ENTITY % e2 "c">
<!ENTITY % e3 "%e1;%e2;">
<!ATTLIST %e3; a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa023xml [
	"Source file: xmltest/valid/not-sa/023.xml"

	^ '<!DOCTYPE doc SYSTEM "023.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa024ent [
	"Source file: xmltest/valid/not-sa/024.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e1 "''v1''">
<!ENTITY % e2 ''a1 CDATA %e1;''>
<!ATTLIST doc %e2;>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa024xml [
	"Source file: xmltest/valid/not-sa/024.xml"

	^ '<!DOCTYPE doc SYSTEM "024.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa025ent [
	"Source file: xmltest/valid/not-sa/025.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e "x">
<!ENTITY % e "y">
<!ENTITY % v "''%e;''">
<!ATTLIST doc a1 CDATA %v;>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa025xml [
	"Source file: xmltest/valid/not-sa/025.xml"

	^ '<!DOCTYPE doc SYSTEM "025.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa026ent [
	"Source file: xmltest/valid/not-sa/026.ent"

	^ '<!ATTLIST doc a1 CDATA "w1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa026xml [
	"Source file: xmltest/valid/not-sa/026.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc ANY>
<!ENTITY % e SYSTEM "026.ent">
%e;
<!ATTLIST doc a1 CDATA "x1" a2 CDATA "x2">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa027ent [
	"Source file: xmltest/valid/not-sa/027.ent"

	^ '<!ENTITY % e "">
<!ELEMENT doc (#PCDATA %e;)>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa027xml [
	"Source file: xmltest/valid/not-sa/027.xml"

	^ '<!DOCTYPE doc SYSTEM "027.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa028ent [
	"Source file: xmltest/valid/not-sa/028.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![INCLUDE[<!ATTLIST doc a1 CDATA "v1">]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa028xml [
	"Source file: xmltest/valid/not-sa/028.xml"

	^ '<!DOCTYPE doc SYSTEM "028.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa029ent [
	"Source file: xmltest/valid/not-sa/029.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![IGNORE[<!ATTLIST doc a1 CDATA "v1">]]>
<!ATTLIST doc a1 CDATA "v2">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa029xml [
	"Source file: xmltest/valid/not-sa/029.xml"

	^ '<!DOCTYPE doc SYSTEM "029.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa030ent [
	"Source file: xmltest/valid/not-sa/030.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![IGNORE[]]>
<![INCLUDE[]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa030xml [
	"Source file: xmltest/valid/not-sa/030.xml"

	^ '<!DOCTYPE doc SYSTEM "030.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa0311ent [
	"Source file: xmltest/valid/not-sa/031-1.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e SYSTEM "031-2.ent">
<!ENTITY e "<![CDATA[%e;]]>">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa0312ent [
	"Source file: xmltest/valid/not-sa/031-2.ent"

	^ '<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsa031xml [
	"Source file: xmltest/valid/not-sa/031.xml"

	^ '<!DOCTYPE doc SYSTEM "031-1.ent">
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout001xml [
	"Source file: xmltest/valid/not-sa/out/001.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout002xml [
	"Source file: xmltest/valid/not-sa/out/002.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout003xml [
	"Source file: xmltest/valid/not-sa/out/003.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout004xml [
	"Source file: xmltest/valid/not-sa/out/004.xml"

	^ '<doc a1="value"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout005xml [
	"Source file: xmltest/valid/not-sa/out/005.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout006xml [
	"Source file: xmltest/valid/not-sa/out/006.xml"

	^ '<doc a1="v1" a2="w2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout007xml [
	"Source file: xmltest/valid/not-sa/out/007.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout008xml [
	"Source file: xmltest/valid/not-sa/out/008.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout009xml [
	"Source file: xmltest/valid/not-sa/out/009.xml"

	^ '<doc a1="v1" a2="v2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout010xml [
	"Source file: xmltest/valid/not-sa/out/010.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout011xml [
	"Source file: xmltest/valid/not-sa/out/011.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout012xml [
	"Source file: xmltest/valid/not-sa/out/012.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout013xml [
	"Source file: xmltest/valid/not-sa/out/013.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout014xml [
	"Source file: xmltest/valid/not-sa/out/014.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout015xml [
	"Source file: xmltest/valid/not-sa/out/015.xml"

	^ '<doc a2="v2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout016xml [
	"Source file: xmltest/valid/not-sa/out/016.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout017xml [
	"Source file: xmltest/valid/not-sa/out/017.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout018xml [
	"Source file: xmltest/valid/not-sa/out/018.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout019xml [
	"Source file: xmltest/valid/not-sa/out/019.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout020xml [
	"Source file: xmltest/valid/not-sa/out/020.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout021xml [
	"Source file: xmltest/valid/not-sa/out/021.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout022xml [
	"Source file: xmltest/valid/not-sa/out/022.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout023xml [
	"Source file: xmltest/valid/not-sa/out/023.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout024xml [
	"Source file: xmltest/valid/not-sa/out/024.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout025xml [
	"Source file: xmltest/valid/not-sa/out/025.xml"

	^ '<doc a1="x"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout026xml [
	"Source file: xmltest/valid/not-sa/out/026.xml"

	^ '<doc a1="w1" a2="x2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout027xml [
	"Source file: xmltest/valid/not-sa/out/027.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout028xml [
	"Source file: xmltest/valid/not-sa/out/028.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout029xml [
	"Source file: xmltest/valid/not-sa/out/029.xml"

	^ '<doc a1="v2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout030xml [
	"Source file: xmltest/valid/not-sa/out/030.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidnotsaout031xml [
	"Source file: xmltest/valid/not-sa/out/031.xml"

	^ '<doc>&lt;!ATTLIST doc a1 CDATA &quot;v1&quot;&gt;&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa001xml [
	"Source file: xmltest/valid/sa/001.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa002xml [
	"Source file: xmltest/valid/sa/002.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc ></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa003xml [
	"Source file: xmltest/valid/sa/003.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc >
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa004xml [
	"Source file: xmltest/valid/sa/004.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa005xml [
	"Source file: xmltest/valid/sa/005.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1 = "v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa006xml [
	"Source file: xmltest/valid/sa/006.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1=''v1''></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa007xml [
	"Source file: xmltest/valid/sa/007.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#32;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa008xml [
	"Source file: xmltest/valid/sa/008.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&amp;&lt;&gt;&quot;&apos;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa009xml [
	"Source file: xmltest/valid/sa/009.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x20;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa010xml [
	"Source file: xmltest/valid/sa/010.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="v1" ></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa011xml [
	"Source file: xmltest/valid/sa/011.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED a2 CDATA #IMPLIED>
]>
<doc a1="v1" a2="v2"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa012xml [
	"Source file: xmltest/valid/sa/012.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc : CDATA #IMPLIED>
]>
<doc :="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa013xml [
	"Source file: xmltest/valid/sa/013.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc _.-0123456789 CDATA #IMPLIED>
]>
<doc _.-0123456789="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa014xml [
	"Source file: xmltest/valid/sa/014.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc abcdefghijklmnopqrstuvwxyz CDATA #IMPLIED>
]>
<doc abcdefghijklmnopqrstuvwxyz="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa015xml [
	"Source file: xmltest/valid/sa/015.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc ABCDEFGHIJKLMNOPQRSTUVWXYZ CDATA #IMPLIED>
]>
<doc ABCDEFGHIJKLMNOPQRSTUVWXYZ="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa016xml [
	"Source file: xmltest/valid/sa/016.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa017axml [
	"Source file: xmltest/valid/sa/017a.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi some data ? > <??></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa017xml [
	"Source file: xmltest/valid/sa/017.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi some data ?><?x?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa018xml [
	"Source file: xmltest/valid/sa/018.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[<foo>]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa019xml [
	"Source file: xmltest/valid/sa/019.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[<&]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa020xml [
	"Source file: xmltest/valid/sa/020.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[<&]>]]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa021xml [
	"Source file: xmltest/valid/sa/021.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><!-- a comment --></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa022xml [
	"Source file: xmltest/valid/sa/022.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><!-- a comment ->--></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa023xml [
	"Source file: xmltest/valid/sa/023.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa024xml [
	"Source file: xmltest/valid/sa/024.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo)>
<!ELEMENT foo (#PCDATA)>
<!ENTITY e "&#60;foo></foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa025xml [
	"Source file: xmltest/valid/sa/025.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo*)>
<!ELEMENT foo (#PCDATA)>
]>
<doc><foo/><foo></foo></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa026xml [
	"Source file: xmltest/valid/sa/026.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo*)>
<!ELEMENT foo EMPTY>
]>
<doc><foo/><foo></foo></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa027xml [
	"Source file: xmltest/valid/sa/027.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo*)>
<!ELEMENT foo ANY>
]>
<doc><foo/><foo></foo></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa028xml [
	"Source file: xmltest/valid/sa/028.xml"

	^ '<?xml version="1.0"?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa029xml [
	"Source file: xmltest/valid/sa/029.xml"

	^ '<?xml version=''1.0''?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa030xml [
	"Source file: xmltest/valid/sa/030.xml"

	^ '<?xml version = "1.0"?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa031xml [
	"Source file: xmltest/valid/sa/031.xml"

	^ '<?xml version=''1.0'' encoding="UTF-8"?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa032xml [
	"Source file: xmltest/valid/sa/032.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa033xml [
	"Source file: xmltest/valid/sa/033.xml"

	^ '<?xml version=''1.0'' encoding="UTF-8" standalone=''yes''?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa034xml [
	"Source file: xmltest/valid/sa/034.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa035xml [
	"Source file: xmltest/valid/sa/035.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc />
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa036xml [
	"Source file: xmltest/valid/sa/036.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
<?pi data?>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa037xml [
	"Source file: xmltest/valid/sa/037.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
<!-- comment -->

'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa038xml [
	"Source file: xmltest/valid/sa/038.xml"

	^ '<!-- comment -->
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa039xml [
	"Source file: xmltest/valid/sa/039.xml"

	^ '<?pi data?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa040xml [
	"Source file: xmltest/valid/sa/040.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="&quot;&lt;&amp;&gt;&apos;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa041xml [
	"Source file: xmltest/valid/sa/041.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="&#65;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa042xml [
	"Source file: xmltest/valid/sa/042.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#00000000000000000000000000000000065;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa043xml [
	"Source file: xmltest/valid/sa/043.xml"

	^ '<!DOCTYPE doc [
<!ATTLIST doc a1 CDATA #IMPLIED>
<!ELEMENT doc (#PCDATA)>
]>
<doc a1="foo
bar"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa044xml [
	"Source file: xmltest/valid/sa/044.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (e*)>
<!ELEMENT e EMPTY>
<!ATTLIST e a1 CDATA "v1" a2 CDATA "v2" a3 CDATA #IMPLIED>
]>
<doc>
<e a3="v3"/>
<e a1="w1"/>
<e a2="w2" a3="v3"/>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa045xml [
	"Source file: xmltest/valid/sa/045.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
<!ATTLIST doc a1 CDATA "z1">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa046xml [
	"Source file: xmltest/valid/sa/046.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
<!ATTLIST doc a2 CDATA "v2">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa047xml [
	"Source file: xmltest/valid/sa/047.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>X
Y</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa048xml [
	"Source file: xmltest/valid/sa/048.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>]</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa049xml [
	"Source file: xmltest/valid/sa/049.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>', 16rA3 asCharacter asString, '</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa050xml [
	"Source file: xmltest/valid/sa/050.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa051xml [
	"Source file: xmltest/valid/sa/051.xml"

	^ '<!DOCTYPE ', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, ' [
<!ELEMENT ', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '  (#PCDATA)>
]>
<', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '></', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa052xml [
	"Source file: xmltest/valid/sa/052.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>', 16r10000 asCharacter asString, 16r10FFFD asCharacter asString, '</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa053xml [
	"Source file: xmltest/valid/sa/053.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<e/>">
<!ELEMENT doc (e)>
<!ELEMENT e EMPTY>
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa054xml [
	"Source file: xmltest/valid/sa/054.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>


<doc
></doc
>


'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa055xml [
	"Source file: xmltest/valid/sa/055.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<?pi  data?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa056xml [
	"Source file: xmltest/valid/sa/056.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x0000000000000000000000000000000000000041;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa057xml [
	"Source file: xmltest/valid/sa/057.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a*)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa058xml [
	"Source file: xmltest/valid/sa/058.xml"

	^ '<!DOCTYPE doc [
<!ATTLIST doc a1 NMTOKENS #IMPLIED>
<!ELEMENT doc (#PCDATA)>
]>
<doc a1=" 1  	2 	"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa059xml [
	"Source file: xmltest/valid/sa/059.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (e*)>
<!ELEMENT e EMPTY>
<!ATTLIST e a1 CDATA #IMPLIED a2 CDATA #IMPLIED a3 CDATA #IMPLIED>
]>
<doc>
<e a1="v1" a2="v2" a3="v3"/>
<e a1="w1" a2="v2"/>
<e a1="v1" a2="w2" a3="v3"/>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa060xml [
	"Source file: xmltest/valid/sa/060.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>X&#10;Y</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa061xml [
	"Source file: xmltest/valid/sa/061.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#163;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa062xml [
	"Source file: xmltest/valid/sa/062.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#xe40;&#xe08;&#xe21;', 16rE2A asCharacter asString, 16rE4C asCharacter asString, '</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa063xml [
	"Source file: xmltest/valid/sa/063.xml"

	^ '<!DOCTYPE ', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, ' [
<!ELEMENT ', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, ' (#PCDATA)>
]>
<', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '></', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa064xml [
	"Source file: xmltest/valid/sa/064.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x10000;&#x10FFFD;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa065xml [
	"Source file: xmltest/valid/sa/065.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa066xml [
	"Source file: xmltest/valid/sa/066.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
<!-- 34 is double quote -->
<!ENTITY e1 "&#34;">
]>
<doc a1="&e1;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa067xml [
	"Source file: xmltest/valid/sa/067.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#13;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa068xml [
	"Source file: xmltest/valid/sa/068.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "&#13;">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa069xml [
	"Source file: xmltest/valid/sa/069.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!NOTATION n PUBLIC "whatever">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa070xml [
	"Source file: xmltest/valid/sa/070.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e "<!ELEMENT doc (#PCDATA)>">
%e;
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa071xml [
	"Source file: xmltest/valid/sa/071.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ID #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa072xml [
	"Source file: xmltest/valid/sa/072.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a IDREF #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa073xml [
	"Source file: xmltest/valid/sa/073.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a IDREFS #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa074xml [
	"Source file: xmltest/valid/sa/074.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ENTITY #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa075xml [
	"Source file: xmltest/valid/sa/075.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ENTITIES #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa076xml [
	"Source file: xmltest/valid/sa/076.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a NOTATION (n1|n2) #IMPLIED>
<!NOTATION n1 SYSTEM "http://www.w3.org/">
<!NOTATION n2 SYSTEM "http://www.w3.org/">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa077xml [
	"Source file: xmltest/valid/sa/077.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a (1|2) #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa078xml [
	"Source file: xmltest/valid/sa/078.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #REQUIRED>
]>
<doc a="v"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa079xml [
	"Source file: xmltest/valid/sa/079.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #FIXED "v">
]>
<doc a="v"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa080xml [
	"Source file: xmltest/valid/sa/080.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #FIXED "v">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa081xml [
	"Source file: xmltest/valid/sa/081.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a, b, c)>
<!ELEMENT a (a?)>
<!ELEMENT b (b*)>
<!ELEMENT c (a | b)+>
]>
<doc><a/><b/><c><a/></c></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa082xml [
	"Source file: xmltest/valid/sa/082.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e SYSTEM "e.dtd">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa083xml [
	"Source file: xmltest/valid/sa/083.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e PUBLIC ''whatever'' "e.dtd">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa084xml [
	"Source file: xmltest/valid/sa/084.xml"

	^ '<!DOCTYPE doc [<!ELEMENT doc (#PCDATA)>]><doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa085xml [
	"Source file: xmltest/valid/sa/085.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "<foo>">
<!ENTITY e "">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa086xml [
	"Source file: xmltest/valid/sa/086.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "">
<!ENTITY e "<foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa087xml [
	"Source file: xmltest/valid/sa/087.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<foo/&#62;">
<!ELEMENT doc (foo)>
<!ELEMENT foo EMPTY>
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa088xml [
	"Source file: xmltest/valid/sa/088.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "&lt;foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa089xml [
	"Source file: xmltest/valid/sa/089.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#x10000;&#x10FFFD;&#x10FFFF;">
<!ELEMENT doc (#PCDATA)>
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa090xml [
	"Source file: xmltest/valid/sa/090.xml"

	^ '<!DOCTYPE doc [
<!ATTLIST e a NOTATION (n) #IMPLIED>
<!ELEMENT doc (e)*>
<!ELEMENT e (#PCDATA)>
<!NOTATION n PUBLIC "whatever">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa091xml [
	"Source file: xmltest/valid/sa/091.xml"

	^ '<!DOCTYPE doc [
<!NOTATION n SYSTEM "http://www.w3.org/">
<!ENTITY e SYSTEM "http://www.w3.org/" NDATA n>
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ENTITY "e">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa092xml [
	"Source file: xmltest/valid/sa/092.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a)*>
<!ELEMENT a EMPTY>
]>
<doc>
<a/>
    <a/>	<a/>


</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa093xml [
	"Source file: xmltest/valid/sa/093.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>


</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa094xml [
	"Source file: xmltest/valid/sa/094.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e "foo">
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "%e;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa095xml [
	"Source file: xmltest/valid/sa/095.xml"

	^ '<!DOCTYPE doc [
<!ATTLIST doc a1 CDATA #IMPLIED>
<!ATTLIST doc a1 NMTOKENS #IMPLIED>
<!ELEMENT doc (#PCDATA)>
]>
<doc a1="1  2"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa096xml [
	"Source file: xmltest/valid/sa/096.xml"

	^ '<!DOCTYPE doc [
<!ATTLIST doc a1 NMTOKENS " 1  	2 	">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa097ent [
	"Source file: xmltest/valid/sa/097.ent"

	^ '<!ATTLIST doc a2 CDATA #IMPLIED>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa097xml [
	"Source file: xmltest/valid/sa/097.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e SYSTEM "097.ent">
<!ATTLIST doc a1 CDATA "v1">
%e;
<!ATTLIST doc a2 CDATA "v2">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa098xml [
	"Source file: xmltest/valid/sa/098.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi x
y?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa099xml [
	"Source file: xmltest/valid/sa/099.xml"

	^ '<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa100xml [
	"Source file: xmltest/valid/sa/100.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e PUBLIC ";!*#@$_%" "100.xml">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa101xml [
	"Source file: xmltest/valid/sa/101.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "&#34;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa102xml [
	"Source file: xmltest/valid/sa/102.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="&#34;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa103xml [
	"Source file: xmltest/valid/sa/103.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#60;doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa104xml [
	"Source file: xmltest/valid/sa/104.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x	y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa105xml [
	"Source file: xmltest/valid/sa/105.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x&#9;y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa106xml [
	"Source file: xmltest/valid/sa/106.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x&#10;y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa107xml [
	"Source file: xmltest/valid/sa/107.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x&#13;y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa108xml [
	"Source file: xmltest/valid/sa/108.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "
">
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x&e;y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa109xml [
	"Source file: xmltest/valid/sa/109.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a=""></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa110xml [
	"Source file: xmltest/valid/sa/110.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "&#13;&#10;">
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x&e;y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa111xml [
	"Source file: xmltest/valid/sa/111.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a NMTOKENS #IMPLIED>
]>
<doc a="&#32;x&#32;&#32;y&#32;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa112xml [
	"Source file: xmltest/valid/sa/112.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a | b)>
<!ELEMENT a (#PCDATA)>
]>
<doc><a></a></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa113xml [
	"Source file: xmltest/valid/sa/113.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST e a CDATA #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa114xml [
	"Source file: xmltest/valid/sa/114.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "<![CDATA[&foo;]]>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa115xml [
	"Source file: xmltest/valid/sa/115.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e1 "&e2;">
<!ENTITY e2 "v">
]>
<doc>&e1;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa116xml [
	"Source file: xmltest/valid/sa/116.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[
]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa117xml [
	"Source file: xmltest/valid/sa/117.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY rsqb "]">
]>
<doc>&rsqb;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa118xml [
	"Source file: xmltest/valid/sa/118.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY rsqb "]]">
]>
<doc>&rsqb;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsa119xml [
	"Source file: xmltest/valid/sa/119.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc ANY>
]>
<doc><!-- -', 16rE1 asCharacter asString, ' --></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout001xml [
	"Source file: xmltest/valid/sa/out/001.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout002xml [
	"Source file: xmltest/valid/sa/out/002.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout003xml [
	"Source file: xmltest/valid/sa/out/003.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout004xml [
	"Source file: xmltest/valid/sa/out/004.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout005xml [
	"Source file: xmltest/valid/sa/out/005.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout006xml [
	"Source file: xmltest/valid/sa/out/006.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout007xml [
	"Source file: xmltest/valid/sa/out/007.xml"

	^ '<doc> </doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout008xml [
	"Source file: xmltest/valid/sa/out/008.xml"

	^ '<doc>&amp;&lt;&gt;&quot;''</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout009xml [
	"Source file: xmltest/valid/sa/out/009.xml"

	^ '<doc> </doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout010xml [
	"Source file: xmltest/valid/sa/out/010.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout011xml [
	"Source file: xmltest/valid/sa/out/011.xml"

	^ '<doc a1="v1" a2="v2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout012xml [
	"Source file: xmltest/valid/sa/out/012.xml"

	^ '<doc :="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout013xml [
	"Source file: xmltest/valid/sa/out/013.xml"

	^ '<doc _.-0123456789="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout014xml [
	"Source file: xmltest/valid/sa/out/014.xml"

	^ '<doc abcdefghijklmnopqrstuvwxyz="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout015xml [
	"Source file: xmltest/valid/sa/out/015.xml"

	^ '<doc ABCDEFGHIJKLMNOPQRSTUVWXYZ="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout016xml [
	"Source file: xmltest/valid/sa/out/016.xml"

	^ '<doc><?pi ?></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout017axml [
	"Source file: xmltest/valid/sa/out/017a.xml"

	^ '<doc><?pi some data ? > <??></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout017xml [
	"Source file: xmltest/valid/sa/out/017.xml"

	^ '<doc><?pi some data ?><?x ?></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout018xml [
	"Source file: xmltest/valid/sa/out/018.xml"

	^ '<doc>&lt;foo&gt;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout019xml [
	"Source file: xmltest/valid/sa/out/019.xml"

	^ '<doc>&lt;&amp;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout020xml [
	"Source file: xmltest/valid/sa/out/020.xml"

	^ '<doc>&lt;&amp;]&gt;]</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout021xml [
	"Source file: xmltest/valid/sa/out/021.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout022xml [
	"Source file: xmltest/valid/sa/out/022.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout023xml [
	"Source file: xmltest/valid/sa/out/023.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout024xml [
	"Source file: xmltest/valid/sa/out/024.xml"

	^ '<doc><foo></foo></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout025xml [
	"Source file: xmltest/valid/sa/out/025.xml"

	^ '<doc><foo></foo><foo></foo></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout026xml [
	"Source file: xmltest/valid/sa/out/026.xml"

	^ '<doc><foo></foo><foo></foo></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout027xml [
	"Source file: xmltest/valid/sa/out/027.xml"

	^ '<doc><foo></foo><foo></foo></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout028xml [
	"Source file: xmltest/valid/sa/out/028.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout029xml [
	"Source file: xmltest/valid/sa/out/029.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout030xml [
	"Source file: xmltest/valid/sa/out/030.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout031xml [
	"Source file: xmltest/valid/sa/out/031.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout032xml [
	"Source file: xmltest/valid/sa/out/032.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout033xml [
	"Source file: xmltest/valid/sa/out/033.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout034xml [
	"Source file: xmltest/valid/sa/out/034.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout035xml [
	"Source file: xmltest/valid/sa/out/035.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout036xml [
	"Source file: xmltest/valid/sa/out/036.xml"

	^ '<doc></doc><?pi data?>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout037xml [
	"Source file: xmltest/valid/sa/out/037.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout038xml [
	"Source file: xmltest/valid/sa/out/038.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout039xml [
	"Source file: xmltest/valid/sa/out/039.xml"

	^ '<?pi data?><doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout040xml [
	"Source file: xmltest/valid/sa/out/040.xml"

	^ '<doc a1="&quot;&lt;&amp;&gt;''"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout041xml [
	"Source file: xmltest/valid/sa/out/041.xml"

	^ '<doc a1="A"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout042xml [
	"Source file: xmltest/valid/sa/out/042.xml"

	^ '<doc>A</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout043xml [
	"Source file: xmltest/valid/sa/out/043.xml"

	^ '<doc a1="foo bar"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout044xml [
	"Source file: xmltest/valid/sa/out/044.xml"

	^ '<doc>&#10;<e a1="v1" a2="v2" a3="v3"></e>&#10;<e a1="w1" a2="v2"></e>&#10;<e a1="v1" a2="w2" a3="v3"></e>&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout045xml [
	"Source file: xmltest/valid/sa/out/045.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout046xml [
	"Source file: xmltest/valid/sa/out/046.xml"

	^ '<doc a1="v1" a2="v2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout047xml [
	"Source file: xmltest/valid/sa/out/047.xml"

	^ '<doc>X&#10;Y</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout048xml [
	"Source file: xmltest/valid/sa/out/048.xml"

	^ '<doc>]</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout049xml [
	"Source file: xmltest/valid/sa/out/049.xml"

	^ '<doc>', 16rA3 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout050xml [
	"Source file: xmltest/valid/sa/out/050.xml"

	^ '<doc>', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout051xml [
	"Source file: xmltest/valid/sa/out/051.xml"

	^ '<', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '></', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout052xml [
	"Source file: xmltest/valid/sa/out/052.xml"

	^ '<doc>', 16r10000 asCharacter asString, 16r10FFFD asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout053xml [
	"Source file: xmltest/valid/sa/out/053.xml"

	^ '<doc><e></e></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout054xml [
	"Source file: xmltest/valid/sa/out/054.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout055xml [
	"Source file: xmltest/valid/sa/out/055.xml"

	^ '<?pi data?><doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout056xml [
	"Source file: xmltest/valid/sa/out/056.xml"

	^ '<doc>A</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout057xml [
	"Source file: xmltest/valid/sa/out/057.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout058xml [
	"Source file: xmltest/valid/sa/out/058.xml"

	^ '<doc a1="1 2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout059xml [
	"Source file: xmltest/valid/sa/out/059.xml"

	^ '<doc>&#10;<e a1="v1" a2="v2" a3="v3"></e>&#10;<e a1="w1" a2="v2"></e>&#10;<e a1="v1" a2="w2" a3="v3"></e>&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout060xml [
	"Source file: xmltest/valid/sa/out/060.xml"

	^ '<doc>X&#10;Y</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout061xml [
	"Source file: xmltest/valid/sa/out/061.xml"

	^ '<doc>', 16rA3 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout062xml [
	"Source file: xmltest/valid/sa/out/062.xml"

	^ '<doc>', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout063xml [
	"Source file: xmltest/valid/sa/out/063.xml"

	^ '<', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '></', 16rE40 asCharacter asString, 16rE08 asCharacter asString, 16rE21 asCharacter asString, 16rE2A asCharacter asString, 16rE4C asCharacter asString, '>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout064xml [
	"Source file: xmltest/valid/sa/out/064.xml"

	^ '<doc>', 16r10000 asCharacter asString, 16r10FFFD asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout065xml [
	"Source file: xmltest/valid/sa/out/065.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout066xml [
	"Source file: xmltest/valid/sa/out/066.xml"

	^ '<doc a1="&quot;"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout067xml [
	"Source file: xmltest/valid/sa/out/067.xml"

	^ '<doc>&#13;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout068xml [
	"Source file: xmltest/valid/sa/out/068.xml"

	^ '<doc>&#13;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout069xml [
	"Source file: xmltest/valid/sa/out/069.xml"

	^ '<!DOCTYPE doc [
<!NOTATION n PUBLIC ''whatever''>
]>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout070xml [
	"Source file: xmltest/valid/sa/out/070.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout071xml [
	"Source file: xmltest/valid/sa/out/071.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout072xml [
	"Source file: xmltest/valid/sa/out/072.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout073xml [
	"Source file: xmltest/valid/sa/out/073.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout074xml [
	"Source file: xmltest/valid/sa/out/074.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout075xml [
	"Source file: xmltest/valid/sa/out/075.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout076xml [
	"Source file: xmltest/valid/sa/out/076.xml"

	^ '<!DOCTYPE doc [
<!NOTATION n1 SYSTEM ''http://www.w3.org/''>
<!NOTATION n2 SYSTEM ''http://www.w3.org/''>
]>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout077xml [
	"Source file: xmltest/valid/sa/out/077.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout078xml [
	"Source file: xmltest/valid/sa/out/078.xml"

	^ '<doc a="v"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout079xml [
	"Source file: xmltest/valid/sa/out/079.xml"

	^ '<doc a="v"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout080xml [
	"Source file: xmltest/valid/sa/out/080.xml"

	^ '<doc a="v"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout081xml [
	"Source file: xmltest/valid/sa/out/081.xml"

	^ '<doc><a></a><b></b><c><a></a></c></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout082xml [
	"Source file: xmltest/valid/sa/out/082.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout083xml [
	"Source file: xmltest/valid/sa/out/083.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout084xml [
	"Source file: xmltest/valid/sa/out/084.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout085xml [
	"Source file: xmltest/valid/sa/out/085.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout086xml [
	"Source file: xmltest/valid/sa/out/086.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout087xml [
	"Source file: xmltest/valid/sa/out/087.xml"

	^ '<doc><foo></foo></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout088xml [
	"Source file: xmltest/valid/sa/out/088.xml"

	^ '<doc>&lt;foo&gt;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout089xml [
	"Source file: xmltest/valid/sa/out/089.xml"

	^ '<doc>', 16r10000 asCharacter asString, 16r10FFFD asCharacter asString, 16r10FFFF asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout090xml [
	"Source file: xmltest/valid/sa/out/090.xml"

	^ '<!DOCTYPE doc [
<!NOTATION n PUBLIC ''whatever''>
]>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout091xml [
	"Source file: xmltest/valid/sa/out/091.xml"

	^ '<!DOCTYPE doc [
<!NOTATION n SYSTEM ''http://www.w3.org/''>
]>
<doc a="e"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout092xml [
	"Source file: xmltest/valid/sa/out/092.xml"

	^ '<doc>&#10;<a></a>&#10;    <a></a>&#9;<a></a>&#10;&#10;&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout093xml [
	"Source file: xmltest/valid/sa/out/093.xml"

	^ '<doc>&#10;&#10;&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout094xml [
	"Source file: xmltest/valid/sa/out/094.xml"

	^ '<doc a1="%e;"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout095xml [
	"Source file: xmltest/valid/sa/out/095.xml"

	^ '<doc a1="1  2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout096xml [
	"Source file: xmltest/valid/sa/out/096.xml"

	^ '<doc a1="1 2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout097xml [
	"Source file: xmltest/valid/sa/out/097.xml"

	^ '<doc a1="v1"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout098xml [
	"Source file: xmltest/valid/sa/out/098.xml"

	^ '<doc><?pi x
y?></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout099xml [
	"Source file: xmltest/valid/sa/out/099.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout100xml [
	"Source file: xmltest/valid/sa/out/100.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout101xml [
	"Source file: xmltest/valid/sa/out/101.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout102xml [
	"Source file: xmltest/valid/sa/out/102.xml"

	^ '<doc a="&quot;"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout103xml [
	"Source file: xmltest/valid/sa/out/103.xml"

	^ '<doc>&lt;doc&gt;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout104xml [
	"Source file: xmltest/valid/sa/out/104.xml"

	^ '<doc a="x y"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout105xml [
	"Source file: xmltest/valid/sa/out/105.xml"

	^ '<doc a="x&#9;y"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout106xml [
	"Source file: xmltest/valid/sa/out/106.xml"

	^ '<doc a="x&#10;y"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout107xml [
	"Source file: xmltest/valid/sa/out/107.xml"

	^ '<doc a="x&#13;y"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout108xml [
	"Source file: xmltest/valid/sa/out/108.xml"

	^ '<doc a="x y"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout109xml [
	"Source file: xmltest/valid/sa/out/109.xml"

	^ '<doc a=""></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout110xml [
	"Source file: xmltest/valid/sa/out/110.xml"

	^ '<doc a="x  y"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout111xml [
	"Source file: xmltest/valid/sa/out/111.xml"

	^ '<doc a="x y"></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout112xml [
	"Source file: xmltest/valid/sa/out/112.xml"

	^ '<doc><a></a></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout113xml [
	"Source file: xmltest/valid/sa/out/113.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout114xml [
	"Source file: xmltest/valid/sa/out/114.xml"

	^ '<doc>&amp;foo;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout115xml [
	"Source file: xmltest/valid/sa/out/115.xml"

	^ '<doc>v</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout116xml [
	"Source file: xmltest/valid/sa/out/116.xml"

	^ '<doc>&#10;</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout117xml [
	"Source file: xmltest/valid/sa/out/117.xml"

	^ '<doc>]</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout118xml [
	"Source file: xmltest/valid/sa/out/118.xml"

	^ '<doc>]]</doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTest class >> sourcevalidsaout119xml [
	"Source file: xmltest/valid/sa/out/119.xml"

	^ '<doc></doc>'
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testinvalid002xml [
	"Source file: xmltest/invalid/002.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalid002xml.
	self
		should: [
			self
				parse: self class sourceinvalid002xml
				documentURI: 'invalid/002.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testinvalid005xml [
	"Source file: xmltest/invalid/005.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalid005xml.
	self
		should: [
			self
				parse: self class sourceinvalid005xml
				documentURI: 'invalid/005.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testinvalid006xml [
	"Source file: xmltest/invalid/006.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalid006xml.
	self
		should: [
			self
				parse: self class sourceinvalid006xml
				documentURI: 'invalid/006.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testinvalidnotsa022xml [
	"Source file: xmltest/invalid/not-sa/022.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testinvalidnotsa022xml.
	self
		should: [
			self
				parse: self class sourceinvalidnotsa022xml
				documentURI: 'invalid/not-sa/022.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfextsa001xml [
	"Source file: xmltest/not-wf/ext-sa/001.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfextsa001xml.
	self
		should: [
			self
				parse: self class sourcenotwfextsa001xml
				documentURI: 'not-wf/ext-sa/001.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfextsa002xml [
	"Source file: xmltest/not-wf/ext-sa/002.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfextsa002xml.
	self
		should: [
			self
				parse: self class sourcenotwfextsa002xml
				documentURI: 'not-wf/ext-sa/002.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfextsa003xml [
	"Source file: xmltest/not-wf/ext-sa/003.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfextsa003xml.
	self
		should: [
			self
				parse: self class sourcenotwfextsa003xml
				documentURI: 'not-wf/ext-sa/003.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa001xml [
	"Source file: xmltest/not-wf/not-sa/001.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa001xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa001xml
				documentURI: 'not-wf/not-sa/001.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa002xml [
	"Source file: xmltest/not-wf/not-sa/002.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa002xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa002xml
				documentURI: 'not-wf/not-sa/002.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa003xml [
	"Source file: xmltest/not-wf/not-sa/003.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa003xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa003xml
				documentURI: 'not-wf/not-sa/003.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa004xml [
	"Source file: xmltest/not-wf/not-sa/004.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa004xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa004xml
				documentURI: 'not-wf/not-sa/004.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa005xml [
	"Source file: xmltest/not-wf/not-sa/005.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa005xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa005xml
				documentURI: 'not-wf/not-sa/005.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa006xml [
	"Source file: xmltest/not-wf/not-sa/006.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa006xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa006xml
				documentURI: 'not-wf/not-sa/006.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa007xml [
	"Source file: xmltest/not-wf/not-sa/007.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa007xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa007xml
				documentURI: 'not-wf/not-sa/007.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa008xml [
	"Source file: xmltest/not-wf/not-sa/008.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa008xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa008xml
				documentURI: 'not-wf/not-sa/008.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa009xml [
	"Source file: xmltest/not-wf/not-sa/009.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa009xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa009xml
				documentURI: 'not-wf/not-sa/009.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa010xml [
	"Source file: xmltest/not-wf/not-sa/010.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa010xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa010xml
				documentURI: 'not-wf/not-sa/010.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfnotsa011xml [
	"Source file: xmltest/not-wf/not-sa/011.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfnotsa011xml.
	self
		should: [
			self
				parse: self class sourcenotwfnotsa011xml
				documentURI: 'not-wf/not-sa/011.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa001xml [
	"Source file: xmltest/not-wf/sa/001.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa001xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa001xml
				documentURI: 'not-wf/sa/001.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa002xml [
	"Source file: xmltest/not-wf/sa/002.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa002xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa002xml
				documentURI: 'not-wf/sa/002.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa003xml [
	"Source file: xmltest/not-wf/sa/003.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa003xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa003xml
				documentURI: 'not-wf/sa/003.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa004xml [
	"Source file: xmltest/not-wf/sa/004.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa004xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa004xml
				documentURI: 'not-wf/sa/004.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa005xml [
	"Source file: xmltest/not-wf/sa/005.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa005xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa005xml
				documentURI: 'not-wf/sa/005.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa006xml [
	"Source file: xmltest/not-wf/sa/006.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa006xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa006xml
				documentURI: 'not-wf/sa/006.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa007xml [
	"Source file: xmltest/not-wf/sa/007.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa007xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa007xml
				documentURI: 'not-wf/sa/007.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa008xml [
	"Source file: xmltest/not-wf/sa/008.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa008xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa008xml
				documentURI: 'not-wf/sa/008.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa009xml [
	"Source file: xmltest/not-wf/sa/009.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa009xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa009xml
				documentURI: 'not-wf/sa/009.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa010xml [
	"Source file: xmltest/not-wf/sa/010.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa010xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa010xml
				documentURI: 'not-wf/sa/010.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa011xml [
	"Source file: xmltest/not-wf/sa/011.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa011xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa011xml
				documentURI: 'not-wf/sa/011.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa012xml [
	"Source file: xmltest/not-wf/sa/012.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa012xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa012xml
				documentURI: 'not-wf/sa/012.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa013xml [
	"Source file: xmltest/not-wf/sa/013.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa013xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa013xml
				documentURI: 'not-wf/sa/013.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa014xml [
	"Source file: xmltest/not-wf/sa/014.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa014xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa014xml
				documentURI: 'not-wf/sa/014.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa015xml [
	"Source file: xmltest/not-wf/sa/015.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa015xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa015xml
				documentURI: 'not-wf/sa/015.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa016xml [
	"Source file: xmltest/not-wf/sa/016.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa016xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa016xml
				documentURI: 'not-wf/sa/016.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa017xml [
	"Source file: xmltest/not-wf/sa/017.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa017xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa017xml
				documentURI: 'not-wf/sa/017.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa018xml [
	"Source file: xmltest/not-wf/sa/018.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa018xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa018xml
				documentURI: 'not-wf/sa/018.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa019xml [
	"Source file: xmltest/not-wf/sa/019.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa019xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa019xml
				documentURI: 'not-wf/sa/019.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa020xml [
	"Source file: xmltest/not-wf/sa/020.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa020xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa020xml
				documentURI: 'not-wf/sa/020.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa021xml [
	"Source file: xmltest/not-wf/sa/021.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa021xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa021xml
				documentURI: 'not-wf/sa/021.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa022xml [
	"Source file: xmltest/not-wf/sa/022.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa022xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa022xml
				documentURI: 'not-wf/sa/022.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa023xml [
	"Source file: xmltest/not-wf/sa/023.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa023xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa023xml
				documentURI: 'not-wf/sa/023.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa024xml [
	"Source file: xmltest/not-wf/sa/024.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa024xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa024xml
				documentURI: 'not-wf/sa/024.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa025xml [
	"Source file: xmltest/not-wf/sa/025.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa025xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa025xml
				documentURI: 'not-wf/sa/025.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa026xml [
	"Source file: xmltest/not-wf/sa/026.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa026xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa026xml
				documentURI: 'not-wf/sa/026.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa027xml [
	"Source file: xmltest/not-wf/sa/027.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa027xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa027xml
				documentURI: 'not-wf/sa/027.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa028xml [
	"Source file: xmltest/not-wf/sa/028.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa028xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa028xml
				documentURI: 'not-wf/sa/028.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa029xml [
	"Source file: xmltest/not-wf/sa/029.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa029xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa029xml
				documentURI: 'not-wf/sa/029.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa030xml [
	"Source file: xmltest/not-wf/sa/030.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa030xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa030xml
				documentURI: 'not-wf/sa/030.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa031xml [
	"Source file: xmltest/not-wf/sa/031.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa031xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa031xml
				documentURI: 'not-wf/sa/031.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa032xml [
	"Source file: xmltest/not-wf/sa/032.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa032xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa032xml
				documentURI: 'not-wf/sa/032.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa033xml [
	"Source file: xmltest/not-wf/sa/033.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa033xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa033xml
				documentURI: 'not-wf/sa/033.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa034xml [
	"Source file: xmltest/not-wf/sa/034.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa034xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa034xml
				documentURI: 'not-wf/sa/034.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa035xml [
	"Source file: xmltest/not-wf/sa/035.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa035xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa035xml
				documentURI: 'not-wf/sa/035.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa036xml [
	"Source file: xmltest/not-wf/sa/036.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa036xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa036xml
				documentURI: 'not-wf/sa/036.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa037xml [
	"Source file: xmltest/not-wf/sa/037.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa037xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa037xml
				documentURI: 'not-wf/sa/037.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa038xml [
	"Source file: xmltest/not-wf/sa/038.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa038xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa038xml
				documentURI: 'not-wf/sa/038.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa039xml [
	"Source file: xmltest/not-wf/sa/039.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa039xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa039xml
				documentURI: 'not-wf/sa/039.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa040xml [
	"Source file: xmltest/not-wf/sa/040.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa040xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa040xml
				documentURI: 'not-wf/sa/040.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa041xml [
	"Source file: xmltest/not-wf/sa/041.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa041xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa041xml
				documentURI: 'not-wf/sa/041.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa042xml [
	"Source file: xmltest/not-wf/sa/042.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa042xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa042xml
				documentURI: 'not-wf/sa/042.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa043xml [
	"Source file: xmltest/not-wf/sa/043.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa043xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa043xml
				documentURI: 'not-wf/sa/043.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa044xml [
	"Source file: xmltest/not-wf/sa/044.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa044xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa044xml
				documentURI: 'not-wf/sa/044.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa045xml [
	"Source file: xmltest/not-wf/sa/045.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa045xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa045xml
				documentURI: 'not-wf/sa/045.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa046xml [
	"Source file: xmltest/not-wf/sa/046.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa046xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa046xml
				documentURI: 'not-wf/sa/046.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa047xml [
	"Source file: xmltest/not-wf/sa/047.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa047xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa047xml
				documentURI: 'not-wf/sa/047.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa048xml [
	"Source file: xmltest/not-wf/sa/048.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa048xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa048xml
				documentURI: 'not-wf/sa/048.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa049xml [
	"Source file: xmltest/not-wf/sa/049.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa049xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa049xml
				documentURI: 'not-wf/sa/049.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa050xml [
	"Source file: xmltest/not-wf/sa/050.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa050xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa050xml
				documentURI: 'not-wf/sa/050.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa051xml [
	"Source file: xmltest/not-wf/sa/051.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa051xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa051xml
				documentURI: 'not-wf/sa/051.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa052xml [
	"Source file: xmltest/not-wf/sa/052.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa052xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa052xml
				documentURI: 'not-wf/sa/052.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa053xml [
	"Source file: xmltest/not-wf/sa/053.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa053xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa053xml
				documentURI: 'not-wf/sa/053.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa054xml [
	"Source file: xmltest/not-wf/sa/054.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa054xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa054xml
				documentURI: 'not-wf/sa/054.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa055xml [
	"Source file: xmltest/not-wf/sa/055.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa055xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa055xml
				documentURI: 'not-wf/sa/055.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa056xml [
	"Source file: xmltest/not-wf/sa/056.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa056xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa056xml
				documentURI: 'not-wf/sa/056.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa057xml [
	"Source file: xmltest/not-wf/sa/057.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa057xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa057xml
				documentURI: 'not-wf/sa/057.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa058xml [
	"Source file: xmltest/not-wf/sa/058.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa058xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa058xml
				documentURI: 'not-wf/sa/058.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa059xml [
	"Source file: xmltest/not-wf/sa/059.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa059xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa059xml
				documentURI: 'not-wf/sa/059.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa060xml [
	"Source file: xmltest/not-wf/sa/060.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa060xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa060xml
				documentURI: 'not-wf/sa/060.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa061xml [
	"Source file: xmltest/not-wf/sa/061.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa061xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa061xml
				documentURI: 'not-wf/sa/061.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa062xml [
	"Source file: xmltest/not-wf/sa/062.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa062xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa062xml
				documentURI: 'not-wf/sa/062.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa063xml [
	"Source file: xmltest/not-wf/sa/063.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa063xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa063xml
				documentURI: 'not-wf/sa/063.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa064xml [
	"Source file: xmltest/not-wf/sa/064.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa064xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa064xml
				documentURI: 'not-wf/sa/064.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa065xml [
	"Source file: xmltest/not-wf/sa/065.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa065xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa065xml
				documentURI: 'not-wf/sa/065.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa066xml [
	"Source file: xmltest/not-wf/sa/066.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa066xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa066xml
				documentURI: 'not-wf/sa/066.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa067xml [
	"Source file: xmltest/not-wf/sa/067.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa067xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa067xml
				documentURI: 'not-wf/sa/067.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa068xml [
	"Source file: xmltest/not-wf/sa/068.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa068xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa068xml
				documentURI: 'not-wf/sa/068.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa069xml [
	"Source file: xmltest/not-wf/sa/069.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa069xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa069xml
				documentURI: 'not-wf/sa/069.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa070xml [
	"Source file: xmltest/not-wf/sa/070.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa070xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa070xml
				documentURI: 'not-wf/sa/070.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa071xml [
	"Source file: xmltest/not-wf/sa/071.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa071xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa071xml
				documentURI: 'not-wf/sa/071.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa072xml [
	"Source file: xmltest/not-wf/sa/072.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa072xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa072xml
				documentURI: 'not-wf/sa/072.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa073xml [
	"Source file: xmltest/not-wf/sa/073.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa073xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa073xml
				documentURI: 'not-wf/sa/073.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa074xml [
	"Source file: xmltest/not-wf/sa/074.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa074xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa074xml
				documentURI: 'not-wf/sa/074.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa075xml [
	"Source file: xmltest/not-wf/sa/075.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa075xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa075xml
				documentURI: 'not-wf/sa/075.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa076xml [
	"Source file: xmltest/not-wf/sa/076.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa076xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa076xml
				documentURI: 'not-wf/sa/076.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa077xml [
	"Source file: xmltest/not-wf/sa/077.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa077xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa077xml
				documentURI: 'not-wf/sa/077.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa078xml [
	"Source file: xmltest/not-wf/sa/078.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa078xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa078xml
				documentURI: 'not-wf/sa/078.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa079xml [
	"Source file: xmltest/not-wf/sa/079.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa079xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa079xml
				documentURI: 'not-wf/sa/079.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa080xml [
	"Source file: xmltest/not-wf/sa/080.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa080xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa080xml
				documentURI: 'not-wf/sa/080.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa081xml [
	"Source file: xmltest/not-wf/sa/081.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa081xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa081xml
				documentURI: 'not-wf/sa/081.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa082xml [
	"Source file: xmltest/not-wf/sa/082.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa082xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa082xml
				documentURI: 'not-wf/sa/082.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa083xml [
	"Source file: xmltest/not-wf/sa/083.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa083xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa083xml
				documentURI: 'not-wf/sa/083.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa084xml [
	"Source file: xmltest/not-wf/sa/084.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa084xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa084xml
				documentURI: 'not-wf/sa/084.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa085xml [
	"Source file: xmltest/not-wf/sa/085.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa085xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa085xml
				documentURI: 'not-wf/sa/085.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa086xml [
	"Source file: xmltest/not-wf/sa/086.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa086xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa086xml
				documentURI: 'not-wf/sa/086.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa087xml [
	"Source file: xmltest/not-wf/sa/087.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa087xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa087xml
				documentURI: 'not-wf/sa/087.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa088xml [
	"Source file: xmltest/not-wf/sa/088.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa088xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa088xml
				documentURI: 'not-wf/sa/088.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa089xml [
	"Source file: xmltest/not-wf/sa/089.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa089xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa089xml
				documentURI: 'not-wf/sa/089.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa090xml [
	"Source file: xmltest/not-wf/sa/090.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa090xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa090xml
				documentURI: 'not-wf/sa/090.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa091xml [
	"Source file: xmltest/not-wf/sa/091.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa091xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa091xml
				documentURI: 'not-wf/sa/091.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa092xml [
	"Source file: xmltest/not-wf/sa/092.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa092xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa092xml
				documentURI: 'not-wf/sa/092.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa093xml [
	"Source file: xmltest/not-wf/sa/093.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa093xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa093xml
				documentURI: 'not-wf/sa/093.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa094xml [
	"Source file: xmltest/not-wf/sa/094.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa094xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa094xml
				documentURI: 'not-wf/sa/094.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa095xml [
	"Source file: xmltest/not-wf/sa/095.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa095xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa095xml
				documentURI: 'not-wf/sa/095.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa096xml [
	"Source file: xmltest/not-wf/sa/096.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa096xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa096xml
				documentURI: 'not-wf/sa/096.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa097xml [
	"Source file: xmltest/not-wf/sa/097.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa097xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa097xml
				documentURI: 'not-wf/sa/097.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa098xml [
	"Source file: xmltest/not-wf/sa/098.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa098xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa098xml
				documentURI: 'not-wf/sa/098.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa099xml [
	"Source file: xmltest/not-wf/sa/099.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa099xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa099xml
				documentURI: 'not-wf/sa/099.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa100xml [
	"Source file: xmltest/not-wf/sa/100.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa100xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa100xml
				documentURI: 'not-wf/sa/100.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa101xml [
	"Source file: xmltest/not-wf/sa/101.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa101xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa101xml
				documentURI: 'not-wf/sa/101.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa102xml [
	"Source file: xmltest/not-wf/sa/102.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa102xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa102xml
				documentURI: 'not-wf/sa/102.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa103xml [
	"Source file: xmltest/not-wf/sa/103.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa103xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa103xml
				documentURI: 'not-wf/sa/103.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa104xml [
	"Source file: xmltest/not-wf/sa/104.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa104xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa104xml
				documentURI: 'not-wf/sa/104.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa105xml [
	"Source file: xmltest/not-wf/sa/105.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa105xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa105xml
				documentURI: 'not-wf/sa/105.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa106xml [
	"Source file: xmltest/not-wf/sa/106.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa106xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa106xml
				documentURI: 'not-wf/sa/106.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa107xml [
	"Source file: xmltest/not-wf/sa/107.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa107xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa107xml
				documentURI: 'not-wf/sa/107.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa108xml [
	"Source file: xmltest/not-wf/sa/108.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa108xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa108xml
				documentURI: 'not-wf/sa/108.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa109xml [
	"Source file: xmltest/not-wf/sa/109.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa109xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa109xml
				documentURI: 'not-wf/sa/109.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa110xml [
	"Source file: xmltest/not-wf/sa/110.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa110xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa110xml
				documentURI: 'not-wf/sa/110.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa111xml [
	"Source file: xmltest/not-wf/sa/111.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa111xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa111xml
				documentURI: 'not-wf/sa/111.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa112xml [
	"Source file: xmltest/not-wf/sa/112.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa112xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa112xml
				documentURI: 'not-wf/sa/112.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa113xml [
	"Source file: xmltest/not-wf/sa/113.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa113xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa113xml
				documentURI: 'not-wf/sa/113.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa114xml [
	"Source file: xmltest/not-wf/sa/114.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa114xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa114xml
				documentURI: 'not-wf/sa/114.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa115xml [
	"Source file: xmltest/not-wf/sa/115.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa115xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa115xml
				documentURI: 'not-wf/sa/115.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa116xml [
	"Source file: xmltest/not-wf/sa/116.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa116xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa116xml
				documentURI: 'not-wf/sa/116.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa117xml [
	"Source file: xmltest/not-wf/sa/117.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa117xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa117xml
				documentURI: 'not-wf/sa/117.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa118xml [
	"Source file: xmltest/not-wf/sa/118.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa118xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa118xml
				documentURI: 'not-wf/sa/118.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa119xml [
	"Source file: xmltest/not-wf/sa/119.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa119xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa119xml
				documentURI: 'not-wf/sa/119.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa120xml [
	"Source file: xmltest/not-wf/sa/120.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa120xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa120xml
				documentURI: 'not-wf/sa/120.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa121xml [
	"Source file: xmltest/not-wf/sa/121.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa121xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa121xml
				documentURI: 'not-wf/sa/121.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa122xml [
	"Source file: xmltest/not-wf/sa/122.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa122xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa122xml
				documentURI: 'not-wf/sa/122.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa123xml [
	"Source file: xmltest/not-wf/sa/123.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa123xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa123xml
				documentURI: 'not-wf/sa/123.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa124xml [
	"Source file: xmltest/not-wf/sa/124.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa124xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa124xml
				documentURI: 'not-wf/sa/124.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa125xml [
	"Source file: xmltest/not-wf/sa/125.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa125xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa125xml
				documentURI: 'not-wf/sa/125.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa126xml [
	"Source file: xmltest/not-wf/sa/126.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa126xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa126xml
				documentURI: 'not-wf/sa/126.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa127xml [
	"Source file: xmltest/not-wf/sa/127.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa127xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa127xml
				documentURI: 'not-wf/sa/127.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa128xml [
	"Source file: xmltest/not-wf/sa/128.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa128xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa128xml
				documentURI: 'not-wf/sa/128.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa129xml [
	"Source file: xmltest/not-wf/sa/129.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa129xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa129xml
				documentURI: 'not-wf/sa/129.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa130xml [
	"Source file: xmltest/not-wf/sa/130.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa130xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa130xml
				documentURI: 'not-wf/sa/130.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa131xml [
	"Source file: xmltest/not-wf/sa/131.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa131xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa131xml
				documentURI: 'not-wf/sa/131.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa132xml [
	"Source file: xmltest/not-wf/sa/132.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa132xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa132xml
				documentURI: 'not-wf/sa/132.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa133xml [
	"Source file: xmltest/not-wf/sa/133.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa133xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa133xml
				documentURI: 'not-wf/sa/133.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa134xml [
	"Source file: xmltest/not-wf/sa/134.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa134xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa134xml
				documentURI: 'not-wf/sa/134.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa135xml [
	"Source file: xmltest/not-wf/sa/135.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa135xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa135xml
				documentURI: 'not-wf/sa/135.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa136xml [
	"Source file: xmltest/not-wf/sa/136.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa136xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa136xml
				documentURI: 'not-wf/sa/136.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa137xml [
	"Source file: xmltest/not-wf/sa/137.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa137xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa137xml
				documentURI: 'not-wf/sa/137.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa138xml [
	"Source file: xmltest/not-wf/sa/138.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa138xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa138xml
				documentURI: 'not-wf/sa/138.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa139xml [
	"Source file: xmltest/not-wf/sa/139.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa139xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa139xml
				documentURI: 'not-wf/sa/139.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa140xml [
	"Source file: xmltest/not-wf/sa/140.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa140xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa140xml
				documentURI: 'not-wf/sa/140.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa141xml [
	"Source file: xmltest/not-wf/sa/141.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa141xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa141xml
				documentURI: 'not-wf/sa/141.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa142xml [
	"Source file: xmltest/not-wf/sa/142.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa142xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa142xml
				documentURI: 'not-wf/sa/142.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa143xml [
	"Source file: xmltest/not-wf/sa/143.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa143xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa143xml
				documentURI: 'not-wf/sa/143.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa144xml [
	"Source file: xmltest/not-wf/sa/144.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa144xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa144xml
				documentURI: 'not-wf/sa/144.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa145xml [
	"Source file: xmltest/not-wf/sa/145.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa145xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa145xml
				documentURI: 'not-wf/sa/145.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa146xml [
	"Source file: xmltest/not-wf/sa/146.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa146xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa146xml
				documentURI: 'not-wf/sa/146.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa147xml [
	"Source file: xmltest/not-wf/sa/147.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa147xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa147xml
				documentURI: 'not-wf/sa/147.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa148xml [
	"Source file: xmltest/not-wf/sa/148.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa148xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa148xml
				documentURI: 'not-wf/sa/148.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa149xml [
	"Source file: xmltest/not-wf/sa/149.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa149xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa149xml
				documentURI: 'not-wf/sa/149.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa150xml [
	"Source file: xmltest/not-wf/sa/150.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa150xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa150xml
				documentURI: 'not-wf/sa/150.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa151xml [
	"Source file: xmltest/not-wf/sa/151.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa151xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa151xml
				documentURI: 'not-wf/sa/151.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa152xml [
	"Source file: xmltest/not-wf/sa/152.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa152xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa152xml
				documentURI: 'not-wf/sa/152.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa153xml [
	"Source file: xmltest/not-wf/sa/153.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa153xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa153xml
				documentURI: 'not-wf/sa/153.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa154xml [
	"Source file: xmltest/not-wf/sa/154.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa154xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa154xml
				documentURI: 'not-wf/sa/154.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa155xml [
	"Source file: xmltest/not-wf/sa/155.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa155xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa155xml
				documentURI: 'not-wf/sa/155.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa156xml [
	"Source file: xmltest/not-wf/sa/156.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa156xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa156xml
				documentURI: 'not-wf/sa/156.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa157xml [
	"Source file: xmltest/not-wf/sa/157.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa157xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa157xml
				documentURI: 'not-wf/sa/157.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa158xml [
	"Source file: xmltest/not-wf/sa/158.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa158xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa158xml
				documentURI: 'not-wf/sa/158.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa159xml [
	"Source file: xmltest/not-wf/sa/159.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa159xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa159xml
				documentURI: 'not-wf/sa/159.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa160xml [
	"Source file: xmltest/not-wf/sa/160.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa160xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa160xml
				documentURI: 'not-wf/sa/160.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa161xml [
	"Source file: xmltest/not-wf/sa/161.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa161xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa161xml
				documentURI: 'not-wf/sa/161.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa162xml [
	"Source file: xmltest/not-wf/sa/162.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa162xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa162xml
				documentURI: 'not-wf/sa/162.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa163xml [
	"Source file: xmltest/not-wf/sa/163.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa163xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa163xml
				documentURI: 'not-wf/sa/163.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa164xml [
	"Source file: xmltest/not-wf/sa/164.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa164xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa164xml
				documentURI: 'not-wf/sa/164.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa165xml [
	"Source file: xmltest/not-wf/sa/165.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa165xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa165xml
				documentURI: 'not-wf/sa/165.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa166xml [
	"Source file: xmltest/not-wf/sa/166.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa166xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa166xml
				documentURI: 'not-wf/sa/166.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa167xml [
	"Source file: xmltest/not-wf/sa/167.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa167xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa167xml
				documentURI: 'not-wf/sa/167.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa168xml [
	"Source file: xmltest/not-wf/sa/168.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa168xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa168xml
				documentURI: 'not-wf/sa/168.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa169xml [
	"Source file: xmltest/not-wf/sa/169.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa169xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa169xml
				documentURI: 'not-wf/sa/169.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa171xml [
	"Source file: xmltest/not-wf/sa/171.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa171xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa171xml
				documentURI: 'not-wf/sa/171.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa172xml [
	"Source file: xmltest/not-wf/sa/172.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa172xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa172xml
				documentURI: 'not-wf/sa/172.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa173xml [
	"Source file: xmltest/not-wf/sa/173.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa173xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa173xml
				documentURI: 'not-wf/sa/173.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa174xml [
	"Source file: xmltest/not-wf/sa/174.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa174xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa174xml
				documentURI: 'not-wf/sa/174.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa175xml [
	"Source file: xmltest/not-wf/sa/175.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa175xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa175xml
				documentURI: 'not-wf/sa/175.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa176xml [
	"Source file: xmltest/not-wf/sa/176.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa176xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa176xml
				documentURI: 'not-wf/sa/176.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa177xml [
	"Source file: xmltest/not-wf/sa/177.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa177xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa177xml
				documentURI: 'not-wf/sa/177.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa178xml [
	"Source file: xmltest/not-wf/sa/178.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa178xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa178xml
				documentURI: 'not-wf/sa/178.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa179xml [
	"Source file: xmltest/not-wf/sa/179.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa179xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa179xml
				documentURI: 'not-wf/sa/179.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa180xml [
	"Source file: xmltest/not-wf/sa/180.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa180xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa180xml
				documentURI: 'not-wf/sa/180.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa181xml [
	"Source file: xmltest/not-wf/sa/181.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa181xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa181xml
				documentURI: 'not-wf/sa/181.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa182xml [
	"Source file: xmltest/not-wf/sa/182.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa182xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa182xml
				documentURI: 'not-wf/sa/182.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa183xml [
	"Source file: xmltest/not-wf/sa/183.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa183xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa183xml
				documentURI: 'not-wf/sa/183.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa184xml [
	"Source file: xmltest/not-wf/sa/184.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa184xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa184xml
				documentURI: 'not-wf/sa/184.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa185xml [
	"Source file: xmltest/not-wf/sa/185.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa185xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa185xml
				documentURI: 'not-wf/sa/185.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTest >> testnotwfsa186xml [
	"Source file: xmltest/not-wf/sa/186.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testnotwfsa186xml.
	self
		should: [
			self
				parse: self class sourcenotwfsa186xml
				documentURI: 'not-wf/sa/186.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa001xml [
	"Source file: xmltest/valid/ext-sa/001.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa001xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa001xml
						documentURI: 'valid/ext-sa/001.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout001xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa002xml [
	"Source file: xmltest/valid/ext-sa/002.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa002xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa002xml
						documentURI: 'valid/ext-sa/002.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout002xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa003xml [
	"Source file: xmltest/valid/ext-sa/003.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa003xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa003xml
						documentURI: 'valid/ext-sa/003.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout003xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa004xml [
	"Source file: xmltest/valid/ext-sa/004.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa004xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa004xml
						documentURI: 'valid/ext-sa/004.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout004xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa005xml [
	"Source file: xmltest/valid/ext-sa/005.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa005xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa005xml
						documentURI: 'valid/ext-sa/005.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout005xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa006xml [
	"Source file: xmltest/valid/ext-sa/006.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa006xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa006xml
						documentURI: 'valid/ext-sa/006.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout006xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa007xml [
	"Source file: xmltest/valid/ext-sa/007.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa007xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa007xml
						documentURI: 'valid/ext-sa/007.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout007xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa008xml [
	"Source file: xmltest/valid/ext-sa/008.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa008xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa008xml
						documentURI: 'valid/ext-sa/008.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout008xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa009xml [
	"Source file: xmltest/valid/ext-sa/009.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa009xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa009xml
						documentURI: 'valid/ext-sa/009.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout009xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa010xml [
	"Source file: xmltest/valid/ext-sa/010.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa010xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa010xml
						documentURI: 'valid/ext-sa/010.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout010xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa011xml [
	"Source file: xmltest/valid/ext-sa/011.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa011xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa011xml
						documentURI: 'valid/ext-sa/011.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout011xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa012xml [
	"Source file: xmltest/valid/ext-sa/012.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa012xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa012xml
						documentURI: 'valid/ext-sa/012.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout012xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa013xml [
	"Source file: xmltest/valid/ext-sa/013.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa013xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa013xml
						documentURI: 'valid/ext-sa/013.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout013xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidextsa014xml [
	"Source file: xmltest/valid/ext-sa/014.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidextsa014xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidextsa014xml
						documentURI: 'valid/ext-sa/014.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidextsaout014xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa001xml [
	"Source file: xmltest/valid/not-sa/001.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa001xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa001xml
						documentURI: 'valid/not-sa/001.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout001xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa002xml [
	"Source file: xmltest/valid/not-sa/002.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa002xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa002xml
						documentURI: 'valid/not-sa/002.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout002xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa003xml [
	"Source file: xmltest/valid/not-sa/003.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa003xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa003xml
						documentURI: 'valid/not-sa/003.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout003xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa004xml [
	"Source file: xmltest/valid/not-sa/004.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa004xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa004xml
						documentURI: 'valid/not-sa/004.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout004xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa005xml [
	"Source file: xmltest/valid/not-sa/005.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa005xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa005xml
						documentURI: 'valid/not-sa/005.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout005xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa006xml [
	"Source file: xmltest/valid/not-sa/006.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa006xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa006xml
						documentURI: 'valid/not-sa/006.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout006xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa007xml [
	"Source file: xmltest/valid/not-sa/007.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa007xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa007xml
						documentURI: 'valid/not-sa/007.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout007xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa008xml [
	"Source file: xmltest/valid/not-sa/008.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa008xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa008xml
						documentURI: 'valid/not-sa/008.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout008xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa009xml [
	"Source file: xmltest/valid/not-sa/009.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa009xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa009xml
						documentURI: 'valid/not-sa/009.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout009xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa010xml [
	"Source file: xmltest/valid/not-sa/010.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa010xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa010xml
						documentURI: 'valid/not-sa/010.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout010xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa011xml [
	"Source file: xmltest/valid/not-sa/011.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa011xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa011xml
						documentURI: 'valid/not-sa/011.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout011xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa012xml [
	"Source file: xmltest/valid/not-sa/012.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa012xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa012xml
						documentURI: 'valid/not-sa/012.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout012xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa013xml [
	"Source file: xmltest/valid/not-sa/013.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa013xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa013xml
						documentURI: 'valid/not-sa/013.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout013xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa014xml [
	"Source file: xmltest/valid/not-sa/014.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa014xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa014xml
						documentURI: 'valid/not-sa/014.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout014xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa015xml [
	"Source file: xmltest/valid/not-sa/015.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa015xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa015xml
						documentURI: 'valid/not-sa/015.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout015xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa016xml [
	"Source file: xmltest/valid/not-sa/016.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa016xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa016xml
						documentURI: 'valid/not-sa/016.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout016xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa017xml [
	"Source file: xmltest/valid/not-sa/017.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa017xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa017xml
						documentURI: 'valid/not-sa/017.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout017xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa018xml [
	"Source file: xmltest/valid/not-sa/018.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa018xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa018xml
						documentURI: 'valid/not-sa/018.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout018xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa019xml [
	"Source file: xmltest/valid/not-sa/019.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa019xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa019xml
						documentURI: 'valid/not-sa/019.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout019xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa020xml [
	"Source file: xmltest/valid/not-sa/020.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa020xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa020xml
						documentURI: 'valid/not-sa/020.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout020xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa021xml [
	"Source file: xmltest/valid/not-sa/021.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa021xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa021xml
						documentURI: 'valid/not-sa/021.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout021xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa023xml [
	"Source file: xmltest/valid/not-sa/023.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa023xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa023xml
						documentURI: 'valid/not-sa/023.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout023xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa024xml [
	"Source file: xmltest/valid/not-sa/024.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa024xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa024xml
						documentURI: 'valid/not-sa/024.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout024xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa025xml [
	"Source file: xmltest/valid/not-sa/025.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa025xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa025xml
						documentURI: 'valid/not-sa/025.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout025xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa026xml [
	"Source file: xmltest/valid/not-sa/026.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa026xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa026xml
						documentURI: 'valid/not-sa/026.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout026xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa027xml [
	"Source file: xmltest/valid/not-sa/027.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa027xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa027xml
						documentURI: 'valid/not-sa/027.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout027xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa028xml [
	"Source file: xmltest/valid/not-sa/028.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa028xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa028xml
						documentURI: 'valid/not-sa/028.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout028xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa029xml [
	"Source file: xmltest/valid/not-sa/029.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa029xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa029xml
						documentURI: 'valid/not-sa/029.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout029xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa030xml [
	"Source file: xmltest/valid/not-sa/030.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa030xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa030xml
						documentURI: 'valid/not-sa/030.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout030xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidnotsa031xml [
	"Source file: xmltest/valid/not-sa/031.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidnotsa031xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidnotsa031xml
						documentURI: 'valid/not-sa/031.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidnotsaout031xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa001xml [
	"Source file: xmltest/valid/sa/001.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa001xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa001xml
						documentURI: 'valid/sa/001.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout001xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa002xml [
	"Source file: xmltest/valid/sa/002.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa002xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa002xml
						documentURI: 'valid/sa/002.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout002xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa003xml [
	"Source file: xmltest/valid/sa/003.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa003xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa003xml
						documentURI: 'valid/sa/003.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout003xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa004xml [
	"Source file: xmltest/valid/sa/004.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa004xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa004xml
						documentURI: 'valid/sa/004.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout004xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa005xml [
	"Source file: xmltest/valid/sa/005.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa005xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa005xml
						documentURI: 'valid/sa/005.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout005xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa006xml [
	"Source file: xmltest/valid/sa/006.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa006xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa006xml
						documentURI: 'valid/sa/006.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout006xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa007xml [
	"Source file: xmltest/valid/sa/007.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa007xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa007xml
						documentURI: 'valid/sa/007.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout007xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa008xml [
	"Source file: xmltest/valid/sa/008.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa008xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa008xml
						documentURI: 'valid/sa/008.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout008xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa009xml [
	"Source file: xmltest/valid/sa/009.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa009xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa009xml
						documentURI: 'valid/sa/009.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout009xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa010xml [
	"Source file: xmltest/valid/sa/010.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa010xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa010xml
						documentURI: 'valid/sa/010.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout010xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa011xml [
	"Source file: xmltest/valid/sa/011.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa011xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa011xml
						documentURI: 'valid/sa/011.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout011xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa012xml [
	"Source file: xmltest/valid/sa/012.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa012xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa012xml
						documentURI: 'valid/sa/012.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout012xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa013xml [
	"Source file: xmltest/valid/sa/013.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa013xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa013xml
						documentURI: 'valid/sa/013.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout013xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa014xml [
	"Source file: xmltest/valid/sa/014.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa014xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa014xml
						documentURI: 'valid/sa/014.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout014xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa015xml [
	"Source file: xmltest/valid/sa/015.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa015xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa015xml
						documentURI: 'valid/sa/015.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout015xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa016xml [
	"Source file: xmltest/valid/sa/016.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa016xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa016xml
						documentURI: 'valid/sa/016.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout016xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa017axml [
	"Source file: xmltest/valid/sa/017a.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa017axml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa017axml
						documentURI: 'valid/sa/017a.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout017axml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa017xml [
	"Source file: xmltest/valid/sa/017.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa017xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa017xml
						documentURI: 'valid/sa/017.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout017xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa018xml [
	"Source file: xmltest/valid/sa/018.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa018xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa018xml
						documentURI: 'valid/sa/018.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout018xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa019xml [
	"Source file: xmltest/valid/sa/019.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa019xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa019xml
						documentURI: 'valid/sa/019.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout019xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa020xml [
	"Source file: xmltest/valid/sa/020.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa020xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa020xml
						documentURI: 'valid/sa/020.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout020xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa021xml [
	"Source file: xmltest/valid/sa/021.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa021xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa021xml
						documentURI: 'valid/sa/021.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout021xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa022xml [
	"Source file: xmltest/valid/sa/022.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa022xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa022xml
						documentURI: 'valid/sa/022.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout022xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa023xml [
	"Source file: xmltest/valid/sa/023.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa023xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa023xml
						documentURI: 'valid/sa/023.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout023xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa024xml [
	"Source file: xmltest/valid/sa/024.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa024xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa024xml
						documentURI: 'valid/sa/024.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout024xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa025xml [
	"Source file: xmltest/valid/sa/025.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa025xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa025xml
						documentURI: 'valid/sa/025.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout025xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa026xml [
	"Source file: xmltest/valid/sa/026.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa026xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa026xml
						documentURI: 'valid/sa/026.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout026xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa027xml [
	"Source file: xmltest/valid/sa/027.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa027xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa027xml
						documentURI: 'valid/sa/027.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout027xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa028xml [
	"Source file: xmltest/valid/sa/028.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa028xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa028xml
						documentURI: 'valid/sa/028.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout028xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa029xml [
	"Source file: xmltest/valid/sa/029.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa029xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa029xml
						documentURI: 'valid/sa/029.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout029xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa030xml [
	"Source file: xmltest/valid/sa/030.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa030xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa030xml
						documentURI: 'valid/sa/030.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout030xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa031xml [
	"Source file: xmltest/valid/sa/031.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa031xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa031xml
						documentURI: 'valid/sa/031.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout031xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa032xml [
	"Source file: xmltest/valid/sa/032.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa032xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa032xml
						documentURI: 'valid/sa/032.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout032xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa033xml [
	"Source file: xmltest/valid/sa/033.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa033xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa033xml
						documentURI: 'valid/sa/033.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout033xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa034xml [
	"Source file: xmltest/valid/sa/034.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa034xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa034xml
						documentURI: 'valid/sa/034.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout034xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa035xml [
	"Source file: xmltest/valid/sa/035.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa035xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa035xml
						documentURI: 'valid/sa/035.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout035xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa036xml [
	"Source file: xmltest/valid/sa/036.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa036xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa036xml
						documentURI: 'valid/sa/036.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout036xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa037xml [
	"Source file: xmltest/valid/sa/037.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa037xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa037xml
						documentURI: 'valid/sa/037.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout037xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa038xml [
	"Source file: xmltest/valid/sa/038.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa038xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa038xml
						documentURI: 'valid/sa/038.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout038xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa039xml [
	"Source file: xmltest/valid/sa/039.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa039xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa039xml
						documentURI: 'valid/sa/039.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout039xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa040xml [
	"Source file: xmltest/valid/sa/040.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa040xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa040xml
						documentURI: 'valid/sa/040.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout040xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa041xml [
	"Source file: xmltest/valid/sa/041.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa041xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa041xml
						documentURI: 'valid/sa/041.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout041xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa042xml [
	"Source file: xmltest/valid/sa/042.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa042xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa042xml
						documentURI: 'valid/sa/042.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout042xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa043xml [
	"Source file: xmltest/valid/sa/043.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa043xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa043xml
						documentURI: 'valid/sa/043.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout043xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa044xml [
	"Source file: xmltest/valid/sa/044.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa044xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa044xml
						documentURI: 'valid/sa/044.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout044xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa045xml [
	"Source file: xmltest/valid/sa/045.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa045xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa045xml
						documentURI: 'valid/sa/045.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout045xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa046xml [
	"Source file: xmltest/valid/sa/046.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa046xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa046xml
						documentURI: 'valid/sa/046.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout046xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa047xml [
	"Source file: xmltest/valid/sa/047.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa047xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa047xml
						documentURI: 'valid/sa/047.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout047xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa048xml [
	"Source file: xmltest/valid/sa/048.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa048xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa048xml
						documentURI: 'valid/sa/048.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout048xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa049xml [
	"Source file: xmltest/valid/sa/049.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa049xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa049xml
						documentURI: 'valid/sa/049.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout049xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa050xml [
	"Source file: xmltest/valid/sa/050.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa050xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa050xml
						documentURI: 'valid/sa/050.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout050xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa051xml [
	"Source file: xmltest/valid/sa/051.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa051xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa051xml
						documentURI: 'valid/sa/051.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout051xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa052xml [
	"Source file: xmltest/valid/sa/052.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa052xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa052xml
						documentURI: 'valid/sa/052.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout052xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa053xml [
	"Source file: xmltest/valid/sa/053.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa053xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa053xml
						documentURI: 'valid/sa/053.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout053xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa054xml [
	"Source file: xmltest/valid/sa/054.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa054xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa054xml
						documentURI: 'valid/sa/054.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout054xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa055xml [
	"Source file: xmltest/valid/sa/055.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa055xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa055xml
						documentURI: 'valid/sa/055.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout055xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa056xml [
	"Source file: xmltest/valid/sa/056.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa056xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa056xml
						documentURI: 'valid/sa/056.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout056xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa057xml [
	"Source file: xmltest/valid/sa/057.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa057xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa057xml
						documentURI: 'valid/sa/057.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout057xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa058xml [
	"Source file: xmltest/valid/sa/058.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa058xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa058xml
						documentURI: 'valid/sa/058.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout058xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa059xml [
	"Source file: xmltest/valid/sa/059.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa059xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa059xml
						documentURI: 'valid/sa/059.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout059xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa060xml [
	"Source file: xmltest/valid/sa/060.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa060xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa060xml
						documentURI: 'valid/sa/060.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout060xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa061xml [
	"Source file: xmltest/valid/sa/061.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa061xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa061xml
						documentURI: 'valid/sa/061.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout061xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa062xml [
	"Source file: xmltest/valid/sa/062.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa062xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa062xml
						documentURI: 'valid/sa/062.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout062xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa063xml [
	"Source file: xmltest/valid/sa/063.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa063xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa063xml
						documentURI: 'valid/sa/063.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout063xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa064xml [
	"Source file: xmltest/valid/sa/064.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa064xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa064xml
						documentURI: 'valid/sa/064.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout064xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa065xml [
	"Source file: xmltest/valid/sa/065.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa065xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa065xml
						documentURI: 'valid/sa/065.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout065xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa066xml [
	"Source file: xmltest/valid/sa/066.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa066xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa066xml
						documentURI: 'valid/sa/066.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout066xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa067xml [
	"Source file: xmltest/valid/sa/067.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa067xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa067xml
						documentURI: 'valid/sa/067.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout067xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa068xml [
	"Source file: xmltest/valid/sa/068.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa068xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa068xml
						documentURI: 'valid/sa/068.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout068xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa069xml [
	"Source file: xmltest/valid/sa/069.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa069xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa069xml
						documentURI: 'valid/sa/069.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout069xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa070xml [
	"Source file: xmltest/valid/sa/070.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa070xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa070xml
						documentURI: 'valid/sa/070.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout070xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa071xml [
	"Source file: xmltest/valid/sa/071.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa071xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa071xml
						documentURI: 'valid/sa/071.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout071xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa072xml [
	"Source file: xmltest/valid/sa/072.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa072xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa072xml
						documentURI: 'valid/sa/072.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout072xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa073xml [
	"Source file: xmltest/valid/sa/073.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa073xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa073xml
						documentURI: 'valid/sa/073.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout073xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa074xml [
	"Source file: xmltest/valid/sa/074.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa074xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa074xml
						documentURI: 'valid/sa/074.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout074xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa075xml [
	"Source file: xmltest/valid/sa/075.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa075xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa075xml
						documentURI: 'valid/sa/075.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout075xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa076xml [
	"Source file: xmltest/valid/sa/076.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa076xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa076xml
						documentURI: 'valid/sa/076.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout076xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa077xml [
	"Source file: xmltest/valid/sa/077.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa077xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa077xml
						documentURI: 'valid/sa/077.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout077xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa078xml [
	"Source file: xmltest/valid/sa/078.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa078xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa078xml
						documentURI: 'valid/sa/078.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout078xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa079xml [
	"Source file: xmltest/valid/sa/079.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa079xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa079xml
						documentURI: 'valid/sa/079.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout079xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa080xml [
	"Source file: xmltest/valid/sa/080.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa080xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa080xml
						documentURI: 'valid/sa/080.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout080xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa081xml [
	"Source file: xmltest/valid/sa/081.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa081xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa081xml
						documentURI: 'valid/sa/081.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout081xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa082xml [
	"Source file: xmltest/valid/sa/082.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa082xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa082xml
						documentURI: 'valid/sa/082.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout082xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa083xml [
	"Source file: xmltest/valid/sa/083.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa083xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa083xml
						documentURI: 'valid/sa/083.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout083xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa084xml [
	"Source file: xmltest/valid/sa/084.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa084xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa084xml
						documentURI: 'valid/sa/084.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout084xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa085xml [
	"Source file: xmltest/valid/sa/085.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa085xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa085xml
						documentURI: 'valid/sa/085.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout085xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa086xml [
	"Source file: xmltest/valid/sa/086.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa086xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa086xml
						documentURI: 'valid/sa/086.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout086xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa087xml [
	"Source file: xmltest/valid/sa/087.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa087xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa087xml
						documentURI: 'valid/sa/087.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout087xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa088xml [
	"Source file: xmltest/valid/sa/088.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa088xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa088xml
						documentURI: 'valid/sa/088.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout088xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa089xml [
	"Source file: xmltest/valid/sa/089.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa089xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa089xml
						documentURI: 'valid/sa/089.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout089xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa090xml [
	"Source file: xmltest/valid/sa/090.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa090xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa090xml
						documentURI: 'valid/sa/090.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout090xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa091xml [
	"Source file: xmltest/valid/sa/091.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa091xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa091xml
						documentURI: 'valid/sa/091.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout091xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa092xml [
	"Source file: xmltest/valid/sa/092.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa092xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa092xml
						documentURI: 'valid/sa/092.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout092xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa093xml [
	"Source file: xmltest/valid/sa/093.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa093xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa093xml
						documentURI: 'valid/sa/093.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout093xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa094xml [
	"Source file: xmltest/valid/sa/094.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa094xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa094xml
						documentURI: 'valid/sa/094.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout094xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa095xml [
	"Source file: xmltest/valid/sa/095.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa095xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa095xml
						documentURI: 'valid/sa/095.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout095xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa096xml [
	"Source file: xmltest/valid/sa/096.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa096xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa096xml
						documentURI: 'valid/sa/096.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout096xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa097xml [
	"Source file: xmltest/valid/sa/097.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa097xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa097xml
						documentURI: 'valid/sa/097.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout097xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa098xml [
	"Source file: xmltest/valid/sa/098.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa098xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa098xml
						documentURI: 'valid/sa/098.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout098xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa099xml [
	"Source file: xmltest/valid/sa/099.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa099xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa099xml
						documentURI: 'valid/sa/099.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout099xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa100xml [
	"Source file: xmltest/valid/sa/100.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa100xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa100xml
						documentURI: 'valid/sa/100.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout100xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa101xml [
	"Source file: xmltest/valid/sa/101.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa101xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa101xml
						documentURI: 'valid/sa/101.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout101xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa102xml [
	"Source file: xmltest/valid/sa/102.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa102xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa102xml
						documentURI: 'valid/sa/102.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout102xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa103xml [
	"Source file: xmltest/valid/sa/103.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa103xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa103xml
						documentURI: 'valid/sa/103.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout103xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa104xml [
	"Source file: xmltest/valid/sa/104.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa104xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa104xml
						documentURI: 'valid/sa/104.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout104xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa105xml [
	"Source file: xmltest/valid/sa/105.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa105xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa105xml
						documentURI: 'valid/sa/105.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout105xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa106xml [
	"Source file: xmltest/valid/sa/106.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa106xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa106xml
						documentURI: 'valid/sa/106.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout106xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa107xml [
	"Source file: xmltest/valid/sa/107.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa107xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa107xml
						documentURI: 'valid/sa/107.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout107xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa108xml [
	"Source file: xmltest/valid/sa/108.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa108xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa108xml
						documentURI: 'valid/sa/108.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout108xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa109xml [
	"Source file: xmltest/valid/sa/109.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa109xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa109xml
						documentURI: 'valid/sa/109.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout109xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa110xml [
	"Source file: xmltest/valid/sa/110.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa110xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa110xml
						documentURI: 'valid/sa/110.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout110xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa111xml [
	"Source file: xmltest/valid/sa/111.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa111xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa111xml
						documentURI: 'valid/sa/111.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout111xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa112xml [
	"Source file: xmltest/valid/sa/112.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa112xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa112xml
						documentURI: 'valid/sa/112.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout112xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa113xml [
	"Source file: xmltest/valid/sa/113.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa113xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa113xml
						documentURI: 'valid/sa/113.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout113xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa114xml [
	"Source file: xmltest/valid/sa/114.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa114xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa114xml
						documentURI: 'valid/sa/114.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout114xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa115xml [
	"Source file: xmltest/valid/sa/115.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa115xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa115xml
						documentURI: 'valid/sa/115.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout115xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa116xml [
	"Source file: xmltest/valid/sa/116.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa116xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa116xml
						documentURI: 'valid/sa/116.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout116xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa117xml [
	"Source file: xmltest/valid/sa/117.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa117xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa117xml
						documentURI: 'valid/sa/117.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout117xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa118xml [
	"Source file: xmltest/valid/sa/118.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa118xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa118xml
						documentURI: 'valid/sa/118.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout118xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTest >> testvalidsa119xml [
	"Source file: xmltest/valid/sa/119.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testvalidsa119xml.
	self
		shouldnt: [
			[| document |
				document :=
					self
						domParse: self class sourcevalidsa119xml
						documentURI: 'valid/sa/119.xml'.
				self
					assertDocument: document 
					canonicallyEquals: self class sourcevalidsaout119xml]
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]
