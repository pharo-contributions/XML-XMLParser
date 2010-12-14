Class {
	#name : #XMLConformanceTestsClark,
	#superclass : #XMLConformanceTests,
	#category : #'XML-Tests-Conformance'
}

{ #category : #'as yet unclassified' }
XMLConformanceTestsClark class >> allTestsToSkip [
	
	^#( "invalid test"
		'valid-sa-012'	
		'valid-sa-105' " the answer the test gives seems incorrect, and parser seems correct"	

		"encoding problems"
"		'valid-sa-049' 'valid-sa-050' 'valid-sa-051' 'valid-sa-061' 'valid-sa-062'
		'valid-sa-063'  'valid-ext-sa-014'"
		"no space between attributes"
		'not-wf-ext-sa-001' 'not-wf-sa-186'

		"Too many cr in parsers answer"
		'valid-sa-093'

		"illegal PE in DTD"
		'valid-sa-094'

		"cr problem should return an entity"
		'valid-sa-107'  'valid-sa-106' 
		)
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfnotsa002xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "<?xml version=''1.0'' encoding=''UTF-8''?>">
%e;
]>
<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa001xml [
	^ '<doc>
<doc
?
<a</a>
</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa003xml [
	^ '<doc><? ?></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa004xml [
	^ '<doc><?target some data></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa005xml [
	^ '<doc><?target some data?</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa007xml [
	^ '<doc>&amp no refc</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa008xml [
	^ '<doc>&.entity;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa009xml [
	^ '<doc>&#RE;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa010xml [
	^ '<doc>A & B</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa011xml [
	^ '<doc a1></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa012xml [
	^ '<doc a1=v1></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa013xml [
	^ '<doc a1="v1''></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa015xml [
	^ '<doc a1=></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa016xml [
	^ '<doc a1="v1" "v2"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa017xml [
	^ '<doc><![CDATA[</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa018xml [
	^ '<doc><![CDATA [ stuff]]></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa019xml [
	^ '<doc></>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa020xml [
	^ '<doc a1="A & B"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa021xml [
	^ '<doc a1="a&b"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa022xml [
	^ '<doc a1="&#123:"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa027xml [
	^ '<doc>
<!-- abc
</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa028xml [
	^ '<doc>
<?a pi that is not closed
</doc>

'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa035xml [
	^ '<doc>1 < 2 but not in XML</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa036xml [
	^ '<doc></doc>
Illegal data
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa037xml [
	^ '<doc></doc>
&#32;
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa039xml [
	^ '<doc><a></aa></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa042xml [
	^ '<doc/></doc/>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa043xml [
	^ '<doc/>
Illegal data
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa045xml [
	^ '<doc>
<a/
</doc>

'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa046xml [
	^ '<doc>
<a/</a>
</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa047xml [
	^ '<doc>
<a / >
</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa048xml [
	^ '<doc>
</doc>
<![CDATA[]]>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa049xml [
	^ '<doc>
<a><![CDATA[xyz]]]></a>
<![CDATA[]]></a>
</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa051xml [
	^ '<!-- a comment -->
<![CDATA[]]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa052xml [
	^ '<!-- a comment -->
&#32;
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa053xml [
	^ '<doc></DOC>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa055xml [
	^ '<!DOCTYPE doc [
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa063xml [
	^ '<!DOCTYPE doc [
<![INCLUDE[ ]]>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa071xml [
	^ '<!DOCTYPE doc [
<!ENTITY e1 "&e2;">
<!ENTITY e2 "&e3;">
<!ENTITY e3 "&e1;">
]>
<doc>&e1;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa072xml [
	^ '<doc>&foo;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa073xml [
	^ '<!DOCTYPE doc [
<!ENTITY e "whatever">
]>
<doc>&f;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa075xml [
	^ '<!DOCTYPE doc [
<!ENTITY e1 "&e2;">
<!ENTITY e2 "&e3;">
<!ENTITY e3 "&e1;">
]>
<doc a="&e1;"></doc>

'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa076xml [
	^ '<doc a="&foo;"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa077xml [
	^ '<!DOCTYPE doc [
<!ENTITY foo "&bar;">
]>
<doc a="&foo;"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa079xml [
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

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa080xml [
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

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa085xml [
	^ '<!DOCTYPE doc PUBLIC "[" "null.ent">
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa088xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
<!ENTITY e ''"''>
]>
<doc a="&e;></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa092xml [
	^ '<!DOCTYPE doc [
<!ENTITY e "<foo a=''&#38;''></foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa093xml [
	^ '<doc>&#X58;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa097xml [
	^ '<?xml version="1.0'' encoding="UTF-8" ?>
<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa103xml [
	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa105xml [
	^ '<?pi stuff?>
<![CDATA[]]>
<doc>
</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa106xml [
	^ '<?pi data?>
&#32;<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa107xml [
	^ '<!DOCTYPE doc [
<![CDATA[]]>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa108xml [
	^ '<doc>
<![CDATA [  ]]>
</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa110xml [
	^ '<!DOCTYPE doc [
<!ENTITY e "">
]>
<doc></doc>
&e;
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa112xml [
	^ '<doc>
<![cdata[data]]>
</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa113xml [
	^ '<!DOCTYPE doc [
<!ENTITY % foo "&">
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa114xml [
	^ '<!DOCTYPE doc [
<!ENTITY foo "&">
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa118xml [
	^ '<!DOCTYPE doc [
<!ENTITY e "#">
]>
<doc>&&e;97;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa121xml [
	^ '<!DOCTYPE doc [
<!ENTITY #DEFAULT "default">
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa159xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "<![CDATA[Tim & Michael]]>">
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa160xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "">
<!ENTITY foo "%e;">
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa162xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e1 "">
<!ENTITY % e2 "%e1;">
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa163xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "">
]>
%e;
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa164xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "">
] %e; >
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa176xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa178xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="&#34;></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa179xml [
	^ '<!DOCTYPE doc [
<!ENTITY e "&#34;>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestnotwfsa185xml [
	^ '<?xml version="1.0" standalone="yes"?>
<!DOCTYPE doc SYSTEM "185.ent">
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidextsa003xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
	<doc>&e;</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidextsaout003xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidnotsa001xml [
	^ '<!ELEMENT doc EMPTY>
	<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidnotsa002xml [
	^ '<!DOCTYPE doc SYSTEM "002.ent" [
<!ELEMENT doc EMPTY>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidnotsa027xml [
	^ '<!DOCTYPE doc SYSTEM "027.ent">
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidnotsa030xml [
	^ '<!DOCTYPE doc SYSTEM "030.ent">
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidnotsaout001xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidnotsaout002xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidnotsaout027xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidnotsaout030xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa001xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa002xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc ></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa003xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc >
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa004xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="v1"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa005xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1 = "v1"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa006xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1=''v1''></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa007xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#32;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa008xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&amp;&lt;&gt;&quot;&apos;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa009xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x20;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa010xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="v1" ></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa011xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED a2 CDATA #IMPLIED>
]>
<doc a1="v1" a2="v2"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa013xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc _.-0123456789 CDATA #IMPLIED>
]>
<doc _.-0123456789="v1"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa014xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc abcdefghijklmnopqrstuvwxyz CDATA #IMPLIED>
]>
<doc abcdefghijklmnopqrstuvwxyz="v1"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa015xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc ABCDEFGHIJKLMNOPQRSTUVWXYZ CDATA #IMPLIED>
]>
<doc ABCDEFGHIJKLMNOPQRSTUVWXYZ="v1"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa016xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi?></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa017xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><?pi some data ? > <??></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa018xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[<foo>]]></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa019xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[<&]]></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa020xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><![CDATA[<&]>]]]></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa021xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><!-- a comment --></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa022xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc><!-- a comment ->--></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa023xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "">
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa024xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo)>
<!ELEMENT foo (#PCDATA)>
<!ENTITY e "&#60;foo></foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa025xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo*)>
<!ELEMENT foo (#PCDATA)>
]>
<doc><foo/><foo></foo></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa026xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo*)>
<!ELEMENT foo EMPTY>
]>
<doc><foo/><foo></foo></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa027xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (foo*)>
<!ELEMENT foo ANY>
]>
<doc><foo/><foo></foo></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa034xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa035xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc />
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa037xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
<!-- comment -->

'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa038xml [
	^ '<!-- comment -->
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>

'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa039xml [
	^ '<?pi data?>
<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa040xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="&quot;&lt;&amp;&gt;&apos;"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa041xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
]>
<doc a1="&#65;"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa042xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#00000000000000000000000000000000065;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa048xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>]</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa053xml [
	^ '<!DOCTYPE doc [
<!ENTITY e "<e/>">
<!ELEMENT doc (e)>
<!ELEMENT e EMPTY>
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa054xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>


<doc
></doc
>


'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa055xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<?pi  data?>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa056xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#x0000000000000000000000000000000000000041;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa057xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (a*)>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa061xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#163;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa062xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
]>
<doc>&#xe40;&#xe08;&#xe21;ส์</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa065xml [
	^ '<!DOCTYPE doc [
<!ENTITY e "&#60;">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa066xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a1 CDATA #IMPLIED>
<!-- 34 is double quote -->
<!ENTITY e1 "&#34;">
]>
<doc a1="&e1;"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa071xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ID #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa072xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a IDREF #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa073xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a IDREFS #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa074xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ENTITY #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa075xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a ENTITIES #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa077xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a (1|2) #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa078xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #REQUIRED>
]>
<doc a="v"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa079xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #FIXED "v">
]>
<doc a="v"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa081xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (a, b, c)>
<!ELEMENT a (a?)>
<!ELEMENT b (b*)>
<!ELEMENT c (a | b)+>
]>
<doc><a/><b/><c><a/></c></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa082xml [
	^ '<!DOCTYPE doc [
<!ENTITY % e SYSTEM "e.dtd">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa083xml [
	^ '<!DOCTYPE doc [
<!ENTITY % e PUBLIC ''whatever'' "e.dtd">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa084xml [
	^ '<!DOCTYPE doc [<!ELEMENT doc (#PCDATA)>]><doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa085xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY % e "<foo>">
<!ENTITY e "">
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa086xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "">
<!ENTITY e "<foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa087xml [
	^ '<!DOCTYPE doc [
<!ENTITY e "<foo/&#62;">
<!ELEMENT doc (foo)>
<!ELEMENT foo EMPTY>
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa088xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "&lt;foo>">
]>
<doc>&e;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa095xml [
	^ '<!DOCTYPE doc [
<!ATTLIST doc a1 CDATA #IMPLIED>
<!ATTLIST doc a1 NMTOKENS #IMPLIED>
<!ELEMENT doc (#PCDATA)>
]>
<doc a1="1  2"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa100xml [
	^ '<!DOCTYPE doc [
<!ENTITY e PUBLIC ";!*#@$_%" "100.xml">
<!ELEMENT doc (#PCDATA)>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa101xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY e "&#34;">
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa102xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a="&#34;"></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa109xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST doc a CDATA #IMPLIED>
]>
<doc a=""></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa112xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (a | b)>
<!ELEMENT a (#PCDATA)>
]>
<doc><a></a></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa113xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ATTLIST e a CDATA #IMPLIED>
]>
<doc></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa117xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY rsqb "]">
]>
<doc>&rsqb;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa118xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc (#PCDATA)>
<!ENTITY rsqb "]]">
]>
<doc>&rsqb;</doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsa119xml [
	^ '<!DOCTYPE doc [
<!ELEMENT doc ANY>
]>
<doc><!-- -á --></doc>
'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout001xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout002xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout003xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout004xml [
	^ '<doc a1="v1"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout005xml [
	^ '<doc a1="v1"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout006xml [
	^ '<doc a1="v1"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout007xml [
	^ '<doc> </doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout008xml [
	^ '<doc>&amp;&lt;&gt;&quot;''</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout009xml [
	^ '<doc> </doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout010xml [
	^ '<doc a1="v1"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout011xml [
	^ '<doc a1="v1" a2="v2"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout013xml [
	^ '<doc _.-0123456789="v1"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout014xml [
	^ '<doc abcdefghijklmnopqrstuvwxyz="v1"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout015xml [
	^ '<doc ABCDEFGHIJKLMNOPQRSTUVWXYZ="v1"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout016xml [
	^ '<doc><?pi ?></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout017xml [
	^ '<doc><?pi some data ? > <??></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout018xml [
	^ '<doc>&lt;foo&gt;</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout019xml [
	^ '<doc>&lt;&amp;</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout020xml [
	^ '<doc>&lt;&amp;]&gt;]</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout021xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout022xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout023xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout024xml [
	^ '<doc><foo></foo></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout025xml [
	^ '<doc><foo></foo><foo></foo></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout026xml [
	^ '<doc><foo></foo><foo></foo></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout027xml [
	^ '<doc><foo></foo><foo></foo></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout034xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout035xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout037xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout038xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout039xml [
	^ '<?pi data?><doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout040xml [
	^ '<doc a1="&quot;&lt;&amp;&gt;''"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout041xml [
	^ '<doc a1="A"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout042xml [
	^ '<doc>A</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout048xml [
	^ '<doc>]</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout053xml [
	^ '<doc><e></e></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout054xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout055xml [
	^ '<?pi data?><doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout056xml [
	^ '<doc>A</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout057xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout061xml [
	^ '<doc>£</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout062xml [
	^ '<doc>เจมส์</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout065xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout066xml [
	^ '<doc a1="&quot;"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout071xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout072xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout073xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout074xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout075xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout077xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout078xml [
	^ '<doc a="v"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout079xml [
	^ '<doc a="v"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout081xml [
	^ '<doc><a></a><b></b><c><a></a></c></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout082xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout083xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout084xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout085xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout086xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout087xml [
	^ '<doc><foo></foo></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout088xml [
	^ '<doc>&lt;foo&gt;</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout095xml [
	^ '<doc a1="1  2"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout100xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout101xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout102xml [
	^ '<doc a="&quot;"></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout109xml [
	^ '<doc a=""></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout112xml [
	^ '<doc><a></a></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout113xml [
	^ '<doc></doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout117xml [
	^ '<doc>]</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout118xml [
	^ '<doc>]]</doc>'
]

{ #category : #source }
XMLConformanceTestsClark class >> sourcexmltestvalidsaout119xml [
	^ '<doc></doc>'
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfextsa001 [
	"
    Tests the No Recursion WFC by having an external general
    entity be self-recursive.
	 See XML Spec. 1.0 section: 4.1"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-ext-sa-001'])
		ifTrue:[^nil].
	self should: [self runTest: self sourcexmltestnotwfsa001xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfnotsa002 [
	"
    Processing instruction target names may not be  XML  
    in any combination of cases. 
	 See XML Spec. 1.0 section: 2.6 [17]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-not-sa-002'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfnotsa002xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa001 [
	"
    Attribute values must start with attribute names, not  ? . 
	 See XML Spec. 1.0 section: 3.1 [41]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-001'])
		ifTrue:[^nil].

	self should: [self runTest: self  sourcexmltestnotwfsa001xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa003 [
	"
    Processing Instruction target name is required.
	 See XML Spec. 1.0 section: 2.6 [16]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-003'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa003xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa004 [
	"
    SGML-ism:  processing instructions end in '?>' not '>'. 
	 See XML Spec. 1.0 section: 2.6 [16]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-004'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa004xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa005 [
	"
    Processing instructions end in '?>' not '?'. 
	 See XML Spec. 1.0 section: 2.6 [16]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-005'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa005xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa007 [
	"
    General entity references have no whitespace after the
    entity name and before the semicolon. 
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-007'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa007xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa008 [
	"
    Entity references must include names, which don't begin
    with '.' (it's not a Letter or other name start character). 
	 See XML Spec. 1.0 section: 2.3 [5]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-008'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa008xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa009 [
	"
    Character references may have only decimal or numeric strings.
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-009'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa009xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa010 [
	"
    Ampersand may only appear as part of a general entity reference.
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-010'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa010xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa011 [
	"
    SGML-ism:  attribute values must be explicitly assigned a
    value, it can't act as a boolean toggle. 
	 See XML Spec. 1.0 section: 3.1 [41]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-011'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa011xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa012 [
	"
    SGML-ism:  attribute values must be quoted in all cases. 
	 See XML Spec. 1.0 section: 2.3 [10]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-012'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa012xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa013 [
	"
    The quotes on both ends of an attribute value must match. 
	 See XML Spec. 1.0 section: 2.3 [10]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-013'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa013xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa015 [
	"
    Attribute values need a value, not just an equals sign. 
	 See XML Spec. 1.0 section: 3.1 [41]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-015'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa015xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa016 [
	"
    Attribute values need an associated name.
	 See XML Spec. 1.0 section: 3.1 [41]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-016'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa016xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa017 [
	"
    CDATA sections need a terminating ']]>'. 
	 See XML Spec. 1.0 section: 2.7 [18]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-017'])
		ifTrue:[^nil].

	self should: [self runTest: self  sourcexmltestnotwfsa017xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa018 [
	"
    CDATA sections begin with a literal '<![CDATA[', no space.
	 See XML Spec. 1.0 section: 2.7 [19]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-018'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa018xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa019 [
	"
    End tags may not be abbreviated as '</>'.
	 See XML Spec. 1.0 section: 3.1 [42]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-019'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa019xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa020 [
	"
    Attribute values may not contain literal '&'
    characters except as part of an entity reference. 
	 See XML Spec. 1.0 section: 2.3 [10]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-020'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa020xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa021 [
	"
    Attribute values may not contain literal '&'
    characters except as part of an entity reference. 
	 See XML Spec. 1.0 section: 2.3 [10]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-021'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa021xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa022 [
	"
    Character references end with semicolons, always!
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-022'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa022xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa027 [
	"
    Comments must be terminated with  --> .
	 See XML Spec. 1.0 section: 2.5 [15]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-027'])
		ifTrue:[^nil].

	self should: [self runTest:self  sourcexmltestnotwfsa027xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa028 [
	"
    Processing instructions must end with '?>'. 
	 See XML Spec. 1.0 section: 2.6 [16]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-028'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa028xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa035 [
	"
    The '<' character is a markup delimiter and must
    start an element, CDATA section, PI, or comment. 
	 See XML Spec. 1.0 section: 3.1 [43]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-035'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa035xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa036 [
	"
    Text may not appear after the root element. 
	 See XML Spec. 1.0 section: 2.8 [27]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-036'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa036xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa037 [
	"
    Character references may not appear after the root element. 
	 See XML Spec. 1.0 section: 2.8 [27]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-037'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa037xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa039 [
	"
    Tests the Element Type Match WFC - end tag name must
    match start tag name.
	 See XML Spec. 1.0 section: 3"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-039'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa039xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa042 [
	"
     Invalid End Tag 
	 See XML Spec. 1.0 section: 3.1 [42]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-042'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa042xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa043 [
	"
    Provides #PCDATA text after the document element. 
	 See XML Spec. 1.0 section: 2.8 [27]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-043'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa043xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa045 [
	"
    Invalid Empty Element Tag 
	 See XML Spec. 1.0 section: 3.1 [44]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-045'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa045xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa046 [
	"
    This start (or empty element) tag was not terminated correctly. 
	 See XML Spec. 1.0 section: 3.1 [40]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-046'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa046xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa047 [
	"
    Invalid empty element tag invalid whitespace 
	 See XML Spec. 1.0 section: 3.1 [44]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-047'])
		ifTrue:[^nil].

	self should: [self runTest:self  sourcexmltestnotwfsa047xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa048 [
	"
    Provides a CDATA section after the roor element.
	 See XML Spec. 1.0 section: 2.8 [27]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-048'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa048xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa049 [
	"
    Missing start tag 
	 See XML Spec. 1.0 section: 3.1 [40]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-049'])
		ifTrue:[^nil].

	self should: [self runTest:self  sourcexmltestnotwfsa049xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa050 [
	"
    Empty document, with no root element. 
	 See XML Spec. 1.0 section: 2.1 [1]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-050'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa050xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa051 [
	"
     CDATA is invalid at top level of document.
	 See XML Spec. 1.0 section: 2.7 [18]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-051'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa051xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa052 [
	"
    Invalid character reference. 
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-052'])
		ifTrue:[^nil].

	self should: [self runTest:self  sourcexmltestnotwfsa052xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa053 [
	"
    End tag does not match start tag. 
	 See XML Spec. 1.0 section: 3.1 [42]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-053'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa053xml]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa055 [
	"
    Invalid Document Type Definition format. 
	 See XML Spec. 1.0 section: 2.8 [28]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-055'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa055xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa063 [
	"
    Conditional sections may only appear in the external
    DTD subset. 
	 See XML Spec. 1.0 section: 2.8 [29]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-063'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa063xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa071 [
	"
     ENTITY can't reference itself directly or indirectly.
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-071'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa071xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa072 [
	"
    Undefined ENTITY foo. 
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-072'])
		ifTrue:[^nil].

	self should: [self runTest:self  sourcexmltestnotwfsa072xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa073 [
	"
    Undefined ENTITY f. 
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-073'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa073xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa075 [
	"
    ENTITY can't reference itself directly or indirectly. 
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-075'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa075xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa076 [
	"
    Undefined ENTITY foo. 
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-076'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa076xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa077 [
	"
    Undefined ENTITY bar. 
	 See XML Spec. 1.0 section: 41. [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-077'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa077xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa079 [
	"
    ENTITY can't reference itself directly or indirectly. 
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-079'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa079xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa080 [
	"
    ENTITY can't reference itself directly or indirectly. 
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-080'])
		ifTrue:[^nil].

	self should: [self runTest:self  sourcexmltestnotwfsa080xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa085 [
	"
    Public IDs may not contain  [ . 
	 See XML Spec. 1.0 section: 2.3 [13]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-085'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa085xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa088 [
	"
    Attribute values are terminated by literal quote characters,
    and any entity expansion is done afterwards. 
	 See XML Spec. 1.0 section: 2.3 [10]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-088'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa088xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa092 [
	"
    The replacement text of this entity has an illegal reference,
    because the character reference is expanded immediately. 
	 See XML Spec. 1.0 section: 4.5"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-092'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa092xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa093 [
	"
    Hexadecimal character references may not use the uppercase 'X'.
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-093'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa093xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa097 [
	"
    Both quotes surrounding VersionNum must be the same. 
	 See XML Spec. 1.0 section: 2.8 [24]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-097'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa097xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa103 [
	"
    End-tag required for element foo. 
	 See XML Spec. 1.0 section: 4.3.2"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-103'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa103xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa105 [
	"
    Invalid placement of CDATA section. 
	 See XML Spec. 1.0 section: 2.7 "

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-105'])
		ifTrue:[^nil].

	self should: [self runTest:self  sourcexmltestnotwfsa105xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa106 [
	"
    Invalid placement of entity declaration. 
	 See XML Spec. 1.0 section: 4.2"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-106'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa106xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa107 [
	"
     Invalid document type declaration.  CDATA alone is invalid.
	 See XML Spec. 1.0 section: 2.8 [28]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-107'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa107xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa108 [
	"
    No space in '<![CDATA['.
	 See XML Spec. 1.0 section: 2.7 [19]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-108'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa108xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa110 [
	"
    Entity reference must be in content of element. 
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-110'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa110xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa112 [
	"
    CDATA sections start '<![CDATA[', not '<!cdata['.
	 See XML Spec. 1.0 section: 2.7 [19]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-112'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa112xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa113 [
	"
    Parameter entity values must use valid reference syntax;
    this reference is malformed.
	 See XML Spec. 1.0 section: 2.3 [9]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-113'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa113xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa114 [
	"
    General entity values must use valid reference syntax;
    this reference is malformed.
	 See XML Spec. 1.0 section: 2.3 [9]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-114'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa114xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa118 [
	"
    Entity reference expansion is not recursive.
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-118'])
		ifTrue:[^nil].

	self should: [self runTest: self sourcexmltestnotwfsa118xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa121 [
	"
    A name of an ENTITY was started with an invalid character. 
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-121'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa121xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa159 [
	"
    Uses '&' unquoted in an entity declaration,
    which is illegal syntax for an entity reference.
	 See XML Spec. 1.0 section: 2.3 [9]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-159'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa159xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa160 [
	"
    Violates the PEs in Internal Subset WFC
    by using a PE reference within a declaration. 
	 See XML Spec. 1.0 section: 2.8"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-160'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa160xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa162 [
	"
    Violates the PEs in Internal Subset WFC
    by using a PE reference within a declaration. 
	 See XML Spec. 1.0 section: 2.8"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-162'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa162xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa163 [
	"
    Invalid placement of Parameter entity reference. 
	 See XML Spec. 1.0 section: 4.1 [69]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-163'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa163xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa164 [
	"
    Invalid placement of Parameter entity reference. 
	 See XML Spec. 1.0 section: 4.1 [69]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-164'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa164xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa170 [
	"
    Four byte UTF-8 encodings can encode UCS-4 characters
    which are beyond the range of legal XML characters
    (and can't be expressed in Unicode surrogate pairs).
    This document holds such a character.  
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-170'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa170xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa176 [
	"
    Start tags must have matching end tags.
	 See XML Spec. 1.0 section: 3 [39]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-176'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa176xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa178 [
	"
    Invalid syntax matching double quote is missing. 
	 See XML Spec. 1.0 section: 3.1 [41]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-178'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa178xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa179 [
	"
    Invalid syntax matching double quote is missing. 
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-179'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa179xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa185 [
	"
    Tests the Entity Declared WFC.
    Note:  a nonvalidating parser is permitted not to report
    this WFC violation, since it would need to read an external
    parameter entity to distinguish it from a violation of
    the Standalone Declaration VC.
	 See XML Spec. 1.0 section: 4.1"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-185'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa185xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarknotwfsa186 [
	"
    Whitespace is required between attribute/value pairs. 
	 See XML Spec. 1.0 section: 3.1 [44]"

	(self class shouldSkipTests and: [testsToSkip includes: 'not-wf-sa-186'])
		ifTrue:[^nil].

	self should: [self runTest:self sourcexmltestnotwfsa186xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidextsa003 [
	"
    Test demonstrates that the content of an element can be empty. In this case the external entity is an empty file. 
	 See XML Spec. 1.0 section: 3.1 4.1 [43] [68]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-ext-sa-003'])
		ifTrue:[^nil].
	correctAnswer := self  class sourcexmltestvalidextsaout003xml.

	[result := self runTest:self class sourcexmltestvalidextsa003xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidnotsa001 [
	"
    Test demonstrates the use of an ExternalID within a document type definition. 
	 See XML Spec. 1.0 section: 4.2.2 [75]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-not-sa-001'])
		ifTrue:[^nil].
	correctAnswer := self class  sourcexmltestvalidnotsaout001xml.

	[result := self runTest: self class sourcexmltestvalidnotsa001xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidnotsa002 [
	"
    Test demonstrates the use of an ExternalID within a document type definition. 
	 See XML Spec. 1.0 section: 4.2.2 [75]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-not-sa-002'])
		ifTrue:[^nil].
	correctAnswer := (self  class  sourcexmltestvalidnotsaout002xml).

	[result := self runTest: self   class   sourcexmltestvalidnotsa002xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidnotsa027 [
	"
    Test demonstrates a parameter entity reference whose value is NULL. 
	 See XML Spec. 1.0 section: 4.1 [69]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-not-sa-027'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcexmltestvalidnotsaout027xml) .

	[result := self runTest: (self  class  sourcexmltestvalidnotsa027xml) ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidnotsa030 [
	"
    Test demonstrates the use of the conditonal section IGNORE the will ignore its content from being used. 
	 See XML Spec. 1.0 section: 3.4 [62]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-not-sa-030'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidnotsaout030xml) .

	[result := self runTest:self   class  sourcexmltestvalidnotsa030xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa001 [
	"
    Test demonstrates an Element Type Declaration with Mixed Content. 
	 See XML Spec. 1.0 section: 3.2.2 [51]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-001'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcexmltestvalidsaout001xml) .

	[result := self runTest:self  class  sourcexmltestvalidsa001xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa002 [
	"
    Test demonstrates that whitespace is permitted after the tag name in a Start-tag. 
	 See XML Spec. 1.0 section: 3.1 [40]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-002'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcexmltestvalidsaout002xml) .

	[result := self runTest:self  class  sourcexmltestvalidsa002xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa003 [
	"
    Test demonstrates that whitespace is permitted after the tag name in an End-tag.
	 See XML Spec. 1.0 section: 3.1 [42]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-003'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcexmltestvalidsaout003xml)  .

	[result := self runTest:self   class    sourcexmltestvalidsa003xml] 
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa004 [
	"
    Test demonstrates a valid attribute specification within a Start-tag. 
	 See XML Spec. 1.0 section: 3.1 [41]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-004'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcexmltestvalidsaout004xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa004xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa005 [
	"
    Test demonstrates a valid attribute specification within a Start-tag that
contains whitespace on both sides of the equal sign. 
	 See XML Spec. 1.0 section: 3.1 [40]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-005'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcexmltestvalidsaout005xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa005xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa006 [
	"
    Test demonstrates that the AttValue within a Start-tag can use a single quote as a delimter. 
	 See XML Spec. 1.0 section: 3.1 [41]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-006'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcexmltestvalidsaout006xml)  .

	[result := self runTest:(self class  sourcexmltestvalidsa006xml) ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa007 [
	"
    Test demonstrates numeric character references can be used for element content. 
	 See XML Spec. 1.0 section: 3.1 4.6 [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-007'])
		ifTrue:[^nil].
	correctAnswer := (self class sourcexmltestvalidsaout007xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa007xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa008 [
	"
    Test demonstrates character references can be used for element content. 
	 See XML Spec. 1.0 section: 2.4 3.1 [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-008'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout008xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa008xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa009 [
	"
    Test demonstrates that PubidChar can be used for element content. 
	 See XML Spec. 1.0 section: 2.3 3.1 [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-009'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout009xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa009xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa010 [
	"
    Test demonstrates that whitespace is valid after the Attribute in a Start-tag. 
	 See XML Spec. 1.0 section: 3.1 [40]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-010'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout010xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa010xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa011 [
	"
    Test demonstrates mutliple Attibutes within the Start-tag. 
	 See XML Spec. 1.0 section: 3.1 [40]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-011'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout011xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa011xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa012 [
	"
    Uses a legal XML 1.0 name consisting of a single colon
    character (disallowed by the latest XML Namespaces draft).
	 See XML Spec. 1.0 section: 2.3 [4]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-012'])
		ifTrue:[^nil].
	correctAnswer := (self sourcexmltestvalidsaout012xml).

	[result := self runTest:self sourcexmltestvalidsa012xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa013 [
	"
    Test demonstrates that the Attribute in a Start-tag can consist of numerals along with special characters. 
	 See XML Spec. 1.0 section: 2.3 3.1 [13] [40]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-013'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout013xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa013xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa014 [
	"
    Test demonstrates that all lower case letters are valid for the Attribute in a Start-tag. 
	 See XML Spec. 1.0 section: 2.3 3.1 [13] [40]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-014'])
		ifTrue:[^nil].
	correctAnswer := (self  class  sourcexmltestvalidsaout014xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa014xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa015 [
	"
    Test demonstrates that all upper case letters are valid for the Attribute in a Start-tag. 
	 See XML Spec. 1.0 section: 2.3 3.1 [13] [40]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-015'])
		ifTrue:[^nil].
	correctAnswer := (self  class  sourcexmltestvalidsaout015xml)  .

	[result := self runTest:self   class  sourcexmltestvalidsa015xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa016 [
	"
    Test demonstrates that Processing Instructions are valid element content. 
	 See XML Spec. 1.0 section: 2.6 3.1 [16] [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-016'])
		ifTrue:[^nil].
	correctAnswer := (self  class  sourcexmltestvalidsaout016xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa016xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa017 [
	"
    Test demonstrates that Processing Instructions are valid element content and there can be more than one. 
	 See XML Spec. 1.0 section: 2.6 3.1 [16] [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-017'])
		ifTrue:[^nil].
	correctAnswer := (self  class  sourcexmltestvalidsaout017xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa017xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa018 [
	"
    Test demonstrates that CDATA sections are valid element content. 
	 See XML Spec. 1.0 section: 2.7 3.1 [18] [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-018'])
		ifTrue:[^nil].
	correctAnswer := (self  class  sourcexmltestvalidsaout018xml)  .

	[result := self runTest:self  class   sourcexmltestvalidsa018xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa019 [
	"
    Test demonstrates that CDATA sections are valid element content and that
ampersands may occur in their literal form. 
	 See XML Spec. 1.0 section: 2.7 3.1 [18] [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-019'])
		ifTrue:[^nil].
	correctAnswer := (self  class  sourcexmltestvalidsaout019xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa019xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa020 [
	"
   Test demonstractes that CDATA sections are valid element content and that
everyting between the CDStart and CDEnd is recognized as character data not markup.  
	 See XML Spec. 1.0 section: 2.7 3.1 [18] [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-020'])
		ifTrue:[^nil].
	correctAnswer := (self  class  sourcexmltestvalidsaout020xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa020xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa021 [
	"
    Test demonstrates that comments are valid element content. 
	 See XML Spec. 1.0 section: 2.5 3.1 [15] [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-021'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout021xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa021xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa022 [
	"
    Test demonstrates that comments are valid element content and that all characters before the double-hypen right angle combination are considered part of thecomment. 
	 See XML Spec. 1.0 section: 2.5 3.1 [15] [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-022'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout022xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa022xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa023 [
	"
    Test demonstrates that Entity References are valid element content. 
	 See XML Spec. 1.0 section: 3.1 [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-023'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout023xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa023xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa024 [
	"
    Test demonstrates that Entity References are valid element content and also demonstrates a valid Entity Declaration. 
	 See XML Spec. 1.0 section: 3.1 4.1 [43] [66]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-024'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout024xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa024xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa025 [
	"
    Test demonstrates an Element Type Declaration and that the contentspec can be of mixed content. 
	 See XML Spec. 1.0 section: 3.2 [46]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-025'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout025xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa025xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa026 [
	"
    Test demonstrates an Element Type Declaration and that EMPTY is a valid contentspec. 
	 See XML Spec. 1.0 section: 3.2 [46]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-026'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout026xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa026xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa027 [
	"
    Test demonstrates an Element Type Declaration and that ANY is a valid contenspec. 
	 See XML Spec. 1.0 section: 3.2 [46]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-027'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout027xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa027xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa034 [
	"
    Test demonstrates the correct syntax for an Empty element tag. 
	 See XML Spec. 1.0 section: 3.1 [44]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-034'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout034xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa034xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa035 [
	"
    Test demonstrates that whitespace is permissible after the name in an Empty element tag. 
	 See XML Spec. 1.0 section: 3.1 [44]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-035'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout035xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa035xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa037 [
	"
    Test demonstrates a valid comment and that it may appear anywhere in the document including at the end. 
	 See XML Spec. 1.0 section: 2.6 [15]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-037'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout037xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa037xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa038 [
	"
    Test demonstrates a valid comment and that it may appear anywhere in the document including the beginning. 
	 See XML Spec. 1.0 section: 2.6 [15]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-038'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout038xml)  .

	[result := self runTest: self  class  sourcexmltestvalidsa038xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa039 [
	"
    Test demonstrates a valid processing instruction and that it may appear at the beginning of the document. 
	 See XML Spec. 1.0 section: 2.6 [16]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-039'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout039xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa039xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa040 [
	"
    Test demonstrates an Attribute List declaration that uses a StringType as the AttType. 
	 See XML Spec. 1.0 section: 3.3 3.3.1 [52] [54]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-040'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout040xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa040xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa041 [
	"
    Test demonstrates an Attribute List declaration that uses a StringType as the AttType and also expands the CDATA attribute with a character reference. 
	 See XML Spec. 1.0 section: 3.3.1 4.1 [54] [66]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-041'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout041xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa041xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa042 [
	"
    Test demonstrates an Attribute List declaration that uses a StringType as the AttType and also expands the CDATA attribute with a character reference.  The test also shows that the leading zeros in the character reference are ignored. 
	 See XML Spec. 1.0 section: 3.3.1 4.1 [54] [66]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-042'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout042xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa042xml ]
		on: self warningSignal
		do: [:warn | warn resume].
	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa048 [
	"
    Test demonstrates that character data is valid element content. 
	 See XML Spec. 1.0 section: 2.4 3.1 [14] [43]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-048'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout048xml)  .

	[result := self runTest:self   class  sourcexmltestvalidsa048xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa053 [
	"
    Tests inclusion of a well-formed internal entity, which
    holds an element required by the content model.
	 See XML Spec. 1.0 section: 4.4.2"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-053'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout053xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa053xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa054 [
	"
    Test demonstrates that extra whitespace within Start-tags and End-tags are nomalized into single spaces. 
	 See XML Spec. 1.0 section: 3.1 [40] [42]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-054'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout054xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa054xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa055 [
	"
    Test demonstrates that extra whitespace within a processing instruction willnormalized into s single space character. 
	 See XML Spec. 1.0 section: 2.6 2.10 [16]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-055'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout055xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa055xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa056 [
	"
    Test demonstrates an Attribute List declaration that uses a StringType as the AttType and also expands the CDATA attribute with a character reference.  The test also shows that the leading zeros in the character reference are ignored. 
	 See XML Spec. 1.0 section: 3.3.1 4.1 [54] [66]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-056'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout056xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa056xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa057 [
	"
    Test demonstrates an element content model whose element can occur zero or more times. 
	 See XML Spec. 1.0 section: 3.2.1 [47]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-057'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout057xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa057xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa061 [
	"
    Test demonstrates the use of decimal Character References within element content. 
	 See XML Spec. 1.0 section: 4.1 [66]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-061'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout061xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa061xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa062 [
	"
    Test demonstrates the use of hexadecimal Character References within element.  
	 See XML Spec. 1.0 section: 4.1 [66]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-062'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout062xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa062xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa065 [
	"
    Tests ability to define an internal entity which can't
    legally be expanded (contains an unquoted <).
	 See XML Spec. 1.0 section: 4.5"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-065'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout065xml)  .

	[result := self runTest:self   class  sourcexmltestvalidsa065xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa066 [
	"
    Expands a CDATA attribute with a character reference.
	 See XML Spec. 1.0 section: 4.1 [66]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-066'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout066xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa066xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa071 [
	"
    Test demonstrates that an AttlistDecl can use ID as the TokenizedType within the Attribute type.  The test also shows that IMPLIED is a valid DefaultDecl. 
	 See XML Spec. 1.0 section: 3.3 3.3.1 [52] [56]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-071'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout071xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa071xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa072 [
	"
    Test demonstrates that an AttlistDecl can use IDREF as the TokenizedType within the Attribute type.  The test also shows that IMPLIED is a valid DefaultDecl. 
	 See XML Spec. 1.0 section: 3.3 3.3.1 [52] [56]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-072'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout072xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa072xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa073 [
	"
    Test demonstrates that an AttlistDecl can use IDREFS as the TokenizedType within the Attribute type.  The test also shows that IMPLIED is a valid DefaultDecl. 
	 See XML Spec. 1.0 section: 3.3 3.3.1 [52] [56]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-073'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout073xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa073xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa074 [
	"
    Test demonstrates that an AttlistDecl can use ENTITY as the TokenizedType within the Attribute type.  The test also shows that IMPLIED is a valid DefaultDecl. 
	 See XML Spec. 1.0 section: 3.3 3.3.1 [52] [56]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-074'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout074xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa074xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa075 [
	"
    Test demonstrates that an AttlistDecl can use ENTITIES as the TokenizedType within the Attribute type.  The test also shows that IMPLIED is a valid DefaultDecl. 
	 See XML Spec. 1.0 section: 3.3 3.3.1 [52] [56]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-075'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout075xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa075xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa077 [
	"
    Test demonstrates that an AttlistDecl can use an EnumeratedType within the Attribute type.  The test also shows that IMPLIED is a valid DefaultDecl. 
	 See XML Spec. 1.0 section: 3.3 3.3.1 [52] [54]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-077'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout077xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa077xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa078 [
	"
    Test demonstrates that an AttlistDecl can use an StringType of CDATA within the Attribute type.  The test also shows that REQUIRED is a valid DefaultDecl. 
	 See XML Spec. 1.0 section: 3.3 3.3.1 [52] [54]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-078'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout078xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa078xml ]
		on: self warningSignal
		do: [:warn | warn resume].
	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa079 [
	"
    Test demonstrates that an AttlistDecl can use an StringType of CDATA within the Attribute type.  The test also shows that FIXED is a valid DefaultDecl and that a value can be given to the attribute in the Start-tag as well as the AttListDecl. 
	 See XML Spec. 1.0 section: 3.3 3.3.2 [52] [60]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-079'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout079xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa079xml ]
		on: self warningSignal
		do: [:warn | warn resume].
	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa081 [
	"
    Test demonstrates the use of the optional character following a name or list  to govern the number of times an element or content particles in the list occur. 
	 See XML Spec. 1.0 section: 3.2.1 [50]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-081'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout081xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa081xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa082 [
	"
    Tests that an external PE may be defined (but not referenced).
	 See XML Spec. 1.0 section: 4.2 [72]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-082'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout082xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa082xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa083 [
	"
    Tests that an external PE may be defined (but not referenced).
	 See XML Spec. 1.0 section: 4.2 [72]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-083'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout083xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa083xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa084 [
	"
    Test demonstrates that although whitespace can be used to set apart markup for greater readability it is not necessary. 
	 See XML Spec. 1.0 section: 2.10"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-084'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout084xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa084xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa085 [
	"
    Parameter and General entities use different namespaces,
    so there can be an entity of each type with a given name.
	 See XML Spec. 1.0 section: 4"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-085'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout085xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa085xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa086 [
	"
    Tests whether entities may be declared more than once,
    with the first declaration being the binding one. 
	 See XML Spec. 1.0 section: 4.2"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-086'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout086xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa086xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa087 [
	"
    Tests whether character references in internal entities are
    expanded early enough, by relying on correct handling to
    make the entity be well formed.
	 See XML Spec. 1.0 section: 4.5"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-087'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout087xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa087xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa088 [
	"
    Tests whether entity references in internal entities are
    expanded late enough, by relying on correct handling to
    make the expanded text be valid.  (If it's expanded too
    early, the entity will parse as an element that's not
    valid in that context.)
	 See XML Spec. 1.0 section: 4.5"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-088'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout088xml)  .

	[result := self runTest: (self class sourcexmltestvalidsa088xml )]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa093 [
	"
    Test demonstrates that extra whitespace is not intended for inclusion in the delivered version of the document. 
	 See XML Spec. 1.0 section: 2.10"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-093'])
		ifTrue:[^nil].
	correctAnswer := (self sourcexmltestvalidsaout093xml) .

	[result := self runTest:self  class  sourcexmltestvalidsa093xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa094 [
	"
    
    This refers to an undefined parameter entity reference within
    a markup declaration in the internal DTD subset, violating
    the PEs in Internal Subset WFC.
	 See XML Spec. 1.0 section: 2.8"

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-094'])
		ifTrue:[^nil].

	self should: [self runTest:self   class sourcexmltestvalidsa094xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa095 [
	"
    Basically an output test, this requires extra whitespace
    to be normalized into a single space character in an
    attribute of type NMTOKENS.
	 See XML Spec. 1.0 section: 3.3.3"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-095'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout095xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa095xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa100 [
	"
    Makes sure that PUBLIC identifiers may have some strange
    characters.  NOTE:  The XML editors have said that the XML
    specification errata will specify that parameter entity expansion
    does not occur in PUBLIC identifiers, so that the '%' character
    will not flag a malformed parameter entity reference.
	 See XML Spec. 1.0 section: 2.3 [12]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-100'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout100xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa100xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa101 [
	"
    This tests whether entity expansion is (incorrectly) done
    while processing entity declarations; if it is, the entity
    value literal will terminate prematurely.
	 See XML Spec. 1.0 section: 4.5"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-101'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout101xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa101xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa102 [
	"
    Test demonstrates that a CDATA attribute can pass a double quote as its value. 
	 See XML Spec. 1.0 section: 3.3.3"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-102'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout102xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa102xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa105 [
	"
    Basically an output test, this requires a CDATA attribute
    with a tab character to be passed through as one space.
	 See XML Spec. 1.0 section: 3.3.3"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-105'])
		ifTrue:[^nil].
	correctAnswer := (self sourcexmltestvalidsaout105xml)  contentsOfEntireFile.

	[result := self runTest:self   class sourcexmltestvalidsa105xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa106 [
	"
    Basically an output test, this requires a CDATA attribute
    with a newline character to be passed through as one space.
	 See XML Spec. 1.0 section: 3.3.3"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-106'])
		ifTrue:[^nil].
	correctAnswer := (self  class  sourcexmltestvalidsaout106xml).

	[result := self runTest:self   class sourcexmltestvalidsa106xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa107 [
	"
    Basically an output test, this requires a CDATA attribute
    with a return character to be passed through as one space.
	 See XML Spec. 1.0 section: 3.3.3"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-107'])
		ifTrue:[^nil].
	correctAnswer := (self sourcexmltestvalidsaout107xml).

	[result := self runTest:self sourcexmltestvalidsa107xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa109 [
	"
    Test demonstrates that an attribute can have a null value. 
	 See XML Spec. 1.0 section: 2.3 3.1 [10][40][41]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-109'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout109xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa109xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa112 [
	"
    Test demonstrates shows the use of content particles within the element content. 
	 See XML Spec. 1.0 section: 3.2.1 [48][49]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-112'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout112xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa112xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa113 [
	"
     Test demonstrates that it is not an error to have attributes declared for an element not itself declared.
	 See XML Spec. 1.0 section: 3.3 [52][53]"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-113'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout113xml)  .

	[result := self runTest:self  class  sourcexmltestvalidsa113xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa117 [
	"
    Test demonstrates that entity expansion is done while processing entity declarations.  
	 See XML Spec. 1.0 section: 4.5"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-117'])
		ifTrue:[^nil].
	correctAnswer := (self  class sourcexmltestvalidsaout117xml)  .

	[result := self runTest: (self   class sourcexmltestvalidsa117xml )]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa118 [
	"
    Test demonstrates that entity expansion is done while processing entity declarations. 
	 See XML Spec. 1.0 section: 4.5"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-118'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout118xml)  .

	[result := self runTest: self   class sourcexmltestvalidsa118xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]

{ #category : #tests }
XMLConformanceTestsClark >> testclarkvalidsa119 [
	"
    Comments may contain any legal XML characters;
    only the string  --  is disallowed.
	 See XML Spec. 1.0 section: 2.5"
	|  correctAnswer  result |

	(self class shouldSkipTests and: [testsToSkip includes: 'valid-sa-119'])
		ifTrue:[^nil].
	correctAnswer := (self class  sourcexmltestvalidsaout119xml)  .

	[result := self runTest:self   class sourcexmltestvalidsa119xml ]
		on: self warningSignal
		do: [:warn | warn resume].

	self assert: correctAnswer = result.
]
