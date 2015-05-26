Class {
	#name : #XMLConformanceOasisTests,
	#superclass : #XMLConformanceTests,
	#category : #'XML-Tests-Conformance'
}

{ #category : #accessing }
XMLConformanceOasisTests class >> skippableTests [
	^ #( teste2xml testp01fail1xml testp09fail2xml testp14fail3xml testp18fail3xml testp22fail1xml testp39fail3xml testp44fail5xml testp66fail5xml testp66fail6xml )
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcee2xml [
	"Source file: oasis/e2.xml"

	^ '<!DOCTYPE el [
<!ELEMENT el EMPTY>
<!ATTLIST el at (one|two|two) #IMPLIED>
]>
<e1 at="two"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep01fail1xml [
	"Source file: oasis/p01fail1.xml"

	^ '
<?xml version="1.0"?>
<doc>
<a><b><c/></b></a>
</doc>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep01fail2xml [
	"Source file: oasis/p01fail2.xml"

	^ '<!--bad comment--><?xml version="1.0"?>
<doc>
<a><b><c/></b></a>
</doc>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep01fail3xml [
	"Source file: oasis/p01fail3.xml"

	^ '<doc/><bad/>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep01fail4xml [
	"Source file: oasis/p01fail4.xml"

	^ '<doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep01pass1xml [
	"Source file: oasis/p01pass1.xml"

	^ '<doc>
<a><b><c/></b></a>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep01pass2xml [
	"Source file: oasis/p01pass2.xml"

	^ '<?PI before document element?>
<!-- comment after document element-->
<?PI before document element?>
<!-- comment after document element-->
<?PI before document element?>
<!-- comment after document element-->
<?PI before document element?>
<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a ANY>
<!ELEMENT b ANY>
<!ELEMENT c ANY>
]>
<doc>
<a><b><c/></b></a>
</doc>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep01pass3xml [
	"Source file: oasis/p01pass3.xml"

	^ '<doc>
<a><b><c/></b></a>
</doc>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
<!-- comment after document element-->
<?PI after document element?>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail10xml [
	"Source file: oasis/p03fail10.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail11xml [
	"Source file: oasis/p03fail11.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail12xml [
	"Source file: oasis/p03fail12.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail13xml [
	"Source file: oasis/p03fail13.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail14xml [
	"Source file: oasis/p03fail14.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail15xml [
	"Source file: oasis/p03fail15.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail16xml [
	"Source file: oasis/p03fail16.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail17xml [
	"Source file: oasis/p03fail17.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail18xml [
	"Source file: oasis/p03fail18.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail19xml [
	"Source file: oasis/p03fail19.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail1xml [
	"Source file: oasis/p03fail1.xml"

	^ ' <doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail20xml [
	"Source file: oasis/p03fail20.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail21xml [
	"Source file: oasis/p03fail21.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail22xml [
	"Source file: oasis/p03fail22.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail23xml [
	"Source file: oasis/p03fail23.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail24xml [
	"Source file: oasis/p03fail24.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail25xml [
	"Source file: oasis/p03fail25.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail26xml [
	"Source file: oasis/p03fail26.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail27xml [
	"Source file: oasis/p03fail27.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail28xml [
	"Source file: oasis/p03fail28.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail29xml [
	"Source file: oasis/p03fail29.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail2xml [
	"Source file: oasis/p03fail2.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail3xml [
	"Source file: oasis/p03fail3.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail4xml [
	"Source file: oasis/p03fail4.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail5xml [
	"Source file: oasis/p03fail5.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail7xml [
	"Source file: oasis/p03fail7.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail8xml [
	"Source file: oasis/p03fail8.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03fail9xml [
	"Source file: oasis/p03fail9.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep03pass1xml [
	"Source file: oasis/p03pass1.xml"

	^ '	
 <doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep04fail1xml [
	"Source file: oasis/p04fail1.xml"

	^ '<A@/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep04fail2xml [
	"Source file: oasis/p04fail2.xml"

	^ '<A#/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep04fail3xml [
	"Source file: oasis/p04fail3.xml"

	^ '<A$/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep04pass1xml [
	"Source file: oasis/p04pass1.xml"

	^ '<doc>
<abcdefghijklmnopqrstuvwxyz/>
<ABCDEFGHIJKLMNOPQRSTUVWXYZ/>
<A01234567890/>
<A.-:̀·/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep05fail1xml [
	"Source file: oasis/p05fail1.xml"

	^ '<0A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep05fail2xml [
	"Source file: oasis/p05fail2.xml"

	^ '<.A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep05fail3xml [
	"Source file: oasis/p05fail3.xml"

	^ '<-A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep05fail4xml [
	"Source file: oasis/p05fail4.xml"

	^ '<̀A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep05fail5xml [
	"Source file: oasis/p05fail5.xml"

	^ '<·A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep05pass1xml [
	"Source file: oasis/p05pass1.xml"

	^ '<doc>
<A:._-0/>
<::._-0/>
<_:._-0/>
<A/>
<_/>
<:/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep06fail1xml [
	"Source file: oasis/p06fail1.xml"

	^ '<!--non-validating processors may pass this instance because they don''t check the IDREFS attribute type-->
<!DOCTYPE doc
[
<!ELEMENT doc (a|refs)*>
<!ELEMENT a EMPTY>
<!ELEMENT refs EMPTY>
<!ATTLIST refs refs IDREFS #REQUIRED>
<!ATTLIST a id ID #REQUIRED>
]>
<doc>
<a id="A1"/><a id="A2"/><a id="A3"/>
<refs refs=""/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep06pass1xml [
	"Source file: oasis/p06pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (a|refs)*>
<!ELEMENT a EMPTY>
<!ELEMENT refs EMPTY>
<!ATTLIST refs refs IDREFS #REQUIRED>
<!ATTLIST a id ID #REQUIRED>
]>
<doc>
<a id="A1"/><a id="A2"/><a id="A3"/>
<refs refs="A1 A2 A3"/>
<refs refs="A1
A2	A3"/>
<refs refs="A1"/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep07pass1xml [
	"Source file: oasis/p07pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att (0|35a|A|-a|:a|a:|.|_a) #IMPLIED>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep08fail1xml [
	"Source file: oasis/p08fail1.xml"

	^ '<!--note: non-validating parsers may accept this document-->
<!DOCTYPE doc
[
<!ELEMENT doc (A*)>
<!ELEMENT A EMPTY>
<!ATTLIST A att NMTOKENS #IMPLIED>
]>
<doc>
<A att=""/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep08fail2xml [
	"Source file: oasis/p08fail2.xml"

	^ '<!--note: non-validating parsers may accept this document-->
<!DOCTYPE doc
[
<!ELEMENT doc (A*)>
<!ELEMENT A EMPTY>
<!ATTLIST A att NMTOKENS #IMPLIED>
]>
<doc>
<A att="abc / def"/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep08pass1xml [
	"Source file: oasis/p08pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (A*)>
<!ELEMENT A EMPTY>
<!ATTLIST A att NMTOKENS #IMPLIED>
]>
<doc>
<A att="abc"/><A att="abc def . :"/><A att="
abc
def
"/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep09fail1dtd [
	"Source file: oasis/p09fail1.dtd"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "asdf%">
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep09fail1xml [
	"Source file: oasis/p09fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p09fail1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep09fail2dtd [
	"Source file: oasis/p09fail2.dtd"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "asdf&">
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep09fail2xml [
	"Source file: oasis/p09fail2.xml"

	^ '<!DOCTYPE doc SYSTEM "p09fail2.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep09fail3xml [
	"Source file: oasis/p09fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "asdf&#65">
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep09fail4xml [
	"Source file: oasis/p09fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY % ent1 ''a">
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep09fail5xml [
	"Source file: oasis/p09fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "a''>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep09pass1dtd [
	"Source file: oasis/p09pass1.dtd"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "">
<!ENTITY ent2 "text2">
<!ENTITY % ent3 "<!-- <!DOCTYPE <!ELEMENT <? ''''''&#34;&ent2; %ent1;">
<!ENTITY % ent4 ''""&#x27;&#39;"''>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep09pass1xml [
	"Source file: oasis/p09pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p09pass1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep10fail1xml [
	"Source file: oasis/p10fail1.xml"

	^ '<doc a="1 < 2"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep10fail2xml [
	"Source file: oasis/p10fail2.xml"

	^ '<doc a="1 &"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep10fail3xml [
	"Source file: oasis/p10fail3.xml"

	^ '<doc a=''asd"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep10pass1xml [
	"Source file: oasis/p10pass1.xml"

	^ '<doc>
<A a="asdf>''&#34;>
asdf
	?>%"/>
<A a=''"">&#39;&#34;''/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep11fail1xml [
	"Source file: oasis/p11fail1.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 SYSTEM ''a">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep11fail2xml [
	"Source file: oasis/p11fail2.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 SYSTEM """>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep11pass1xml [
	"Source file: oasis/p11pass1.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 SYSTEM "a%a&b&#0<!ELEMENT<!--<?</>?>/\''''">
<!NOTATION not2 SYSTEM ''a
	b"""''>
<!NOTATION not3 SYSTEM "">
<!NOTATION not4 SYSTEM ''''>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep12fail1xml [
	"Source file: oasis/p12fail1.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 PUBLIC ''"''>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep12fail2xml [
	"Source file: oasis/p12fail2.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 PUBLIC "\\">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep12fail3xml [
	"Source file: oasis/p12fail3.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY x "x">
<!NOTATION not1 PUBLIC "&x;">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep12fail4xml [
	"Source file: oasis/p12fail4.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 PUBLIC ">">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep12fail5xml [
	"Source file: oasis/p12fail5.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 PUBLIC "<">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep12fail6xml [
	"Source file: oasis/p12fail6.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 PUBLIC "&amp;">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep12fail7xml [
	"Source file: oasis/p12fail7.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 PUBLIC "	">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep12pass1xml [
	"Source file: oasis/p12pass1.xml"

	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 PUBLIC "a b
cdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ">
<!NOTATION not2 PUBLIC ''0123456789-()+,./:=?;!*#@$_%''>
<!NOTATION not3 PUBLIC "0123456789-()+,.''/:=?;!*#@$_%">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep14fail1xml [
	"Source file: oasis/p14fail1.xml"

	^ '<doc>< </doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep14fail2xml [
	"Source file: oasis/p14fail2.xml"

	^ '<doc>& </doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep14fail3xml [
	"Source file: oasis/p14fail3.xml"

	^ '<doc>a]]>b</doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep14pass1xml [
	"Source file: oasis/p14pass1.xml"

	^ '<doc>a%b%&lt;/doc>&#60;/doc>]]&lt;&amp;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep15fail1xml [
	"Source file: oasis/p15fail1.xml"

	^ '<!--a--->
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep15fail2xml [
	"Source file: oasis/p15fail2.xml"

	^ '<!-- -- -- -->
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep15fail3xml [
	"Source file: oasis/p15fail3.xml"

	^ '<!-- --- -->
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep15pass1xml [
	"Source file: oasis/p15pass1.xml"

	^ '<!--a
<!DOCTYPE
<?-
]]>-<[ CDATA [
"- -''-
-<doc>-->
<!---->
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep16fail1xml [
	"Source file: oasis/p16fail1.xml"

	^ '<?pitarget?>
<?xml?>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep16fail2xml [
	"Source file: oasis/p16fail2.xml"

	^ '<??>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep16fail3xml [
	"Source file: oasis/p16fail3.xml"

	^ '<?pitarget+++?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep16pass1xml [
	"Source file: oasis/p16pass1.xml"

	^ '<?pitarget?>
<?xmla <!DOCTYPE <[ CDATA [</doc> &a%b&#c?>
<?pitarget ...?>
<?pitarget 
	?>
<?pitarget > ?>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep16pass2xml [
	"Source file: oasis/p16pass2.xml"

	^ '<?pitarget ''?>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep16pass3xml [
	"Source file: oasis/p16pass3.xml"

	^ '<?pitarget "?>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep18fail1xml [
	"Source file: oasis/p18fail1.xml"

	^ '<doc><![ CDATA[a]]></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep18fail2xml [
	"Source file: oasis/p18fail2.xml"

	^ '<doc><![CDATA [a]]></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep18fail3xml [
	"Source file: oasis/p18fail3.xml"

	^ '<doc>
<![CDATA[
<![CDATA[XML doesn''t allow CDATA sections to nest]]>
]]>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep18pass1xml [
	"Source file: oasis/p18pass1.xml"

	^ '<doc><![CDATA[<doc<!DOCTYPE&a%b&#c]] >] ]> ]]]><![CDATA[]]>
<![CDATA[
<![CDATA[
]]>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep22fail1xml [
	"Source file: oasis/p22fail1.xml"

	^ '
<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep22fail2xml [
	"Source file: oasis/p22fail2.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc EMPTY>
]>
<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep22pass1xml [
	"Source file: oasis/p22pass1.xml"

	^ '<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep22pass2xml [
	"Source file: oasis/p22pass2.xml"

	^ '<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep22pass3xml [
	"Source file: oasis/p22pass3.xml"

	^ '<?xml version="1.0"?>
<!--comment--> <?pi?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep22pass4xml [
	"Source file: oasis/p22pass4.xml"

	^ '<?xml version="1.0"?>
<!--comment--> <?pi?>
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
]>

<!--comment--> <?pi?>

<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep22pass5xml [
	"Source file: oasis/p22pass5.xml"

	^ '<!--comment--> <?pi?>
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
]>

<!--comment--> <?pi?>

<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep22pass6xml [
	"Source file: oasis/p22pass6.xml"

	^ '<?xml version="1.0"?><!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
]><doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep23fail1xml [
	"Source file: oasis/p23fail1.xml"

	^ '<?XML version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep23fail2xml [
	"Source file: oasis/p23fail2.xml"

	^ '<?xml encoding="UTF-8"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep23fail3xml [
	"Source file: oasis/p23fail3.xml"

	^ '<?xml encoding="UTF-8" version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep23fail4xml [
	"Source file: oasis/p23fail4.xml"

	^ '<?xml version="1.0" standalone="yes" encoding="UTF-8"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep23fail5xml [
	"Source file: oasis/p23fail5.xml"

	^ '<?xml version="1.0">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep23pass1xml [
	"Source file: oasis/p23pass1.xml"

	^ '<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep23pass2xml [
	"Source file: oasis/p23pass2.xml"

	^ '<?xml version="1.0" encoding="UTF-8"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep23pass3xml [
	"Source file: oasis/p23pass3.xml"

	^ '<?xml version="1.0" standalone="yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep23pass4xml [
	"Source file: oasis/p23pass4.xml"

	^ '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep24fail1xml [
	"Source file: oasis/p24fail1.xml"

	^ '<?xml version = ''1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep24fail2xml [
	"Source file: oasis/p24fail2.xml"

	^ '<?xml version = "1.0''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep24pass1xml [
	"Source file: oasis/p24pass1.xml"

	^ '<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep24pass2xml [
	"Source file: oasis/p24pass2.xml"

	^ '<?xml version=''1.0''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep24pass3xml [
	"Source file: oasis/p24pass3.xml"

	^ '<?xml


version
=
''1.0''
?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep24pass4xml [
	"Source file: oasis/p24pass4.xml"

	^ '<?xml version = ''1.0''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep25fail1xml [
	"Source file: oasis/p25fail1.xml"

	^ '<?xml version <!--bad comment--> ="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep25pass1xml [
	"Source file: oasis/p25pass1.xml"

	^ '<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep25pass2xml [
	"Source file: oasis/p25pass2.xml"

	^ '<?xml version

	 
=
  

"1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep26fail1xml [
	"Source file: oasis/p26fail1.xml"

	^ '<?xml version="1.0?"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep26fail2xml [
	"Source file: oasis/p26fail2.xml"

	^ '<?xml version="1.0^"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep26pass1xml [
	"Source file: oasis/p26pass1.xml"

	^ '<?xml version="1.0"?>
<!--because we are testing conformace to XML 1.0, there can be no
    exhaustive tests of the VersionNum production.  The only
    VersionNum a 1.0-compliant processor is required to pass
    is "1.0" -->
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep27fail1xml [
	"Source file: oasis/p27fail1.xml"

	^ '<?xml version="1.0"?>
&#32;
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep27pass1xml [
	"Source file: oasis/p27pass1.xml"

	^ '<?xml version="1.0"?>
<!--Non-terminal Misc only appears as Misc*, so we cannot test the fact
    that Misc must match exactly one comment, PI, or S-->
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep27pass2xml [
	"Source file: oasis/p27pass2.xml"

	^ '<?xml version="1.0"?>
<?pi?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep27pass3xml [
	"Source file: oasis/p27pass3.xml"

	^ '<?xml version="1.0"?>

 	

<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep27pass4xml [
	"Source file: oasis/p27pass4.xml"

	^ '<?xml version="1.0"?><?pi?>

 	

<!--comment-->
<?pi?>

 	

<!--comment-->
<?pi?><doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep28fail1xml [
	"Source file: oasis/p28fail1.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc EMPTY>
<doc/>
]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep28pass1xml [
	"Source file: oasis/p28pass1.xml"

	^ '<!DOCTYPE 

doc

[
<!ELEMENT doc EMPTY>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep28pass2xml [
	"Source file: oasis/p28pass2.xml"

	^ '<!DOCTYPE 

doc

[
<!ELEMENT doc EMPTY>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep28pass3xml [
	"Source file: oasis/p28pass3.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % eldecl "<!ELEMENT doc EMPTY>">
%eldecl;
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep28pass4dtd [
	"Source file: oasis/p28pass4.dtd"

	^ '<!ELEMENT doc EMPTY>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep28pass4xml [
	"Source file: oasis/p28pass4.xml"

	^ '<!DOCTYPE doc SYSTEM "p28pass4.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep28pass5dtd [
	"Source file: oasis/p28pass5.dtd"

	^ '%rootdecl;

'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep28pass5xml [
	"Source file: oasis/p28pass5.xml"

	^ '<!DOCTYPE doc SYSTEM "p28pass5.dtd"[
<!--comment-->
<!ENTITY % rootdecl "<!ELEMENT doc (a)>">
<!ELEMENT a EMPTY>
]>
<doc><a/></doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep29fail1xml [
	"Source file: oasis/p29fail1.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc EMPTY>
<!DUNNO should not pass unknown declaration types>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep29pass1xml [
	"Source file: oasis/p29pass1.xml"

	^ '<!DOCTYPE doc [
<?Pi?><!--comment-->
<!ELEMENT doc EMPTY>
<?Pi?><!--comment-->
<!ATTLIST doc att CDATA #IMPLIED>
<?Pi?><!--comment-->
<!ENTITY % ent "">
<?Pi?><!--comment-->
<!NOTATION not PUBLIC "some notation">
<?Pi?><!--comment-->
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep30fail1dtd [
	"Source file: oasis/p30fail1.dtd"

	^ '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!ELEMENT doc EMPTY>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep30fail1xml [
	"Source file: oasis/p30fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p30fail1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep30pass1dtd [
	"Source file: oasis/p30pass1.dtd"

	^ '<!ELEMENT doc EMPTY>


'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep30pass1xml [
	"Source file: oasis/p30pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p30pass1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep30pass2dtd [
	"Source file: oasis/p30pass2.dtd"

	^ '<?xml encoding="UTF-8"?>
<!ELEMENT doc EMPTY>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep30pass2xml [
	"Source file: oasis/p30pass2.xml"

	^ '<!DOCTYPE doc SYSTEM "p30pass2.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep31fail1dtd [
	"Source file: oasis/p31fail1.dtd"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep31fail1xml [
	"Source file: oasis/p31fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p31fail1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep31pass1dtd [
	"Source file: oasis/p31pass1.dtd"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep31pass1xml [
	"Source file: oasis/p31pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p31pass1.dtd" [<!ELEMENT doc EMPTY>]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep31pass2dtd [
	"Source file: oasis/p31pass2.dtd"

	^ '<![INCLUDE[
<!ENTITY % rootel "<!ELEMENT doc EMPTY>">
]]>

%rootel;

<!ATTLIST doc att CDATA #IMPLIED>

<![IGNORE[
<!ELEMENT doc (a)>
]]>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep31pass2xml [
	"Source file: oasis/p31pass2.xml"

	^ '<!DOCTYPE doc SYSTEM "p31pass2.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep32fail1xml [
	"Source file: oasis/p32fail1.xml"

	^ '<?xml version="1.0" standalone=''yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep32fail2xml [
	"Source file: oasis/p32fail2.xml"

	^ '<?xml version="1.0" standalone="yes''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep32fail3xml [
	"Source file: oasis/p32fail3.xml"

	^ '<?xml version="1.0"standalone="yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep32fail4xml [
	"Source file: oasis/p32fail4.xml"

	^ '<?xml version="1.0" standalone=yes?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep32fail5xml [
	"Source file: oasis/p32fail5.xml"

	^ '<?xml version="1.0" standalone="YES"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep32pass1xml [
	"Source file: oasis/p32pass1.xml"

	^ '<?xml version="1.0" standalone="yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep32pass2xml [
	"Source file: oasis/p32pass2.xml"

	^ '<?xml version="1.0" standalone=''no''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep39fail1xml [
	"Source file: oasis/p39fail1.xml"

	^ '<doc>content'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep39fail2xml [
	"Source file: oasis/p39fail2.xml"

	^ '<doc>content</a></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep39fail3xml [
	"Source file: oasis/p39fail3.xml"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep39fail4xml [
	"Source file: oasis/p39fail4.xml"

	^ '<?xml version="1.0">
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep39fail5xml [
	"Source file: oasis/p39fail5.xml"

	^ '<?xml version="1.0">
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
]>

<!--comment-->
<?pi?>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep39pass1xml [
	"Source file: oasis/p39pass1.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep39pass2xml [
	"Source file: oasis/p39pass2.xml"

	^ '<doc>content</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep40fail1xml [
	"Source file: oasis/p40fail1.xml"

	^ '<doc att="val"att2="val2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep40fail2xml [
	"Source file: oasis/p40fail2.xml"

	^ '<3notname></3notname>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep40fail3xml [
	"Source file: oasis/p40fail3.xml"

	^ '<3notname></notname>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep40fail4xml [
	"Source file: oasis/p40fail4.xml"

	^ '< doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep40pass1xml [
	"Source file: oasis/p40pass1.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep40pass2xml [
	"Source file: oasis/p40pass2.xml"

	^ '<doc
 
></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep40pass3xml [
	"Source file: oasis/p40pass3.xml"

	^ '<doc att="val"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep40pass4xml [
	"Source file: oasis/p40pass4.xml"

	^ '<doc att="val" att2="val2"
att3="val3"
></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep41fail1xml [
	"Source file: oasis/p41fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc att (val|val2)>
]>
<doc att=val></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep41fail2xml [
	"Source file: oasis/p41fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc att (val|val2)>
]>
<doc val></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep41fail3xml [
	"Source file: oasis/p41fail3.xml"

	^ '<doc att "val"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep41pass1xml [
	"Source file: oasis/p41pass1.xml"

	^ '<doc att="val"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep41pass2xml [
	"Source file: oasis/p41pass2.xml"

	^ '<doc att
 =
  "val"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep42fail1xml [
	"Source file: oasis/p42fail1.xml"

	^ '<doc></ doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep42fail2xml [
	"Source file: oasis/p42fail2.xml"

	^ '<doc></doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep42fail3xml [
	"Source file: oasis/p42fail3.xml"

	^ '<doc/doc/'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep42pass1xml [
	"Source file: oasis/p42pass1.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep42pass2xml [
	"Source file: oasis/p42pass2.xml"

	^ '<doc></doc  
>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep43fail1xml [
	"Source file: oasis/p43fail1.xml"

	^ '<!DOCTYPE elem
[
<!ELEMENT elem (#PCDATA|elem)*>
<!ENTITY ent "<elem>CharData</elem>">
]>
<elem>
<!ENTITY badent "bad">
</elem>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep43fail2xml [
	"Source file: oasis/p43fail2.xml"

	^ '<!DOCTYPE elem
[
<!ELEMENT elem (#PCDATA|elem)*>
<!ENTITY ent "<elem>CharData</elem>">
]>
<elem>
<![IGNORE[This was valid in SGML, but not XML]]>
</elem>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep43fail3xml [
	"Source file: oasis/p43fail3.xml"

	^ '<!DOCTYPE elem
[
<!ELEMENT elem (#PCDATA|elem)*>
<!ENTITY ent "<elem>CharData</elem>">
]>
<elem>
<![INCLUDE[This was valid in SGML, but not XML]]>
</elem>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep43pass1xml [
	"Source file: oasis/p43pass1.xml"

	^ '<!DOCTYPE elem
[
<!ELEMENT elem (#PCDATA|elem)*>
<!ENTITY ent "<elem>CharData</elem>">
]>
<elem>
CharData&#32;
<!--comment-->
<![CDATA[
<elem>
CharData&#32;
<!--comment-->
<?pi?>&ent;&quot;
CharData
</elem>
]]>
<![CDATA[
<elem>
CharData&#32;
<!--comment-->
<?pi?>&ent;&quot;
CharData
</elem>
]]>
<?pi?>&ent;&quot;
CharData
</elem>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44fail1xml [
	"Source file: oasis/p44fail1.xml"

	^ '< doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44fail2xml [
	"Source file: oasis/p44fail2.xml"

	^ '<doc/ >'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44fail3xml [
	"Source file: oasis/p44fail3.xml"

	^ '<doc --bad comment--/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44fail4xml [
	"Source file: oasis/p44fail4.xml"

	^ '<doc att="val"att2="val2"/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44fail5xml [
	"Source file: oasis/p44fail5.xml"

	^ '<doc att="val" att="val"/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44pass1xml [
	"Source file: oasis/p44pass1.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44pass2xml [
	"Source file: oasis/p44pass2.xml"

	^ '<doc att="val"/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44pass3xml [
	"Source file: oasis/p44pass3.xml"

	^ '<doc att="val"


/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44pass4xml [
	"Source file: oasis/p44pass4.xml"

	^ '<doc
  
/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep44pass5xml [
	"Source file: oasis/p44pass5.xml"

	^ '<doc att="val"
att2="val2" att3="val3"/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep45fail1xml [
	"Source file: oasis/p45fail1.xml"

	^ '<!DOCTYPE doc
[
<!element doc EMPTY>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep45fail2xml [
	"Source file: oasis/p45fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc(#PCDATA)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep45fail3xml [
	"Source file: oasis/p45fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT (doc|a) (#PCDATA)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep45fail4xml [
	"Source file: oasis/p45fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA) --bad comment-->
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep45pass1xml [
	"Source file: oasis/p45pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT
a ANY
>
<!ELEMENT c (#PCDATA)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep46fail1xml [
	"Source file: oasis/p46fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (#EMPTY)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep46fail2xml [
	"Source file: oasis/p46fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (#PCDATA) +(doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep46fail3xml [
	"Source file: oasis/p46fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (#PCDATA) -(doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep46fail4xml [
	"Source file: oasis/p46fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc) +>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep46fail5xml [
	"Source file: oasis/p46fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (#PCDATA)(doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep46fail6xml [
	"Source file: oasis/p46fail6.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a EMPTY (doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep46pass1xml [
	"Source file: oasis/p46pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a EMPTY>
<!ELEMENT b (#PCDATA)*>
<!ELEMENT c (a,b)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep47fail1xml [
	"Source file: oasis/p47fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc,a?|a?)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep47fail2xml [
	"Source file: oasis/p47fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc)->
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep47fail3xml [
	"Source file: oasis/p47fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a *(doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep47fail4xml [
	"Source file: oasis/p47fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc) ?>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep47pass1xml [
	"Source file: oasis/p47pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc,a?)>
<!ELEMENT b (doc|a)>
<!ELEMENT c (a,b)?>
<!ELEMENT d (a|b)? >
<!ELEMENT e (a,b)* >
<!ELEMENT f (a,b)+ >
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep48fail1xml [
	"Source file: oasis/p48fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc *)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep48fail2xml [
	"Source file: oasis/p48fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a ((doc|a?) +)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep48pass1xml [
	"Source file: oasis/p48pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc)>
<!ELEMENT b ((doc|a?))>
<!ELEMENT c ((a,b))>
<!ELEMENT d (doc*)>
<!ELEMENT e (doc+)>
<!ELEMENT f (doc?)>
<!ELEMENT g ((a,b)*)>
<!ELEMENT h ((a,b)?)>
<!ELEMENT i ((a,b)+)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep49fail1xml [
	"Source file: oasis/p49fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc|a?,a?)>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep49pass1xml [
	"Source file: oasis/p49pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!--NOTE: XML doesn''t specify whether this is a choice or a seq-->
<!ELEMENT a (doc?)>
<!ELEMENT b (doc|a)>
<!ELEMENT c (
doc
|
a
|
c?
)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep50fail1xml [
	"Source file: oasis/p50fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc,a?|a?)>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep50pass1xml [
	"Source file: oasis/p50pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!--NOTE: XML doesn''t specify whether this is a choice or a seq-->
<!ELEMENT a (doc?)>
<!ELEMENT b (doc,a)>
<!ELEMENT c (
doc
,
a
,
c?
)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep51fail1xml [
	"Source file: oasis/p51fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)?>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep51fail2xml [
	"Source file: oasis/p51fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)+>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep51fail3xml [
	"Source file: oasis/p51fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (doc|#PCDATA)*>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep51fail4xml [
	"Source file: oasis/p51fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (#PCDATA|doc)?>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep51fail5xml [
	"Source file: oasis/p51fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (#PCDATA|doc,a?)*>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep51fail6xml [
	"Source file: oasis/p51fail6.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (#PCDATA,doc,a?)*>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep51fail7xml [
	"Source file: oasis/p51fail7.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (#PCDATA|(doc|a))*>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep51pass1xml [
	"Source file: oasis/p51pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (#PCDATA|doc)*>
<!ELEMENT b (
#PCDATA
|
doc
|
a
|
b
)*>
<!ELEMENT c (#PCDATA)*>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep52fail1xml [
	"Source file: oasis/p52fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST  >
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep52fail2xml [
	"Source file: oasis/p52fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep52pass1xml [
	"Source file: oasis/p52pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA|a|b|c|d)*>
<!ELEMENT a EMPTY>
<!ELEMENT b EMPTY>
<!ELEMENT c EMPTY>
<!ELEMENT d EMPTY>
<!ATTLIST a>
<!ATTLIST b >
<!ATTLIST c att CDATA #IMPLIED>
<!ATTLIST d att CDATA #IMPLIED>
<!ATTLIST
c att CDATA
 #IMPLIED
att2
 CDATA
 "second declaration is OK"
att2 CDATA
 #REQUIRED
 >
<!ATTLIST d>
]>
<doc><c/><c att2="test"/></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep53fail1xml [
	"Source file: oasis/p53fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att CDATA#IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep53fail2xml [
	"Source file: oasis/p53fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att(a|b) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep53fail3xml [
	"Source file: oasis/p53fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep53fail4xml [
	"Source file: oasis/p53fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att CDATA>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep53fail5xml [
	"Source file: oasis/p53fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc (a|b) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep53pass1xml [
	"Source file: oasis/p53pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att CDATA #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep54fail1xml [
	"Source file: oasis/p54fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att DUNNO #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep54pass1xml [
	"Source file: oasis/p54pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (a|b|c)*>
<!ELEMENT a EMPTY>
<!ELEMENT b EMPTY>
<!ELEMENT c EMPTY>
<!ATTLIST a att CDATA #IMPLIED>
<!ATTLIST b att NMTOKENS #IMPLIED>
<!ATTLIST c att (a|b) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep55fail1xml [
	"Source file: oasis/p55fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att cdata #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep55pass1xml [
	"Source file: oasis/p55pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att CDATA #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep56fail1xml [
	"Source file: oasis/p56fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att IDS #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep56fail2xml [
	"Source file: oasis/p56fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att NUMBER #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep56fail3xml [
	"Source file: oasis/p56fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att NAME #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep56fail4xml [
	"Source file: oasis/p56fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att ENTITYS #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep56fail5xml [
	"Source file: oasis/p56fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att id #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep56pass1xml [
	"Source file: oasis/p56pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (a|b|c|d|e|f|g)*>
<!ELEMENT a EMPTY>
<!ELEMENT b EMPTY>
<!ELEMENT c EMPTY>
<!ELEMENT d EMPTY>
<!ELEMENT e EMPTY>
<!ELEMENT f EMPTY>
<!ELEMENT g EMPTY>
<!ATTLIST a att ID #IMPLIED>
<!ATTLIST b att IDREF #IMPLIED>
<!ATTLIST c att IDREFS #IMPLIED>
<!ATTLIST d att ENTITY #IMPLIED>
<!ATTLIST e att ENTITIES #IMPLIED>
<!ATTLIST f att NMTOKEN #IMPLIED>
<!ATTLIST g att NMTOKENS #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep57fail1xml [
	"Source file: oasis/p57fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att NMTOKEN (a|b) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep57pass1xml [
	"Source file: oasis/p57pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (a|b)*>
<!ELEMENT a ANY>
<!ELEMENT b ANY>
<!NOTATION a SYSTEM "a">
<!ATTLIST a att (a|b) #IMPLIED>
<!ATTLIST b att NOTATION (a|b) #IMPLIED>
<!NOTATION b SYSTEM "b">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep58fail1xml [
	"Source file: oasis/p58fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION a SYSTEM "a">
<!NOTATION b SYSTEM "b">
<!ATTLIST doc att NOTATION () #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep58fail2xml [
	"Source file: oasis/p58fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION a SYSTEM "a">
<!NOTATION b SYSTEM "b">
<!ATTLIST doc att NOTATION (a,b) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep58fail3xml [
	"Source file: oasis/p58fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION a SYSTEM "a">
<!--should fail at this AttlistDecl, before NOTATION decl-->
<!ATTLIST doc att NOTATION (a|0b) #IMPLIED>



<!NOTATION 0b SYSTEM "0b">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep58fail4xml [
	"Source file: oasis/p58fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION a SYSTEM "a">
<!NOTATION b SYSTEM "b">
<!ATTLIST doc att notation (a|b) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep58fail5xml [
	"Source file: oasis/p58fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION a SYSTEM "a">
<!NOTATION b SYSTEM "b">
<!ATTLIST doc att NOTATION(a|b) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep58fail6xml [
	"Source file: oasis/p58fail6.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION a SYSTEM "a">
<!ATTLIST doc att NOTATION a #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep58fail7xml [
	"Source file: oasis/p58fail7.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION a SYSTEM "a">
<!ATTLIST doc att NOTATION "a" #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep58fail8xml [
	"Source file: oasis/p58fail8.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION a SYSTEM "a">
<!ATTLIST doc att NOTATION ("a") #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep58pass1xml [
	"Source file: oasis/p58pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (a|b)*>
<!ELEMENT a ANY>
<!ELEMENT b ANY>
<!NOTATION a SYSTEM "a">
<!NOTATION b SYSTEM "b">
<!ATTLIST a att NOTATION (a) #IMPLIED>
<!ATTLIST b att NOTATION ( a | b ) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep59fail1xml [
	"Source file: oasis/p59fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att () #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep59fail2xml [
	"Source file: oasis/p59fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att (a,b) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep59fail3xml [
	"Source file: oasis/p59fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att ("a") #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep59pass1xml [
	"Source file: oasis/p59pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (a|b)*>
<!ELEMENT a EMPTY>
<!ELEMENT b EMPTY>
<!ATTLIST a att (a) #IMPLIED>
<!ATTLIST b att ( a | b ) #IMPLIED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep60fail1xml [
	"Source file: oasis/p60fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att CDATA #implied>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep60fail2xml [
	"Source file: oasis/p60fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att CDATA #FIXED"value">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep60fail3xml [
	"Source file: oasis/p60fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att CDATA #REQUIRED "value">
]>
<doc att="value"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep60fail4xml [
	"Source file: oasis/p60fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att CDATA #FIXED>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep60fail5xml [
	"Source file: oasis/p60fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att CDATA #IMPLIED #REQUIRED>
]>
<doc att="value"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep60pass1xml [
	"Source file: oasis/p60pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (a|b|c|d)*>
<!ELEMENT a EMPTY>
<!ELEMENT b EMPTY>
<!ELEMENT c EMPTY>
<!ELEMENT d EMPTY>
<!ATTLIST a att CDATA #REQUIRED>
<!ATTLIST b att CDATA #IMPLIED>
<!ATTLIST c att CDATA #FIXED "value">
<!ATTLIST d att CDATA ''default''>
]>
<doc><c/><c att="value"/></doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep61fail1dtd [
	"Source file: oasis/p61fail1.dtd"

	^ '<!ELEMENT doc EMPTY>
<![TEMP[
<!ATTLIST doc att CDATA #IMPLIED>
]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep61fail1xml [
	"Source file: oasis/p61fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p61fail1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep61pass1dtd [
	"Source file: oasis/p61pass1.dtd"

	^ '<![INCLUDE[<![INCLUDE[
<![IGNORE[ ignored ]]>
<!ELEMENT doc EMPTY>
]]>]]>
<![IGNORE[ ignored ]]>
<![IGNORE[ <!ELEMENT doc ignored ]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep61pass1xml [
	"Source file: oasis/p61pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p61pass1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep62fail1dtd [
	"Source file: oasis/p62fail1.dtd"

	^ '<![include[
<!ELEMENT doc EMPTY>
]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep62fail1xml [
	"Source file: oasis/p62fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p62fail1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep62fail2dtd [
	"Source file: oasis/p62fail2.dtd"

	^ '<![INCLUDE[
<!ELEMENT doc EMPTY>
] ]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep62fail2xml [
	"Source file: oasis/p62fail2.xml"

	^ '<!DOCTYPE doc SYSTEM "p62fail2.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep62pass1dtd [
	"Source file: oasis/p62pass1.dtd"

	^ '<![INCLUDE[
<![
INCLUDE
[
<!ELEMENT doc EMPTY>
<![IGNORE[asdfasdf]]>
]]>]]>
<![INCLUDE[]]>
<![INCLUDE[
]]>
<![INCLUDE[ ]]>

'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep62pass1xml [
	"Source file: oasis/p62pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p62pass1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep63fail1dtd [
	"Source file: oasis/p63fail1.dtd"

	^ '<!ELEMENT doc EMPTY>
<![ignore[]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep63fail1xml [
	"Source file: oasis/p63fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p63fail1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep63fail2dtd [
	"Source file: oasis/p63fail2.dtd"

	^ '<!ELEMENT doc EMPTY>
<![IGNORE[<![]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep63fail2xml [
	"Source file: oasis/p63fail2.xml"

	^ '<!DOCTYPE doc SYSTEM "p63fail2.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep63pass1dtd [
	"Source file: oasis/p63pass1.dtd"

	^ '<!ELEMENT doc EMPTY>
<![IGNORE[
<![INCLUDE[
<!ELEMENT doc
]]>]]>
<![
IGNORE
[
]]>
<![IGNORE[]]>
<![IGNORE[ ]]>
<![IGNORE[
]]>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep63pass1xml [
	"Source file: oasis/p63pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p63pass1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep64fail1dtd [
	"Source file: oasis/p64fail1.dtd"

	^ '<!ELEMENT doc EMPTY>
<![IGNORE[ ends must balance ]]>]]>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep64fail1xml [
	"Source file: oasis/p64fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p64fail1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep64fail2dtd [
	"Source file: oasis/p64fail2.dtd"

	^ '<!ELEMENT doc EMPTY>
<![IGNORE[ <![ starts must balance ]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep64fail2xml [
	"Source file: oasis/p64fail2.xml"

	^ '<!DOCTYPE doc SYSTEM "p64fail2.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep64pass1dtd [
	"Source file: oasis/p64pass1.dtd"

	^ '<!ELEMENT doc EMPTY>
<![IGNORE[
Everything is ignored within an ignored section, except the
sub-section delimiters ''<!['' and '']]>''.  These must be balanced,
but it is no section keyword is required:
<![]]>
<![DUNNO[ ]]>
<![INCLUDE[
asdfasdfasdf
<!OK
]]>
] ]> ]] > ]]>
<![IGNORE[ < ![ <! [ <![]]>]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep64pass1xml [
	"Source file: oasis/p64pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p64pass1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep66fail1xml [
	"Source file: oasis/p66fail1.xml"

	^ '<doc>&#65</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep66fail2xml [
	"Source file: oasis/p66fail2.xml"

	^ '<doc>&# 65;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep66fail3xml [
	"Source file: oasis/p66fail3.xml"

	^ '<doc>&#A;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep66fail4xml [
	"Source file: oasis/p66fail4.xml"

	^ '<doc>&#x4G;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep66fail5xml [
	"Source file: oasis/p66fail5.xml"

	^ '<doc>&#5;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep66fail6xml [
	"Source file: oasis/p66fail6.xml"

	^ '<doc>&#xd802;&#xdc02;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep66pass1xml [
	"Source file: oasis/p66pass1.xml"

	^ '<doc>
&#65;&#9;&#x41;&#x4f;&#x4F;&#0000000000000000009;
&#x10F2ec;&#xa;
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep68fail1xml [
	"Source file: oasis/p68fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY ent "replacement text">
]>
<doc>
&ent
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep68fail2xml [
	"Source file: oasis/p68fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY ent "replacement text">
]>
<doc>
& ent;
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep68fail3xml [
	"Source file: oasis/p68fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY ent "replacement text">
]>
<doc>
&ent ;
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep68pass1xml [
	"Source file: oasis/p68pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY ent "replacement text">
]>
<doc>
&ent;aaa&ent;
<!--Not a reference:-->
<!--Charref to & doesn''t make a delimiter-->
&#38;en
</doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep69fail1xml [
	"Source file: oasis/p69fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % pe "<!---->">
%pe<!---->
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep69fail2xml [
	"Source file: oasis/p69fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % pe "<!---->">
% pe;
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep69fail3xml [
	"Source file: oasis/p69fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % pe "<!---->">
%pe ;
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep69pass1xml [
	"Source file: oasis/p69pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % pe "<!---->">
%pe;<!---->%pe;
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep70fail1xml [
	"Source file: oasis/p70fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY & bad "replacement text">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep70pass1xml [
	"Source file: oasis/p70pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY ge "replacement text">
<!ENTITY % pe "<!-- replacement decl -->">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep71fail1xml [
	"Source file: oasis/p71fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY ge"replacement text">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep71fail2xml [
	"Source file: oasis/p71fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY -ge "replacement text">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep71fail3xml [
	"Source file: oasis/p71fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<! ENTITY ge "replacement text">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep71fail4xml [
	"Source file: oasis/p71fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITYge "replacement text">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep71pass1xml [
	"Source file: oasis/p71pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY ge "replacement text">
<!ENTITY
 ge2
 "replacement text"
 >
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep72fail1xml [
	"Source file: oasis/p72fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY% pe "<!--replacement decl-->">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep72fail2xml [
	"Source file: oasis/p72fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY %pe "<!--replacement decl-->">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep72fail3xml [
	"Source file: oasis/p72fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % pe"<!--replacement decl-->">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep72fail4xml [
	"Source file: oasis/p72fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % .pe "<!--replacement decl-->">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep72pass1xml [
	"Source file: oasis/p72pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % pe "<!--replacement decl-->">
<!ENTITY
  %
  pe2
  "<!--replacement decl-->"
  >
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep73fail1xml [
	"Source file: oasis/p73fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge CDATA "replacement text">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep73fail2xml [
	"Source file: oasis/p73fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge "replacement text" "more text">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep73fail3xml [
	"Source file: oasis/p73fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge "replacement text" NDATA unknot>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep73fail4xml [
	"Source file: oasis/p73fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge >
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep73fail5xml [
	"Source file: oasis/p73fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge NDATA unknot>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep73pass1xml [
	"Source file: oasis/p73pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge "replacement text">
<!ENTITY ge2 SYSTEM "nop.ent">
<!ENTITY ge3 SYSTEM "nop.ent" NDATA unknot>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep74fail1xml [
	"Source file: oasis/p74fail1.xml"

	^ '<!DOCTYPE doc
[
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY % pe SYSTEM "nop.ent" NDATA unknot>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep74fail2xml [
	"Source file: oasis/p74fail2.xml"

	^ '<!DOCTYPE doc
[
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY % pe>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep74fail3xml [
	"Source file: oasis/p74fail3.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY % pe "<!--decl1-->" SYSTEM "nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep74pass1xml [
	"Source file: oasis/p74pass1.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY % pe "<!--replacement decl-->">
<!ENTITY % pe2 SYSTEM "nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep75fail1xml [
	"Source file: oasis/p75fail1.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent PUBLIC"PublicID" "nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep75fail2xml [
	"Source file: oasis/p75fail2.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent SYSTEM"nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep75fail3xml [
	"Source file: oasis/p75fail3.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent PUBLIC "PublicID""nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep75fail4xml [
	"Source file: oasis/p75fail4.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent SYSTEM "PublicID" "nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep75fail5xml [
	"Source file: oasis/p75fail5.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent PUBLIC "PublicID" SYSTEM "nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep75fail6xml [
	"Source file: oasis/p75fail6.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent PUBLIC "PublicID">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep75pass1xml [
	"Source file: oasis/p75pass1.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent SYSTEM "nop.ent">
<!ENTITY ent2 PUBLIC "PublicID" "nop.ent">
<!ENTITY ent3 PUBLIC
              "PublicID"
              "nop.ent"
              >
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep76fail1xml [
	"Source file: oasis/p76fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge SYSTEM "nop.ent"NDATA unknot>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep76fail2xml [
	"Source file: oasis/p76fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge SYSTEM "nop.ent" ndata unknot>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep76fail3xml [
	"Source file: oasis/p76fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge SYSTEM "nop.ent" NDATA>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep76fail4xml [
	"Source file: oasis/p76fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!--error should be reported here, not at <!Notation-->
<!ENTITY ge SYSTEM "nop.ent" NDATA -unknot>
<!NOTATION -unknot PUBLIC "Unknown">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTests class >> sourcep76pass1xml [
	"Source file: oasis/p76pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge SYSTEM "nop.ent" NDATA unknot>
<!ENTITY ge2 SYSTEM "nop.ent"
  NDATA
  unknot
  >
]>
<doc/>
'
]

{ #category : #tests }
XMLConformanceOasisTests >> teste2xml [
	"Source file: oasis/e2.xml"

	(self isSkippableTest: #teste2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcee2xml
				documentURI: 'e2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp01fail1xml [
	"Source file: oasis/p01fail1.xml"

	(self isSkippableTest: #testp01fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep01fail1xml
				documentURI: 'p01fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp01fail2xml [
	"Source file: oasis/p01fail2.xml"

	(self isSkippableTest: #testp01fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep01fail2xml
				documentURI: 'p01fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp01fail3xml [
	"Source file: oasis/p01fail3.xml"

	(self isSkippableTest: #testp01fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep01fail3xml
				documentURI: 'p01fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp01fail4xml [
	"Source file: oasis/p01fail4.xml"

	(self isSkippableTest: #testp01fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep01fail4xml
				documentURI: 'p01fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp01pass1xml [
	"Source file: oasis/p01pass1.xml"

	(self isSkippableTest: #testp01pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep01pass1xml
				documentURI: 'p01pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp01pass2xml [
	"Source file: oasis/p01pass2.xml"

	(self isSkippableTest: #testp01pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep01pass2xml
				documentURI: 'p01pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp01pass3xml [
	"Source file: oasis/p01pass3.xml"

	(self isSkippableTest: #testp01pass3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep01pass3xml
				documentURI: 'p01pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail10xml [
	"Source file: oasis/p03fail10.xml"

	(self isSkippableTest: #testp03fail10xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail10xml
				documentURI: 'p03fail10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail11xml [
	"Source file: oasis/p03fail11.xml"

	(self isSkippableTest: #testp03fail11xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail11xml
				documentURI: 'p03fail11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail12xml [
	"Source file: oasis/p03fail12.xml"

	(self isSkippableTest: #testp03fail12xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail12xml
				documentURI: 'p03fail12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail13xml [
	"Source file: oasis/p03fail13.xml"

	(self isSkippableTest: #testp03fail13xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail13xml
				documentURI: 'p03fail13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail14xml [
	"Source file: oasis/p03fail14.xml"

	(self isSkippableTest: #testp03fail14xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail14xml
				documentURI: 'p03fail14.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail15xml [
	"Source file: oasis/p03fail15.xml"

	(self isSkippableTest: #testp03fail15xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail15xml
				documentURI: 'p03fail15.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail16xml [
	"Source file: oasis/p03fail16.xml"

	(self isSkippableTest: #testp03fail16xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail16xml
				documentURI: 'p03fail16.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail17xml [
	"Source file: oasis/p03fail17.xml"

	(self isSkippableTest: #testp03fail17xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail17xml
				documentURI: 'p03fail17.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail18xml [
	"Source file: oasis/p03fail18.xml"

	(self isSkippableTest: #testp03fail18xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail18xml
				documentURI: 'p03fail18.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail19xml [
	"Source file: oasis/p03fail19.xml"

	(self isSkippableTest: #testp03fail19xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail19xml
				documentURI: 'p03fail19.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail1xml [
	"Source file: oasis/p03fail1.xml"

	(self isSkippableTest: #testp03fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail1xml
				documentURI: 'p03fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail20xml [
	"Source file: oasis/p03fail20.xml"

	(self isSkippableTest: #testp03fail20xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail20xml
				documentURI: 'p03fail20.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail21xml [
	"Source file: oasis/p03fail21.xml"

	(self isSkippableTest: #testp03fail21xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail21xml
				documentURI: 'p03fail21.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail22xml [
	"Source file: oasis/p03fail22.xml"

	(self isSkippableTest: #testp03fail22xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail22xml
				documentURI: 'p03fail22.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail23xml [
	"Source file: oasis/p03fail23.xml"

	(self isSkippableTest: #testp03fail23xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail23xml
				documentURI: 'p03fail23.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail24xml [
	"Source file: oasis/p03fail24.xml"

	(self isSkippableTest: #testp03fail24xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail24xml
				documentURI: 'p03fail24.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail25xml [
	"Source file: oasis/p03fail25.xml"

	(self isSkippableTest: #testp03fail25xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail25xml
				documentURI: 'p03fail25.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail26xml [
	"Source file: oasis/p03fail26.xml"

	(self isSkippableTest: #testp03fail26xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail26xml
				documentURI: 'p03fail26.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail27xml [
	"Source file: oasis/p03fail27.xml"

	(self isSkippableTest: #testp03fail27xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail27xml
				documentURI: 'p03fail27.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail28xml [
	"Source file: oasis/p03fail28.xml"

	(self isSkippableTest: #testp03fail28xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail28xml
				documentURI: 'p03fail28.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail29xml [
	"Source file: oasis/p03fail29.xml"

	(self isSkippableTest: #testp03fail29xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail29xml
				documentURI: 'p03fail29.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail2xml [
	"Source file: oasis/p03fail2.xml"

	(self isSkippableTest: #testp03fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail2xml
				documentURI: 'p03fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail3xml [
	"Source file: oasis/p03fail3.xml"

	(self isSkippableTest: #testp03fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail3xml
				documentURI: 'p03fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail4xml [
	"Source file: oasis/p03fail4.xml"

	(self isSkippableTest: #testp03fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail4xml
				documentURI: 'p03fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail5xml [
	"Source file: oasis/p03fail5.xml"

	(self isSkippableTest: #testp03fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail5xml
				documentURI: 'p03fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail7xml [
	"Source file: oasis/p03fail7.xml"

	(self isSkippableTest: #testp03fail7xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail7xml
				documentURI: 'p03fail7.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail8xml [
	"Source file: oasis/p03fail8.xml"

	(self isSkippableTest: #testp03fail8xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail8xml
				documentURI: 'p03fail8.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp03fail9xml [
	"Source file: oasis/p03fail9.xml"

	(self isSkippableTest: #testp03fail9xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep03fail9xml
				documentURI: 'p03fail9.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp03pass1xml [
	"Source file: oasis/p03pass1.xml"

	(self isSkippableTest: #testp03pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep03pass1xml
				documentURI: 'p03pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp04fail1xml [
	"Source file: oasis/p04fail1.xml"

	(self isSkippableTest: #testp04fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep04fail1xml
				documentURI: 'p04fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp04fail2xml [
	"Source file: oasis/p04fail2.xml"

	(self isSkippableTest: #testp04fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep04fail2xml
				documentURI: 'p04fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp04fail3xml [
	"Source file: oasis/p04fail3.xml"

	(self isSkippableTest: #testp04fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep04fail3xml
				documentURI: 'p04fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp04pass1xml [
	"Source file: oasis/p04pass1.xml"

	(self isSkippableTest: #testp04pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep04pass1xml
				documentURI: 'p04pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp05fail1xml [
	"Source file: oasis/p05fail1.xml"

	(self isSkippableTest: #testp05fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep05fail1xml
				documentURI: 'p05fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp05fail2xml [
	"Source file: oasis/p05fail2.xml"

	(self isSkippableTest: #testp05fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep05fail2xml
				documentURI: 'p05fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp05fail3xml [
	"Source file: oasis/p05fail3.xml"

	(self isSkippableTest: #testp05fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep05fail3xml
				documentURI: 'p05fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp05fail4xml [
	"Source file: oasis/p05fail4.xml"

	(self isSkippableTest: #testp05fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep05fail4xml
				documentURI: 'p05fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp05fail5xml [
	"Source file: oasis/p05fail5.xml"

	(self isSkippableTest: #testp05fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep05fail5xml
				documentURI: 'p05fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp05pass1xml [
	"Source file: oasis/p05pass1.xml"

	(self isSkippableTest: #testp05pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep05pass1xml
				documentURI: 'p05pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp06fail1xml [
	"Source file: oasis/p06fail1.xml"

	(self isSkippableTest: #testp06fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep06fail1xml
				documentURI: 'p06fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp06pass1xml [
	"Source file: oasis/p06pass1.xml"

	(self isSkippableTest: #testp06pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep06pass1xml
				documentURI: 'p06pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp07pass1xml [
	"Source file: oasis/p07pass1.xml"

	(self isSkippableTest: #testp07pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep07pass1xml
				documentURI: 'p07pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp08fail1xml [
	"Source file: oasis/p08fail1.xml"

	(self isSkippableTest: #testp08fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep08fail1xml
				documentURI: 'p08fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp08fail2xml [
	"Source file: oasis/p08fail2.xml"

	(self isSkippableTest: #testp08fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep08fail2xml
				documentURI: 'p08fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp08pass1xml [
	"Source file: oasis/p08pass1.xml"

	(self isSkippableTest: #testp08pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep08pass1xml
				documentURI: 'p08pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp09fail1xml [
	"Source file: oasis/p09fail1.xml"

	(self isSkippableTest: #testp09fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep09fail1xml
				documentURI: 'p09fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp09fail2xml [
	"Source file: oasis/p09fail2.xml"

	(self isSkippableTest: #testp09fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep09fail2xml
				documentURI: 'p09fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp09fail3xml [
	"Source file: oasis/p09fail3.xml"

	(self isSkippableTest: #testp09fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep09fail3xml
				documentURI: 'p09fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp09fail4xml [
	"Source file: oasis/p09fail4.xml"

	(self isSkippableTest: #testp09fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep09fail4xml
				documentURI: 'p09fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp09fail5xml [
	"Source file: oasis/p09fail5.xml"

	(self isSkippableTest: #testp09fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep09fail5xml
				documentURI: 'p09fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp09pass1xml [
	"Source file: oasis/p09pass1.xml"

	(self isSkippableTest: #testp09pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep09pass1xml
				documentURI: 'p09pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp10fail1xml [
	"Source file: oasis/p10fail1.xml"

	(self isSkippableTest: #testp10fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep10fail1xml
				documentURI: 'p10fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp10fail2xml [
	"Source file: oasis/p10fail2.xml"

	(self isSkippableTest: #testp10fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep10fail2xml
				documentURI: 'p10fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp10fail3xml [
	"Source file: oasis/p10fail3.xml"

	(self isSkippableTest: #testp10fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep10fail3xml
				documentURI: 'p10fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp10pass1xml [
	"Source file: oasis/p10pass1.xml"

	(self isSkippableTest: #testp10pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep10pass1xml
				documentURI: 'p10pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp11fail1xml [
	"Source file: oasis/p11fail1.xml"

	(self isSkippableTest: #testp11fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep11fail1xml
				documentURI: 'p11fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp11fail2xml [
	"Source file: oasis/p11fail2.xml"

	(self isSkippableTest: #testp11fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep11fail2xml
				documentURI: 'p11fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp11pass1xml [
	"Source file: oasis/p11pass1.xml"

	(self isSkippableTest: #testp11pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep11pass1xml
				documentURI: 'p11pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp12fail1xml [
	"Source file: oasis/p12fail1.xml"

	(self isSkippableTest: #testp12fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep12fail1xml
				documentURI: 'p12fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp12fail2xml [
	"Source file: oasis/p12fail2.xml"

	(self isSkippableTest: #testp12fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep12fail2xml
				documentURI: 'p12fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp12fail3xml [
	"Source file: oasis/p12fail3.xml"

	(self isSkippableTest: #testp12fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep12fail3xml
				documentURI: 'p12fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp12fail4xml [
	"Source file: oasis/p12fail4.xml"

	(self isSkippableTest: #testp12fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep12fail4xml
				documentURI: 'p12fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp12fail5xml [
	"Source file: oasis/p12fail5.xml"

	(self isSkippableTest: #testp12fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep12fail5xml
				documentURI: 'p12fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp12fail6xml [
	"Source file: oasis/p12fail6.xml"

	(self isSkippableTest: #testp12fail6xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep12fail6xml
				documentURI: 'p12fail6.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp12fail7xml [
	"Source file: oasis/p12fail7.xml"

	(self isSkippableTest: #testp12fail7xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep12fail7xml
				documentURI: 'p12fail7.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp12pass1xml [
	"Source file: oasis/p12pass1.xml"

	(self isSkippableTest: #testp12pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep12pass1xml
				documentURI: 'p12pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp14fail1xml [
	"Source file: oasis/p14fail1.xml"

	(self isSkippableTest: #testp14fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep14fail1xml
				documentURI: 'p14fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp14fail2xml [
	"Source file: oasis/p14fail2.xml"

	(self isSkippableTest: #testp14fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep14fail2xml
				documentURI: 'p14fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp14fail3xml [
	"Source file: oasis/p14fail3.xml"

	(self isSkippableTest: #testp14fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep14fail3xml
				documentURI: 'p14fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp14pass1xml [
	"Source file: oasis/p14pass1.xml"

	(self isSkippableTest: #testp14pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep14pass1xml
				documentURI: 'p14pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp15fail1xml [
	"Source file: oasis/p15fail1.xml"

	(self isSkippableTest: #testp15fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep15fail1xml
				documentURI: 'p15fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp15fail2xml [
	"Source file: oasis/p15fail2.xml"

	(self isSkippableTest: #testp15fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep15fail2xml
				documentURI: 'p15fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp15fail3xml [
	"Source file: oasis/p15fail3.xml"

	(self isSkippableTest: #testp15fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep15fail3xml
				documentURI: 'p15fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp15pass1xml [
	"Source file: oasis/p15pass1.xml"

	(self isSkippableTest: #testp15pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep15pass1xml
				documentURI: 'p15pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp16fail1xml [
	"Source file: oasis/p16fail1.xml"

	(self isSkippableTest: #testp16fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep16fail1xml
				documentURI: 'p16fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp16fail2xml [
	"Source file: oasis/p16fail2.xml"

	(self isSkippableTest: #testp16fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep16fail2xml
				documentURI: 'p16fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp16fail3xml [
	"Source file: oasis/p16fail3.xml"

	(self isSkippableTest: #testp16fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep16fail3xml
				documentURI: 'p16fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp16pass1xml [
	"Source file: oasis/p16pass1.xml"

	(self isSkippableTest: #testp16pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep16pass1xml
				documentURI: 'p16pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp16pass2xml [
	"Source file: oasis/p16pass2.xml"

	(self isSkippableTest: #testp16pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep16pass2xml
				documentURI: 'p16pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp16pass3xml [
	"Source file: oasis/p16pass3.xml"

	(self isSkippableTest: #testp16pass3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep16pass3xml
				documentURI: 'p16pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp18fail1xml [
	"Source file: oasis/p18fail1.xml"

	(self isSkippableTest: #testp18fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep18fail1xml
				documentURI: 'p18fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp18fail2xml [
	"Source file: oasis/p18fail2.xml"

	(self isSkippableTest: #testp18fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep18fail2xml
				documentURI: 'p18fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp18fail3xml [
	"Source file: oasis/p18fail3.xml"

	(self isSkippableTest: #testp18fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep18fail3xml
				documentURI: 'p18fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp18pass1xml [
	"Source file: oasis/p18pass1.xml"

	(self isSkippableTest: #testp18pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep18pass1xml
				documentURI: 'p18pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp22fail1xml [
	"Source file: oasis/p22fail1.xml"

	(self isSkippableTest: #testp22fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep22fail1xml
				documentURI: 'p22fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp22fail2xml [
	"Source file: oasis/p22fail2.xml"

	(self isSkippableTest: #testp22fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep22fail2xml
				documentURI: 'p22fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp22pass1xml [
	"Source file: oasis/p22pass1.xml"

	(self isSkippableTest: #testp22pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass1xml
				documentURI: 'p22pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp22pass2xml [
	"Source file: oasis/p22pass2.xml"

	(self isSkippableTest: #testp22pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass2xml
				documentURI: 'p22pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp22pass3xml [
	"Source file: oasis/p22pass3.xml"

	(self isSkippableTest: #testp22pass3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass3xml
				documentURI: 'p22pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp22pass4xml [
	"Source file: oasis/p22pass4.xml"

	(self isSkippableTest: #testp22pass4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass4xml
				documentURI: 'p22pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp22pass5xml [
	"Source file: oasis/p22pass5.xml"

	(self isSkippableTest: #testp22pass5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass5xml
				documentURI: 'p22pass5.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp22pass6xml [
	"Source file: oasis/p22pass6.xml"

	(self isSkippableTest: #testp22pass6xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass6xml
				documentURI: 'p22pass6.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp23fail1xml [
	"Source file: oasis/p23fail1.xml"

	(self isSkippableTest: #testp23fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep23fail1xml
				documentURI: 'p23fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp23fail2xml [
	"Source file: oasis/p23fail2.xml"

	(self isSkippableTest: #testp23fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep23fail2xml
				documentURI: 'p23fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp23fail3xml [
	"Source file: oasis/p23fail3.xml"

	(self isSkippableTest: #testp23fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep23fail3xml
				documentURI: 'p23fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp23fail4xml [
	"Source file: oasis/p23fail4.xml"

	(self isSkippableTest: #testp23fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep23fail4xml
				documentURI: 'p23fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp23fail5xml [
	"Source file: oasis/p23fail5.xml"

	(self isSkippableTest: #testp23fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep23fail5xml
				documentURI: 'p23fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp23pass1xml [
	"Source file: oasis/p23pass1.xml"

	(self isSkippableTest: #testp23pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep23pass1xml
				documentURI: 'p23pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp23pass2xml [
	"Source file: oasis/p23pass2.xml"

	(self isSkippableTest: #testp23pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep23pass2xml
				documentURI: 'p23pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp23pass3xml [
	"Source file: oasis/p23pass3.xml"

	(self isSkippableTest: #testp23pass3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep23pass3xml
				documentURI: 'p23pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp23pass4xml [
	"Source file: oasis/p23pass4.xml"

	(self isSkippableTest: #testp23pass4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep23pass4xml
				documentURI: 'p23pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp24fail1xml [
	"Source file: oasis/p24fail1.xml"

	(self isSkippableTest: #testp24fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep24fail1xml
				documentURI: 'p24fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp24fail2xml [
	"Source file: oasis/p24fail2.xml"

	(self isSkippableTest: #testp24fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep24fail2xml
				documentURI: 'p24fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp24pass1xml [
	"Source file: oasis/p24pass1.xml"

	(self isSkippableTest: #testp24pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep24pass1xml
				documentURI: 'p24pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp24pass2xml [
	"Source file: oasis/p24pass2.xml"

	(self isSkippableTest: #testp24pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep24pass2xml
				documentURI: 'p24pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp24pass3xml [
	"Source file: oasis/p24pass3.xml"

	(self isSkippableTest: #testp24pass3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep24pass3xml
				documentURI: 'p24pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp24pass4xml [
	"Source file: oasis/p24pass4.xml"

	(self isSkippableTest: #testp24pass4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep24pass4xml
				documentURI: 'p24pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp25fail1xml [
	"Source file: oasis/p25fail1.xml"

	(self isSkippableTest: #testp25fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep25fail1xml
				documentURI: 'p25fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp25pass1xml [
	"Source file: oasis/p25pass1.xml"

	(self isSkippableTest: #testp25pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep25pass1xml
				documentURI: 'p25pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp25pass2xml [
	"Source file: oasis/p25pass2.xml"

	(self isSkippableTest: #testp25pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep25pass2xml
				documentURI: 'p25pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp26fail1xml [
	"Source file: oasis/p26fail1.xml"

	(self isSkippableTest: #testp26fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep26fail1xml
				documentURI: 'p26fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp26fail2xml [
	"Source file: oasis/p26fail2.xml"

	(self isSkippableTest: #testp26fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep26fail2xml
				documentURI: 'p26fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp26pass1xml [
	"Source file: oasis/p26pass1.xml"

	(self isSkippableTest: #testp26pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep26pass1xml
				documentURI: 'p26pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp27fail1xml [
	"Source file: oasis/p27fail1.xml"

	(self isSkippableTest: #testp27fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep27fail1xml
				documentURI: 'p27fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp27pass1xml [
	"Source file: oasis/p27pass1.xml"

	(self isSkippableTest: #testp27pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep27pass1xml
				documentURI: 'p27pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp27pass2xml [
	"Source file: oasis/p27pass2.xml"

	(self isSkippableTest: #testp27pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep27pass2xml
				documentURI: 'p27pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp27pass3xml [
	"Source file: oasis/p27pass3.xml"

	(self isSkippableTest: #testp27pass3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep27pass3xml
				documentURI: 'p27pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp27pass4xml [
	"Source file: oasis/p27pass4.xml"

	(self isSkippableTest: #testp27pass4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep27pass4xml
				documentURI: 'p27pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp28fail1xml [
	"Source file: oasis/p28fail1.xml"

	(self isSkippableTest: #testp28fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep28fail1xml
				documentURI: 'p28fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp28pass1xml [
	"Source file: oasis/p28pass1.xml"

	(self isSkippableTest: #testp28pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass1xml
				documentURI: 'p28pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp28pass2xml [
	"Source file: oasis/p28pass2.xml"

	(self isSkippableTest: #testp28pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass2xml
				documentURI: 'p28pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp28pass3xml [
	"Source file: oasis/p28pass3.xml"

	(self isSkippableTest: #testp28pass3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass3xml
				documentURI: 'p28pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp28pass4xml [
	"Source file: oasis/p28pass4.xml"

	(self isSkippableTest: #testp28pass4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass4xml
				documentURI: 'p28pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp28pass5xml [
	"Source file: oasis/p28pass5.xml"

	(self isSkippableTest: #testp28pass5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass5xml
				documentURI: 'p28pass5.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp29fail1xml [
	"Source file: oasis/p29fail1.xml"

	(self isSkippableTest: #testp29fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep29fail1xml
				documentURI: 'p29fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp29pass1xml [
	"Source file: oasis/p29pass1.xml"

	(self isSkippableTest: #testp29pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep29pass1xml
				documentURI: 'p29pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp30fail1xml [
	"Source file: oasis/p30fail1.xml"

	(self isSkippableTest: #testp30fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep30fail1xml
				documentURI: 'p30fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp30pass1xml [
	"Source file: oasis/p30pass1.xml"

	(self isSkippableTest: #testp30pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep30pass1xml
				documentURI: 'p30pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp30pass2xml [
	"Source file: oasis/p30pass2.xml"

	(self isSkippableTest: #testp30pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep30pass2xml
				documentURI: 'p30pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp31fail1xml [
	"Source file: oasis/p31fail1.xml"

	(self isSkippableTest: #testp31fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep31fail1xml
				documentURI: 'p31fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp31pass1xml [
	"Source file: oasis/p31pass1.xml"

	(self isSkippableTest: #testp31pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep31pass1xml
				documentURI: 'p31pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp31pass2xml [
	"Source file: oasis/p31pass2.xml"

	(self isSkippableTest: #testp31pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep31pass2xml
				documentURI: 'p31pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp32fail1xml [
	"Source file: oasis/p32fail1.xml"

	(self isSkippableTest: #testp32fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep32fail1xml
				documentURI: 'p32fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp32fail2xml [
	"Source file: oasis/p32fail2.xml"

	(self isSkippableTest: #testp32fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep32fail2xml
				documentURI: 'p32fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp32fail3xml [
	"Source file: oasis/p32fail3.xml"

	(self isSkippableTest: #testp32fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep32fail3xml
				documentURI: 'p32fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp32fail4xml [
	"Source file: oasis/p32fail4.xml"

	(self isSkippableTest: #testp32fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep32fail4xml
				documentURI: 'p32fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp32fail5xml [
	"Source file: oasis/p32fail5.xml"

	(self isSkippableTest: #testp32fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep32fail5xml
				documentURI: 'p32fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp32pass1xml [
	"Source file: oasis/p32pass1.xml"

	(self isSkippableTest: #testp32pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep32pass1xml
				documentURI: 'p32pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp32pass2xml [
	"Source file: oasis/p32pass2.xml"

	(self isSkippableTest: #testp32pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep32pass2xml
				documentURI: 'p32pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp39fail1xml [
	"Source file: oasis/p39fail1.xml"

	(self isSkippableTest: #testp39fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep39fail1xml
				documentURI: 'p39fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp39fail2xml [
	"Source file: oasis/p39fail2.xml"

	(self isSkippableTest: #testp39fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep39fail2xml
				documentURI: 'p39fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp39fail3xml [
	"Source file: oasis/p39fail3.xml"

	(self isSkippableTest: #testp39fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep39fail3xml
				documentURI: 'p39fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp39fail4xml [
	"Source file: oasis/p39fail4.xml"

	(self isSkippableTest: #testp39fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep39fail4xml
				documentURI: 'p39fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp39fail5xml [
	"Source file: oasis/p39fail5.xml"

	(self isSkippableTest: #testp39fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep39fail5xml
				documentURI: 'p39fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp39pass1xml [
	"Source file: oasis/p39pass1.xml"

	(self isSkippableTest: #testp39pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep39pass1xml
				documentURI: 'p39pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp39pass2xml [
	"Source file: oasis/p39pass2.xml"

	(self isSkippableTest: #testp39pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep39pass2xml
				documentURI: 'p39pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp40fail1xml [
	"Source file: oasis/p40fail1.xml"

	(self isSkippableTest: #testp40fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep40fail1xml
				documentURI: 'p40fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp40fail2xml [
	"Source file: oasis/p40fail2.xml"

	(self isSkippableTest: #testp40fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep40fail2xml
				documentURI: 'p40fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp40fail3xml [
	"Source file: oasis/p40fail3.xml"

	(self isSkippableTest: #testp40fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep40fail3xml
				documentURI: 'p40fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp40fail4xml [
	"Source file: oasis/p40fail4.xml"

	(self isSkippableTest: #testp40fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep40fail4xml
				documentURI: 'p40fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp40pass1xml [
	"Source file: oasis/p40pass1.xml"

	(self isSkippableTest: #testp40pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep40pass1xml
				documentURI: 'p40pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp40pass2xml [
	"Source file: oasis/p40pass2.xml"

	(self isSkippableTest: #testp40pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep40pass2xml
				documentURI: 'p40pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp40pass3xml [
	"Source file: oasis/p40pass3.xml"

	(self isSkippableTest: #testp40pass3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep40pass3xml
				documentURI: 'p40pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp40pass4xml [
	"Source file: oasis/p40pass4.xml"

	(self isSkippableTest: #testp40pass4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep40pass4xml
				documentURI: 'p40pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp41fail1xml [
	"Source file: oasis/p41fail1.xml"

	(self isSkippableTest: #testp41fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep41fail1xml
				documentURI: 'p41fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp41fail2xml [
	"Source file: oasis/p41fail2.xml"

	(self isSkippableTest: #testp41fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep41fail2xml
				documentURI: 'p41fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp41fail3xml [
	"Source file: oasis/p41fail3.xml"

	(self isSkippableTest: #testp41fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep41fail3xml
				documentURI: 'p41fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp41pass1xml [
	"Source file: oasis/p41pass1.xml"

	(self isSkippableTest: #testp41pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep41pass1xml
				documentURI: 'p41pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp41pass2xml [
	"Source file: oasis/p41pass2.xml"

	(self isSkippableTest: #testp41pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep41pass2xml
				documentURI: 'p41pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp42fail1xml [
	"Source file: oasis/p42fail1.xml"

	(self isSkippableTest: #testp42fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep42fail1xml
				documentURI: 'p42fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp42fail2xml [
	"Source file: oasis/p42fail2.xml"

	(self isSkippableTest: #testp42fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep42fail2xml
				documentURI: 'p42fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp42fail3xml [
	"Source file: oasis/p42fail3.xml"

	(self isSkippableTest: #testp42fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep42fail3xml
				documentURI: 'p42fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp42pass1xml [
	"Source file: oasis/p42pass1.xml"

	(self isSkippableTest: #testp42pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep42pass1xml
				documentURI: 'p42pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp42pass2xml [
	"Source file: oasis/p42pass2.xml"

	(self isSkippableTest: #testp42pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep42pass2xml
				documentURI: 'p42pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp43fail1xml [
	"Source file: oasis/p43fail1.xml"

	(self isSkippableTest: #testp43fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep43fail1xml
				documentURI: 'p43fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp43fail2xml [
	"Source file: oasis/p43fail2.xml"

	(self isSkippableTest: #testp43fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep43fail2xml
				documentURI: 'p43fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp43fail3xml [
	"Source file: oasis/p43fail3.xml"

	(self isSkippableTest: #testp43fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep43fail3xml
				documentURI: 'p43fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp43pass1xml [
	"Source file: oasis/p43pass1.xml"

	(self isSkippableTest: #testp43pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep43pass1xml
				documentURI: 'p43pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp44fail1xml [
	"Source file: oasis/p44fail1.xml"

	(self isSkippableTest: #testp44fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep44fail1xml
				documentURI: 'p44fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp44fail2xml [
	"Source file: oasis/p44fail2.xml"

	(self isSkippableTest: #testp44fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep44fail2xml
				documentURI: 'p44fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp44fail3xml [
	"Source file: oasis/p44fail3.xml"

	(self isSkippableTest: #testp44fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep44fail3xml
				documentURI: 'p44fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp44fail4xml [
	"Source file: oasis/p44fail4.xml"

	(self isSkippableTest: #testp44fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep44fail4xml
				documentURI: 'p44fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp44fail5xml [
	"Source file: oasis/p44fail5.xml"

	(self isSkippableTest: #testp44fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep44fail5xml
				documentURI: 'p44fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp44pass1xml [
	"Source file: oasis/p44pass1.xml"

	(self isSkippableTest: #testp44pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass1xml
				documentURI: 'p44pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp44pass2xml [
	"Source file: oasis/p44pass2.xml"

	(self isSkippableTest: #testp44pass2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass2xml
				documentURI: 'p44pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp44pass3xml [
	"Source file: oasis/p44pass3.xml"

	(self isSkippableTest: #testp44pass3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass3xml
				documentURI: 'p44pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp44pass4xml [
	"Source file: oasis/p44pass4.xml"

	(self isSkippableTest: #testp44pass4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass4xml
				documentURI: 'p44pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp44pass5xml [
	"Source file: oasis/p44pass5.xml"

	(self isSkippableTest: #testp44pass5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass5xml
				documentURI: 'p44pass5.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp45fail1xml [
	"Source file: oasis/p45fail1.xml"

	(self isSkippableTest: #testp45fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep45fail1xml
				documentURI: 'p45fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp45fail2xml [
	"Source file: oasis/p45fail2.xml"

	(self isSkippableTest: #testp45fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep45fail2xml
				documentURI: 'p45fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp45fail3xml [
	"Source file: oasis/p45fail3.xml"

	(self isSkippableTest: #testp45fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep45fail3xml
				documentURI: 'p45fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp45fail4xml [
	"Source file: oasis/p45fail4.xml"

	(self isSkippableTest: #testp45fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep45fail4xml
				documentURI: 'p45fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp45pass1xml [
	"Source file: oasis/p45pass1.xml"

	(self isSkippableTest: #testp45pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep45pass1xml
				documentURI: 'p45pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp46fail1xml [
	"Source file: oasis/p46fail1.xml"

	(self isSkippableTest: #testp46fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep46fail1xml
				documentURI: 'p46fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp46fail2xml [
	"Source file: oasis/p46fail2.xml"

	(self isSkippableTest: #testp46fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep46fail2xml
				documentURI: 'p46fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp46fail3xml [
	"Source file: oasis/p46fail3.xml"

	(self isSkippableTest: #testp46fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep46fail3xml
				documentURI: 'p46fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp46fail4xml [
	"Source file: oasis/p46fail4.xml"

	(self isSkippableTest: #testp46fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep46fail4xml
				documentURI: 'p46fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp46fail5xml [
	"Source file: oasis/p46fail5.xml"

	(self isSkippableTest: #testp46fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep46fail5xml
				documentURI: 'p46fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp46fail6xml [
	"Source file: oasis/p46fail6.xml"

	(self isSkippableTest: #testp46fail6xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep46fail6xml
				documentURI: 'p46fail6.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp46pass1xml [
	"Source file: oasis/p46pass1.xml"

	(self isSkippableTest: #testp46pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep46pass1xml
				documentURI: 'p46pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp47fail1xml [
	"Source file: oasis/p47fail1.xml"

	(self isSkippableTest: #testp47fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep47fail1xml
				documentURI: 'p47fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp47fail2xml [
	"Source file: oasis/p47fail2.xml"

	(self isSkippableTest: #testp47fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep47fail2xml
				documentURI: 'p47fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp47fail3xml [
	"Source file: oasis/p47fail3.xml"

	(self isSkippableTest: #testp47fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep47fail3xml
				documentURI: 'p47fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp47fail4xml [
	"Source file: oasis/p47fail4.xml"

	(self isSkippableTest: #testp47fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep47fail4xml
				documentURI: 'p47fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp47pass1xml [
	"Source file: oasis/p47pass1.xml"

	(self isSkippableTest: #testp47pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep47pass1xml
				documentURI: 'p47pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp48fail1xml [
	"Source file: oasis/p48fail1.xml"

	(self isSkippableTest: #testp48fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep48fail1xml
				documentURI: 'p48fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp48fail2xml [
	"Source file: oasis/p48fail2.xml"

	(self isSkippableTest: #testp48fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep48fail2xml
				documentURI: 'p48fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp48pass1xml [
	"Source file: oasis/p48pass1.xml"

	(self isSkippableTest: #testp48pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep48pass1xml
				documentURI: 'p48pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp49fail1xml [
	"Source file: oasis/p49fail1.xml"

	(self isSkippableTest: #testp49fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep49fail1xml
				documentURI: 'p49fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp49pass1xml [
	"Source file: oasis/p49pass1.xml"

	(self isSkippableTest: #testp49pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep49pass1xml
				documentURI: 'p49pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp50fail1xml [
	"Source file: oasis/p50fail1.xml"

	(self isSkippableTest: #testp50fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep50fail1xml
				documentURI: 'p50fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp50pass1xml [
	"Source file: oasis/p50pass1.xml"

	(self isSkippableTest: #testp50pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep50pass1xml
				documentURI: 'p50pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp51fail1xml [
	"Source file: oasis/p51fail1.xml"

	(self isSkippableTest: #testp51fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep51fail1xml
				documentURI: 'p51fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp51fail2xml [
	"Source file: oasis/p51fail2.xml"

	(self isSkippableTest: #testp51fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep51fail2xml
				documentURI: 'p51fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp51fail3xml [
	"Source file: oasis/p51fail3.xml"

	(self isSkippableTest: #testp51fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep51fail3xml
				documentURI: 'p51fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp51fail4xml [
	"Source file: oasis/p51fail4.xml"

	(self isSkippableTest: #testp51fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep51fail4xml
				documentURI: 'p51fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp51fail5xml [
	"Source file: oasis/p51fail5.xml"

	(self isSkippableTest: #testp51fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep51fail5xml
				documentURI: 'p51fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp51fail6xml [
	"Source file: oasis/p51fail6.xml"

	(self isSkippableTest: #testp51fail6xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep51fail6xml
				documentURI: 'p51fail6.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp51fail7xml [
	"Source file: oasis/p51fail7.xml"

	(self isSkippableTest: #testp51fail7xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep51fail7xml
				documentURI: 'p51fail7.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp51pass1xml [
	"Source file: oasis/p51pass1.xml"

	(self isSkippableTest: #testp51pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep51pass1xml
				documentURI: 'p51pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp52fail1xml [
	"Source file: oasis/p52fail1.xml"

	(self isSkippableTest: #testp52fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep52fail1xml
				documentURI: 'p52fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp52fail2xml [
	"Source file: oasis/p52fail2.xml"

	(self isSkippableTest: #testp52fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep52fail2xml
				documentURI: 'p52fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp52pass1xml [
	"Source file: oasis/p52pass1.xml"

	(self isSkippableTest: #testp52pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep52pass1xml
				documentURI: 'p52pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp53fail1xml [
	"Source file: oasis/p53fail1.xml"

	(self isSkippableTest: #testp53fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep53fail1xml
				documentURI: 'p53fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp53fail2xml [
	"Source file: oasis/p53fail2.xml"

	(self isSkippableTest: #testp53fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep53fail2xml
				documentURI: 'p53fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp53fail3xml [
	"Source file: oasis/p53fail3.xml"

	(self isSkippableTest: #testp53fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep53fail3xml
				documentURI: 'p53fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp53fail4xml [
	"Source file: oasis/p53fail4.xml"

	(self isSkippableTest: #testp53fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep53fail4xml
				documentURI: 'p53fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp53fail5xml [
	"Source file: oasis/p53fail5.xml"

	(self isSkippableTest: #testp53fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep53fail5xml
				documentURI: 'p53fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp53pass1xml [
	"Source file: oasis/p53pass1.xml"

	(self isSkippableTest: #testp53pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep53pass1xml
				documentURI: 'p53pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp54fail1xml [
	"Source file: oasis/p54fail1.xml"

	(self isSkippableTest: #testp54fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep54fail1xml
				documentURI: 'p54fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp54pass1xml [
	"Source file: oasis/p54pass1.xml"

	(self isSkippableTest: #testp54pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep54pass1xml
				documentURI: 'p54pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp55fail1xml [
	"Source file: oasis/p55fail1.xml"

	(self isSkippableTest: #testp55fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep55fail1xml
				documentURI: 'p55fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp55pass1xml [
	"Source file: oasis/p55pass1.xml"

	(self isSkippableTest: #testp55pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep55pass1xml
				documentURI: 'p55pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp56fail1xml [
	"Source file: oasis/p56fail1.xml"

	(self isSkippableTest: #testp56fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep56fail1xml
				documentURI: 'p56fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp56fail2xml [
	"Source file: oasis/p56fail2.xml"

	(self isSkippableTest: #testp56fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep56fail2xml
				documentURI: 'p56fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp56fail3xml [
	"Source file: oasis/p56fail3.xml"

	(self isSkippableTest: #testp56fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep56fail3xml
				documentURI: 'p56fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp56fail4xml [
	"Source file: oasis/p56fail4.xml"

	(self isSkippableTest: #testp56fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep56fail4xml
				documentURI: 'p56fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp56fail5xml [
	"Source file: oasis/p56fail5.xml"

	(self isSkippableTest: #testp56fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep56fail5xml
				documentURI: 'p56fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp56pass1xml [
	"Source file: oasis/p56pass1.xml"

	(self isSkippableTest: #testp56pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep56pass1xml
				documentURI: 'p56pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp57fail1xml [
	"Source file: oasis/p57fail1.xml"

	(self isSkippableTest: #testp57fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep57fail1xml
				documentURI: 'p57fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp57pass1xml [
	"Source file: oasis/p57pass1.xml"

	(self isSkippableTest: #testp57pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep57pass1xml
				documentURI: 'p57pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp58fail1xml [
	"Source file: oasis/p58fail1.xml"

	(self isSkippableTest: #testp58fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep58fail1xml
				documentURI: 'p58fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp58fail2xml [
	"Source file: oasis/p58fail2.xml"

	(self isSkippableTest: #testp58fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep58fail2xml
				documentURI: 'p58fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp58fail3xml [
	"Source file: oasis/p58fail3.xml"

	(self isSkippableTest: #testp58fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep58fail3xml
				documentURI: 'p58fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp58fail4xml [
	"Source file: oasis/p58fail4.xml"

	(self isSkippableTest: #testp58fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep58fail4xml
				documentURI: 'p58fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp58fail5xml [
	"Source file: oasis/p58fail5.xml"

	(self isSkippableTest: #testp58fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep58fail5xml
				documentURI: 'p58fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp58fail6xml [
	"Source file: oasis/p58fail6.xml"

	(self isSkippableTest: #testp58fail6xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep58fail6xml
				documentURI: 'p58fail6.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp58fail7xml [
	"Source file: oasis/p58fail7.xml"

	(self isSkippableTest: #testp58fail7xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep58fail7xml
				documentURI: 'p58fail7.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp58fail8xml [
	"Source file: oasis/p58fail8.xml"

	(self isSkippableTest: #testp58fail8xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep58fail8xml
				documentURI: 'p58fail8.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp58pass1xml [
	"Source file: oasis/p58pass1.xml"

	(self isSkippableTest: #testp58pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep58pass1xml
				documentURI: 'p58pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp59fail1xml [
	"Source file: oasis/p59fail1.xml"

	(self isSkippableTest: #testp59fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep59fail1xml
				documentURI: 'p59fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp59fail2xml [
	"Source file: oasis/p59fail2.xml"

	(self isSkippableTest: #testp59fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep59fail2xml
				documentURI: 'p59fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp59fail3xml [
	"Source file: oasis/p59fail3.xml"

	(self isSkippableTest: #testp59fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep59fail3xml
				documentURI: 'p59fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp59pass1xml [
	"Source file: oasis/p59pass1.xml"

	(self isSkippableTest: #testp59pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep59pass1xml
				documentURI: 'p59pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp60fail1xml [
	"Source file: oasis/p60fail1.xml"

	(self isSkippableTest: #testp60fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep60fail1xml
				documentURI: 'p60fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp60fail2xml [
	"Source file: oasis/p60fail2.xml"

	(self isSkippableTest: #testp60fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep60fail2xml
				documentURI: 'p60fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp60fail3xml [
	"Source file: oasis/p60fail3.xml"

	(self isSkippableTest: #testp60fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep60fail3xml
				documentURI: 'p60fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp60fail4xml [
	"Source file: oasis/p60fail4.xml"

	(self isSkippableTest: #testp60fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep60fail4xml
				documentURI: 'p60fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp60fail5xml [
	"Source file: oasis/p60fail5.xml"

	(self isSkippableTest: #testp60fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep60fail5xml
				documentURI: 'p60fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp60pass1xml [
	"Source file: oasis/p60pass1.xml"

	(self isSkippableTest: #testp60pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep60pass1xml
				documentURI: 'p60pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp61fail1xml [
	"Source file: oasis/p61fail1.xml"

	(self isSkippableTest: #testp61fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep61fail1xml
				documentURI: 'p61fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp61pass1xml [
	"Source file: oasis/p61pass1.xml"

	(self isSkippableTest: #testp61pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep61pass1xml
				documentURI: 'p61pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp62fail1xml [
	"Source file: oasis/p62fail1.xml"

	(self isSkippableTest: #testp62fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep62fail1xml
				documentURI: 'p62fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp62fail2xml [
	"Source file: oasis/p62fail2.xml"

	(self isSkippableTest: #testp62fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep62fail2xml
				documentURI: 'p62fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp62pass1xml [
	"Source file: oasis/p62pass1.xml"

	(self isSkippableTest: #testp62pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep62pass1xml
				documentURI: 'p62pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp63fail1xml [
	"Source file: oasis/p63fail1.xml"

	(self isSkippableTest: #testp63fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep63fail1xml
				documentURI: 'p63fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp63fail2xml [
	"Source file: oasis/p63fail2.xml"

	(self isSkippableTest: #testp63fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep63fail2xml
				documentURI: 'p63fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp63pass1xml [
	"Source file: oasis/p63pass1.xml"

	(self isSkippableTest: #testp63pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep63pass1xml
				documentURI: 'p63pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp64fail1xml [
	"Source file: oasis/p64fail1.xml"

	(self isSkippableTest: #testp64fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep64fail1xml
				documentURI: 'p64fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp64fail2xml [
	"Source file: oasis/p64fail2.xml"

	(self isSkippableTest: #testp64fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep64fail2xml
				documentURI: 'p64fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp64pass1xml [
	"Source file: oasis/p64pass1.xml"

	(self isSkippableTest: #testp64pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep64pass1xml
				documentURI: 'p64pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp66fail1xml [
	"Source file: oasis/p66fail1.xml"

	(self isSkippableTest: #testp66fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep66fail1xml
				documentURI: 'p66fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp66fail2xml [
	"Source file: oasis/p66fail2.xml"

	(self isSkippableTest: #testp66fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep66fail2xml
				documentURI: 'p66fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp66fail3xml [
	"Source file: oasis/p66fail3.xml"

	(self isSkippableTest: #testp66fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep66fail3xml
				documentURI: 'p66fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp66fail4xml [
	"Source file: oasis/p66fail4.xml"

	(self isSkippableTest: #testp66fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep66fail4xml
				documentURI: 'p66fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp66fail5xml [
	"Source file: oasis/p66fail5.xml"

	(self isSkippableTest: #testp66fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep66fail5xml
				documentURI: 'p66fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp66fail6xml [
	"Source file: oasis/p66fail6.xml"

	(self isSkippableTest: #testp66fail6xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep66fail6xml
				documentURI: 'p66fail6.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp66pass1xml [
	"Source file: oasis/p66pass1.xml"

	(self isSkippableTest: #testp66pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep66pass1xml
				documentURI: 'p66pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp68fail1xml [
	"Source file: oasis/p68fail1.xml"

	(self isSkippableTest: #testp68fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep68fail1xml
				documentURI: 'p68fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp68fail2xml [
	"Source file: oasis/p68fail2.xml"

	(self isSkippableTest: #testp68fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep68fail2xml
				documentURI: 'p68fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp68fail3xml [
	"Source file: oasis/p68fail3.xml"

	(self isSkippableTest: #testp68fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep68fail3xml
				documentURI: 'p68fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp68pass1xml [
	"Source file: oasis/p68pass1.xml"

	(self isSkippableTest: #testp68pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep68pass1xml
				documentURI: 'p68pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp69fail1xml [
	"Source file: oasis/p69fail1.xml"

	(self isSkippableTest: #testp69fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep69fail1xml
				documentURI: 'p69fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp69fail2xml [
	"Source file: oasis/p69fail2.xml"

	(self isSkippableTest: #testp69fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep69fail2xml
				documentURI: 'p69fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp69fail3xml [
	"Source file: oasis/p69fail3.xml"

	(self isSkippableTest: #testp69fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep69fail3xml
				documentURI: 'p69fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp69pass1xml [
	"Source file: oasis/p69pass1.xml"

	(self isSkippableTest: #testp69pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep69pass1xml
				documentURI: 'p69pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp70fail1xml [
	"Source file: oasis/p70fail1.xml"

	(self isSkippableTest: #testp70fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep70fail1xml
				documentURI: 'p70fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp70pass1xml [
	"Source file: oasis/p70pass1.xml"

	(self isSkippableTest: #testp70pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep70pass1xml
				documentURI: 'p70pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp71fail1xml [
	"Source file: oasis/p71fail1.xml"

	(self isSkippableTest: #testp71fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep71fail1xml
				documentURI: 'p71fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp71fail2xml [
	"Source file: oasis/p71fail2.xml"

	(self isSkippableTest: #testp71fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep71fail2xml
				documentURI: 'p71fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp71fail3xml [
	"Source file: oasis/p71fail3.xml"

	(self isSkippableTest: #testp71fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep71fail3xml
				documentURI: 'p71fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp71fail4xml [
	"Source file: oasis/p71fail4.xml"

	(self isSkippableTest: #testp71fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep71fail4xml
				documentURI: 'p71fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp71pass1xml [
	"Source file: oasis/p71pass1.xml"

	(self isSkippableTest: #testp71pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep71pass1xml
				documentURI: 'p71pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp72fail1xml [
	"Source file: oasis/p72fail1.xml"

	(self isSkippableTest: #testp72fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep72fail1xml
				documentURI: 'p72fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp72fail2xml [
	"Source file: oasis/p72fail2.xml"

	(self isSkippableTest: #testp72fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep72fail2xml
				documentURI: 'p72fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp72fail3xml [
	"Source file: oasis/p72fail3.xml"

	(self isSkippableTest: #testp72fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep72fail3xml
				documentURI: 'p72fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp72fail4xml [
	"Source file: oasis/p72fail4.xml"

	(self isSkippableTest: #testp72fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep72fail4xml
				documentURI: 'p72fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp72pass1xml [
	"Source file: oasis/p72pass1.xml"

	(self isSkippableTest: #testp72pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep72pass1xml
				documentURI: 'p72pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp73fail1xml [
	"Source file: oasis/p73fail1.xml"

	(self isSkippableTest: #testp73fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep73fail1xml
				documentURI: 'p73fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp73fail2xml [
	"Source file: oasis/p73fail2.xml"

	(self isSkippableTest: #testp73fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep73fail2xml
				documentURI: 'p73fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp73fail3xml [
	"Source file: oasis/p73fail3.xml"

	(self isSkippableTest: #testp73fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep73fail3xml
				documentURI: 'p73fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp73fail4xml [
	"Source file: oasis/p73fail4.xml"

	(self isSkippableTest: #testp73fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep73fail4xml
				documentURI: 'p73fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp73fail5xml [
	"Source file: oasis/p73fail5.xml"

	(self isSkippableTest: #testp73fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep73fail5xml
				documentURI: 'p73fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp73pass1xml [
	"Source file: oasis/p73pass1.xml"

	(self isSkippableTest: #testp73pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep73pass1xml
				documentURI: 'p73pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp74fail1xml [
	"Source file: oasis/p74fail1.xml"

	(self isSkippableTest: #testp74fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep74fail1xml
				documentURI: 'p74fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp74fail2xml [
	"Source file: oasis/p74fail2.xml"

	(self isSkippableTest: #testp74fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep74fail2xml
				documentURI: 'p74fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp74fail3xml [
	"Source file: oasis/p74fail3.xml"

	(self isSkippableTest: #testp74fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep74fail3xml
				documentURI: 'p74fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp74pass1xml [
	"Source file: oasis/p74pass1.xml"

	(self isSkippableTest: #testp74pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep74pass1xml
				documentURI: 'p74pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp75fail1xml [
	"Source file: oasis/p75fail1.xml"

	(self isSkippableTest: #testp75fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep75fail1xml
				documentURI: 'p75fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp75fail2xml [
	"Source file: oasis/p75fail2.xml"

	(self isSkippableTest: #testp75fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep75fail2xml
				documentURI: 'p75fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp75fail3xml [
	"Source file: oasis/p75fail3.xml"

	(self isSkippableTest: #testp75fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep75fail3xml
				documentURI: 'p75fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp75fail4xml [
	"Source file: oasis/p75fail4.xml"

	(self isSkippableTest: #testp75fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep75fail4xml
				documentURI: 'p75fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp75fail5xml [
	"Source file: oasis/p75fail5.xml"

	(self isSkippableTest: #testp75fail5xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep75fail5xml
				documentURI: 'p75fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp75fail6xml [
	"Source file: oasis/p75fail6.xml"

	(self isSkippableTest: #testp75fail6xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep75fail6xml
				documentURI: 'p75fail6.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp75pass1xml [
	"Source file: oasis/p75pass1.xml"

	(self isSkippableTest: #testp75pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep75pass1xml
				documentURI: 'p75pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp76fail1xml [
	"Source file: oasis/p76fail1.xml"

	(self isSkippableTest: #testp76fail1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep76fail1xml
				documentURI: 'p76fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp76fail2xml [
	"Source file: oasis/p76fail2.xml"

	(self isSkippableTest: #testp76fail2xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep76fail2xml
				documentURI: 'p76fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp76fail3xml [
	"Source file: oasis/p76fail3.xml"

	(self isSkippableTest: #testp76fail3xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep76fail3xml
				documentURI: 'p76fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTests >> testp76fail4xml [
	"Source file: oasis/p76fail4.xml"

	(self isSkippableTest: #testp76fail4xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		should: [
			self
				parse: self class sourcep76fail4xml
				documentURI: 'p76fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTests >> testp76pass1xml [
	"Source file: oasis/p76pass1.xml"

	(self isSkippableTest: #testp76pass1xml)
		ifTrue: [self skipOrReturnWith: [^ self]].
	self
		shouldnt: [
			[self
				parse: self class sourcep76pass1xml
				documentURI: 'p76pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isSkippableException: error)
						ifTrue: [self skipOrReturnWith: [^ self]]
						ifFalse: [error pass]]]
		raise: self parserExceptions
]
