Class {
	#name : #XMLConformanceExpatTests,
	#superclass : #XMLConformanceTests,
	#category : #'XML-Tests-Conformance'
}

{ #category : #accessing }
XMLConformanceExpatTests class >> skippableTests [
	^ #( testinvalid002xml testinvalid005xml testinvalid006xml testinvalidnotsa022xml testnotwfnotsa009xml testnotwfnotsa010xml testnotwfnotsa011xml testnotwfsa074xml testnotwfsa104xml testnotwfsa110xml testnotwfsa116xml testnotwfsa117xml testnotwfsa119xml testnotwfsa140xml testnotwfsa141xml testnotwfsa175xml testnotwfsa181xml testnotwfsa182xml )
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourceinvalid002ent [
	"Source file: xmltest/invalid/002.ent"

	^ '<!ENTITY % e "(#PCDATA">
<!ELEMENT doc %e;)>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourceinvalid002xml [
	"Source file: xmltest/invalid/002.xml"

	^ '<!DOCTYPE doc SYSTEM "002.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourceinvalid005ent [
	"Source file: xmltest/invalid/005.ent"

	^ '<!ENTITY % e ">">
<!ELEMENT doc (#PCDATA) %e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourceinvalid005xml [
	"Source file: xmltest/invalid/005.xml"

	^ '<!DOCTYPE doc SYSTEM "005.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourceinvalid006ent [
	"Source file: xmltest/invalid/006.ent"

	^ '<!ENTITY % e "(#PCDATA)>">
<!ELEMENT doc %e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourceinvalid006xml [
	"Source file: xmltest/invalid/006.xml"

	^ '<!DOCTYPE doc SYSTEM "006.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourceinvalidnotsa022ent [
	"Source file: xmltest/invalid/not-sa/022.ent"

	^ '<!ENTITY % e "INCLUDE[">
<!ELEMENT doc (#PCDATA)>
<![ %e; <!ATTLIST doc a1 CDATA "v1"> ]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourceinvalidnotsa022xml [
	"Source file: xmltest/invalid/not-sa/022.xml"

	^ '<!DOCTYPE doc SYSTEM "022.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfextsa001ent [
	"Source file: xmltest/not-wf/ext-sa/001.ent"

	^ '&e;'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfextsa001xml [
	"Source file: xmltest/not-wf/ext-sa/001.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e SYSTEM "001.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfextsa002ent [
	"Source file: xmltest/not-wf/ext-sa/002.ent"

	^ '<?xml version="1.0" standalone="yes"?>
data

'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfextsa002xml [
	"Source file: xmltest/not-wf/ext-sa/002.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "002.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfextsa003ent [
	"Source file: xmltest/not-wf/ext-sa/003.ent"

	^ '<?xml version="1.0" encoding="UTF-8"?><?xml version="1.0" encoding="UTF-8"?>
data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfextsa003xml [
	"Source file: xmltest/not-wf/ext-sa/003.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "003.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa001ent [
	"Source file: xmltest/not-wf/not-sa/001.ent"

	^ '<![ INCLUDE [
<!ELEMENT doc (#PCDATA)>
]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa001xml [
	"Source file: xmltest/not-wf/not-sa/001.xml"

	^ '<!DOCTYPE doc SYSTEM "001.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa002xml [
	"Source file: xmltest/not-wf/not-sa/002.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "<?xml version=''1.0'' encoding=''UTF-8''?>">
%e;
]>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa003ent [
	"Source file: xmltest/not-wf/not-sa/003.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ IGNORE [
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa003xml [
	"Source file: xmltest/not-wf/not-sa/003.xml"

	^ '<!DOCTYPE doc SYSTEM "003.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa004ent [
	"Source file: xmltest/not-wf/not-sa/004.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ INCLUDE [
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa004xml [
	"Source file: xmltest/not-wf/not-sa/004.xml"

	^ '<!DOCTYPE doc SYSTEM "004.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa005ent [
	"Source file: xmltest/not-wf/not-sa/005.ent"

	^ '<!ELEMENT doc (#PCDATA)>
%e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa005xml [
	"Source file: xmltest/not-wf/not-sa/005.xml"

	^ '<!DOCTYPE doc SYSTEM "005.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa006ent [
	"Source file: xmltest/not-wf/not-sa/006.ent"

	^ '<![INCLUDE
<!ELEMENT doc (#PCDATA)>
]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa006xml [
	"Source file: xmltest/not-wf/not-sa/006.xml"

	^ '<!DOCTYPE doc SYSTEM "006.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa007ent [
	"Source file: xmltest/not-wf/not-sa/007.ent"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa007xml [
	"Source file: xmltest/not-wf/not-sa/007.xml"

	^ '<!DOCTYPE doc SYSTEM "007.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa008ent [
	"Source file: xmltest/not-wf/not-sa/008.ent"

	^ '<!ELEMENT doc ANY>
<!ENTITY e "100%">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa008xml [
	"Source file: xmltest/not-wf/not-sa/008.xml"

	^ '<!DOCTYPE doc SYSTEM "008.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa009ent [
	"Source file: xmltest/not-wf/not-sa/009.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e "<!--">
%e; -->
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa009xml [
	"Source file: xmltest/not-wf/not-sa/009.xml"

	^ '<!DOCTYPE doc SYSTEM "009.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa010ent [
	"Source file: xmltest/not-wf/not-sa/010.ent"

	^ '<!ENTITY % e "<!ELEMENT ">
%e; doc (#PCDATA)>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa010xml [
	"Source file: xmltest/not-wf/not-sa/010.xml"

	^ '<!DOCTYPE doc SYSTEM "010.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa011ent [
	"Source file: xmltest/not-wf/not-sa/011.ent"

	^ '<!ENTITY % e1 "<!ELEMENT ">
<!ENTITY % e2 ">">
%e1; doc (#PCDATA) %e2;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfnotsa011xml [
	"Source file: xmltest/not-wf/not-sa/011.xml"

	^ '<!DOCTYPE doc SYSTEM "011.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa001xml [
	"Source file: xmltest/not-wf/sa/001.xml"

	^ '<doc>
<doc
?
<a</a>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa002xml [
	"Source file: xmltest/not-wf/sa/002.xml"

	^ '<doc>
<.doc></.doc>
</doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa003xml [
	"Source file: xmltest/not-wf/sa/003.xml"

	^ '<doc><? ?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa004xml [
	"Source file: xmltest/not-wf/sa/004.xml"

	^ '<doc><?target some data></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa005xml [
	"Source file: xmltest/not-wf/sa/005.xml"

	^ '<doc><?target some data?</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa006xml [
	"Source file: xmltest/not-wf/sa/006.xml"

	^ '<doc><!-- a comment -- another --></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa007xml [
	"Source file: xmltest/not-wf/sa/007.xml"

	^ '<doc>&amp no refc</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa008xml [
	"Source file: xmltest/not-wf/sa/008.xml"

	^ '<doc>&.entity;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa009xml [
	"Source file: xmltest/not-wf/sa/009.xml"

	^ '<doc>&#RE;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa010xml [
	"Source file: xmltest/not-wf/sa/010.xml"

	^ '<doc>A & B</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa011xml [
	"Source file: xmltest/not-wf/sa/011.xml"

	^ '<doc a1></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa012xml [
	"Source file: xmltest/not-wf/sa/012.xml"

	^ '<doc a1=v1></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa013xml [
	"Source file: xmltest/not-wf/sa/013.xml"

	^ '<doc a1="v1''></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa014xml [
	"Source file: xmltest/not-wf/sa/014.xml"

	^ '<doc a1="<foo>"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa015xml [
	"Source file: xmltest/not-wf/sa/015.xml"

	^ '<doc a1=></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa016xml [
	"Source file: xmltest/not-wf/sa/016.xml"

	^ '<doc a1="v1" "v2"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa017xml [
	"Source file: xmltest/not-wf/sa/017.xml"

	^ '<doc><![CDATA[</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa018xml [
	"Source file: xmltest/not-wf/sa/018.xml"

	^ '<doc><![CDATA [ stuff]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa019xml [
	"Source file: xmltest/not-wf/sa/019.xml"

	^ '<doc></>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa020xml [
	"Source file: xmltest/not-wf/sa/020.xml"

	^ '<doc a1="A & B"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa021xml [
	"Source file: xmltest/not-wf/sa/021.xml"

	^ '<doc a1="a&b"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa022xml [
	"Source file: xmltest/not-wf/sa/022.xml"

	^ '<doc a1="&#123:"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa023xml [
	"Source file: xmltest/not-wf/sa/023.xml"

	^ '<doc 12="34"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa024xml [
	"Source file: xmltest/not-wf/sa/024.xml"

	^ '<doc>
<123></123>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa025xml [
	"Source file: xmltest/not-wf/sa/025.xml"

	^ '<doc>]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa026xml [
	"Source file: xmltest/not-wf/sa/026.xml"

	^ '<doc>]]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa027xml [
	"Source file: xmltest/not-wf/sa/027.xml"

	^ '<doc>
<!-- abc
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa028xml [
	"Source file: xmltest/not-wf/sa/028.xml"

	^ '<doc>
<?a pi that is not closed
</doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa029xml [
	"Source file: xmltest/not-wf/sa/029.xml"

	^ '<doc>abc]]]>def</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa030xml [
	"Source file: xmltest/not-wf/sa/030.xml"

	^ '<doc>A form feed () is not legal in data</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa031xml [
	"Source file: xmltest/not-wf/sa/031.xml"

	^ '<doc><?pi a form feed () is not allowed in a pi?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa032xml [
	"Source file: xmltest/not-wf/sa/032.xml"

	^ '<doc><!-- a form feed () is not allowed in a comment --></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa033xml [
	"Source file: xmltest/not-wf/sa/033.xml"

	^ '<doc>abcdef</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa034xml [
	"Source file: xmltest/not-wf/sa/034.xml"

	^ '<doc>A form-feed is not white space or a name character</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa035xml [
	"Source file: xmltest/not-wf/sa/035.xml"

	^ '<doc>1 < 2 but not in XML</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa036xml [
	"Source file: xmltest/not-wf/sa/036.xml"

	^ '<doc></doc>
Illegal data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa037xml [
	"Source file: xmltest/not-wf/sa/037.xml"

	^ '<doc></doc>
&#32;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa038xml [
	"Source file: xmltest/not-wf/sa/038.xml"

	^ '<doc x="foo" y="bar" x="baz"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa039xml [
	"Source file: xmltest/not-wf/sa/039.xml"

	^ '<doc><a></aa></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa040xml [
	"Source file: xmltest/not-wf/sa/040.xml"

	^ '<doc></doc>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa041xml [
	"Source file: xmltest/not-wf/sa/041.xml"

	^ '<doc/>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa042xml [
	"Source file: xmltest/not-wf/sa/042.xml"

	^ '<doc/></doc/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa043xml [
	"Source file: xmltest/not-wf/sa/043.xml"

	^ '<doc/>
Illegal data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa044xml [
	"Source file: xmltest/not-wf/sa/044.xml"

	^ '<doc/><doc/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa045xml [
	"Source file: xmltest/not-wf/sa/045.xml"

	^ '<doc>
<a/
</doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa046xml [
	"Source file: xmltest/not-wf/sa/046.xml"

	^ '<doc>
<a/</a>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa047xml [
	"Source file: xmltest/not-wf/sa/047.xml"

	^ '<doc>
<a / >
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa048xml [
	"Source file: xmltest/not-wf/sa/048.xml"

	^ '<doc>
</doc>
<![CDATA[]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa049xml [
	"Source file: xmltest/not-wf/sa/049.xml"

	^ '<doc>
<a><![CDATA[xyz]]]></a>
<![CDATA[]]></a>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa050xml [
	"Source file: xmltest/not-wf/sa/050.xml"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa051xml [
	"Source file: xmltest/not-wf/sa/051.xml"

	^ '<!-- a comment -->
<![CDATA[]]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa052xml [
	"Source file: xmltest/not-wf/sa/052.xml"

	^ '<!-- a comment -->
&#32;
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa053xml [
	"Source file: xmltest/not-wf/sa/053.xml"

	^ '<doc></DOC>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa054xml [
	"Source file: xmltest/not-wf/sa/054.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo PUBLIC "some public id">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa055xml [
	"Source file: xmltest/not-wf/sa/055.xml"

	^ '<!DOCTYPE doc [
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa056xml [
	"Source file: xmltest/not-wf/sa/056.xml"

	^ '<!DOCTYPE doc -- a comment -- []>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa057xml [
	"Source file: xmltest/not-wf/sa/057.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "whatever" -- a comment -->
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa058xml [
	"Source file: xmltest/not-wf/sa/058.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 (foo,bar) #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa059xml [
	"Source file: xmltest/not-wf/sa/059.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 NMTOKEN v1>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa060xml [
	"Source file: xmltest/not-wf/sa/060.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 NAME #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa061xml [
	"Source file: xmltest/not-wf/sa/061.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e PUBLIC "whatever""e.ent">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa062xml [
	"Source file: xmltest/not-wf/sa/062.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo"some text">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa063xml [
	"Source file: xmltest/not-wf/sa/063.xml"

	^ '<!DOCTYPE doc [
<![INCLUDE[ ]]>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa064xml [
	"Source file: xmltest/not-wf/sa/064.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST e a1 CDATA"foo">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa065xml [
	"Source file: xmltest/not-wf/sa/065.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1(foo|bar) #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa066xml [
	"Source file: xmltest/not-wf/sa/066.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 (foo|bar)#IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa067xml [
	"Source file: xmltest/not-wf/sa/067.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 (foo)"foo">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa068xml [
	"Source file: xmltest/not-wf/sa/068.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 NOTATION(foo) #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa069xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa070xml [
	"Source file: xmltest/not-wf/sa/070.xml"

	^ '<!-- a comment ending with three dashes --->
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa071xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa072xml [
	"Source file: xmltest/not-wf/sa/072.xml"

	^ '<doc>&foo;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa073xml [
	"Source file: xmltest/not-wf/sa/073.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "whatever">
]>
<doc>&f;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa074xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa075xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa076xml [
	"Source file: xmltest/not-wf/sa/076.xml"

	^ '<doc a="&foo;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa077xml [
	"Source file: xmltest/not-wf/sa/077.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo "&bar;">
]>
<doc a="&foo;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa078xml [
	"Source file: xmltest/not-wf/sa/078.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA "&foo;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa079xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa080xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa081xml [
	"Source file: xmltest/not-wf/sa/081.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e SYSTEM "nul">
]>
<doc a="&e;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa082xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa083xml [
	"Source file: xmltest/not-wf/sa/083.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e SYSTEM "nul" NDATA n>
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa084xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa085xml [
	"Source file: xmltest/not-wf/sa/085.xml"

	^ '<!DOCTYPE doc PUBLIC "[" "null.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa086xml [
	"Source file: xmltest/not-wf/sa/086.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo PUBLIC "[" "null.xml">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa087xml [
	"Source file: xmltest/not-wf/sa/087.xml"

	^ '<!DOCTYPE doc [
<!NOTATION foo PUBLIC "[" "null.ent">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa088xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa089xml [
	"Source file: xmltest/not-wf/sa/089.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % foo SYSTEM "foo.xml" NDATA bar>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa090xml [
	"Source file: xmltest/not-wf/sa/090.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<foo a=''&#60;''></foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa091xml [
	"Source file: xmltest/not-wf/sa/091.xml"

	^ '<!DOCTYPE doc [
<!NOTATION n SYSTEM "n">
<!ENTITY % foo SYSTEM "foo.xml" NDATA n>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa092xml [
	"Source file: xmltest/not-wf/sa/092.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<foo a=''&#38;''></foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa093xml [
	"Source file: xmltest/not-wf/sa/093.xml"

	^ '<doc>&#X58;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa094xml [
	"Source file: xmltest/not-wf/sa/094.xml"

	^ '<?xml VERSION="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa095xml [
	"Source file: xmltest/not-wf/sa/095.xml"

	^ '<?xml encoding="UTF-8" version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa096xml [
	"Source file: xmltest/not-wf/sa/096.xml"

	^ '<?xml version="1.0"encoding="UTF-8" ?>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa097xml [
	"Source file: xmltest/not-wf/sa/097.xml"

	^ '<?xml version="1.0'' encoding="UTF-8" ?>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa098xml [
	"Source file: xmltest/not-wf/sa/098.xml"

	^ '<?xml version="1.0" version="1.0"?>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa099xml [
	"Source file: xmltest/not-wf/sa/099.xml"

	^ '<?xml version="1.0" valid="no" ?>
<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa100xml [
	"Source file: xmltest/not-wf/sa/100.xml"

	^ '<?xml version="1.0" standalone="YES" ?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa101xml [
	"Source file: xmltest/not-wf/sa/101.xml"

	^ '<?xml version="1.0" encoding=" UTF-8"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa102xml [
	"Source file: xmltest/not-wf/sa/102.xml"

	^ '<?xml version="1.0 " ?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa103xml [
	"Source file: xmltest/not-wf/sa/103.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa104xml [
	"Source file: xmltest/not-wf/sa/104.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<foo>">
]>
<doc>&e;</foo></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa105xml [
	"Source file: xmltest/not-wf/sa/105.xml"

	^ '<?pi stuff?>
<![CDATA[]]>
<doc>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa106xml [
	"Source file: xmltest/not-wf/sa/106.xml"

	^ '<?pi data?>
&#32;<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa107xml [
	"Source file: xmltest/not-wf/sa/107.xml"

	^ '<!DOCTYPE doc [
<![CDATA[]]>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa108xml [
	"Source file: xmltest/not-wf/sa/108.xml"

	^ '<doc>
<![CDATA [  ]]>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa109xml [
	"Source file: xmltest/not-wf/sa/109.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<doc></doc>">
]>
&e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa110xml [
	"Source file: xmltest/not-wf/sa/110.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "">
]>
<doc></doc>
&e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa111xml [
	"Source file: xmltest/not-wf/sa/111.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "foo=''bar''">
]>
<doc &e;></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa112xml [
	"Source file: xmltest/not-wf/sa/112.xml"

	^ '<doc>
<![cdata[data]]>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa113xml [
	"Source file: xmltest/not-wf/sa/113.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % foo "&">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa114xml [
	"Source file: xmltest/not-wf/sa/114.xml"

	^ '<!DOCTYPE doc [
<!ENTITY foo "&">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa115xml [
	"Source file: xmltest/not-wf/sa/115.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#38;">
]>
<doc a="&e;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa116xml [
	"Source file: xmltest/not-wf/sa/116.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#38;#9">
]>
<doc>&e;7;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa117xml [
	"Source file: xmltest/not-wf/sa/117.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#38;">
]>
<doc>&e;#97;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa118xml [
	"Source file: xmltest/not-wf/sa/118.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "#">
]>
<doc>&&e;97;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa119xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa120xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa121xml [
	"Source file: xmltest/not-wf/sa/121.xml"

	^ '<!DOCTYPE doc [
<!ENTITY #DEFAULT "default">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa122xml [
	"Source file: xmltest/not-wf/sa/122.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a, (b) | c)?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa123xml [
	"Source file: xmltest/not-wf/sa/123.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc ((doc?)))>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa124xml [
	"Source file: xmltest/not-wf/sa/124.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (doc|#PCDATA)*>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa125xml [
	"Source file: xmltest/not-wf/sa/125.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc ((#PCDATA))>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa126xml [
	"Source file: xmltest/not-wf/sa/126.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)+>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa127xml [
	"Source file: xmltest/not-wf/sa/127.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa128xml [
	"Source file: xmltest/not-wf/sa/128.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc CDATA>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa129xml [
	"Source file: xmltest/not-wf/sa/129.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc - - (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa130xml [
	"Source file: xmltest/not-wf/sa/130.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (doc?) +(foo)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa131xml [
	"Source file: xmltest/not-wf/sa/131.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (doc?) -(foo)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa132xml [
	"Source file: xmltest/not-wf/sa/132.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a, (b, c), (d, (e, f) | g))?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa133xml [
	"Source file: xmltest/not-wf/sa/133.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a *)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa134xml [
	"Source file: xmltest/not-wf/sa/134.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a) *>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa135xml [
	"Source file: xmltest/not-wf/sa/135.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a & b)?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa136xml [
	"Source file: xmltest/not-wf/sa/136.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc O O (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa137xml [
	"Source file: xmltest/not-wf/sa/137.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc(#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa138xml [
	"Source file: xmltest/not-wf/sa/138.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (doc*?)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa139xml [
	"Source file: xmltest/not-wf/sa/139.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc ()>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa140xml [
	"Source file: xmltest/not-wf/sa/140.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<&#x309a;></&#x309a;>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa141xml [
	"Source file: xmltest/not-wf/sa/141.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "<X&#xe5c;></X&#xe5c;>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa142xml [
	"Source file: xmltest/not-wf/sa/142.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#0;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa143xml [
	"Source file: xmltest/not-wf/sa/143.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#31;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa144xml [
	"Source file: xmltest/not-wf/sa/144.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#xFFFF;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa145xml [
	"Source file: xmltest/not-wf/sa/145.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#xD800;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa146xml [
	"Source file: xmltest/not-wf/sa/146.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x110000;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa147xml [
	"Source file: xmltest/not-wf/sa/147.xml"

	^ '
<?xml version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa148xml [
	"Source file: xmltest/not-wf/sa/148.xml"

	^ '<!-- -->
<?xml version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa149xml [
	"Source file: xmltest/not-wf/sa/149.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<?xml version="1.0"?>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa150xml [
	"Source file: xmltest/not-wf/sa/150.xml"

	^ '<doc>
<?xml version="1.0"?>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa151xml [
	"Source file: xmltest/not-wf/sa/151.xml"

	^ '<doc>
</doc>
<?xml version="1.0"?>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa152xml [
	"Source file: xmltest/not-wf/sa/152.xml"

	^ '<?xml encoding="UTF-8"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa153xml [
	"Source file: xmltest/not-wf/sa/153.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "<?xml encoding=''UTF-8''?>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa154xml [
	"Source file: xmltest/not-wf/sa/154.xml"

	^ '<?XML version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa155xml [
	"Source file: xmltest/not-wf/sa/155.xml"

	^ '<?xmL version="1.0"?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa156xml [
	"Source file: xmltest/not-wf/sa/156.xml"

	^ '<doc>
<?xMl version="1.0"?>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa157xml [
	"Source file: xmltest/not-wf/sa/157.xml"

	^ '<doc>
<?xmL?>
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa158xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa159xml [
	"Source file: xmltest/not-wf/sa/159.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "<![CDATA[Tim & Michael]]>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa160xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa161xml [
	"Source file: xmltest/not-wf/sa/161.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e "#PCDATA">
<!ELEMENT doc (%e;)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa162xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa163xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa164xml [
	"Source file: xmltest/not-wf/sa/164.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "">
] %e; >
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa165xml [
	"Source file: xmltest/not-wf/sa/165.xml"

	^ '<!DOCTYPE doc [
<!ENTITY% e "">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa166xml [
	"Source file: xmltest/not-wf/sa/166.xml"

	^ '<doc>￿</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa167xml [
	"Source file: xmltest/not-wf/sa/167.xml"

	^ '<doc>￾</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa168xml [
	"Source file: xmltest/not-wf/sa/168.xml"

	^ '<doc>́</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa169xml [
	"Source file: xmltest/not-wf/sa/169.xml"

	^ '<doc>́</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa171xml [
	"Source file: xmltest/not-wf/sa/171.xml"

	^ '<!-- ￿ -->
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa172xml [
	"Source file: xmltest/not-wf/sa/172.xml"

	^ '<?pi ￿?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa173xml [
	"Source file: xmltest/not-wf/sa/173.xml"

	^ '<doc a="￿"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa174xml [
	"Source file: xmltest/not-wf/sa/174.xml"

	^ '<doc><![CDATA[￿]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa175xml [
	"Source file: xmltest/not-wf/sa/175.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "￿">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa176xml [
	"Source file: xmltest/not-wf/sa/176.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa177xml [
	"Source file: xmltest/not-wf/sa/177.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>A￿</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa178xml [
	"Source file: xmltest/not-wf/sa/178.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="&#34;></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa179xml [
	"Source file: xmltest/not-wf/sa/179.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#34;>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa180xml [
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
XMLConformanceExpatTests class >> sourcenotwfsa181xml [
	"Source file: xmltest/not-wf/sa/181.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;![CDATA[">
<!ELEMENT doc (#PCDATA)>
]>
<doc>&e;]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa182xml [
	"Source file: xmltest/not-wf/sa/182.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;!--">
<!ELEMENT doc (#PCDATA)>
]>
<doc>&e;--></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa183xml [
	"Source file: xmltest/not-wf/sa/183.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA | foo*)* >
<!ELEMENT foo EMPTY>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa184xml [
	"Source file: xmltest/not-wf/sa/184.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA | (foo))* >
<!ELEMENT foo EMPTY>
]>
<doc></doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa185ent [
	"Source file: xmltest/not-wf/sa/185.ent"

	^ '<!ELEMENT doc (#PCDATA)>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa185xml [
	"Source file: xmltest/not-wf/sa/185.xml"

	^ '<?xml version="1.0" standalone="yes"?>
<!DOCTYPE doc SYSTEM "185.ent">
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsa186xml [
	"Source file: xmltest/not-wf/sa/186.xml"

	^ '<!DOCTYPE a [
<!ELEMENT a EMPTY>
<!ATTLIST a b CDATA #IMPLIED d CDATA #IMPLIED>
]>
<a b="c"d="e"/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcenotwfsanullent [
	"Source file: xmltest/not-wf/sa/null.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa001ent [
	"Source file: xmltest/valid/ext-sa/001.ent"

	^ 'Data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa001xml [
	"Source file: xmltest/valid/ext-sa/001.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "001.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa002ent [
	"Source file: xmltest/valid/ext-sa/002.ent"

	^ 'Data'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa002xml [
	"Source file: xmltest/valid/ext-sa/002.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "002.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa003ent [
	"Source file: xmltest/valid/ext-sa/003.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa003xml [
	"Source file: xmltest/valid/ext-sa/003.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "003.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa004ent [
	"Source file: xmltest/valid/ext-sa/004.ent"

	^ 'Data
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa004xml [
	"Source file: xmltest/valid/ext-sa/004.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "004.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa005ent [
	"Source file: xmltest/valid/ext-sa/005.ent"

	^ '<e/><e/><e/>'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa005xml [
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
XMLConformanceExpatTests class >> sourcevalidextsa006ent [
	"Source file: xmltest/valid/ext-sa/006.ent"

	^ 'Data
<e/>
More data
<e/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa006xml [
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
XMLConformanceExpatTests class >> sourcevalidextsa007xml [
	"Source file: xmltest/valid/ext-sa/007.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "007.ent">
]>
<doc>X&e;Z</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa008xml [
	"Source file: xmltest/valid/ext-sa/008.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "008.ent">
]>
<doc>X&e;Z</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa009ent [
	"Source file: xmltest/valid/ext-sa/009.ent"

	^ '
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa009xml [
	"Source file: xmltest/valid/ext-sa/009.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "009.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa010ent [
	"Source file: xmltest/valid/ext-sa/010.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa010xml [
	"Source file: xmltest/valid/ext-sa/010.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "010.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa011ent [
	"Source file: xmltest/valid/ext-sa/011.ent"

	^ 'xyzzy
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa011xml [
	"Source file: xmltest/valid/ext-sa/011.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e PUBLIC "a not very interesting file" "011.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa012ent [
	"Source file: xmltest/valid/ext-sa/012.ent"

	^ '&e4;'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa012xml [
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
XMLConformanceExpatTests class >> sourcevalidextsa013ent [
	"Source file: xmltest/valid/ext-sa/013.ent"

	^ '<e/>'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidextsa013xml [
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
XMLConformanceExpatTests class >> sourcevalidextsa014xml [
	"Source file: xmltest/valid/ext-sa/014.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e SYSTEM "014.ent">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa001ent [
	"Source file: xmltest/valid/not-sa/001.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa001xml [
	"Source file: xmltest/valid/not-sa/001.xml"

	^ '<!DOCTYPE doc SYSTEM "001.ent" [
<!ELEMENT doc EMPTY>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa002ent [
	"Source file: xmltest/valid/not-sa/002.ent"

	^ '
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa002xml [
	"Source file: xmltest/valid/not-sa/002.xml"

	^ '<!DOCTYPE doc SYSTEM "002.ent" [
<!ELEMENT doc EMPTY>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa0031ent [
	"Source file: xmltest/valid/not-sa/003-1.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e SYSTEM "003-2.ent">
<!ATTLIST doc a1 CDATA %e; "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa0032ent [
	"Source file: xmltest/valid/not-sa/003-2.ent"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa003xml [
	"Source file: xmltest/valid/not-sa/003.xml"

	^ '<!DOCTYPE doc SYSTEM "003-1.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa0041ent [
	"Source file: xmltest/valid/not-sa/004-1.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e1 SYSTEM "004-2.ent">
<!ENTITY % e2 "%e1;">
%e1;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa0042ent [
	"Source file: xmltest/valid/not-sa/004-2.ent"

	^ '<!ATTLIST doc a1 CDATA "value">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa004xml [
	"Source file: xmltest/valid/not-sa/004.xml"

	^ '<!DOCTYPE doc SYSTEM "004-1.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa0051ent [
	"Source file: xmltest/valid/not-sa/005-1.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e SYSTEM "005-2.ent">
%e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa0052ent [
	"Source file: xmltest/valid/not-sa/005-2.ent"

	^ '<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa005xml [
	"Source file: xmltest/valid/not-sa/005.xml"

	^ '<!DOCTYPE doc SYSTEM "005-1.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa006ent [
	"Source file: xmltest/valid/not-sa/006.ent"

	^ '<!ELEMENT doc EMPTY>
<!ATTLIST doc a1 CDATA "w1" a2 CDATA "w2">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa006xml [
	"Source file: xmltest/valid/not-sa/006.xml"

	^ '<!DOCTYPE doc SYSTEM "006.ent" [
<!ATTLIST doc a1 CDATA "v1">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa007ent [
	"Source file: xmltest/valid/not-sa/007.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa007xml [
	"Source file: xmltest/valid/not-sa/007.xml"

	^ '<!DOCTYPE doc SYSTEM "007.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa008ent [
	"Source file: xmltest/valid/not-sa/008.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa008xml [
	"Source file: xmltest/valid/not-sa/008.xml"

	^ '<!DOCTYPE doc PUBLIC "whatever" "008.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa009ent [
	"Source file: xmltest/valid/not-sa/009.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa009xml [
	"Source file: xmltest/valid/not-sa/009.xml"

	^ '<!DOCTYPE doc PUBLIC "whatever" "009.ent" [
<!ATTLIST doc a2 CDATA "v2">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa010ent [
	"Source file: xmltest/valid/not-sa/010.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v2">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa010xml [
	"Source file: xmltest/valid/not-sa/010.xml"

	^ '<!DOCTYPE doc SYSTEM "010.ent" [
<!ATTLIST doc a1 CDATA "v1">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa011ent [
	"Source file: xmltest/valid/not-sa/011.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa011xml [
	"Source file: xmltest/valid/not-sa/011.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e SYSTEM "011.ent">
%e;
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa012ent [
	"Source file: xmltest/valid/not-sa/012.ent"

	^ '<?xml version="1.0" encoding="UTF-8"?>
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa012xml [
	"Source file: xmltest/valid/not-sa/012.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e SYSTEM "012.ent">
%e;
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa013ent [
	"Source file: xmltest/valid/not-sa/013.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ INCLUDE [
<!ATTLIST doc a1 CDATA "v1">
]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa013xml [
	"Source file: xmltest/valid/not-sa/013.xml"

	^ '<!DOCTYPE doc SYSTEM "013.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa014ent [
	"Source file: xmltest/valid/not-sa/014.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ %e; [
<!ATTLIST doc a1 CDATA "v1">
]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa014xml [
	"Source file: xmltest/valid/not-sa/014.xml"

	^ '<!DOCTYPE doc SYSTEM "014.ent" [
<!ENTITY % e "INCLUDE">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa015ent [
	"Source file: xmltest/valid/not-sa/015.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![ %e; [
<!ATTLIST doc a1 CDATA "v1">
]]>
<!ATTLIST doc a2 CDATA "v2">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa015xml [
	"Source file: xmltest/valid/not-sa/015.xml"

	^ '<!DOCTYPE doc SYSTEM "015.ent" [
<!ENTITY % e "IGNORE">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa016ent [
	"Source file: xmltest/valid/not-sa/016.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![%e;[
<!ATTLIST doc a1 CDATA "v1">
]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa016xml [
	"Source file: xmltest/valid/not-sa/016.xml"

	^ '<!DOCTYPE doc SYSTEM "016.ent" [
<!ENTITY % e "INCLUDE">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa017ent [
	"Source file: xmltest/valid/not-sa/017.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "<!ATTLIST doc a1 CDATA ''v1''>">
%e;
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa017xml [
	"Source file: xmltest/valid/not-sa/017.xml"

	^ '<!DOCTYPE doc SYSTEM "017.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa018ent [
	"Source file: xmltest/valid/not-sa/018.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "''v1''">
<!ATTLIST doc a1 CDATA %e;>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa018xml [
	"Source file: xmltest/valid/not-sa/018.xml"

	^ '<!DOCTYPE doc SYSTEM "018.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa019ent [
	"Source file: xmltest/valid/not-sa/019.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "''v1''">
<!ATTLIST doc a1 CDATA%e;>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa019xml [
	"Source file: xmltest/valid/not-sa/019.xml"

	^ '<!DOCTYPE doc SYSTEM "019.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa020ent [
	"Source file: xmltest/valid/not-sa/020.ent"

	^ '<!ENTITY % e "doc">
<!ELEMENT doc (#PCDATA)>
<!ATTLIST%e;a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa020xml [
	"Source file: xmltest/valid/not-sa/020.xml"

	^ '<!DOCTYPE doc SYSTEM "020.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa021ent [
	"Source file: xmltest/valid/not-sa/021.ent"

	^ '<!ENTITY % e "doc a1 CDATA">
<!ELEMENT doc (#PCDATA)>
<!ATTLIST %e; "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa021xml [
	"Source file: xmltest/valid/not-sa/021.xml"

	^ '<!DOCTYPE doc SYSTEM "021.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa023ent [
	"Source file: xmltest/valid/not-sa/023.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e1 "do">
<!ENTITY % e2 "c">
<!ENTITY % e3 "%e1;%e2;">
<!ATTLIST %e3; a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa023xml [
	"Source file: xmltest/valid/not-sa/023.xml"

	^ '<!DOCTYPE doc SYSTEM "023.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa024ent [
	"Source file: xmltest/valid/not-sa/024.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e1 "''v1''">
<!ENTITY % e2 ''a1 CDATA %e1;''>
<!ATTLIST doc %e2;>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa024xml [
	"Source file: xmltest/valid/not-sa/024.xml"

	^ '<!DOCTYPE doc SYSTEM "024.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa025ent [
	"Source file: xmltest/valid/not-sa/025.ent"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % e "x">
<!ENTITY % e "y">
<!ENTITY % v "''%e;''">
<!ATTLIST doc a1 CDATA %v;>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa025xml [
	"Source file: xmltest/valid/not-sa/025.xml"

	^ '<!DOCTYPE doc SYSTEM "025.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa026ent [
	"Source file: xmltest/valid/not-sa/026.ent"

	^ '<!ATTLIST doc a1 CDATA "w1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa026xml [
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
XMLConformanceExpatTests class >> sourcevalidnotsa027ent [
	"Source file: xmltest/valid/not-sa/027.ent"

	^ '<!ENTITY % e "">
<!ELEMENT doc (#PCDATA %e;)>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa027xml [
	"Source file: xmltest/valid/not-sa/027.xml"

	^ '<!DOCTYPE doc SYSTEM "027.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa028ent [
	"Source file: xmltest/valid/not-sa/028.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![INCLUDE[<!ATTLIST doc a1 CDATA "v1">]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa028xml [
	"Source file: xmltest/valid/not-sa/028.xml"

	^ '<!DOCTYPE doc SYSTEM "028.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa029ent [
	"Source file: xmltest/valid/not-sa/029.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![IGNORE[<!ATTLIST doc a1 CDATA "v1">]]>
<!ATTLIST doc a1 CDATA "v2">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa029xml [
	"Source file: xmltest/valid/not-sa/029.xml"

	^ '<!DOCTYPE doc SYSTEM "029.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa030ent [
	"Source file: xmltest/valid/not-sa/030.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<![IGNORE[]]>
<![INCLUDE[]]>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa030xml [
	"Source file: xmltest/valid/not-sa/030.xml"

	^ '<!DOCTYPE doc SYSTEM "030.ent">
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa0311ent [
	"Source file: xmltest/valid/not-sa/031-1.ent"

	^ '<!ELEMENT doc (#PCDATA)>
<!ENTITY % e SYSTEM "031-2.ent">
<!ENTITY e "<![CDATA[%e;]]>">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa0312ent [
	"Source file: xmltest/valid/not-sa/031-2.ent"

	^ '<!ATTLIST doc a1 CDATA "v1">
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidnotsa031xml [
	"Source file: xmltest/valid/not-sa/031.xml"

	^ '<!DOCTYPE doc SYSTEM "031-1.ent">
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa001xml [
	"Source file: xmltest/valid/sa/001.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa002xml [
	"Source file: xmltest/valid/sa/002.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc ></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa003xml [
	"Source file: xmltest/valid/sa/003.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc >
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa004xml [
	"Source file: xmltest/valid/sa/004.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa005xml [
	"Source file: xmltest/valid/sa/005.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1 = "v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa006xml [
	"Source file: xmltest/valid/sa/006.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1=''v1''></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa007xml [
	"Source file: xmltest/valid/sa/007.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#32;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa008xml [
	"Source file: xmltest/valid/sa/008.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&amp;&lt;&gt;&quot;&apos;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa009xml [
	"Source file: xmltest/valid/sa/009.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x20;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa010xml [
	"Source file: xmltest/valid/sa/010.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="v1" ></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa011xml [
	"Source file: xmltest/valid/sa/011.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED a2 CDATA #IMPLIED>
]>
<doc a1="v1" a2="v2"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa012xml [
	"Source file: xmltest/valid/sa/012.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc : CDATA #IMPLIED>
]>
<doc :="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa013xml [
	"Source file: xmltest/valid/sa/013.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc _.-0123456789 CDATA #IMPLIED>
]>
<doc _.-0123456789="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa014xml [
	"Source file: xmltest/valid/sa/014.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc abcdefghijklmnopqrstuvwxyz CDATA #IMPLIED>
]>
<doc abcdefghijklmnopqrstuvwxyz="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa015xml [
	"Source file: xmltest/valid/sa/015.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc ABCDEFGHIJKLMNOPQRSTUVWXYZ CDATA #IMPLIED>
]>
<doc ABCDEFGHIJKLMNOPQRSTUVWXYZ="v1"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa016xml [
	"Source file: xmltest/valid/sa/016.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa017axml [
	"Source file: xmltest/valid/sa/017a.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi some data ? > <??></doc>'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa017xml [
	"Source file: xmltest/valid/sa/017.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi some data ?><?x?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa018xml [
	"Source file: xmltest/valid/sa/018.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[<foo>]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa019xml [
	"Source file: xmltest/valid/sa/019.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[<&]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa020xml [
	"Source file: xmltest/valid/sa/020.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[<&]>]]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa021xml [
	"Source file: xmltest/valid/sa/021.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><!-- a comment --></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa022xml [
	"Source file: xmltest/valid/sa/022.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><!-- a comment ->--></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa023xml [
	"Source file: xmltest/valid/sa/023.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa024xml [
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
XMLConformanceExpatTests class >> sourcevalidsa025xml [
	"Source file: xmltest/valid/sa/025.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo*)>
<!ELEMENT foo (#PCDATA)>
]>
<doc><foo/><foo></foo></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa026xml [
	"Source file: xmltest/valid/sa/026.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo*)>
<!ELEMENT foo EMPTY>
]>
<doc><foo/><foo></foo></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa027xml [
	"Source file: xmltest/valid/sa/027.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo*)>
<!ELEMENT foo ANY>
]>
<doc><foo/><foo></foo></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa028xml [
	"Source file: xmltest/valid/sa/028.xml"

	^ '<?xml version="1.0"?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa029xml [
	"Source file: xmltest/valid/sa/029.xml"

	^ '<?xml version=''1.0''?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa030xml [
	"Source file: xmltest/valid/sa/030.xml"

	^ '<?xml version = "1.0"?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa031xml [
	"Source file: xmltest/valid/sa/031.xml"

	^ '<?xml version=''1.0'' encoding="UTF-8"?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa032xml [
	"Source file: xmltest/valid/sa/032.xml"

	^ '<?xml version=''1.0'' standalone=''yes''?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa033xml [
	"Source file: xmltest/valid/sa/033.xml"

	^ '<?xml version=''1.0'' encoding="UTF-8" standalone=''yes''?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa034xml [
	"Source file: xmltest/valid/sa/034.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa035xml [
	"Source file: xmltest/valid/sa/035.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc />
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa036xml [
	"Source file: xmltest/valid/sa/036.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
<?pi data?>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa037xml [
	"Source file: xmltest/valid/sa/037.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
<!-- comment -->

'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa038xml [
	"Source file: xmltest/valid/sa/038.xml"

	^ '<!-- comment -->
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>

'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa039xml [
	"Source file: xmltest/valid/sa/039.xml"

	^ '<?pi data?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa040xml [
	"Source file: xmltest/valid/sa/040.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="&quot;&lt;&amp;&gt;&apos;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa041xml [
	"Source file: xmltest/valid/sa/041.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="&#65;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa042xml [
	"Source file: xmltest/valid/sa/042.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#00000000000000000000000000000000065;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa043xml [
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
XMLConformanceExpatTests class >> sourcevalidsa044xml [
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
XMLConformanceExpatTests class >> sourcevalidsa045xml [
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
XMLConformanceExpatTests class >> sourcevalidsa046xml [
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
XMLConformanceExpatTests class >> sourcevalidsa047xml [
	"Source file: xmltest/valid/sa/047.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>X
Y</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa048xml [
	"Source file: xmltest/valid/sa/048.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>]</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa052xml [
	"Source file: xmltest/valid/sa/052.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>𐀀􏿽</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa053xml [
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
XMLConformanceExpatTests class >> sourcevalidsa054xml [
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
XMLConformanceExpatTests class >> sourcevalidsa055xml [
	"Source file: xmltest/valid/sa/055.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<?pi  data?>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa056xml [
	"Source file: xmltest/valid/sa/056.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x0000000000000000000000000000000000000041;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa057xml [
	"Source file: xmltest/valid/sa/057.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a*)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa058xml [
	"Source file: xmltest/valid/sa/058.xml"

	^ '<!DOCTYPE doc [
<!ATTLIST doc a1 NMTOKENS #IMPLIED>
<!ELEMENT doc (#PCDATA)>
]>
<doc a1=" 1  	2 	"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa059xml [
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
XMLConformanceExpatTests class >> sourcevalidsa060xml [
	"Source file: xmltest/valid/sa/060.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>X&#10;Y</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa061xml [
	"Source file: xmltest/valid/sa/061.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#163;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa062xml [
	"Source file: xmltest/valid/sa/062.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#xe40;&#xe08;&#xe21;ส์</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa063xml [
	"Source file: xmltest/valid/sa/063.xml"

	^ '<!DOCTYPE เจมส์ [
<!ELEMENT เจมส์ (#PCDATA)>
]>
<เจมส์></เจมส์>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa064xml [
	"Source file: xmltest/valid/sa/064.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x10000;&#x10FFFD;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa065xml [
	"Source file: xmltest/valid/sa/065.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa066xml [
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
XMLConformanceExpatTests class >> sourcevalidsa067xml [
	"Source file: xmltest/valid/sa/067.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#13;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa068xml [
	"Source file: xmltest/valid/sa/068.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "&#13;">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa069xml [
	"Source file: xmltest/valid/sa/069.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!NOTATION n PUBLIC "whatever">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa070xml [
	"Source file: xmltest/valid/sa/070.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e "<!ELEMENT doc (#PCDATA)>">
%e;
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa071xml [
	"Source file: xmltest/valid/sa/071.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ID #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa072xml [
	"Source file: xmltest/valid/sa/072.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a IDREF #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa073xml [
	"Source file: xmltest/valid/sa/073.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a IDREFS #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa074xml [
	"Source file: xmltest/valid/sa/074.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ENTITY #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa075xml [
	"Source file: xmltest/valid/sa/075.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ENTITIES #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa076xml [
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
XMLConformanceExpatTests class >> sourcevalidsa077xml [
	"Source file: xmltest/valid/sa/077.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a (1|2) #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa078xml [
	"Source file: xmltest/valid/sa/078.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #REQUIRED>
]>
<doc a="v"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa079xml [
	"Source file: xmltest/valid/sa/079.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #FIXED "v">
]>
<doc a="v"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa080xml [
	"Source file: xmltest/valid/sa/080.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #FIXED "v">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa081xml [
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
XMLConformanceExpatTests class >> sourcevalidsa082xml [
	"Source file: xmltest/valid/sa/082.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e SYSTEM "e.dtd">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa083xml [
	"Source file: xmltest/valid/sa/083.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % e PUBLIC ''whatever'' "e.dtd">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa084xml [
	"Source file: xmltest/valid/sa/084.xml"

	^ '<!DOCTYPE doc [<!ELEMENT doc (#PCDATA)>]><doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa085xml [
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
XMLConformanceExpatTests class >> sourcevalidsa086xml [
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
XMLConformanceExpatTests class >> sourcevalidsa087xml [
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
XMLConformanceExpatTests class >> sourcevalidsa088xml [
	"Source file: xmltest/valid/sa/088.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "&lt;foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa089xml [
	"Source file: xmltest/valid/sa/089.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e "&#x10000;&#x10FFFD;&#x10FFFF;">
<!ELEMENT doc (#PCDATA)>
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa090xml [
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
XMLConformanceExpatTests class >> sourcevalidsa091xml [
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
XMLConformanceExpatTests class >> sourcevalidsa092xml [
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
XMLConformanceExpatTests class >> sourcevalidsa093xml [
	"Source file: xmltest/valid/sa/093.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>


</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa094xml [
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
XMLConformanceExpatTests class >> sourcevalidsa095xml [
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
XMLConformanceExpatTests class >> sourcevalidsa096xml [
	"Source file: xmltest/valid/sa/096.xml"

	^ '<!DOCTYPE doc [
<!ATTLIST doc a1 NMTOKENS " 1  	2 	">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa097ent [
	"Source file: xmltest/valid/sa/097.ent"

	^ '<!ATTLIST doc a2 CDATA #IMPLIED>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa097xml [
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
XMLConformanceExpatTests class >> sourcevalidsa098xml [
	"Source file: xmltest/valid/sa/098.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi x
y?></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa099xml [
	"Source file: xmltest/valid/sa/099.xml"

	^ '<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa100xml [
	"Source file: xmltest/valid/sa/100.xml"

	^ '<!DOCTYPE doc [
<!ENTITY e PUBLIC ";!*#@$_%" "100.xml">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa101xml [
	"Source file: xmltest/valid/sa/101.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "&#34;">
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa102xml [
	"Source file: xmltest/valid/sa/102.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="&#34;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa103xml [
	"Source file: xmltest/valid/sa/103.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#60;doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa104xml [
	"Source file: xmltest/valid/sa/104.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x	y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa105xml [
	"Source file: xmltest/valid/sa/105.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x&#9;y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa106xml [
	"Source file: xmltest/valid/sa/106.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x&#10;y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa107xml [
	"Source file: xmltest/valid/sa/107.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="x&#13;y"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa108xml [
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
XMLConformanceExpatTests class >> sourcevalidsa109xml [
	"Source file: xmltest/valid/sa/109.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a=""></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa110xml [
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
XMLConformanceExpatTests class >> sourcevalidsa111xml [
	"Source file: xmltest/valid/sa/111.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a NMTOKENS #IMPLIED>
]>
<doc a="&#32;x&#32;&#32;y&#32;"></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa112xml [
	"Source file: xmltest/valid/sa/112.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (a | b)>
<!ELEMENT a (#PCDATA)>
]>
<doc><a></a></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa113xml [
	"Source file: xmltest/valid/sa/113.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST e a CDATA #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa114xml [
	"Source file: xmltest/valid/sa/114.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "<![CDATA[&foo;]]>">
]>
<doc>&e;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa115xml [
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
XMLConformanceExpatTests class >> sourcevalidsa116xml [
	"Source file: xmltest/valid/sa/116.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[
]]></doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa117xml [
	"Source file: xmltest/valid/sa/117.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY rsqb "]">
]>
<doc>&rsqb;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa118xml [
	"Source file: xmltest/valid/sa/118.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY rsqb "]]">
]>
<doc>&rsqb;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceExpatTests class >> sourcevalidsa119xml [
	"Source file: xmltest/valid/sa/119.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc ANY>
]>
<doc><!-- -á --></doc>
'
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testinvalid002xml [
	"Source file: xmltest/invalid/002.xml"

	(self isSkippableTest: #testinvalid002xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalid002xml
				documentURI: 'invalid/002.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testinvalid005xml [
	"Source file: xmltest/invalid/005.xml"

	(self isSkippableTest: #testinvalid005xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalid005xml
				documentURI: 'invalid/005.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testinvalid006xml [
	"Source file: xmltest/invalid/006.xml"

	(self isSkippableTest: #testinvalid006xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalid006xml
				documentURI: 'invalid/006.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testinvalidnotsa022xml [
	"Source file: xmltest/invalid/not-sa/022.xml"

	(self isSkippableTest: #testinvalidnotsa022xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourceinvalidnotsa022xml
				documentURI: 'invalid/not-sa/022.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfextsa001xml [
	"Source file: xmltest/not-wf/ext-sa/001.xml"

	(self isSkippableTest: #testnotwfextsa001xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfextsa001xml
				documentURI: 'not-wf/ext-sa/001.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfextsa002xml [
	"Source file: xmltest/not-wf/ext-sa/002.xml"

	(self isSkippableTest: #testnotwfextsa002xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfextsa002xml
				documentURI: 'not-wf/ext-sa/002.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfextsa003xml [
	"Source file: xmltest/not-wf/ext-sa/003.xml"

	(self isSkippableTest: #testnotwfextsa003xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfextsa003xml
				documentURI: 'not-wf/ext-sa/003.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa001xml [
	"Source file: xmltest/not-wf/not-sa/001.xml"

	(self isSkippableTest: #testnotwfnotsa001xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa001xml
				documentURI: 'not-wf/not-sa/001.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa002xml [
	"Source file: xmltest/not-wf/not-sa/002.xml"

	(self isSkippableTest: #testnotwfnotsa002xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa002xml
				documentURI: 'not-wf/not-sa/002.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa003xml [
	"Source file: xmltest/not-wf/not-sa/003.xml"

	(self isSkippableTest: #testnotwfnotsa003xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa003xml
				documentURI: 'not-wf/not-sa/003.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa004xml [
	"Source file: xmltest/not-wf/not-sa/004.xml"

	(self isSkippableTest: #testnotwfnotsa004xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa004xml
				documentURI: 'not-wf/not-sa/004.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa005xml [
	"Source file: xmltest/not-wf/not-sa/005.xml"

	(self isSkippableTest: #testnotwfnotsa005xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa005xml
				documentURI: 'not-wf/not-sa/005.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa006xml [
	"Source file: xmltest/not-wf/not-sa/006.xml"

	(self isSkippableTest: #testnotwfnotsa006xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa006xml
				documentURI: 'not-wf/not-sa/006.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa007xml [
	"Source file: xmltest/not-wf/not-sa/007.xml"

	(self isSkippableTest: #testnotwfnotsa007xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa007xml
				documentURI: 'not-wf/not-sa/007.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa008xml [
	"Source file: xmltest/not-wf/not-sa/008.xml"

	(self isSkippableTest: #testnotwfnotsa008xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa008xml
				documentURI: 'not-wf/not-sa/008.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa009xml [
	"Source file: xmltest/not-wf/not-sa/009.xml"

	(self isSkippableTest: #testnotwfnotsa009xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa009xml
				documentURI: 'not-wf/not-sa/009.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa010xml [
	"Source file: xmltest/not-wf/not-sa/010.xml"

	(self isSkippableTest: #testnotwfnotsa010xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa010xml
				documentURI: 'not-wf/not-sa/010.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfnotsa011xml [
	"Source file: xmltest/not-wf/not-sa/011.xml"

	(self isSkippableTest: #testnotwfnotsa011xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfnotsa011xml
				documentURI: 'not-wf/not-sa/011.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa001xml [
	"Source file: xmltest/not-wf/sa/001.xml"

	(self isSkippableTest: #testnotwfsa001xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa001xml
				documentURI: 'not-wf/sa/001.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa002xml [
	"Source file: xmltest/not-wf/sa/002.xml"

	(self isSkippableTest: #testnotwfsa002xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa002xml
				documentURI: 'not-wf/sa/002.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa003xml [
	"Source file: xmltest/not-wf/sa/003.xml"

	(self isSkippableTest: #testnotwfsa003xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa003xml
				documentURI: 'not-wf/sa/003.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa004xml [
	"Source file: xmltest/not-wf/sa/004.xml"

	(self isSkippableTest: #testnotwfsa004xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa004xml
				documentURI: 'not-wf/sa/004.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa005xml [
	"Source file: xmltest/not-wf/sa/005.xml"

	(self isSkippableTest: #testnotwfsa005xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa005xml
				documentURI: 'not-wf/sa/005.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa006xml [
	"Source file: xmltest/not-wf/sa/006.xml"

	(self isSkippableTest: #testnotwfsa006xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa006xml
				documentURI: 'not-wf/sa/006.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa007xml [
	"Source file: xmltest/not-wf/sa/007.xml"

	(self isSkippableTest: #testnotwfsa007xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa007xml
				documentURI: 'not-wf/sa/007.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa008xml [
	"Source file: xmltest/not-wf/sa/008.xml"

	(self isSkippableTest: #testnotwfsa008xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa008xml
				documentURI: 'not-wf/sa/008.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa009xml [
	"Source file: xmltest/not-wf/sa/009.xml"

	(self isSkippableTest: #testnotwfsa009xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa009xml
				documentURI: 'not-wf/sa/009.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa010xml [
	"Source file: xmltest/not-wf/sa/010.xml"

	(self isSkippableTest: #testnotwfsa010xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa010xml
				documentURI: 'not-wf/sa/010.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa011xml [
	"Source file: xmltest/not-wf/sa/011.xml"

	(self isSkippableTest: #testnotwfsa011xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa011xml
				documentURI: 'not-wf/sa/011.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa012xml [
	"Source file: xmltest/not-wf/sa/012.xml"

	(self isSkippableTest: #testnotwfsa012xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa012xml
				documentURI: 'not-wf/sa/012.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa013xml [
	"Source file: xmltest/not-wf/sa/013.xml"

	(self isSkippableTest: #testnotwfsa013xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa013xml
				documentURI: 'not-wf/sa/013.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa014xml [
	"Source file: xmltest/not-wf/sa/014.xml"

	(self isSkippableTest: #testnotwfsa014xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa014xml
				documentURI: 'not-wf/sa/014.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa015xml [
	"Source file: xmltest/not-wf/sa/015.xml"

	(self isSkippableTest: #testnotwfsa015xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa015xml
				documentURI: 'not-wf/sa/015.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa016xml [
	"Source file: xmltest/not-wf/sa/016.xml"

	(self isSkippableTest: #testnotwfsa016xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa016xml
				documentURI: 'not-wf/sa/016.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa017xml [
	"Source file: xmltest/not-wf/sa/017.xml"

	(self isSkippableTest: #testnotwfsa017xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa017xml
				documentURI: 'not-wf/sa/017.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa018xml [
	"Source file: xmltest/not-wf/sa/018.xml"

	(self isSkippableTest: #testnotwfsa018xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa018xml
				documentURI: 'not-wf/sa/018.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa019xml [
	"Source file: xmltest/not-wf/sa/019.xml"

	(self isSkippableTest: #testnotwfsa019xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa019xml
				documentURI: 'not-wf/sa/019.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa020xml [
	"Source file: xmltest/not-wf/sa/020.xml"

	(self isSkippableTest: #testnotwfsa020xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa020xml
				documentURI: 'not-wf/sa/020.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa021xml [
	"Source file: xmltest/not-wf/sa/021.xml"

	(self isSkippableTest: #testnotwfsa021xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa021xml
				documentURI: 'not-wf/sa/021.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa022xml [
	"Source file: xmltest/not-wf/sa/022.xml"

	(self isSkippableTest: #testnotwfsa022xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa022xml
				documentURI: 'not-wf/sa/022.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa023xml [
	"Source file: xmltest/not-wf/sa/023.xml"

	(self isSkippableTest: #testnotwfsa023xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa023xml
				documentURI: 'not-wf/sa/023.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa024xml [
	"Source file: xmltest/not-wf/sa/024.xml"

	(self isSkippableTest: #testnotwfsa024xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa024xml
				documentURI: 'not-wf/sa/024.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa025xml [
	"Source file: xmltest/not-wf/sa/025.xml"

	(self isSkippableTest: #testnotwfsa025xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa025xml
				documentURI: 'not-wf/sa/025.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa026xml [
	"Source file: xmltest/not-wf/sa/026.xml"

	(self isSkippableTest: #testnotwfsa026xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa026xml
				documentURI: 'not-wf/sa/026.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa027xml [
	"Source file: xmltest/not-wf/sa/027.xml"

	(self isSkippableTest: #testnotwfsa027xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa027xml
				documentURI: 'not-wf/sa/027.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa028xml [
	"Source file: xmltest/not-wf/sa/028.xml"

	(self isSkippableTest: #testnotwfsa028xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa028xml
				documentURI: 'not-wf/sa/028.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa029xml [
	"Source file: xmltest/not-wf/sa/029.xml"

	(self isSkippableTest: #testnotwfsa029xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa029xml
				documentURI: 'not-wf/sa/029.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa030xml [
	"Source file: xmltest/not-wf/sa/030.xml"

	(self isSkippableTest: #testnotwfsa030xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa030xml
				documentURI: 'not-wf/sa/030.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa031xml [
	"Source file: xmltest/not-wf/sa/031.xml"

	(self isSkippableTest: #testnotwfsa031xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa031xml
				documentURI: 'not-wf/sa/031.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa032xml [
	"Source file: xmltest/not-wf/sa/032.xml"

	(self isSkippableTest: #testnotwfsa032xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa032xml
				documentURI: 'not-wf/sa/032.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa033xml [
	"Source file: xmltest/not-wf/sa/033.xml"

	(self isSkippableTest: #testnotwfsa033xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa033xml
				documentURI: 'not-wf/sa/033.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa034xml [
	"Source file: xmltest/not-wf/sa/034.xml"

	(self isSkippableTest: #testnotwfsa034xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa034xml
				documentURI: 'not-wf/sa/034.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa035xml [
	"Source file: xmltest/not-wf/sa/035.xml"

	(self isSkippableTest: #testnotwfsa035xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa035xml
				documentURI: 'not-wf/sa/035.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa036xml [
	"Source file: xmltest/not-wf/sa/036.xml"

	(self isSkippableTest: #testnotwfsa036xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa036xml
				documentURI: 'not-wf/sa/036.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa037xml [
	"Source file: xmltest/not-wf/sa/037.xml"

	(self isSkippableTest: #testnotwfsa037xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa037xml
				documentURI: 'not-wf/sa/037.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa038xml [
	"Source file: xmltest/not-wf/sa/038.xml"

	(self isSkippableTest: #testnotwfsa038xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa038xml
				documentURI: 'not-wf/sa/038.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa039xml [
	"Source file: xmltest/not-wf/sa/039.xml"

	(self isSkippableTest: #testnotwfsa039xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa039xml
				documentURI: 'not-wf/sa/039.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa040xml [
	"Source file: xmltest/not-wf/sa/040.xml"

	(self isSkippableTest: #testnotwfsa040xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa040xml
				documentURI: 'not-wf/sa/040.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa041xml [
	"Source file: xmltest/not-wf/sa/041.xml"

	(self isSkippableTest: #testnotwfsa041xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa041xml
				documentURI: 'not-wf/sa/041.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa042xml [
	"Source file: xmltest/not-wf/sa/042.xml"

	(self isSkippableTest: #testnotwfsa042xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa042xml
				documentURI: 'not-wf/sa/042.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa043xml [
	"Source file: xmltest/not-wf/sa/043.xml"

	(self isSkippableTest: #testnotwfsa043xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa043xml
				documentURI: 'not-wf/sa/043.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa044xml [
	"Source file: xmltest/not-wf/sa/044.xml"

	(self isSkippableTest: #testnotwfsa044xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa044xml
				documentURI: 'not-wf/sa/044.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa045xml [
	"Source file: xmltest/not-wf/sa/045.xml"

	(self isSkippableTest: #testnotwfsa045xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa045xml
				documentURI: 'not-wf/sa/045.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa046xml [
	"Source file: xmltest/not-wf/sa/046.xml"

	(self isSkippableTest: #testnotwfsa046xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa046xml
				documentURI: 'not-wf/sa/046.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa047xml [
	"Source file: xmltest/not-wf/sa/047.xml"

	(self isSkippableTest: #testnotwfsa047xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa047xml
				documentURI: 'not-wf/sa/047.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa048xml [
	"Source file: xmltest/not-wf/sa/048.xml"

	(self isSkippableTest: #testnotwfsa048xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa048xml
				documentURI: 'not-wf/sa/048.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa049xml [
	"Source file: xmltest/not-wf/sa/049.xml"

	(self isSkippableTest: #testnotwfsa049xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa049xml
				documentURI: 'not-wf/sa/049.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa050xml [
	"Source file: xmltest/not-wf/sa/050.xml"

	(self isSkippableTest: #testnotwfsa050xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa050xml
				documentURI: 'not-wf/sa/050.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa051xml [
	"Source file: xmltest/not-wf/sa/051.xml"

	(self isSkippableTest: #testnotwfsa051xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa051xml
				documentURI: 'not-wf/sa/051.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa052xml [
	"Source file: xmltest/not-wf/sa/052.xml"

	(self isSkippableTest: #testnotwfsa052xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa052xml
				documentURI: 'not-wf/sa/052.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa053xml [
	"Source file: xmltest/not-wf/sa/053.xml"

	(self isSkippableTest: #testnotwfsa053xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa053xml
				documentURI: 'not-wf/sa/053.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa054xml [
	"Source file: xmltest/not-wf/sa/054.xml"

	(self isSkippableTest: #testnotwfsa054xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa054xml
				documentURI: 'not-wf/sa/054.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa055xml [
	"Source file: xmltest/not-wf/sa/055.xml"

	(self isSkippableTest: #testnotwfsa055xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa055xml
				documentURI: 'not-wf/sa/055.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa056xml [
	"Source file: xmltest/not-wf/sa/056.xml"

	(self isSkippableTest: #testnotwfsa056xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa056xml
				documentURI: 'not-wf/sa/056.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa057xml [
	"Source file: xmltest/not-wf/sa/057.xml"

	(self isSkippableTest: #testnotwfsa057xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa057xml
				documentURI: 'not-wf/sa/057.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa058xml [
	"Source file: xmltest/not-wf/sa/058.xml"

	(self isSkippableTest: #testnotwfsa058xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa058xml
				documentURI: 'not-wf/sa/058.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa059xml [
	"Source file: xmltest/not-wf/sa/059.xml"

	(self isSkippableTest: #testnotwfsa059xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa059xml
				documentURI: 'not-wf/sa/059.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa060xml [
	"Source file: xmltest/not-wf/sa/060.xml"

	(self isSkippableTest: #testnotwfsa060xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa060xml
				documentURI: 'not-wf/sa/060.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa061xml [
	"Source file: xmltest/not-wf/sa/061.xml"

	(self isSkippableTest: #testnotwfsa061xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa061xml
				documentURI: 'not-wf/sa/061.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa062xml [
	"Source file: xmltest/not-wf/sa/062.xml"

	(self isSkippableTest: #testnotwfsa062xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa062xml
				documentURI: 'not-wf/sa/062.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa063xml [
	"Source file: xmltest/not-wf/sa/063.xml"

	(self isSkippableTest: #testnotwfsa063xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa063xml
				documentURI: 'not-wf/sa/063.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa064xml [
	"Source file: xmltest/not-wf/sa/064.xml"

	(self isSkippableTest: #testnotwfsa064xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa064xml
				documentURI: 'not-wf/sa/064.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa065xml [
	"Source file: xmltest/not-wf/sa/065.xml"

	(self isSkippableTest: #testnotwfsa065xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa065xml
				documentURI: 'not-wf/sa/065.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa066xml [
	"Source file: xmltest/not-wf/sa/066.xml"

	(self isSkippableTest: #testnotwfsa066xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa066xml
				documentURI: 'not-wf/sa/066.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa067xml [
	"Source file: xmltest/not-wf/sa/067.xml"

	(self isSkippableTest: #testnotwfsa067xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa067xml
				documentURI: 'not-wf/sa/067.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa068xml [
	"Source file: xmltest/not-wf/sa/068.xml"

	(self isSkippableTest: #testnotwfsa068xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa068xml
				documentURI: 'not-wf/sa/068.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa069xml [
	"Source file: xmltest/not-wf/sa/069.xml"

	(self isSkippableTest: #testnotwfsa069xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa069xml
				documentURI: 'not-wf/sa/069.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa070xml [
	"Source file: xmltest/not-wf/sa/070.xml"

	(self isSkippableTest: #testnotwfsa070xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa070xml
				documentURI: 'not-wf/sa/070.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa071xml [
	"Source file: xmltest/not-wf/sa/071.xml"

	(self isSkippableTest: #testnotwfsa071xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa071xml
				documentURI: 'not-wf/sa/071.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa072xml [
	"Source file: xmltest/not-wf/sa/072.xml"

	(self isSkippableTest: #testnotwfsa072xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa072xml
				documentURI: 'not-wf/sa/072.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa073xml [
	"Source file: xmltest/not-wf/sa/073.xml"

	(self isSkippableTest: #testnotwfsa073xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa073xml
				documentURI: 'not-wf/sa/073.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa074xml [
	"Source file: xmltest/not-wf/sa/074.xml"

	(self isSkippableTest: #testnotwfsa074xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa074xml
				documentURI: 'not-wf/sa/074.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa075xml [
	"Source file: xmltest/not-wf/sa/075.xml"

	(self isSkippableTest: #testnotwfsa075xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa075xml
				documentURI: 'not-wf/sa/075.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa076xml [
	"Source file: xmltest/not-wf/sa/076.xml"

	(self isSkippableTest: #testnotwfsa076xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa076xml
				documentURI: 'not-wf/sa/076.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa077xml [
	"Source file: xmltest/not-wf/sa/077.xml"

	(self isSkippableTest: #testnotwfsa077xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa077xml
				documentURI: 'not-wf/sa/077.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa078xml [
	"Source file: xmltest/not-wf/sa/078.xml"

	(self isSkippableTest: #testnotwfsa078xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa078xml
				documentURI: 'not-wf/sa/078.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa079xml [
	"Source file: xmltest/not-wf/sa/079.xml"

	(self isSkippableTest: #testnotwfsa079xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa079xml
				documentURI: 'not-wf/sa/079.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa080xml [
	"Source file: xmltest/not-wf/sa/080.xml"

	(self isSkippableTest: #testnotwfsa080xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa080xml
				documentURI: 'not-wf/sa/080.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa081xml [
	"Source file: xmltest/not-wf/sa/081.xml"

	(self isSkippableTest: #testnotwfsa081xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa081xml
				documentURI: 'not-wf/sa/081.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa082xml [
	"Source file: xmltest/not-wf/sa/082.xml"

	(self isSkippableTest: #testnotwfsa082xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa082xml
				documentURI: 'not-wf/sa/082.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa083xml [
	"Source file: xmltest/not-wf/sa/083.xml"

	(self isSkippableTest: #testnotwfsa083xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa083xml
				documentURI: 'not-wf/sa/083.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa084xml [
	"Source file: xmltest/not-wf/sa/084.xml"

	(self isSkippableTest: #testnotwfsa084xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa084xml
				documentURI: 'not-wf/sa/084.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa085xml [
	"Source file: xmltest/not-wf/sa/085.xml"

	(self isSkippableTest: #testnotwfsa085xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa085xml
				documentURI: 'not-wf/sa/085.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa086xml [
	"Source file: xmltest/not-wf/sa/086.xml"

	(self isSkippableTest: #testnotwfsa086xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa086xml
				documentURI: 'not-wf/sa/086.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa087xml [
	"Source file: xmltest/not-wf/sa/087.xml"

	(self isSkippableTest: #testnotwfsa087xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa087xml
				documentURI: 'not-wf/sa/087.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa088xml [
	"Source file: xmltest/not-wf/sa/088.xml"

	(self isSkippableTest: #testnotwfsa088xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa088xml
				documentURI: 'not-wf/sa/088.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa089xml [
	"Source file: xmltest/not-wf/sa/089.xml"

	(self isSkippableTest: #testnotwfsa089xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa089xml
				documentURI: 'not-wf/sa/089.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa090xml [
	"Source file: xmltest/not-wf/sa/090.xml"

	(self isSkippableTest: #testnotwfsa090xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa090xml
				documentURI: 'not-wf/sa/090.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa091xml [
	"Source file: xmltest/not-wf/sa/091.xml"

	(self isSkippableTest: #testnotwfsa091xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa091xml
				documentURI: 'not-wf/sa/091.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa092xml [
	"Source file: xmltest/not-wf/sa/092.xml"

	(self isSkippableTest: #testnotwfsa092xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa092xml
				documentURI: 'not-wf/sa/092.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa093xml [
	"Source file: xmltest/not-wf/sa/093.xml"

	(self isSkippableTest: #testnotwfsa093xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa093xml
				documentURI: 'not-wf/sa/093.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa094xml [
	"Source file: xmltest/not-wf/sa/094.xml"

	(self isSkippableTest: #testnotwfsa094xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa094xml
				documentURI: 'not-wf/sa/094.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa095xml [
	"Source file: xmltest/not-wf/sa/095.xml"

	(self isSkippableTest: #testnotwfsa095xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa095xml
				documentURI: 'not-wf/sa/095.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa096xml [
	"Source file: xmltest/not-wf/sa/096.xml"

	(self isSkippableTest: #testnotwfsa096xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa096xml
				documentURI: 'not-wf/sa/096.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa097xml [
	"Source file: xmltest/not-wf/sa/097.xml"

	(self isSkippableTest: #testnotwfsa097xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa097xml
				documentURI: 'not-wf/sa/097.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa098xml [
	"Source file: xmltest/not-wf/sa/098.xml"

	(self isSkippableTest: #testnotwfsa098xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa098xml
				documentURI: 'not-wf/sa/098.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa099xml [
	"Source file: xmltest/not-wf/sa/099.xml"

	(self isSkippableTest: #testnotwfsa099xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa099xml
				documentURI: 'not-wf/sa/099.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa100xml [
	"Source file: xmltest/not-wf/sa/100.xml"

	(self isSkippableTest: #testnotwfsa100xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa100xml
				documentURI: 'not-wf/sa/100.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa101xml [
	"Source file: xmltest/not-wf/sa/101.xml"

	(self isSkippableTest: #testnotwfsa101xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa101xml
				documentURI: 'not-wf/sa/101.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa102xml [
	"Source file: xmltest/not-wf/sa/102.xml"

	(self isSkippableTest: #testnotwfsa102xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa102xml
				documentURI: 'not-wf/sa/102.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa103xml [
	"Source file: xmltest/not-wf/sa/103.xml"

	(self isSkippableTest: #testnotwfsa103xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa103xml
				documentURI: 'not-wf/sa/103.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa104xml [
	"Source file: xmltest/not-wf/sa/104.xml"

	(self isSkippableTest: #testnotwfsa104xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa104xml
				documentURI: 'not-wf/sa/104.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa105xml [
	"Source file: xmltest/not-wf/sa/105.xml"

	(self isSkippableTest: #testnotwfsa105xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa105xml
				documentURI: 'not-wf/sa/105.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa106xml [
	"Source file: xmltest/not-wf/sa/106.xml"

	(self isSkippableTest: #testnotwfsa106xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa106xml
				documentURI: 'not-wf/sa/106.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa107xml [
	"Source file: xmltest/not-wf/sa/107.xml"

	(self isSkippableTest: #testnotwfsa107xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa107xml
				documentURI: 'not-wf/sa/107.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa108xml [
	"Source file: xmltest/not-wf/sa/108.xml"

	(self isSkippableTest: #testnotwfsa108xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa108xml
				documentURI: 'not-wf/sa/108.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa109xml [
	"Source file: xmltest/not-wf/sa/109.xml"

	(self isSkippableTest: #testnotwfsa109xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa109xml
				documentURI: 'not-wf/sa/109.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa110xml [
	"Source file: xmltest/not-wf/sa/110.xml"

	(self isSkippableTest: #testnotwfsa110xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa110xml
				documentURI: 'not-wf/sa/110.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa111xml [
	"Source file: xmltest/not-wf/sa/111.xml"

	(self isSkippableTest: #testnotwfsa111xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa111xml
				documentURI: 'not-wf/sa/111.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa112xml [
	"Source file: xmltest/not-wf/sa/112.xml"

	(self isSkippableTest: #testnotwfsa112xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa112xml
				documentURI: 'not-wf/sa/112.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa113xml [
	"Source file: xmltest/not-wf/sa/113.xml"

	(self isSkippableTest: #testnotwfsa113xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa113xml
				documentURI: 'not-wf/sa/113.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa114xml [
	"Source file: xmltest/not-wf/sa/114.xml"

	(self isSkippableTest: #testnotwfsa114xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa114xml
				documentURI: 'not-wf/sa/114.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa115xml [
	"Source file: xmltest/not-wf/sa/115.xml"

	(self isSkippableTest: #testnotwfsa115xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa115xml
				documentURI: 'not-wf/sa/115.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa116xml [
	"Source file: xmltest/not-wf/sa/116.xml"

	(self isSkippableTest: #testnotwfsa116xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa116xml
				documentURI: 'not-wf/sa/116.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa117xml [
	"Source file: xmltest/not-wf/sa/117.xml"

	(self isSkippableTest: #testnotwfsa117xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa117xml
				documentURI: 'not-wf/sa/117.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa118xml [
	"Source file: xmltest/not-wf/sa/118.xml"

	(self isSkippableTest: #testnotwfsa118xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa118xml
				documentURI: 'not-wf/sa/118.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa119xml [
	"Source file: xmltest/not-wf/sa/119.xml"

	(self isSkippableTest: #testnotwfsa119xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa119xml
				documentURI: 'not-wf/sa/119.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa120xml [
	"Source file: xmltest/not-wf/sa/120.xml"

	(self isSkippableTest: #testnotwfsa120xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa120xml
				documentURI: 'not-wf/sa/120.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa121xml [
	"Source file: xmltest/not-wf/sa/121.xml"

	(self isSkippableTest: #testnotwfsa121xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa121xml
				documentURI: 'not-wf/sa/121.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa122xml [
	"Source file: xmltest/not-wf/sa/122.xml"

	(self isSkippableTest: #testnotwfsa122xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa122xml
				documentURI: 'not-wf/sa/122.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa123xml [
	"Source file: xmltest/not-wf/sa/123.xml"

	(self isSkippableTest: #testnotwfsa123xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa123xml
				documentURI: 'not-wf/sa/123.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa124xml [
	"Source file: xmltest/not-wf/sa/124.xml"

	(self isSkippableTest: #testnotwfsa124xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa124xml
				documentURI: 'not-wf/sa/124.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa125xml [
	"Source file: xmltest/not-wf/sa/125.xml"

	(self isSkippableTest: #testnotwfsa125xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa125xml
				documentURI: 'not-wf/sa/125.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa126xml [
	"Source file: xmltest/not-wf/sa/126.xml"

	(self isSkippableTest: #testnotwfsa126xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa126xml
				documentURI: 'not-wf/sa/126.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa127xml [
	"Source file: xmltest/not-wf/sa/127.xml"

	(self isSkippableTest: #testnotwfsa127xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa127xml
				documentURI: 'not-wf/sa/127.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa128xml [
	"Source file: xmltest/not-wf/sa/128.xml"

	(self isSkippableTest: #testnotwfsa128xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa128xml
				documentURI: 'not-wf/sa/128.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa129xml [
	"Source file: xmltest/not-wf/sa/129.xml"

	(self isSkippableTest: #testnotwfsa129xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa129xml
				documentURI: 'not-wf/sa/129.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa130xml [
	"Source file: xmltest/not-wf/sa/130.xml"

	(self isSkippableTest: #testnotwfsa130xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa130xml
				documentURI: 'not-wf/sa/130.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa131xml [
	"Source file: xmltest/not-wf/sa/131.xml"

	(self isSkippableTest: #testnotwfsa131xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa131xml
				documentURI: 'not-wf/sa/131.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa132xml [
	"Source file: xmltest/not-wf/sa/132.xml"

	(self isSkippableTest: #testnotwfsa132xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa132xml
				documentURI: 'not-wf/sa/132.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa133xml [
	"Source file: xmltest/not-wf/sa/133.xml"

	(self isSkippableTest: #testnotwfsa133xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa133xml
				documentURI: 'not-wf/sa/133.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa134xml [
	"Source file: xmltest/not-wf/sa/134.xml"

	(self isSkippableTest: #testnotwfsa134xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa134xml
				documentURI: 'not-wf/sa/134.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa135xml [
	"Source file: xmltest/not-wf/sa/135.xml"

	(self isSkippableTest: #testnotwfsa135xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa135xml
				documentURI: 'not-wf/sa/135.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa136xml [
	"Source file: xmltest/not-wf/sa/136.xml"

	(self isSkippableTest: #testnotwfsa136xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa136xml
				documentURI: 'not-wf/sa/136.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa137xml [
	"Source file: xmltest/not-wf/sa/137.xml"

	(self isSkippableTest: #testnotwfsa137xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa137xml
				documentURI: 'not-wf/sa/137.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa138xml [
	"Source file: xmltest/not-wf/sa/138.xml"

	(self isSkippableTest: #testnotwfsa138xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa138xml
				documentURI: 'not-wf/sa/138.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa139xml [
	"Source file: xmltest/not-wf/sa/139.xml"

	(self isSkippableTest: #testnotwfsa139xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa139xml
				documentURI: 'not-wf/sa/139.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa140xml [
	"Source file: xmltest/not-wf/sa/140.xml"

	(self isSkippableTest: #testnotwfsa140xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa140xml
				documentURI: 'not-wf/sa/140.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa141xml [
	"Source file: xmltest/not-wf/sa/141.xml"

	(self isSkippableTest: #testnotwfsa141xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa141xml
				documentURI: 'not-wf/sa/141.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa142xml [
	"Source file: xmltest/not-wf/sa/142.xml"

	(self isSkippableTest: #testnotwfsa142xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa142xml
				documentURI: 'not-wf/sa/142.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa143xml [
	"Source file: xmltest/not-wf/sa/143.xml"

	(self isSkippableTest: #testnotwfsa143xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa143xml
				documentURI: 'not-wf/sa/143.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa144xml [
	"Source file: xmltest/not-wf/sa/144.xml"

	(self isSkippableTest: #testnotwfsa144xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa144xml
				documentURI: 'not-wf/sa/144.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa145xml [
	"Source file: xmltest/not-wf/sa/145.xml"

	(self isSkippableTest: #testnotwfsa145xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa145xml
				documentURI: 'not-wf/sa/145.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa146xml [
	"Source file: xmltest/not-wf/sa/146.xml"

	(self isSkippableTest: #testnotwfsa146xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa146xml
				documentURI: 'not-wf/sa/146.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa147xml [
	"Source file: xmltest/not-wf/sa/147.xml"

	(self isSkippableTest: #testnotwfsa147xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa147xml
				documentURI: 'not-wf/sa/147.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa148xml [
	"Source file: xmltest/not-wf/sa/148.xml"

	(self isSkippableTest: #testnotwfsa148xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa148xml
				documentURI: 'not-wf/sa/148.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa149xml [
	"Source file: xmltest/not-wf/sa/149.xml"

	(self isSkippableTest: #testnotwfsa149xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa149xml
				documentURI: 'not-wf/sa/149.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa150xml [
	"Source file: xmltest/not-wf/sa/150.xml"

	(self isSkippableTest: #testnotwfsa150xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa150xml
				documentURI: 'not-wf/sa/150.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa151xml [
	"Source file: xmltest/not-wf/sa/151.xml"

	(self isSkippableTest: #testnotwfsa151xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa151xml
				documentURI: 'not-wf/sa/151.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa152xml [
	"Source file: xmltest/not-wf/sa/152.xml"

	(self isSkippableTest: #testnotwfsa152xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa152xml
				documentURI: 'not-wf/sa/152.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa153xml [
	"Source file: xmltest/not-wf/sa/153.xml"

	(self isSkippableTest: #testnotwfsa153xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa153xml
				documentURI: 'not-wf/sa/153.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa154xml [
	"Source file: xmltest/not-wf/sa/154.xml"

	(self isSkippableTest: #testnotwfsa154xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa154xml
				documentURI: 'not-wf/sa/154.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa155xml [
	"Source file: xmltest/not-wf/sa/155.xml"

	(self isSkippableTest: #testnotwfsa155xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa155xml
				documentURI: 'not-wf/sa/155.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa156xml [
	"Source file: xmltest/not-wf/sa/156.xml"

	(self isSkippableTest: #testnotwfsa156xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa156xml
				documentURI: 'not-wf/sa/156.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa157xml [
	"Source file: xmltest/not-wf/sa/157.xml"

	(self isSkippableTest: #testnotwfsa157xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa157xml
				documentURI: 'not-wf/sa/157.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa158xml [
	"Source file: xmltest/not-wf/sa/158.xml"

	(self isSkippableTest: #testnotwfsa158xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa158xml
				documentURI: 'not-wf/sa/158.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa159xml [
	"Source file: xmltest/not-wf/sa/159.xml"

	(self isSkippableTest: #testnotwfsa159xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa159xml
				documentURI: 'not-wf/sa/159.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa160xml [
	"Source file: xmltest/not-wf/sa/160.xml"

	(self isSkippableTest: #testnotwfsa160xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa160xml
				documentURI: 'not-wf/sa/160.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa161xml [
	"Source file: xmltest/not-wf/sa/161.xml"

	(self isSkippableTest: #testnotwfsa161xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa161xml
				documentURI: 'not-wf/sa/161.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa162xml [
	"Source file: xmltest/not-wf/sa/162.xml"

	(self isSkippableTest: #testnotwfsa162xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa162xml
				documentURI: 'not-wf/sa/162.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa163xml [
	"Source file: xmltest/not-wf/sa/163.xml"

	(self isSkippableTest: #testnotwfsa163xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa163xml
				documentURI: 'not-wf/sa/163.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa164xml [
	"Source file: xmltest/not-wf/sa/164.xml"

	(self isSkippableTest: #testnotwfsa164xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa164xml
				documentURI: 'not-wf/sa/164.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa165xml [
	"Source file: xmltest/not-wf/sa/165.xml"

	(self isSkippableTest: #testnotwfsa165xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa165xml
				documentURI: 'not-wf/sa/165.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa166xml [
	"Source file: xmltest/not-wf/sa/166.xml"

	(self isSkippableTest: #testnotwfsa166xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa166xml
				documentURI: 'not-wf/sa/166.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa167xml [
	"Source file: xmltest/not-wf/sa/167.xml"

	(self isSkippableTest: #testnotwfsa167xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa167xml
				documentURI: 'not-wf/sa/167.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa168xml [
	"Source file: xmltest/not-wf/sa/168.xml"

	(self isSkippableTest: #testnotwfsa168xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa168xml
				documentURI: 'not-wf/sa/168.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa169xml [
	"Source file: xmltest/not-wf/sa/169.xml"

	(self isSkippableTest: #testnotwfsa169xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa169xml
				documentURI: 'not-wf/sa/169.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa171xml [
	"Source file: xmltest/not-wf/sa/171.xml"

	(self isSkippableTest: #testnotwfsa171xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa171xml
				documentURI: 'not-wf/sa/171.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa172xml [
	"Source file: xmltest/not-wf/sa/172.xml"

	(self isSkippableTest: #testnotwfsa172xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa172xml
				documentURI: 'not-wf/sa/172.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa173xml [
	"Source file: xmltest/not-wf/sa/173.xml"

	(self isSkippableTest: #testnotwfsa173xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa173xml
				documentURI: 'not-wf/sa/173.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa174xml [
	"Source file: xmltest/not-wf/sa/174.xml"

	(self isSkippableTest: #testnotwfsa174xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa174xml
				documentURI: 'not-wf/sa/174.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa175xml [
	"Source file: xmltest/not-wf/sa/175.xml"

	(self isSkippableTest: #testnotwfsa175xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa175xml
				documentURI: 'not-wf/sa/175.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa176xml [
	"Source file: xmltest/not-wf/sa/176.xml"

	(self isSkippableTest: #testnotwfsa176xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa176xml
				documentURI: 'not-wf/sa/176.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa177xml [
	"Source file: xmltest/not-wf/sa/177.xml"

	(self isSkippableTest: #testnotwfsa177xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa177xml
				documentURI: 'not-wf/sa/177.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa178xml [
	"Source file: xmltest/not-wf/sa/178.xml"

	(self isSkippableTest: #testnotwfsa178xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa178xml
				documentURI: 'not-wf/sa/178.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa179xml [
	"Source file: xmltest/not-wf/sa/179.xml"

	(self isSkippableTest: #testnotwfsa179xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa179xml
				documentURI: 'not-wf/sa/179.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa180xml [
	"Source file: xmltest/not-wf/sa/180.xml"

	(self isSkippableTest: #testnotwfsa180xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa180xml
				documentURI: 'not-wf/sa/180.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa181xml [
	"Source file: xmltest/not-wf/sa/181.xml"

	(self isSkippableTest: #testnotwfsa181xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa181xml
				documentURI: 'not-wf/sa/181.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa182xml [
	"Source file: xmltest/not-wf/sa/182.xml"

	(self isSkippableTest: #testnotwfsa182xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa182xml
				documentURI: 'not-wf/sa/182.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa183xml [
	"Source file: xmltest/not-wf/sa/183.xml"

	(self isSkippableTest: #testnotwfsa183xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa183xml
				documentURI: 'not-wf/sa/183.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa184xml [
	"Source file: xmltest/not-wf/sa/184.xml"

	(self isSkippableTest: #testnotwfsa184xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa184xml
				documentURI: 'not-wf/sa/184.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa185xml [
	"Source file: xmltest/not-wf/sa/185.xml"

	(self isSkippableTest: #testnotwfsa185xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa185xml
				documentURI: 'not-wf/sa/185.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceExpatTests >> testnotwfsa186xml [
	"Source file: xmltest/not-wf/sa/186.xml"

	(self isSkippableTest: #testnotwfsa186xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcenotwfsa186xml
				documentURI: 'not-wf/sa/186.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa001xml [
	"Source file: xmltest/valid/ext-sa/001.xml"

	(self isSkippableTest: #testvalidextsa001xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa001xml
				documentURI: 'valid/ext-sa/001.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa002xml [
	"Source file: xmltest/valid/ext-sa/002.xml"

	(self isSkippableTest: #testvalidextsa002xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa002xml
				documentURI: 'valid/ext-sa/002.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa003xml [
	"Source file: xmltest/valid/ext-sa/003.xml"

	(self isSkippableTest: #testvalidextsa003xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa003xml
				documentURI: 'valid/ext-sa/003.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa004xml [
	"Source file: xmltest/valid/ext-sa/004.xml"

	(self isSkippableTest: #testvalidextsa004xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa004xml
				documentURI: 'valid/ext-sa/004.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa005xml [
	"Source file: xmltest/valid/ext-sa/005.xml"

	(self isSkippableTest: #testvalidextsa005xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa005xml
				documentURI: 'valid/ext-sa/005.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa006xml [
	"Source file: xmltest/valid/ext-sa/006.xml"

	(self isSkippableTest: #testvalidextsa006xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa006xml
				documentURI: 'valid/ext-sa/006.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa007xml [
	"Source file: xmltest/valid/ext-sa/007.xml"

	(self isSkippableTest: #testvalidextsa007xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa007xml
				documentURI: 'valid/ext-sa/007.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa008xml [
	"Source file: xmltest/valid/ext-sa/008.xml"

	(self isSkippableTest: #testvalidextsa008xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa008xml
				documentURI: 'valid/ext-sa/008.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa009xml [
	"Source file: xmltest/valid/ext-sa/009.xml"

	(self isSkippableTest: #testvalidextsa009xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa009xml
				documentURI: 'valid/ext-sa/009.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa010xml [
	"Source file: xmltest/valid/ext-sa/010.xml"

	(self isSkippableTest: #testvalidextsa010xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa010xml
				documentURI: 'valid/ext-sa/010.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa011xml [
	"Source file: xmltest/valid/ext-sa/011.xml"

	(self isSkippableTest: #testvalidextsa011xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa011xml
				documentURI: 'valid/ext-sa/011.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa012xml [
	"Source file: xmltest/valid/ext-sa/012.xml"

	(self isSkippableTest: #testvalidextsa012xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa012xml
				documentURI: 'valid/ext-sa/012.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa013xml [
	"Source file: xmltest/valid/ext-sa/013.xml"

	(self isSkippableTest: #testvalidextsa013xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa013xml
				documentURI: 'valid/ext-sa/013.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidextsa014xml [
	"Source file: xmltest/valid/ext-sa/014.xml"

	(self isSkippableTest: #testvalidextsa014xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidextsa014xml
				documentURI: 'valid/ext-sa/014.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa001xml [
	"Source file: xmltest/valid/not-sa/001.xml"

	(self isSkippableTest: #testvalidnotsa001xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa001xml
				documentURI: 'valid/not-sa/001.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa002xml [
	"Source file: xmltest/valid/not-sa/002.xml"

	(self isSkippableTest: #testvalidnotsa002xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa002xml
				documentURI: 'valid/not-sa/002.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa003xml [
	"Source file: xmltest/valid/not-sa/003.xml"

	(self isSkippableTest: #testvalidnotsa003xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa003xml
				documentURI: 'valid/not-sa/003.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa004xml [
	"Source file: xmltest/valid/not-sa/004.xml"

	(self isSkippableTest: #testvalidnotsa004xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa004xml
				documentURI: 'valid/not-sa/004.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa005xml [
	"Source file: xmltest/valid/not-sa/005.xml"

	(self isSkippableTest: #testvalidnotsa005xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa005xml
				documentURI: 'valid/not-sa/005.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa006xml [
	"Source file: xmltest/valid/not-sa/006.xml"

	(self isSkippableTest: #testvalidnotsa006xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa006xml
				documentURI: 'valid/not-sa/006.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa007xml [
	"Source file: xmltest/valid/not-sa/007.xml"

	(self isSkippableTest: #testvalidnotsa007xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa007xml
				documentURI: 'valid/not-sa/007.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa008xml [
	"Source file: xmltest/valid/not-sa/008.xml"

	(self isSkippableTest: #testvalidnotsa008xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa008xml
				documentURI: 'valid/not-sa/008.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa009xml [
	"Source file: xmltest/valid/not-sa/009.xml"

	(self isSkippableTest: #testvalidnotsa009xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa009xml
				documentURI: 'valid/not-sa/009.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa010xml [
	"Source file: xmltest/valid/not-sa/010.xml"

	(self isSkippableTest: #testvalidnotsa010xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa010xml
				documentURI: 'valid/not-sa/010.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa011xml [
	"Source file: xmltest/valid/not-sa/011.xml"

	(self isSkippableTest: #testvalidnotsa011xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa011xml
				documentURI: 'valid/not-sa/011.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa012xml [
	"Source file: xmltest/valid/not-sa/012.xml"

	(self isSkippableTest: #testvalidnotsa012xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa012xml
				documentURI: 'valid/not-sa/012.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa013xml [
	"Source file: xmltest/valid/not-sa/013.xml"

	(self isSkippableTest: #testvalidnotsa013xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa013xml
				documentURI: 'valid/not-sa/013.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa014xml [
	"Source file: xmltest/valid/not-sa/014.xml"

	(self isSkippableTest: #testvalidnotsa014xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa014xml
				documentURI: 'valid/not-sa/014.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa015xml [
	"Source file: xmltest/valid/not-sa/015.xml"

	(self isSkippableTest: #testvalidnotsa015xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa015xml
				documentURI: 'valid/not-sa/015.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa016xml [
	"Source file: xmltest/valid/not-sa/016.xml"

	(self isSkippableTest: #testvalidnotsa016xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa016xml
				documentURI: 'valid/not-sa/016.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa017xml [
	"Source file: xmltest/valid/not-sa/017.xml"

	(self isSkippableTest: #testvalidnotsa017xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa017xml
				documentURI: 'valid/not-sa/017.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa018xml [
	"Source file: xmltest/valid/not-sa/018.xml"

	(self isSkippableTest: #testvalidnotsa018xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa018xml
				documentURI: 'valid/not-sa/018.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa019xml [
	"Source file: xmltest/valid/not-sa/019.xml"

	(self isSkippableTest: #testvalidnotsa019xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa019xml
				documentURI: 'valid/not-sa/019.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa020xml [
	"Source file: xmltest/valid/not-sa/020.xml"

	(self isSkippableTest: #testvalidnotsa020xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa020xml
				documentURI: 'valid/not-sa/020.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa021xml [
	"Source file: xmltest/valid/not-sa/021.xml"

	(self isSkippableTest: #testvalidnotsa021xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa021xml
				documentURI: 'valid/not-sa/021.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa023xml [
	"Source file: xmltest/valid/not-sa/023.xml"

	(self isSkippableTest: #testvalidnotsa023xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa023xml
				documentURI: 'valid/not-sa/023.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa024xml [
	"Source file: xmltest/valid/not-sa/024.xml"

	(self isSkippableTest: #testvalidnotsa024xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa024xml
				documentURI: 'valid/not-sa/024.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa025xml [
	"Source file: xmltest/valid/not-sa/025.xml"

	(self isSkippableTest: #testvalidnotsa025xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa025xml
				documentURI: 'valid/not-sa/025.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa026xml [
	"Source file: xmltest/valid/not-sa/026.xml"

	(self isSkippableTest: #testvalidnotsa026xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa026xml
				documentURI: 'valid/not-sa/026.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa027xml [
	"Source file: xmltest/valid/not-sa/027.xml"

	(self isSkippableTest: #testvalidnotsa027xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa027xml
				documentURI: 'valid/not-sa/027.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa028xml [
	"Source file: xmltest/valid/not-sa/028.xml"

	(self isSkippableTest: #testvalidnotsa028xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa028xml
				documentURI: 'valid/not-sa/028.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa029xml [
	"Source file: xmltest/valid/not-sa/029.xml"

	(self isSkippableTest: #testvalidnotsa029xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa029xml
				documentURI: 'valid/not-sa/029.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa030xml [
	"Source file: xmltest/valid/not-sa/030.xml"

	(self isSkippableTest: #testvalidnotsa030xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa030xml
				documentURI: 'valid/not-sa/030.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidnotsa031xml [
	"Source file: xmltest/valid/not-sa/031.xml"

	(self isSkippableTest: #testvalidnotsa031xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidnotsa031xml
				documentURI: 'valid/not-sa/031.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa001xml [
	"Source file: xmltest/valid/sa/001.xml"

	(self isSkippableTest: #testvalidsa001xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa001xml
				documentURI: 'valid/sa/001.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa002xml [
	"Source file: xmltest/valid/sa/002.xml"

	(self isSkippableTest: #testvalidsa002xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa002xml
				documentURI: 'valid/sa/002.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa003xml [
	"Source file: xmltest/valid/sa/003.xml"

	(self isSkippableTest: #testvalidsa003xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa003xml
				documentURI: 'valid/sa/003.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa004xml [
	"Source file: xmltest/valid/sa/004.xml"

	(self isSkippableTest: #testvalidsa004xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa004xml
				documentURI: 'valid/sa/004.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa005xml [
	"Source file: xmltest/valid/sa/005.xml"

	(self isSkippableTest: #testvalidsa005xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa005xml
				documentURI: 'valid/sa/005.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa006xml [
	"Source file: xmltest/valid/sa/006.xml"

	(self isSkippableTest: #testvalidsa006xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa006xml
				documentURI: 'valid/sa/006.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa007xml [
	"Source file: xmltest/valid/sa/007.xml"

	(self isSkippableTest: #testvalidsa007xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa007xml
				documentURI: 'valid/sa/007.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa008xml [
	"Source file: xmltest/valid/sa/008.xml"

	(self isSkippableTest: #testvalidsa008xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa008xml
				documentURI: 'valid/sa/008.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa009xml [
	"Source file: xmltest/valid/sa/009.xml"

	(self isSkippableTest: #testvalidsa009xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa009xml
				documentURI: 'valid/sa/009.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa010xml [
	"Source file: xmltest/valid/sa/010.xml"

	(self isSkippableTest: #testvalidsa010xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa010xml
				documentURI: 'valid/sa/010.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa011xml [
	"Source file: xmltest/valid/sa/011.xml"

	(self isSkippableTest: #testvalidsa011xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa011xml
				documentURI: 'valid/sa/011.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa012xml [
	"Source file: xmltest/valid/sa/012.xml"

	(self isSkippableTest: #testvalidsa012xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa012xml
				documentURI: 'valid/sa/012.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa013xml [
	"Source file: xmltest/valid/sa/013.xml"

	(self isSkippableTest: #testvalidsa013xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa013xml
				documentURI: 'valid/sa/013.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa014xml [
	"Source file: xmltest/valid/sa/014.xml"

	(self isSkippableTest: #testvalidsa014xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa014xml
				documentURI: 'valid/sa/014.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa015xml [
	"Source file: xmltest/valid/sa/015.xml"

	(self isSkippableTest: #testvalidsa015xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa015xml
				documentURI: 'valid/sa/015.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa016xml [
	"Source file: xmltest/valid/sa/016.xml"

	(self isSkippableTest: #testvalidsa016xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa016xml
				documentURI: 'valid/sa/016.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa017axml [
	"Source file: xmltest/valid/sa/017a.xml"

	(self isSkippableTest: #testvalidsa017axml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa017axml
				documentURI: 'valid/sa/017a.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa017xml [
	"Source file: xmltest/valid/sa/017.xml"

	(self isSkippableTest: #testvalidsa017xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa017xml
				documentURI: 'valid/sa/017.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa018xml [
	"Source file: xmltest/valid/sa/018.xml"

	(self isSkippableTest: #testvalidsa018xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa018xml
				documentURI: 'valid/sa/018.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa019xml [
	"Source file: xmltest/valid/sa/019.xml"

	(self isSkippableTest: #testvalidsa019xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa019xml
				documentURI: 'valid/sa/019.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa020xml [
	"Source file: xmltest/valid/sa/020.xml"

	(self isSkippableTest: #testvalidsa020xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa020xml
				documentURI: 'valid/sa/020.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa021xml [
	"Source file: xmltest/valid/sa/021.xml"

	(self isSkippableTest: #testvalidsa021xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa021xml
				documentURI: 'valid/sa/021.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa022xml [
	"Source file: xmltest/valid/sa/022.xml"

	(self isSkippableTest: #testvalidsa022xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa022xml
				documentURI: 'valid/sa/022.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa023xml [
	"Source file: xmltest/valid/sa/023.xml"

	(self isSkippableTest: #testvalidsa023xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa023xml
				documentURI: 'valid/sa/023.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa024xml [
	"Source file: xmltest/valid/sa/024.xml"

	(self isSkippableTest: #testvalidsa024xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa024xml
				documentURI: 'valid/sa/024.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa025xml [
	"Source file: xmltest/valid/sa/025.xml"

	(self isSkippableTest: #testvalidsa025xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa025xml
				documentURI: 'valid/sa/025.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa026xml [
	"Source file: xmltest/valid/sa/026.xml"

	(self isSkippableTest: #testvalidsa026xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa026xml
				documentURI: 'valid/sa/026.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa027xml [
	"Source file: xmltest/valid/sa/027.xml"

	(self isSkippableTest: #testvalidsa027xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa027xml
				documentURI: 'valid/sa/027.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa028xml [
	"Source file: xmltest/valid/sa/028.xml"

	(self isSkippableTest: #testvalidsa028xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa028xml
				documentURI: 'valid/sa/028.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa029xml [
	"Source file: xmltest/valid/sa/029.xml"

	(self isSkippableTest: #testvalidsa029xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa029xml
				documentURI: 'valid/sa/029.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa030xml [
	"Source file: xmltest/valid/sa/030.xml"

	(self isSkippableTest: #testvalidsa030xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa030xml
				documentURI: 'valid/sa/030.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa031xml [
	"Source file: xmltest/valid/sa/031.xml"

	(self isSkippableTest: #testvalidsa031xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa031xml
				documentURI: 'valid/sa/031.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa032xml [
	"Source file: xmltest/valid/sa/032.xml"

	(self isSkippableTest: #testvalidsa032xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa032xml
				documentURI: 'valid/sa/032.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa033xml [
	"Source file: xmltest/valid/sa/033.xml"

	(self isSkippableTest: #testvalidsa033xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa033xml
				documentURI: 'valid/sa/033.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa034xml [
	"Source file: xmltest/valid/sa/034.xml"

	(self isSkippableTest: #testvalidsa034xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa034xml
				documentURI: 'valid/sa/034.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa035xml [
	"Source file: xmltest/valid/sa/035.xml"

	(self isSkippableTest: #testvalidsa035xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa035xml
				documentURI: 'valid/sa/035.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa036xml [
	"Source file: xmltest/valid/sa/036.xml"

	(self isSkippableTest: #testvalidsa036xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa036xml
				documentURI: 'valid/sa/036.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa037xml [
	"Source file: xmltest/valid/sa/037.xml"

	(self isSkippableTest: #testvalidsa037xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa037xml
				documentURI: 'valid/sa/037.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa038xml [
	"Source file: xmltest/valid/sa/038.xml"

	(self isSkippableTest: #testvalidsa038xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa038xml
				documentURI: 'valid/sa/038.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa039xml [
	"Source file: xmltest/valid/sa/039.xml"

	(self isSkippableTest: #testvalidsa039xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa039xml
				documentURI: 'valid/sa/039.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa040xml [
	"Source file: xmltest/valid/sa/040.xml"

	(self isSkippableTest: #testvalidsa040xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa040xml
				documentURI: 'valid/sa/040.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa041xml [
	"Source file: xmltest/valid/sa/041.xml"

	(self isSkippableTest: #testvalidsa041xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa041xml
				documentURI: 'valid/sa/041.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa042xml [
	"Source file: xmltest/valid/sa/042.xml"

	(self isSkippableTest: #testvalidsa042xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa042xml
				documentURI: 'valid/sa/042.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa043xml [
	"Source file: xmltest/valid/sa/043.xml"

	(self isSkippableTest: #testvalidsa043xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa043xml
				documentURI: 'valid/sa/043.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa044xml [
	"Source file: xmltest/valid/sa/044.xml"

	(self isSkippableTest: #testvalidsa044xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa044xml
				documentURI: 'valid/sa/044.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa045xml [
	"Source file: xmltest/valid/sa/045.xml"

	(self isSkippableTest: #testvalidsa045xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa045xml
				documentURI: 'valid/sa/045.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa046xml [
	"Source file: xmltest/valid/sa/046.xml"

	(self isSkippableTest: #testvalidsa046xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa046xml
				documentURI: 'valid/sa/046.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa047xml [
	"Source file: xmltest/valid/sa/047.xml"

	(self isSkippableTest: #testvalidsa047xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa047xml
				documentURI: 'valid/sa/047.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa048xml [
	"Source file: xmltest/valid/sa/048.xml"

	(self isSkippableTest: #testvalidsa048xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa048xml
				documentURI: 'valid/sa/048.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa052xml [
	"Source file: xmltest/valid/sa/052.xml"

	(self isSkippableTest: #testvalidsa052xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa052xml
				documentURI: 'valid/sa/052.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa053xml [
	"Source file: xmltest/valid/sa/053.xml"

	(self isSkippableTest: #testvalidsa053xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa053xml
				documentURI: 'valid/sa/053.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa054xml [
	"Source file: xmltest/valid/sa/054.xml"

	(self isSkippableTest: #testvalidsa054xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa054xml
				documentURI: 'valid/sa/054.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa055xml [
	"Source file: xmltest/valid/sa/055.xml"

	(self isSkippableTest: #testvalidsa055xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa055xml
				documentURI: 'valid/sa/055.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa056xml [
	"Source file: xmltest/valid/sa/056.xml"

	(self isSkippableTest: #testvalidsa056xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa056xml
				documentURI: 'valid/sa/056.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa057xml [
	"Source file: xmltest/valid/sa/057.xml"

	(self isSkippableTest: #testvalidsa057xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa057xml
				documentURI: 'valid/sa/057.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa058xml [
	"Source file: xmltest/valid/sa/058.xml"

	(self isSkippableTest: #testvalidsa058xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa058xml
				documentURI: 'valid/sa/058.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa059xml [
	"Source file: xmltest/valid/sa/059.xml"

	(self isSkippableTest: #testvalidsa059xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa059xml
				documentURI: 'valid/sa/059.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa060xml [
	"Source file: xmltest/valid/sa/060.xml"

	(self isSkippableTest: #testvalidsa060xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa060xml
				documentURI: 'valid/sa/060.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa061xml [
	"Source file: xmltest/valid/sa/061.xml"

	(self isSkippableTest: #testvalidsa061xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa061xml
				documentURI: 'valid/sa/061.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa062xml [
	"Source file: xmltest/valid/sa/062.xml"

	(self isSkippableTest: #testvalidsa062xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa062xml
				documentURI: 'valid/sa/062.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa063xml [
	"Source file: xmltest/valid/sa/063.xml"

	(self isSkippableTest: #testvalidsa063xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa063xml
				documentURI: 'valid/sa/063.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa064xml [
	"Source file: xmltest/valid/sa/064.xml"

	(self isSkippableTest: #testvalidsa064xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa064xml
				documentURI: 'valid/sa/064.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa065xml [
	"Source file: xmltest/valid/sa/065.xml"

	(self isSkippableTest: #testvalidsa065xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa065xml
				documentURI: 'valid/sa/065.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa066xml [
	"Source file: xmltest/valid/sa/066.xml"

	(self isSkippableTest: #testvalidsa066xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa066xml
				documentURI: 'valid/sa/066.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa067xml [
	"Source file: xmltest/valid/sa/067.xml"

	(self isSkippableTest: #testvalidsa067xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa067xml
				documentURI: 'valid/sa/067.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa068xml [
	"Source file: xmltest/valid/sa/068.xml"

	(self isSkippableTest: #testvalidsa068xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa068xml
				documentURI: 'valid/sa/068.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa069xml [
	"Source file: xmltest/valid/sa/069.xml"

	(self isSkippableTest: #testvalidsa069xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa069xml
				documentURI: 'valid/sa/069.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa070xml [
	"Source file: xmltest/valid/sa/070.xml"

	(self isSkippableTest: #testvalidsa070xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa070xml
				documentURI: 'valid/sa/070.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa071xml [
	"Source file: xmltest/valid/sa/071.xml"

	(self isSkippableTest: #testvalidsa071xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa071xml
				documentURI: 'valid/sa/071.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa072xml [
	"Source file: xmltest/valid/sa/072.xml"

	(self isSkippableTest: #testvalidsa072xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa072xml
				documentURI: 'valid/sa/072.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa073xml [
	"Source file: xmltest/valid/sa/073.xml"

	(self isSkippableTest: #testvalidsa073xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa073xml
				documentURI: 'valid/sa/073.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa074xml [
	"Source file: xmltest/valid/sa/074.xml"

	(self isSkippableTest: #testvalidsa074xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa074xml
				documentURI: 'valid/sa/074.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa075xml [
	"Source file: xmltest/valid/sa/075.xml"

	(self isSkippableTest: #testvalidsa075xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa075xml
				documentURI: 'valid/sa/075.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa076xml [
	"Source file: xmltest/valid/sa/076.xml"

	(self isSkippableTest: #testvalidsa076xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa076xml
				documentURI: 'valid/sa/076.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa077xml [
	"Source file: xmltest/valid/sa/077.xml"

	(self isSkippableTest: #testvalidsa077xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa077xml
				documentURI: 'valid/sa/077.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa078xml [
	"Source file: xmltest/valid/sa/078.xml"

	(self isSkippableTest: #testvalidsa078xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa078xml
				documentURI: 'valid/sa/078.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa079xml [
	"Source file: xmltest/valid/sa/079.xml"

	(self isSkippableTest: #testvalidsa079xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa079xml
				documentURI: 'valid/sa/079.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa080xml [
	"Source file: xmltest/valid/sa/080.xml"

	(self isSkippableTest: #testvalidsa080xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa080xml
				documentURI: 'valid/sa/080.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa081xml [
	"Source file: xmltest/valid/sa/081.xml"

	(self isSkippableTest: #testvalidsa081xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa081xml
				documentURI: 'valid/sa/081.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa082xml [
	"Source file: xmltest/valid/sa/082.xml"

	(self isSkippableTest: #testvalidsa082xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa082xml
				documentURI: 'valid/sa/082.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa083xml [
	"Source file: xmltest/valid/sa/083.xml"

	(self isSkippableTest: #testvalidsa083xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa083xml
				documentURI: 'valid/sa/083.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa084xml [
	"Source file: xmltest/valid/sa/084.xml"

	(self isSkippableTest: #testvalidsa084xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa084xml
				documentURI: 'valid/sa/084.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa085xml [
	"Source file: xmltest/valid/sa/085.xml"

	(self isSkippableTest: #testvalidsa085xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa085xml
				documentURI: 'valid/sa/085.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa086xml [
	"Source file: xmltest/valid/sa/086.xml"

	(self isSkippableTest: #testvalidsa086xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa086xml
				documentURI: 'valid/sa/086.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa087xml [
	"Source file: xmltest/valid/sa/087.xml"

	(self isSkippableTest: #testvalidsa087xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa087xml
				documentURI: 'valid/sa/087.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa088xml [
	"Source file: xmltest/valid/sa/088.xml"

	(self isSkippableTest: #testvalidsa088xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa088xml
				documentURI: 'valid/sa/088.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa089xml [
	"Source file: xmltest/valid/sa/089.xml"

	(self isSkippableTest: #testvalidsa089xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa089xml
				documentURI: 'valid/sa/089.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa090xml [
	"Source file: xmltest/valid/sa/090.xml"

	(self isSkippableTest: #testvalidsa090xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa090xml
				documentURI: 'valid/sa/090.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa091xml [
	"Source file: xmltest/valid/sa/091.xml"

	(self isSkippableTest: #testvalidsa091xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa091xml
				documentURI: 'valid/sa/091.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa092xml [
	"Source file: xmltest/valid/sa/092.xml"

	(self isSkippableTest: #testvalidsa092xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa092xml
				documentURI: 'valid/sa/092.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa093xml [
	"Source file: xmltest/valid/sa/093.xml"

	(self isSkippableTest: #testvalidsa093xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa093xml
				documentURI: 'valid/sa/093.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa094xml [
	"Source file: xmltest/valid/sa/094.xml"

	(self isSkippableTest: #testvalidsa094xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa094xml
				documentURI: 'valid/sa/094.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa095xml [
	"Source file: xmltest/valid/sa/095.xml"

	(self isSkippableTest: #testvalidsa095xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa095xml
				documentURI: 'valid/sa/095.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa096xml [
	"Source file: xmltest/valid/sa/096.xml"

	(self isSkippableTest: #testvalidsa096xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa096xml
				documentURI: 'valid/sa/096.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa097xml [
	"Source file: xmltest/valid/sa/097.xml"

	(self isSkippableTest: #testvalidsa097xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa097xml
				documentURI: 'valid/sa/097.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa098xml [
	"Source file: xmltest/valid/sa/098.xml"

	(self isSkippableTest: #testvalidsa098xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa098xml
				documentURI: 'valid/sa/098.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa099xml [
	"Source file: xmltest/valid/sa/099.xml"

	(self isSkippableTest: #testvalidsa099xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa099xml
				documentURI: 'valid/sa/099.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa100xml [
	"Source file: xmltest/valid/sa/100.xml"

	(self isSkippableTest: #testvalidsa100xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa100xml
				documentURI: 'valid/sa/100.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa101xml [
	"Source file: xmltest/valid/sa/101.xml"

	(self isSkippableTest: #testvalidsa101xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa101xml
				documentURI: 'valid/sa/101.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa102xml [
	"Source file: xmltest/valid/sa/102.xml"

	(self isSkippableTest: #testvalidsa102xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa102xml
				documentURI: 'valid/sa/102.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa103xml [
	"Source file: xmltest/valid/sa/103.xml"

	(self isSkippableTest: #testvalidsa103xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa103xml
				documentURI: 'valid/sa/103.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa104xml [
	"Source file: xmltest/valid/sa/104.xml"

	(self isSkippableTest: #testvalidsa104xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa104xml
				documentURI: 'valid/sa/104.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa105xml [
	"Source file: xmltest/valid/sa/105.xml"

	(self isSkippableTest: #testvalidsa105xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa105xml
				documentURI: 'valid/sa/105.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa106xml [
	"Source file: xmltest/valid/sa/106.xml"

	(self isSkippableTest: #testvalidsa106xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa106xml
				documentURI: 'valid/sa/106.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa107xml [
	"Source file: xmltest/valid/sa/107.xml"

	(self isSkippableTest: #testvalidsa107xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa107xml
				documentURI: 'valid/sa/107.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa108xml [
	"Source file: xmltest/valid/sa/108.xml"

	(self isSkippableTest: #testvalidsa108xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa108xml
				documentURI: 'valid/sa/108.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa109xml [
	"Source file: xmltest/valid/sa/109.xml"

	(self isSkippableTest: #testvalidsa109xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa109xml
				documentURI: 'valid/sa/109.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa110xml [
	"Source file: xmltest/valid/sa/110.xml"

	(self isSkippableTest: #testvalidsa110xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa110xml
				documentURI: 'valid/sa/110.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa111xml [
	"Source file: xmltest/valid/sa/111.xml"

	(self isSkippableTest: #testvalidsa111xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa111xml
				documentURI: 'valid/sa/111.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa112xml [
	"Source file: xmltest/valid/sa/112.xml"

	(self isSkippableTest: #testvalidsa112xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa112xml
				documentURI: 'valid/sa/112.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa113xml [
	"Source file: xmltest/valid/sa/113.xml"

	(self isSkippableTest: #testvalidsa113xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa113xml
				documentURI: 'valid/sa/113.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa114xml [
	"Source file: xmltest/valid/sa/114.xml"

	(self isSkippableTest: #testvalidsa114xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa114xml
				documentURI: 'valid/sa/114.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa115xml [
	"Source file: xmltest/valid/sa/115.xml"

	(self isSkippableTest: #testvalidsa115xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa115xml
				documentURI: 'valid/sa/115.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa116xml [
	"Source file: xmltest/valid/sa/116.xml"

	(self isSkippableTest: #testvalidsa116xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa116xml
				documentURI: 'valid/sa/116.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa117xml [
	"Source file: xmltest/valid/sa/117.xml"

	(self isSkippableTest: #testvalidsa117xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa117xml
				documentURI: 'valid/sa/117.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa118xml [
	"Source file: xmltest/valid/sa/118.xml"

	(self isSkippableTest: #testvalidsa118xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa118xml
				documentURI: 'valid/sa/118.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceExpatTests >> testvalidsa119xml [
	"Source file: xmltest/valid/sa/119.xml"

	(self isSkippableTest: #testvalidsa119xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcevalidsa119xml
				documentURI: 'valid/sa/119.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]
