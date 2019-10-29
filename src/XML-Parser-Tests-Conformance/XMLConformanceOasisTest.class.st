Class {
	#name : #XMLConformanceOasisTest,
	#superclass : #XMLConformanceTest,
	#category : #'XML-Parser-Tests-Conformance'
}

{ #category : #accessing }
XMLConformanceOasisTest class >> skippableTests [
	^ #( )
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcee2xml [
	"Source file: oasis/e2.xml"

	^ '<!DOCTYPE el [
<!ELEMENT el EMPTY>
<!ATTLIST el at (one|two|two) #IMPLIED>
]>
<e1 at="two"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep01fail1xml [
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
XMLConformanceOasisTest class >> sourcep01fail2xml [
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
XMLConformanceOasisTest class >> sourcep01fail3xml [
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
XMLConformanceOasisTest class >> sourcep01fail4xml [
	"Source file: oasis/p01fail4.xml"

	^ '<doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep01pass1xml [
	"Source file: oasis/p01pass1.xml"

	^ '<doc>
<a><b><c/></b></a>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep01pass2xml [
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
XMLConformanceOasisTest class >> sourcep01pass3xml [
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
XMLConformanceOasisTest class >> sourcep02fail10xml [
	"Source file: oasis/p02fail10.xml"

	^ '<doc>', 16rB asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail11xml [
	"Source file: oasis/p02fail11.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail12xml [
	"Source file: oasis/p02fail12.xml"

	^ '<doc>', 16rE asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail13xml [
	"Source file: oasis/p02fail13.xml"

	^ '<doc>', 16rF asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail14xml [
	"Source file: oasis/p02fail14.xml"

	^ '<doc>', 16r10 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail15xml [
	"Source file: oasis/p02fail15.xml"

	^ '<doc>', 16r11 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail16xml [
	"Source file: oasis/p02fail16.xml"

	^ '<doc>', 16r12 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail17xml [
	"Source file: oasis/p02fail17.xml"

	^ '<doc>', 16r13 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail18xml [
	"Source file: oasis/p02fail18.xml"

	^ '<doc>', 16r14 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail19xml [
	"Source file: oasis/p02fail19.xml"

	^ '<doc>', 16r15 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail1xml [
	"Source file: oasis/p02fail1.xml"

	^ '<doc>', 16r0 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail20xml [
	"Source file: oasis/p02fail20.xml"

	^ '<doc>', 16r16 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail21xml [
	"Source file: oasis/p02fail21.xml"

	^ '<doc>', 16r17 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail22xml [
	"Source file: oasis/p02fail22.xml"

	^ '<doc>', 16r18 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail23xml [
	"Source file: oasis/p02fail23.xml"

	^ '<doc>', 16r19 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail24xml [
	"Source file: oasis/p02fail24.xml"

	^ '<doc>', 16r1A asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail25xml [
	"Source file: oasis/p02fail25.xml"

	^ '<doc>', 16r1B asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail26xml [
	"Source file: oasis/p02fail26.xml"

	^ '<doc>', 16r1C asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail27xml [
	"Source file: oasis/p02fail27.xml"

	^ '<doc>', 16r1D asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail28xml [
	"Source file: oasis/p02fail28.xml"

	^ '<doc>', 16r1E asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail29xml [
	"Source file: oasis/p02fail29.xml"

	^ '<doc>', 16r1F asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail2xml [
	"Source file: oasis/p02fail2.xml"

	^ '<doc>', 16r1 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail30xml [
	"Source file: oasis/p02fail30.xml"

	^ '<doc>', 16rFFFE asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail31xml [
	"Source file: oasis/p02fail31.xml"

	^ '<doc>', 16rFFFF asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail3xml [
	"Source file: oasis/p02fail3.xml"

	^ '<doc>', 16r2 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail4xml [
	"Source file: oasis/p02fail4.xml"

	^ '<doc>', 16r3 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail5xml [
	"Source file: oasis/p02fail5.xml"

	^ '<doc>', 16r4 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail6xml [
	"Source file: oasis/p02fail6.xml"

	^ '<doc>', 16r5 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail7xml [
	"Source file: oasis/p02fail7.xml"

	^ '<doc>', 16r6 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail8xml [
	"Source file: oasis/p02fail8.xml"

	^ '<doc>', 16r7 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep02fail9xml [
	"Source file: oasis/p02fail9.xml"

	^ '<doc>', 16r8 asCharacter asString, '</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail10xml [
	"Source file: oasis/p03fail10.xml"

	^ '', 16rB asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail11xml [
	"Source file: oasis/p03fail11.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail12xml [
	"Source file: oasis/p03fail12.xml"

	^ '', 16rE asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail13xml [
	"Source file: oasis/p03fail13.xml"

	^ '', 16rF asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail14xml [
	"Source file: oasis/p03fail14.xml"

	^ '', 16r10 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail15xml [
	"Source file: oasis/p03fail15.xml"

	^ '', 16r11 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail16xml [
	"Source file: oasis/p03fail16.xml"

	^ '', 16r12 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail17xml [
	"Source file: oasis/p03fail17.xml"

	^ '', 16r13 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail18xml [
	"Source file: oasis/p03fail18.xml"

	^ '', 16r14 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail19xml [
	"Source file: oasis/p03fail19.xml"

	^ '', 16r15 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail20xml [
	"Source file: oasis/p03fail20.xml"

	^ '', 16r16 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail21xml [
	"Source file: oasis/p03fail21.xml"

	^ '', 16r17 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail22xml [
	"Source file: oasis/p03fail22.xml"

	^ '', 16r18 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail23xml [
	"Source file: oasis/p03fail23.xml"

	^ '', 16r19 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail24xml [
	"Source file: oasis/p03fail24.xml"

	^ '', 16r1A asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail25xml [
	"Source file: oasis/p03fail25.xml"

	^ '', 16r1B asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail26xml [
	"Source file: oasis/p03fail26.xml"

	^ '', 16r1C asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail27xml [
	"Source file: oasis/p03fail27.xml"

	^ '', 16r1D asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail28xml [
	"Source file: oasis/p03fail28.xml"

	^ '', 16r1E asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail29xml [
	"Source file: oasis/p03fail29.xml"

	^ '', 16r1F asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail2xml [
	"Source file: oasis/p03fail2.xml"

	^ '', 16r1 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail3xml [
	"Source file: oasis/p03fail3.xml"

	^ '', 16r2 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail4xml [
	"Source file: oasis/p03fail4.xml"

	^ '', 16r3 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail5xml [
	"Source file: oasis/p03fail5.xml"

	^ '', 16r4 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail7xml [
	"Source file: oasis/p03fail7.xml"

	^ '', 16r6 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail8xml [
	"Source file: oasis/p03fail8.xml"

	^ '', 16r7 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03fail9xml [
	"Source file: oasis/p03fail9.xml"

	^ '', 16r8 asCharacter asString, '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep03pass1xml [
	"Source file: oasis/p03pass1.xml"

	^ '	
 <doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep04fail1xml [
	"Source file: oasis/p04fail1.xml"

	^ '<A@/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep04fail2xml [
	"Source file: oasis/p04fail2.xml"

	^ '<A#/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep04fail3xml [
	"Source file: oasis/p04fail3.xml"

	^ '<A$/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep04pass1xml [
	"Source file: oasis/p04pass1.xml"

	^ '<doc>
<abcdefghijklmnopqrstuvwxyz/>
<ABCDEFGHIJKLMNOPQRSTUVWXYZ/>
<A01234567890/>
<A.-:', 16r300 asCharacter asString, 16rB7 asCharacter asString, '/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep05fail1xml [
	"Source file: oasis/p05fail1.xml"

	^ '<0A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep05fail2xml [
	"Source file: oasis/p05fail2.xml"

	^ '<.A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep05fail3xml [
	"Source file: oasis/p05fail3.xml"

	^ '<-A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep05fail4xml [
	"Source file: oasis/p05fail4.xml"

	^ '<', 16r300 asCharacter asString, 'A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep05fail5xml [
	"Source file: oasis/p05fail5.xml"

	^ '<', 16rB7 asCharacter asString, 'A/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep05pass1xml [
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
XMLConformanceOasisTest class >> sourcep06fail1xml [
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
XMLConformanceOasisTest class >> sourcep06pass1xml [
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
XMLConformanceOasisTest class >> sourcep07pass1xml [
	"Source file: oasis/p07pass1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST doc att (0|35a|A|-a|:a|a:|.|_a) #IMPLIED>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep08fail1xml [
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
XMLConformanceOasisTest class >> sourcep08fail2xml [
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
XMLConformanceOasisTest class >> sourcep08pass1xml [
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
XMLConformanceOasisTest class >> sourcep09fail1dtd [
	"Source file: oasis/p09fail1.dtd"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "asdf%">
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep09fail1xml [
	"Source file: oasis/p09fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p09fail1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep09fail2dtd [
	"Source file: oasis/p09fail2.dtd"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "asdf&">
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep09fail2xml [
	"Source file: oasis/p09fail2.xml"

	^ '<!DOCTYPE doc SYSTEM "p09fail2.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep09fail3xml [
	"Source file: oasis/p09fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "asdf&#65">
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep09fail4xml [
	"Source file: oasis/p09fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY % ent1 ''a">
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep09fail5xml [
	"Source file: oasis/p09fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "a''>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep09pass1dtd [
	"Source file: oasis/p09pass1.dtd"

	^ '<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "">
<!ENTITY ent2 "text2">
<!ENTITY % ent3 "<!-- <!DOCTYPE <!ELEMENT <? ''''''&#34;&ent2; %ent1;">
<!ENTITY % ent4 ''""&#x27;&#39;"''>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep09pass1xml [
	"Source file: oasis/p09pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p09pass1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep10fail1xml [
	"Source file: oasis/p10fail1.xml"

	^ '<doc a="1 < 2"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep10fail2xml [
	"Source file: oasis/p10fail2.xml"

	^ '<doc a="1 &"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep10fail3xml [
	"Source file: oasis/p10fail3.xml"

	^ '<doc a=''asd"/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep10pass1xml [
	"Source file: oasis/p10pass1.xml"

	^ '<doc>
<A a="asdf>''&#34;>
asdf
	?>%"/>
<A a=''"">&#39;&#34;''/>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep11fail1xml [
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
XMLConformanceOasisTest class >> sourcep11fail2xml [
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
XMLConformanceOasisTest class >> sourcep11pass1xml [
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
XMLConformanceOasisTest class >> sourcep12fail1xml [
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
XMLConformanceOasisTest class >> sourcep12fail2xml [
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
XMLConformanceOasisTest class >> sourcep12fail3xml [
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
XMLConformanceOasisTest class >> sourcep12fail4xml [
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
XMLConformanceOasisTest class >> sourcep12fail5xml [
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
XMLConformanceOasisTest class >> sourcep12fail6xml [
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
XMLConformanceOasisTest class >> sourcep12fail7xml [
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
XMLConformanceOasisTest class >> sourcep12pass1xml [
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
XMLConformanceOasisTest class >> sourcep14fail1xml [
	"Source file: oasis/p14fail1.xml"

	^ '<doc>< </doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep14fail2xml [
	"Source file: oasis/p14fail2.xml"

	^ '<doc>& </doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep14fail3xml [
	"Source file: oasis/p14fail3.xml"

	^ '<doc>a]]>b</doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep14pass1xml [
	"Source file: oasis/p14pass1.xml"

	^ '<doc>a%b%&lt;/doc>&#60;/doc>]]&lt;&amp;</doc>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep15fail1xml [
	"Source file: oasis/p15fail1.xml"

	^ '<!--a--->
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep15fail2xml [
	"Source file: oasis/p15fail2.xml"

	^ '<!-- -- -- -->
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep15fail3xml [
	"Source file: oasis/p15fail3.xml"

	^ '<!-- --- -->
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep15pass1xml [
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
XMLConformanceOasisTest class >> sourcep16fail1xml [
	"Source file: oasis/p16fail1.xml"

	^ '<?pitarget?>
<?xml?>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep16fail2xml [
	"Source file: oasis/p16fail2.xml"

	^ '<??>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep16fail3xml [
	"Source file: oasis/p16fail3.xml"

	^ '<?pitarget+++?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep16pass1xml [
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
XMLConformanceOasisTest class >> sourcep16pass2xml [
	"Source file: oasis/p16pass2.xml"

	^ '<?pitarget ''?>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep16pass3xml [
	"Source file: oasis/p16pass3.xml"

	^ '<?pitarget "?>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep18fail1xml [
	"Source file: oasis/p18fail1.xml"

	^ '<doc><![ CDATA[a]]></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep18fail2xml [
	"Source file: oasis/p18fail2.xml"

	^ '<doc><![CDATA [a]]></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep18fail3xml [
	"Source file: oasis/p18fail3.xml"

	^ '<doc>
<![CDATA[
<![CDATA[XML doesn''t allow CDATA sections to nest]]>
]]>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep18pass1xml [
	"Source file: oasis/p18pass1.xml"

	^ '<doc><![CDATA[<doc<!DOCTYPE&a%b&#c]] >] ]> ]]]><![CDATA[]]>
<![CDATA[
<![CDATA[
]]>
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep22fail1xml [
	"Source file: oasis/p22fail1.xml"

	^ '
<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep22fail2xml [
	"Source file: oasis/p22fail2.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc EMPTY>
]>
<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep22pass1xml [
	"Source file: oasis/p22pass1.xml"

	^ '<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep22pass2xml [
	"Source file: oasis/p22pass2.xml"

	^ '<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep22pass3xml [
	"Source file: oasis/p22pass3.xml"

	^ '<?xml version="1.0"?>
<!--comment--> <?pi?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep22pass4xml [
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
XMLConformanceOasisTest class >> sourcep22pass5xml [
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
XMLConformanceOasisTest class >> sourcep22pass6xml [
	"Source file: oasis/p22pass6.xml"

	^ '<?xml version="1.0"?><!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
]><doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep23fail1xml [
	"Source file: oasis/p23fail1.xml"

	^ '<?XML version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep23fail2xml [
	"Source file: oasis/p23fail2.xml"

	^ '<?xml encoding="UTF-8"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep23fail3xml [
	"Source file: oasis/p23fail3.xml"

	^ '<?xml encoding="UTF-8" version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep23fail4xml [
	"Source file: oasis/p23fail4.xml"

	^ '<?xml version="1.0" standalone="yes" encoding="UTF-8"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep23fail5xml [
	"Source file: oasis/p23fail5.xml"

	^ '<?xml version="1.0">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep23pass1xml [
	"Source file: oasis/p23pass1.xml"

	^ '<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep23pass2xml [
	"Source file: oasis/p23pass2.xml"

	^ '<?xml version="1.0" encoding="UTF-8"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep23pass3xml [
	"Source file: oasis/p23pass3.xml"

	^ '<?xml version="1.0" standalone="yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep23pass4xml [
	"Source file: oasis/p23pass4.xml"

	^ '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep24fail1xml [
	"Source file: oasis/p24fail1.xml"

	^ '<?xml version = ''1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep24fail2xml [
	"Source file: oasis/p24fail2.xml"

	^ '<?xml version = "1.0''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep24pass1xml [
	"Source file: oasis/p24pass1.xml"

	^ '<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep24pass2xml [
	"Source file: oasis/p24pass2.xml"

	^ '<?xml version=''1.0''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep24pass3xml [
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
XMLConformanceOasisTest class >> sourcep24pass4xml [
	"Source file: oasis/p24pass4.xml"

	^ '<?xml version = ''1.0''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep25fail1xml [
	"Source file: oasis/p25fail1.xml"

	^ '<?xml version <!--bad comment--> ="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep25pass1xml [
	"Source file: oasis/p25pass1.xml"

	^ '<?xml version="1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep25pass2xml [
	"Source file: oasis/p25pass2.xml"

	^ '<?xml version

	 
=
  

"1.0"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep26fail1xml [
	"Source file: oasis/p26fail1.xml"

	^ '<?xml version="1.0?"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep26fail2xml [
	"Source file: oasis/p26fail2.xml"

	^ '<?xml version="1.0^"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep26pass1xml [
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
XMLConformanceOasisTest class >> sourcep27fail1xml [
	"Source file: oasis/p27fail1.xml"

	^ '<?xml version="1.0"?>
&#32;
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep27pass1xml [
	"Source file: oasis/p27pass1.xml"

	^ '<?xml version="1.0"?>
<!--Non-terminal Misc only appears as Misc*, so we cannot test the fact
    that Misc must match exactly one comment, PI, or S-->
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep27pass2xml [
	"Source file: oasis/p27pass2.xml"

	^ '<?xml version="1.0"?>
<?pi?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep27pass3xml [
	"Source file: oasis/p27pass3.xml"

	^ '<?xml version="1.0"?>

 	

<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep27pass4xml [
	"Source file: oasis/p27pass4.xml"

	^ '<?xml version="1.0"?><?pi?>

 	

<!--comment-->
<?pi?>

 	

<!--comment-->
<?pi?><doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep28fail1xml [
	"Source file: oasis/p28fail1.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc EMPTY>
<doc/>
]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep28pass1xml [
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
XMLConformanceOasisTest class >> sourcep28pass2xml [
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
XMLConformanceOasisTest class >> sourcep28pass3xml [
	"Source file: oasis/p28pass3.xml"

	^ '<!DOCTYPE doc [
<!ENTITY % eldecl "<!ELEMENT doc EMPTY>">
%eldecl;
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep28pass4dtd [
	"Source file: oasis/p28pass4.dtd"

	^ '<!ELEMENT doc EMPTY>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep28pass4xml [
	"Source file: oasis/p28pass4.xml"

	^ '<!DOCTYPE doc SYSTEM "p28pass4.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep28pass5dtd [
	"Source file: oasis/p28pass5.dtd"

	^ '%rootdecl;

'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep28pass5xml [
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
XMLConformanceOasisTest class >> sourcep29fail1xml [
	"Source file: oasis/p29fail1.xml"

	^ '<!DOCTYPE doc [
<!ELEMENT doc EMPTY>
<!DUNNO should not pass unknown declaration types>
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep29pass1xml [
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
XMLConformanceOasisTest class >> sourcep30fail1dtd [
	"Source file: oasis/p30fail1.dtd"

	^ '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!ELEMENT doc EMPTY>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep30fail1xml [
	"Source file: oasis/p30fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p30fail1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep30pass1dtd [
	"Source file: oasis/p30pass1.dtd"

	^ '<!ELEMENT doc EMPTY>


'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep30pass1xml [
	"Source file: oasis/p30pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p30pass1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep30pass2dtd [
	"Source file: oasis/p30pass2.dtd"

	^ '<?xml encoding="UTF-8"?>
<!ELEMENT doc EMPTY>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep30pass2xml [
	"Source file: oasis/p30pass2.xml"

	^ '<!DOCTYPE doc SYSTEM "p30pass2.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep31fail1dtd [
	"Source file: oasis/p31fail1.dtd"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep31fail1xml [
	"Source file: oasis/p31fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p31fail1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep31pass1dtd [
	"Source file: oasis/p31pass1.dtd"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep31pass1xml [
	"Source file: oasis/p31pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p31pass1.dtd" [<!ELEMENT doc EMPTY>]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep31pass2dtd [
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
XMLConformanceOasisTest class >> sourcep31pass2xml [
	"Source file: oasis/p31pass2.xml"

	^ '<!DOCTYPE doc SYSTEM "p31pass2.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep32fail1xml [
	"Source file: oasis/p32fail1.xml"

	^ '<?xml version="1.0" standalone=''yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep32fail2xml [
	"Source file: oasis/p32fail2.xml"

	^ '<?xml version="1.0" standalone="yes''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep32fail3xml [
	"Source file: oasis/p32fail3.xml"

	^ '<?xml version="1.0"standalone="yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep32fail4xml [
	"Source file: oasis/p32fail4.xml"

	^ '<?xml version="1.0" standalone=yes?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep32fail5xml [
	"Source file: oasis/p32fail5.xml"

	^ '<?xml version="1.0" standalone="YES"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep32pass1xml [
	"Source file: oasis/p32pass1.xml"

	^ '<?xml version="1.0" standalone="yes"?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep32pass2xml [
	"Source file: oasis/p32pass2.xml"

	^ '<?xml version="1.0" standalone=''no''?>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep39fail1xml [
	"Source file: oasis/p39fail1.xml"

	^ '<doc>content'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep39fail2xml [
	"Source file: oasis/p39fail2.xml"

	^ '<doc>content</a></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep39fail3xml [
	"Source file: oasis/p39fail3.xml"

	^ ''
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep39fail4xml [
	"Source file: oasis/p39fail4.xml"

	^ '<?xml version="1.0">
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep39fail5xml [
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
XMLConformanceOasisTest class >> sourcep39pass1xml [
	"Source file: oasis/p39pass1.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep39pass2xml [
	"Source file: oasis/p39pass2.xml"

	^ '<doc>content</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep40fail1xml [
	"Source file: oasis/p40fail1.xml"

	^ '<doc att="val"att2="val2"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep40fail2xml [
	"Source file: oasis/p40fail2.xml"

	^ '<3notname></3notname>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep40fail3xml [
	"Source file: oasis/p40fail3.xml"

	^ '<3notname></notname>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep40fail4xml [
	"Source file: oasis/p40fail4.xml"

	^ '< doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep40pass1xml [
	"Source file: oasis/p40pass1.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep40pass2xml [
	"Source file: oasis/p40pass2.xml"

	^ '<doc
 
></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep40pass3xml [
	"Source file: oasis/p40pass3.xml"

	^ '<doc att="val"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep40pass4xml [
	"Source file: oasis/p40pass4.xml"

	^ '<doc att="val" att2="val2"
att3="val3"
></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep41fail1xml [
	"Source file: oasis/p41fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc att (val|val2)>
]>
<doc att=val></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep41fail2xml [
	"Source file: oasis/p41fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc att (val|val2)>
]>
<doc val></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep41fail3xml [
	"Source file: oasis/p41fail3.xml"

	^ '<doc att "val"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep41pass1xml [
	"Source file: oasis/p41pass1.xml"

	^ '<doc att="val"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep41pass2xml [
	"Source file: oasis/p41pass2.xml"

	^ '<doc att
 =
  "val"></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep42fail1xml [
	"Source file: oasis/p42fail1.xml"

	^ '<doc></ doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep42fail2xml [
	"Source file: oasis/p42fail2.xml"

	^ '<doc></doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep42fail3xml [
	"Source file: oasis/p42fail3.xml"

	^ '<doc/doc/'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep42pass1xml [
	"Source file: oasis/p42pass1.xml"

	^ '<doc></doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep42pass2xml [
	"Source file: oasis/p42pass2.xml"

	^ '<doc></doc  
>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep43fail1xml [
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
XMLConformanceOasisTest class >> sourcep43fail2xml [
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
XMLConformanceOasisTest class >> sourcep43fail3xml [
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
XMLConformanceOasisTest class >> sourcep43pass1xml [
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
XMLConformanceOasisTest class >> sourcep44fail1xml [
	"Source file: oasis/p44fail1.xml"

	^ '< doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep44fail2xml [
	"Source file: oasis/p44fail2.xml"

	^ '<doc/ >'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep44fail3xml [
	"Source file: oasis/p44fail3.xml"

	^ '<doc --bad comment--/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep44fail4xml [
	"Source file: oasis/p44fail4.xml"

	^ '<doc att="val"att2="val2"/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep44fail5xml [
	"Source file: oasis/p44fail5.xml"

	^ '<doc att="val" att="val"/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep44pass1xml [
	"Source file: oasis/p44pass1.xml"

	^ '<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep44pass2xml [
	"Source file: oasis/p44pass2.xml"

	^ '<doc att="val"/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep44pass3xml [
	"Source file: oasis/p44pass3.xml"

	^ '<doc att="val"


/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep44pass4xml [
	"Source file: oasis/p44pass4.xml"

	^ '<doc
  
/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep44pass5xml [
	"Source file: oasis/p44pass5.xml"

	^ '<doc att="val"
att2="val2" att3="val3"/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep45fail1xml [
	"Source file: oasis/p45fail1.xml"

	^ '<!DOCTYPE doc
[
<!element doc EMPTY>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep45fail2xml [
	"Source file: oasis/p45fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc(#PCDATA)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep45fail3xml [
	"Source file: oasis/p45fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT (doc|a) (#PCDATA)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep45fail4xml [
	"Source file: oasis/p45fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA) --bad comment-->
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep45pass1xml [
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
XMLConformanceOasisTest class >> sourcep46fail1xml [
	"Source file: oasis/p46fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (#EMPTY)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep46fail2xml [
	"Source file: oasis/p46fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (#PCDATA) +(doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep46fail3xml [
	"Source file: oasis/p46fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (#PCDATA) -(doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep46fail4xml [
	"Source file: oasis/p46fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc) +>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep46fail5xml [
	"Source file: oasis/p46fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (#PCDATA)(doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep46fail6xml [
	"Source file: oasis/p46fail6.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a EMPTY (doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep46pass1xml [
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
XMLConformanceOasisTest class >> sourcep47fail1xml [
	"Source file: oasis/p47fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc,a?|a?)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep47fail2xml [
	"Source file: oasis/p47fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc)->
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep47fail3xml [
	"Source file: oasis/p47fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a *(doc)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep47fail4xml [
	"Source file: oasis/p47fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc) ?>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep47pass1xml [
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
XMLConformanceOasisTest class >> sourcep48fail1xml [
	"Source file: oasis/p48fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc *)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep48fail2xml [
	"Source file: oasis/p48fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a ((doc|a?) +)>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep48pass1xml [
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
XMLConformanceOasisTest class >> sourcep49fail1xml [
	"Source file: oasis/p49fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc|a?,a?)>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep49pass1xml [
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
XMLConformanceOasisTest class >> sourcep50fail1xml [
	"Source file: oasis/p50fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc,a?|a?)>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep50pass1xml [
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
XMLConformanceOasisTest class >> sourcep51fail1xml [
	"Source file: oasis/p51fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)?>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep51fail2xml [
	"Source file: oasis/p51fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)+>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep51fail3xml [
	"Source file: oasis/p51fail3.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (doc|#PCDATA)*>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep51fail4xml [
	"Source file: oasis/p51fail4.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (#PCDATA|doc)?>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep51fail5xml [
	"Source file: oasis/p51fail5.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (#PCDATA|doc,a?)*>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep51fail6xml [
	"Source file: oasis/p51fail6.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (#PCDATA,doc,a?)*>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep51fail7xml [
	"Source file: oasis/p51fail7.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ELEMENT a (#PCDATA|(doc|a))*>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep51pass1xml [
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
XMLConformanceOasisTest class >> sourcep52fail1xml [
	"Source file: oasis/p52fail1.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST  >
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep52fail2xml [
	"Source file: oasis/p52fail2.xml"

	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ATTLIST>
]>
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep52pass1xml [
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
XMLConformanceOasisTest class >> sourcep53fail1xml [
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
XMLConformanceOasisTest class >> sourcep53fail2xml [
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
XMLConformanceOasisTest class >> sourcep53fail3xml [
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
XMLConformanceOasisTest class >> sourcep53fail4xml [
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
XMLConformanceOasisTest class >> sourcep53fail5xml [
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
XMLConformanceOasisTest class >> sourcep53pass1xml [
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
XMLConformanceOasisTest class >> sourcep54fail1xml [
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
XMLConformanceOasisTest class >> sourcep54pass1xml [
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
XMLConformanceOasisTest class >> sourcep55fail1xml [
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
XMLConformanceOasisTest class >> sourcep55pass1xml [
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
XMLConformanceOasisTest class >> sourcep56fail1xml [
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
XMLConformanceOasisTest class >> sourcep56fail2xml [
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
XMLConformanceOasisTest class >> sourcep56fail3xml [
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
XMLConformanceOasisTest class >> sourcep56fail4xml [
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
XMLConformanceOasisTest class >> sourcep56fail5xml [
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
XMLConformanceOasisTest class >> sourcep56pass1xml [
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
XMLConformanceOasisTest class >> sourcep57fail1xml [
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
XMLConformanceOasisTest class >> sourcep57pass1xml [
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
XMLConformanceOasisTest class >> sourcep58fail1xml [
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
XMLConformanceOasisTest class >> sourcep58fail2xml [
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
XMLConformanceOasisTest class >> sourcep58fail3xml [
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
XMLConformanceOasisTest class >> sourcep58fail4xml [
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
XMLConformanceOasisTest class >> sourcep58fail5xml [
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
XMLConformanceOasisTest class >> sourcep58fail6xml [
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
XMLConformanceOasisTest class >> sourcep58fail7xml [
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
XMLConformanceOasisTest class >> sourcep58fail8xml [
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
XMLConformanceOasisTest class >> sourcep58pass1xml [
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
XMLConformanceOasisTest class >> sourcep59fail1xml [
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
XMLConformanceOasisTest class >> sourcep59fail2xml [
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
XMLConformanceOasisTest class >> sourcep59fail3xml [
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
XMLConformanceOasisTest class >> sourcep59pass1xml [
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
XMLConformanceOasisTest class >> sourcep60fail1xml [
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
XMLConformanceOasisTest class >> sourcep60fail2xml [
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
XMLConformanceOasisTest class >> sourcep60fail3xml [
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
XMLConformanceOasisTest class >> sourcep60fail4xml [
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
XMLConformanceOasisTest class >> sourcep60fail5xml [
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
XMLConformanceOasisTest class >> sourcep60pass1xml [
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
XMLConformanceOasisTest class >> sourcep61fail1dtd [
	"Source file: oasis/p61fail1.dtd"

	^ '<!ELEMENT doc EMPTY>
<![TEMP[
<!ATTLIST doc att CDATA #IMPLIED>
]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep61fail1xml [
	"Source file: oasis/p61fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p61fail1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep61pass1dtd [
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
XMLConformanceOasisTest class >> sourcep61pass1xml [
	"Source file: oasis/p61pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p61pass1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep62fail1dtd [
	"Source file: oasis/p62fail1.dtd"

	^ '<![include[
<!ELEMENT doc EMPTY>
]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep62fail1xml [
	"Source file: oasis/p62fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p62fail1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep62fail2dtd [
	"Source file: oasis/p62fail2.dtd"

	^ '<![INCLUDE[
<!ELEMENT doc EMPTY>
] ]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep62fail2xml [
	"Source file: oasis/p62fail2.xml"

	^ '<!DOCTYPE doc SYSTEM "p62fail2.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep62pass1dtd [
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
XMLConformanceOasisTest class >> sourcep62pass1xml [
	"Source file: oasis/p62pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p62pass1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep63fail1dtd [
	"Source file: oasis/p63fail1.dtd"

	^ '<!ELEMENT doc EMPTY>
<![ignore[]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep63fail1xml [
	"Source file: oasis/p63fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p63fail1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep63fail2dtd [
	"Source file: oasis/p63fail2.dtd"

	^ '<!ELEMENT doc EMPTY>
<![IGNORE[<![]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep63fail2xml [
	"Source file: oasis/p63fail2.xml"

	^ '<!DOCTYPE doc SYSTEM "p63fail2.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep63pass1dtd [
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
XMLConformanceOasisTest class >> sourcep63pass1xml [
	"Source file: oasis/p63pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p63pass1.dtd">
<doc/>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep64fail1dtd [
	"Source file: oasis/p64fail1.dtd"

	^ '<!ELEMENT doc EMPTY>
<![IGNORE[ ends must balance ]]>]]>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep64fail1xml [
	"Source file: oasis/p64fail1.xml"

	^ '<!DOCTYPE doc SYSTEM "p64fail1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep64fail2dtd [
	"Source file: oasis/p64fail2.dtd"

	^ '<!ELEMENT doc EMPTY>
<![IGNORE[ <![ starts must balance ]]>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep64fail2xml [
	"Source file: oasis/p64fail2.xml"

	^ '<!DOCTYPE doc SYSTEM "p64fail2.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep64pass1dtd [
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
XMLConformanceOasisTest class >> sourcep64pass1xml [
	"Source file: oasis/p64pass1.xml"

	^ '<!DOCTYPE doc SYSTEM "p64pass1.dtd">
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep66fail1xml [
	"Source file: oasis/p66fail1.xml"

	^ '<doc>&#65</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep66fail2xml [
	"Source file: oasis/p66fail2.xml"

	^ '<doc>&# 65;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep66fail3xml [
	"Source file: oasis/p66fail3.xml"

	^ '<doc>&#A;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep66fail4xml [
	"Source file: oasis/p66fail4.xml"

	^ '<doc>&#x4G;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep66fail5xml [
	"Source file: oasis/p66fail5.xml"

	^ '<doc>&#5;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep66fail6xml [
	"Source file: oasis/p66fail6.xml"

	^ '<doc>&#xd802;&#xdc02;</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep66pass1xml [
	"Source file: oasis/p66pass1.xml"

	^ '<doc>
&#65;&#9;&#x41;&#x4f;&#x4F;&#0000000000000000009;
&#x10F2ec;&#xa;
</doc>'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep68fail1xml [
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
XMLConformanceOasisTest class >> sourcep68fail2xml [
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
XMLConformanceOasisTest class >> sourcep68fail3xml [
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
XMLConformanceOasisTest class >> sourcep68pass1xml [
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
XMLConformanceOasisTest class >> sourcep69fail1xml [
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
XMLConformanceOasisTest class >> sourcep69fail2xml [
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
XMLConformanceOasisTest class >> sourcep69fail3xml [
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
XMLConformanceOasisTest class >> sourcep69pass1xml [
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
XMLConformanceOasisTest class >> sourcep70fail1xml [
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
XMLConformanceOasisTest class >> sourcep70pass1xml [
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
XMLConformanceOasisTest class >> sourcep71fail1xml [
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
XMLConformanceOasisTest class >> sourcep71fail2xml [
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
XMLConformanceOasisTest class >> sourcep71fail3xml [
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
XMLConformanceOasisTest class >> sourcep71fail4xml [
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
XMLConformanceOasisTest class >> sourcep71pass1xml [
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
XMLConformanceOasisTest class >> sourcep72fail1xml [
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
XMLConformanceOasisTest class >> sourcep72fail2xml [
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
XMLConformanceOasisTest class >> sourcep72fail3xml [
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
XMLConformanceOasisTest class >> sourcep72fail4xml [
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
XMLConformanceOasisTest class >> sourcep72pass1xml [
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
XMLConformanceOasisTest class >> sourcep73fail1xml [
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
XMLConformanceOasisTest class >> sourcep73fail2xml [
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
XMLConformanceOasisTest class >> sourcep73fail3xml [
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
XMLConformanceOasisTest class >> sourcep73fail4xml [
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
XMLConformanceOasisTest class >> sourcep73fail5xml [
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
XMLConformanceOasisTest class >> sourcep73pass1xml [
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
XMLConformanceOasisTest class >> sourcep74fail1xml [
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
XMLConformanceOasisTest class >> sourcep74fail2xml [
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
XMLConformanceOasisTest class >> sourcep74fail3xml [
	"Source file: oasis/p74fail3.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY % pe "<!--decl1-->" SYSTEM "nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep74pass1xml [
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
XMLConformanceOasisTest class >> sourcep75fail1xml [
	"Source file: oasis/p75fail1.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent PUBLIC"PublicID" "nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep75fail2xml [
	"Source file: oasis/p75fail2.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent SYSTEM"nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep75fail3xml [
	"Source file: oasis/p75fail3.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent PUBLIC "PublicID""nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep75fail4xml [
	"Source file: oasis/p75fail4.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent SYSTEM "PublicID" "nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep75fail5xml [
	"Source file: oasis/p75fail5.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent PUBLIC "PublicID" SYSTEM "nop.ent">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep75fail6xml [
	"Source file: oasis/p75fail6.xml"

	^ '<!DOCTYPE doc
[
<!ENTITY ent PUBLIC "PublicID">
]>
<doc/>
'
]

{ #category : #'xml source' }
XMLConformanceOasisTest class >> sourcep75pass1xml [
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
XMLConformanceOasisTest class >> sourcep76fail1xml [
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
XMLConformanceOasisTest class >> sourcep76fail2xml [
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
XMLConformanceOasisTest class >> sourcep76fail3xml [
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
XMLConformanceOasisTest class >> sourcep76fail4xml [
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
XMLConformanceOasisTest class >> sourcep76pass1xml [
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

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> teste2xml [
	"Source file: oasis/e2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #teste2xml.
	self
		should: [
			self
				parse: self class sourcee2xml
				documentURI: 'e2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp01fail1xml [
	"Source file: oasis/p01fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp01fail1xml.
	self
		should: [
			self
				parse: self class sourcep01fail1xml
				documentURI: 'p01fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp01fail2xml [
	"Source file: oasis/p01fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp01fail2xml.
	self
		should: [
			self
				parse: self class sourcep01fail2xml
				documentURI: 'p01fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp01fail3xml [
	"Source file: oasis/p01fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp01fail3xml.
	self
		should: [
			self
				parse: self class sourcep01fail3xml
				documentURI: 'p01fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp01fail4xml [
	"Source file: oasis/p01fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp01fail4xml.
	self
		should: [
			self
				parse: self class sourcep01fail4xml
				documentURI: 'p01fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp01pass1xml [
	"Source file: oasis/p01pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp01pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep01pass1xml
				documentURI: 'p01pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp01pass2xml [
	"Source file: oasis/p01pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp01pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep01pass2xml
				documentURI: 'p01pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp01pass3xml [
	"Source file: oasis/p01pass3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp01pass3xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep01pass3xml
				documentURI: 'p01pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail10xml [
	"Source file: oasis/p02fail10.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail10xml.
	self
		should: [
			self
				parse: self class sourcep02fail10xml
				documentURI: 'p02fail10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail11xml [
	"Source file: oasis/p02fail11.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail11xml.
	self
		should: [
			self
				parse: self class sourcep02fail11xml
				documentURI: 'p02fail11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail12xml [
	"Source file: oasis/p02fail12.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail12xml.
	self
		should: [
			self
				parse: self class sourcep02fail12xml
				documentURI: 'p02fail12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail13xml [
	"Source file: oasis/p02fail13.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail13xml.
	self
		should: [
			self
				parse: self class sourcep02fail13xml
				documentURI: 'p02fail13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail14xml [
	"Source file: oasis/p02fail14.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail14xml.
	self
		should: [
			self
				parse: self class sourcep02fail14xml
				documentURI: 'p02fail14.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail15xml [
	"Source file: oasis/p02fail15.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail15xml.
	self
		should: [
			self
				parse: self class sourcep02fail15xml
				documentURI: 'p02fail15.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail16xml [
	"Source file: oasis/p02fail16.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail16xml.
	self
		should: [
			self
				parse: self class sourcep02fail16xml
				documentURI: 'p02fail16.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail17xml [
	"Source file: oasis/p02fail17.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail17xml.
	self
		should: [
			self
				parse: self class sourcep02fail17xml
				documentURI: 'p02fail17.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail18xml [
	"Source file: oasis/p02fail18.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail18xml.
	self
		should: [
			self
				parse: self class sourcep02fail18xml
				documentURI: 'p02fail18.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail19xml [
	"Source file: oasis/p02fail19.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail19xml.
	self
		should: [
			self
				parse: self class sourcep02fail19xml
				documentURI: 'p02fail19.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail1xml [
	"Source file: oasis/p02fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail1xml.
	self
		should: [
			self
				parse: self class sourcep02fail1xml
				documentURI: 'p02fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail20xml [
	"Source file: oasis/p02fail20.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail20xml.
	self
		should: [
			self
				parse: self class sourcep02fail20xml
				documentURI: 'p02fail20.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail21xml [
	"Source file: oasis/p02fail21.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail21xml.
	self
		should: [
			self
				parse: self class sourcep02fail21xml
				documentURI: 'p02fail21.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail22xml [
	"Source file: oasis/p02fail22.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail22xml.
	self
		should: [
			self
				parse: self class sourcep02fail22xml
				documentURI: 'p02fail22.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail23xml [
	"Source file: oasis/p02fail23.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail23xml.
	self
		should: [
			self
				parse: self class sourcep02fail23xml
				documentURI: 'p02fail23.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail24xml [
	"Source file: oasis/p02fail24.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail24xml.
	self
		should: [
			self
				parse: self class sourcep02fail24xml
				documentURI: 'p02fail24.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail25xml [
	"Source file: oasis/p02fail25.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail25xml.
	self
		should: [
			self
				parse: self class sourcep02fail25xml
				documentURI: 'p02fail25.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail26xml [
	"Source file: oasis/p02fail26.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail26xml.
	self
		should: [
			self
				parse: self class sourcep02fail26xml
				documentURI: 'p02fail26.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail27xml [
	"Source file: oasis/p02fail27.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail27xml.
	self
		should: [
			self
				parse: self class sourcep02fail27xml
				documentURI: 'p02fail27.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail28xml [
	"Source file: oasis/p02fail28.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail28xml.
	self
		should: [
			self
				parse: self class sourcep02fail28xml
				documentURI: 'p02fail28.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail29xml [
	"Source file: oasis/p02fail29.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail29xml.
	self
		should: [
			self
				parse: self class sourcep02fail29xml
				documentURI: 'p02fail29.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail2xml [
	"Source file: oasis/p02fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail2xml.
	self
		should: [
			self
				parse: self class sourcep02fail2xml
				documentURI: 'p02fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail30xml [
	"Source file: oasis/p02fail30.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail30xml.
	self
		should: [
			self
				parse: self class sourcep02fail30xml
				documentURI: 'p02fail30.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail31xml [
	"Source file: oasis/p02fail31.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail31xml.
	self
		should: [
			self
				parse: self class sourcep02fail31xml
				documentURI: 'p02fail31.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail3xml [
	"Source file: oasis/p02fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail3xml.
	self
		should: [
			self
				parse: self class sourcep02fail3xml
				documentURI: 'p02fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail4xml [
	"Source file: oasis/p02fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail4xml.
	self
		should: [
			self
				parse: self class sourcep02fail4xml
				documentURI: 'p02fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail5xml [
	"Source file: oasis/p02fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail5xml.
	self
		should: [
			self
				parse: self class sourcep02fail5xml
				documentURI: 'p02fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail6xml [
	"Source file: oasis/p02fail6.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail6xml.
	self
		should: [
			self
				parse: self class sourcep02fail6xml
				documentURI: 'p02fail6.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail7xml [
	"Source file: oasis/p02fail7.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail7xml.
	self
		should: [
			self
				parse: self class sourcep02fail7xml
				documentURI: 'p02fail7.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail8xml [
	"Source file: oasis/p02fail8.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail8xml.
	self
		should: [
			self
				parse: self class sourcep02fail8xml
				documentURI: 'p02fail8.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp02fail9xml [
	"Source file: oasis/p02fail9.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp02fail9xml.
	self
		should: [
			self
				parse: self class sourcep02fail9xml
				documentURI: 'p02fail9.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail10xml [
	"Source file: oasis/p03fail10.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail10xml.
	self
		should: [
			self
				parse: self class sourcep03fail10xml
				documentURI: 'p03fail10.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail11xml [
	"Source file: oasis/p03fail11.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail11xml.
	self
		should: [
			self
				parse: self class sourcep03fail11xml
				documentURI: 'p03fail11.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail12xml [
	"Source file: oasis/p03fail12.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail12xml.
	self
		should: [
			self
				parse: self class sourcep03fail12xml
				documentURI: 'p03fail12.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail13xml [
	"Source file: oasis/p03fail13.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail13xml.
	self
		should: [
			self
				parse: self class sourcep03fail13xml
				documentURI: 'p03fail13.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail14xml [
	"Source file: oasis/p03fail14.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail14xml.
	self
		should: [
			self
				parse: self class sourcep03fail14xml
				documentURI: 'p03fail14.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail15xml [
	"Source file: oasis/p03fail15.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail15xml.
	self
		should: [
			self
				parse: self class sourcep03fail15xml
				documentURI: 'p03fail15.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail16xml [
	"Source file: oasis/p03fail16.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail16xml.
	self
		should: [
			self
				parse: self class sourcep03fail16xml
				documentURI: 'p03fail16.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail17xml [
	"Source file: oasis/p03fail17.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail17xml.
	self
		should: [
			self
				parse: self class sourcep03fail17xml
				documentURI: 'p03fail17.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail18xml [
	"Source file: oasis/p03fail18.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail18xml.
	self
		should: [
			self
				parse: self class sourcep03fail18xml
				documentURI: 'p03fail18.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail19xml [
	"Source file: oasis/p03fail19.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail19xml.
	self
		should: [
			self
				parse: self class sourcep03fail19xml
				documentURI: 'p03fail19.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail20xml [
	"Source file: oasis/p03fail20.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail20xml.
	self
		should: [
			self
				parse: self class sourcep03fail20xml
				documentURI: 'p03fail20.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail21xml [
	"Source file: oasis/p03fail21.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail21xml.
	self
		should: [
			self
				parse: self class sourcep03fail21xml
				documentURI: 'p03fail21.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail22xml [
	"Source file: oasis/p03fail22.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail22xml.
	self
		should: [
			self
				parse: self class sourcep03fail22xml
				documentURI: 'p03fail22.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail23xml [
	"Source file: oasis/p03fail23.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail23xml.
	self
		should: [
			self
				parse: self class sourcep03fail23xml
				documentURI: 'p03fail23.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail24xml [
	"Source file: oasis/p03fail24.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail24xml.
	self
		should: [
			self
				parse: self class sourcep03fail24xml
				documentURI: 'p03fail24.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail25xml [
	"Source file: oasis/p03fail25.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail25xml.
	self
		should: [
			self
				parse: self class sourcep03fail25xml
				documentURI: 'p03fail25.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail26xml [
	"Source file: oasis/p03fail26.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail26xml.
	self
		should: [
			self
				parse: self class sourcep03fail26xml
				documentURI: 'p03fail26.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail27xml [
	"Source file: oasis/p03fail27.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail27xml.
	self
		should: [
			self
				parse: self class sourcep03fail27xml
				documentURI: 'p03fail27.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail28xml [
	"Source file: oasis/p03fail28.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail28xml.
	self
		should: [
			self
				parse: self class sourcep03fail28xml
				documentURI: 'p03fail28.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail29xml [
	"Source file: oasis/p03fail29.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail29xml.
	self
		should: [
			self
				parse: self class sourcep03fail29xml
				documentURI: 'p03fail29.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail2xml [
	"Source file: oasis/p03fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail2xml.
	self
		should: [
			self
				parse: self class sourcep03fail2xml
				documentURI: 'p03fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail3xml [
	"Source file: oasis/p03fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail3xml.
	self
		should: [
			self
				parse: self class sourcep03fail3xml
				documentURI: 'p03fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail4xml [
	"Source file: oasis/p03fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail4xml.
	self
		should: [
			self
				parse: self class sourcep03fail4xml
				documentURI: 'p03fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail5xml [
	"Source file: oasis/p03fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail5xml.
	self
		should: [
			self
				parse: self class sourcep03fail5xml
				documentURI: 'p03fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail7xml [
	"Source file: oasis/p03fail7.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail7xml.
	self
		should: [
			self
				parse: self class sourcep03fail7xml
				documentURI: 'p03fail7.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail8xml [
	"Source file: oasis/p03fail8.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail8xml.
	self
		should: [
			self
				parse: self class sourcep03fail8xml
				documentURI: 'p03fail8.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp03fail9xml [
	"Source file: oasis/p03fail9.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03fail9xml.
	self
		should: [
			self
				parse: self class sourcep03fail9xml
				documentURI: 'p03fail9.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp03pass1xml [
	"Source file: oasis/p03pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp03pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep03pass1xml
				documentURI: 'p03pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp04fail1xml [
	"Source file: oasis/p04fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp04fail1xml.
	self
		should: [
			self
				parse: self class sourcep04fail1xml
				documentURI: 'p04fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp04fail2xml [
	"Source file: oasis/p04fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp04fail2xml.
	self
		should: [
			self
				parse: self class sourcep04fail2xml
				documentURI: 'p04fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp04fail3xml [
	"Source file: oasis/p04fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp04fail3xml.
	self
		should: [
			self
				parse: self class sourcep04fail3xml
				documentURI: 'p04fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp04pass1xml [
	"Source file: oasis/p04pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp04pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep04pass1xml
				documentURI: 'p04pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp05fail1xml [
	"Source file: oasis/p05fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp05fail1xml.
	self
		should: [
			self
				parse: self class sourcep05fail1xml
				documentURI: 'p05fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp05fail2xml [
	"Source file: oasis/p05fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp05fail2xml.
	self
		should: [
			self
				parse: self class sourcep05fail2xml
				documentURI: 'p05fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp05fail3xml [
	"Source file: oasis/p05fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp05fail3xml.
	self
		should: [
			self
				parse: self class sourcep05fail3xml
				documentURI: 'p05fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp05fail4xml [
	"Source file: oasis/p05fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp05fail4xml.
	self
		should: [
			self
				parse: self class sourcep05fail4xml
				documentURI: 'p05fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp05fail5xml [
	"Source file: oasis/p05fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp05fail5xml.
	self
		should: [
			self
				parse: self class sourcep05fail5xml
				documentURI: 'p05fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp05pass1xml [
	"Source file: oasis/p05pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp05pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep05pass1xml
				documentURI: 'p05pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp06fail1xml [
	"Source file: oasis/p06fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp06fail1xml.
	self
		should: [
			self
				parse: self class sourcep06fail1xml
				documentURI: 'p06fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp06pass1xml [
	"Source file: oasis/p06pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp06pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep06pass1xml
				documentURI: 'p06pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp07pass1xml [
	"Source file: oasis/p07pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp07pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep07pass1xml
				documentURI: 'p07pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp08fail1xml [
	"Source file: oasis/p08fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp08fail1xml.
	self
		should: [
			self
				parse: self class sourcep08fail1xml
				documentURI: 'p08fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp08fail2xml [
	"Source file: oasis/p08fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp08fail2xml.
	self
		should: [
			self
				parse: self class sourcep08fail2xml
				documentURI: 'p08fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp08pass1xml [
	"Source file: oasis/p08pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp08pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep08pass1xml
				documentURI: 'p08pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp09fail1xml [
	"Source file: oasis/p09fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp09fail1xml.
	self
		should: [
			self
				parse: self class sourcep09fail1xml
				documentURI: 'p09fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp09fail2xml [
	"Source file: oasis/p09fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp09fail2xml.
	self
		should: [
			self
				parse: self class sourcep09fail2xml
				documentURI: 'p09fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp09fail3xml [
	"Source file: oasis/p09fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp09fail3xml.
	self
		should: [
			self
				parse: self class sourcep09fail3xml
				documentURI: 'p09fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp09fail4xml [
	"Source file: oasis/p09fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp09fail4xml.
	self
		should: [
			self
				parse: self class sourcep09fail4xml
				documentURI: 'p09fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp09fail5xml [
	"Source file: oasis/p09fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp09fail5xml.
	self
		should: [
			self
				parse: self class sourcep09fail5xml
				documentURI: 'p09fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp09pass1xml [
	"Source file: oasis/p09pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp09pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep09pass1xml
				documentURI: 'p09pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp10fail1xml [
	"Source file: oasis/p10fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp10fail1xml.
	self
		should: [
			self
				parse: self class sourcep10fail1xml
				documentURI: 'p10fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp10fail2xml [
	"Source file: oasis/p10fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp10fail2xml.
	self
		should: [
			self
				parse: self class sourcep10fail2xml
				documentURI: 'p10fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp10fail3xml [
	"Source file: oasis/p10fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp10fail3xml.
	self
		should: [
			self
				parse: self class sourcep10fail3xml
				documentURI: 'p10fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp10pass1xml [
	"Source file: oasis/p10pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp10pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep10pass1xml
				documentURI: 'p10pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp11fail1xml [
	"Source file: oasis/p11fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp11fail1xml.
	self
		should: [
			self
				parse: self class sourcep11fail1xml
				documentURI: 'p11fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp11fail2xml [
	"Source file: oasis/p11fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp11fail2xml.
	self
		should: [
			self
				parse: self class sourcep11fail2xml
				documentURI: 'p11fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp11pass1xml [
	"Source file: oasis/p11pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp11pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep11pass1xml
				documentURI: 'p11pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp12fail1xml [
	"Source file: oasis/p12fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp12fail1xml.
	self
		should: [
			self
				parse: self class sourcep12fail1xml
				documentURI: 'p12fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp12fail2xml [
	"Source file: oasis/p12fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp12fail2xml.
	self
		should: [
			self
				parse: self class sourcep12fail2xml
				documentURI: 'p12fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp12fail3xml [
	"Source file: oasis/p12fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp12fail3xml.
	self
		should: [
			self
				parse: self class sourcep12fail3xml
				documentURI: 'p12fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp12fail4xml [
	"Source file: oasis/p12fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp12fail4xml.
	self
		should: [
			self
				parse: self class sourcep12fail4xml
				documentURI: 'p12fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp12fail5xml [
	"Source file: oasis/p12fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp12fail5xml.
	self
		should: [
			self
				parse: self class sourcep12fail5xml
				documentURI: 'p12fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp12fail6xml [
	"Source file: oasis/p12fail6.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp12fail6xml.
	self
		should: [
			self
				parse: self class sourcep12fail6xml
				documentURI: 'p12fail6.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp12fail7xml [
	"Source file: oasis/p12fail7.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp12fail7xml.
	self
		should: [
			self
				parse: self class sourcep12fail7xml
				documentURI: 'p12fail7.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp12pass1xml [
	"Source file: oasis/p12pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp12pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep12pass1xml
				documentURI: 'p12pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp14fail1xml [
	"Source file: oasis/p14fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp14fail1xml.
	self
		should: [
			self
				parse: self class sourcep14fail1xml
				documentURI: 'p14fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp14fail2xml [
	"Source file: oasis/p14fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp14fail2xml.
	self
		should: [
			self
				parse: self class sourcep14fail2xml
				documentURI: 'p14fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp14fail3xml [
	"Source file: oasis/p14fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp14fail3xml.
	self
		should: [
			self
				parse: self class sourcep14fail3xml
				documentURI: 'p14fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp14pass1xml [
	"Source file: oasis/p14pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp14pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep14pass1xml
				documentURI: 'p14pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp15fail1xml [
	"Source file: oasis/p15fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp15fail1xml.
	self
		should: [
			self
				parse: self class sourcep15fail1xml
				documentURI: 'p15fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp15fail2xml [
	"Source file: oasis/p15fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp15fail2xml.
	self
		should: [
			self
				parse: self class sourcep15fail2xml
				documentURI: 'p15fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp15fail3xml [
	"Source file: oasis/p15fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp15fail3xml.
	self
		should: [
			self
				parse: self class sourcep15fail3xml
				documentURI: 'p15fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp15pass1xml [
	"Source file: oasis/p15pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp15pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep15pass1xml
				documentURI: 'p15pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp16fail1xml [
	"Source file: oasis/p16fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp16fail1xml.
	self
		should: [
			self
				parse: self class sourcep16fail1xml
				documentURI: 'p16fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp16fail2xml [
	"Source file: oasis/p16fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp16fail2xml.
	self
		should: [
			self
				parse: self class sourcep16fail2xml
				documentURI: 'p16fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp16fail3xml [
	"Source file: oasis/p16fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp16fail3xml.
	self
		should: [
			self
				parse: self class sourcep16fail3xml
				documentURI: 'p16fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp16pass1xml [
	"Source file: oasis/p16pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp16pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep16pass1xml
				documentURI: 'p16pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp16pass2xml [
	"Source file: oasis/p16pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp16pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep16pass2xml
				documentURI: 'p16pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp16pass3xml [
	"Source file: oasis/p16pass3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp16pass3xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep16pass3xml
				documentURI: 'p16pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp18fail1xml [
	"Source file: oasis/p18fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp18fail1xml.
	self
		should: [
			self
				parse: self class sourcep18fail1xml
				documentURI: 'p18fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp18fail2xml [
	"Source file: oasis/p18fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp18fail2xml.
	self
		should: [
			self
				parse: self class sourcep18fail2xml
				documentURI: 'p18fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp18fail3xml [
	"Source file: oasis/p18fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp18fail3xml.
	self
		should: [
			self
				parse: self class sourcep18fail3xml
				documentURI: 'p18fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp18pass1xml [
	"Source file: oasis/p18pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp18pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep18pass1xml
				documentURI: 'p18pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp22fail1xml [
	"Source file: oasis/p22fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp22fail1xml.
	self
		should: [
			self
				parse: self class sourcep22fail1xml
				documentURI: 'p22fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp22fail2xml [
	"Source file: oasis/p22fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp22fail2xml.
	self
		should: [
			self
				parse: self class sourcep22fail2xml
				documentURI: 'p22fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp22pass1xml [
	"Source file: oasis/p22pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp22pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass1xml
				documentURI: 'p22pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp22pass2xml [
	"Source file: oasis/p22pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp22pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass2xml
				documentURI: 'p22pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp22pass3xml [
	"Source file: oasis/p22pass3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp22pass3xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass3xml
				documentURI: 'p22pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp22pass4xml [
	"Source file: oasis/p22pass4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp22pass4xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass4xml
				documentURI: 'p22pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp22pass5xml [
	"Source file: oasis/p22pass5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp22pass5xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass5xml
				documentURI: 'p22pass5.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp22pass6xml [
	"Source file: oasis/p22pass6.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp22pass6xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep22pass6xml
				documentURI: 'p22pass6.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp23fail1xml [
	"Source file: oasis/p23fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp23fail1xml.
	self
		should: [
			self
				parse: self class sourcep23fail1xml
				documentURI: 'p23fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp23fail2xml [
	"Source file: oasis/p23fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp23fail2xml.
	self
		should: [
			self
				parse: self class sourcep23fail2xml
				documentURI: 'p23fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp23fail3xml [
	"Source file: oasis/p23fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp23fail3xml.
	self
		should: [
			self
				parse: self class sourcep23fail3xml
				documentURI: 'p23fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp23fail4xml [
	"Source file: oasis/p23fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp23fail4xml.
	self
		should: [
			self
				parse: self class sourcep23fail4xml
				documentURI: 'p23fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp23fail5xml [
	"Source file: oasis/p23fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp23fail5xml.
	self
		should: [
			self
				parse: self class sourcep23fail5xml
				documentURI: 'p23fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp23pass1xml [
	"Source file: oasis/p23pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp23pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep23pass1xml
				documentURI: 'p23pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp23pass2xml [
	"Source file: oasis/p23pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp23pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep23pass2xml
				documentURI: 'p23pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp23pass3xml [
	"Source file: oasis/p23pass3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp23pass3xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep23pass3xml
				documentURI: 'p23pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp23pass4xml [
	"Source file: oasis/p23pass4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp23pass4xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep23pass4xml
				documentURI: 'p23pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp24fail1xml [
	"Source file: oasis/p24fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp24fail1xml.
	self
		should: [
			self
				parse: self class sourcep24fail1xml
				documentURI: 'p24fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp24fail2xml [
	"Source file: oasis/p24fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp24fail2xml.
	self
		should: [
			self
				parse: self class sourcep24fail2xml
				documentURI: 'p24fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp24pass1xml [
	"Source file: oasis/p24pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp24pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep24pass1xml
				documentURI: 'p24pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp24pass2xml [
	"Source file: oasis/p24pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp24pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep24pass2xml
				documentURI: 'p24pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp24pass3xml [
	"Source file: oasis/p24pass3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp24pass3xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep24pass3xml
				documentURI: 'p24pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp24pass4xml [
	"Source file: oasis/p24pass4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp24pass4xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep24pass4xml
				documentURI: 'p24pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp25fail1xml [
	"Source file: oasis/p25fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp25fail1xml.
	self
		should: [
			self
				parse: self class sourcep25fail1xml
				documentURI: 'p25fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp25pass1xml [
	"Source file: oasis/p25pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp25pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep25pass1xml
				documentURI: 'p25pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp25pass2xml [
	"Source file: oasis/p25pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp25pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep25pass2xml
				documentURI: 'p25pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp26fail1xml [
	"Source file: oasis/p26fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp26fail1xml.
	self
		should: [
			self
				parse: self class sourcep26fail1xml
				documentURI: 'p26fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp26fail2xml [
	"Source file: oasis/p26fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp26fail2xml.
	self
		should: [
			self
				parse: self class sourcep26fail2xml
				documentURI: 'p26fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp26pass1xml [
	"Source file: oasis/p26pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp26pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep26pass1xml
				documentURI: 'p26pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp27fail1xml [
	"Source file: oasis/p27fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp27fail1xml.
	self
		should: [
			self
				parse: self class sourcep27fail1xml
				documentURI: 'p27fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp27pass1xml [
	"Source file: oasis/p27pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp27pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep27pass1xml
				documentURI: 'p27pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp27pass2xml [
	"Source file: oasis/p27pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp27pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep27pass2xml
				documentURI: 'p27pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp27pass3xml [
	"Source file: oasis/p27pass3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp27pass3xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep27pass3xml
				documentURI: 'p27pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp27pass4xml [
	"Source file: oasis/p27pass4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp27pass4xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep27pass4xml
				documentURI: 'p27pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp28fail1xml [
	"Source file: oasis/p28fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp28fail1xml.
	self
		should: [
			self
				parse: self class sourcep28fail1xml
				documentURI: 'p28fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp28pass1xml [
	"Source file: oasis/p28pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp28pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass1xml
				documentURI: 'p28pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp28pass2xml [
	"Source file: oasis/p28pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp28pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass2xml
				documentURI: 'p28pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp28pass3xml [
	"Source file: oasis/p28pass3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp28pass3xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass3xml
				documentURI: 'p28pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp28pass4xml [
	"Source file: oasis/p28pass4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp28pass4xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass4xml
				documentURI: 'p28pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp28pass5xml [
	"Source file: oasis/p28pass5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp28pass5xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep28pass5xml
				documentURI: 'p28pass5.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp29fail1xml [
	"Source file: oasis/p29fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp29fail1xml.
	self
		should: [
			self
				parse: self class sourcep29fail1xml
				documentURI: 'p29fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp29pass1xml [
	"Source file: oasis/p29pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp29pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep29pass1xml
				documentURI: 'p29pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp30fail1xml [
	"Source file: oasis/p30fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp30fail1xml.
	self
		should: [
			self
				parse: self class sourcep30fail1xml
				documentURI: 'p30fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp30pass1xml [
	"Source file: oasis/p30pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp30pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep30pass1xml
				documentURI: 'p30pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp30pass2xml [
	"Source file: oasis/p30pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp30pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep30pass2xml
				documentURI: 'p30pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp31fail1xml [
	"Source file: oasis/p31fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp31fail1xml.
	self
		should: [
			self
				parse: self class sourcep31fail1xml
				documentURI: 'p31fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp31pass1xml [
	"Source file: oasis/p31pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp31pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep31pass1xml
				documentURI: 'p31pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp31pass2xml [
	"Source file: oasis/p31pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp31pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep31pass2xml
				documentURI: 'p31pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp32fail1xml [
	"Source file: oasis/p32fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp32fail1xml.
	self
		should: [
			self
				parse: self class sourcep32fail1xml
				documentURI: 'p32fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp32fail2xml [
	"Source file: oasis/p32fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp32fail2xml.
	self
		should: [
			self
				parse: self class sourcep32fail2xml
				documentURI: 'p32fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp32fail3xml [
	"Source file: oasis/p32fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp32fail3xml.
	self
		should: [
			self
				parse: self class sourcep32fail3xml
				documentURI: 'p32fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp32fail4xml [
	"Source file: oasis/p32fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp32fail4xml.
	self
		should: [
			self
				parse: self class sourcep32fail4xml
				documentURI: 'p32fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp32fail5xml [
	"Source file: oasis/p32fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp32fail5xml.
	self
		should: [
			self
				parse: self class sourcep32fail5xml
				documentURI: 'p32fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp32pass1xml [
	"Source file: oasis/p32pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp32pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep32pass1xml
				documentURI: 'p32pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp32pass2xml [
	"Source file: oasis/p32pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp32pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep32pass2xml
				documentURI: 'p32pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp39fail1xml [
	"Source file: oasis/p39fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp39fail1xml.
	self
		should: [
			self
				parse: self class sourcep39fail1xml
				documentURI: 'p39fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp39fail2xml [
	"Source file: oasis/p39fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp39fail2xml.
	self
		should: [
			self
				parse: self class sourcep39fail2xml
				documentURI: 'p39fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp39fail3xml [
	"Source file: oasis/p39fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp39fail3xml.
	self
		should: [
			self
				parse: self class sourcep39fail3xml
				documentURI: 'p39fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp39fail4xml [
	"Source file: oasis/p39fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp39fail4xml.
	self
		should: [
			self
				parse: self class sourcep39fail4xml
				documentURI: 'p39fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp39fail5xml [
	"Source file: oasis/p39fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp39fail5xml.
	self
		should: [
			self
				parse: self class sourcep39fail5xml
				documentURI: 'p39fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp39pass1xml [
	"Source file: oasis/p39pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp39pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep39pass1xml
				documentURI: 'p39pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp39pass2xml [
	"Source file: oasis/p39pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp39pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep39pass2xml
				documentURI: 'p39pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp40fail1xml [
	"Source file: oasis/p40fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp40fail1xml.
	self
		should: [
			self
				parse: self class sourcep40fail1xml
				documentURI: 'p40fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp40fail2xml [
	"Source file: oasis/p40fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp40fail2xml.
	self
		should: [
			self
				parse: self class sourcep40fail2xml
				documentURI: 'p40fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp40fail3xml [
	"Source file: oasis/p40fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp40fail3xml.
	self
		should: [
			self
				parse: self class sourcep40fail3xml
				documentURI: 'p40fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp40fail4xml [
	"Source file: oasis/p40fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp40fail4xml.
	self
		should: [
			self
				parse: self class sourcep40fail4xml
				documentURI: 'p40fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp40pass1xml [
	"Source file: oasis/p40pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp40pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep40pass1xml
				documentURI: 'p40pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp40pass2xml [
	"Source file: oasis/p40pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp40pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep40pass2xml
				documentURI: 'p40pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp40pass3xml [
	"Source file: oasis/p40pass3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp40pass3xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep40pass3xml
				documentURI: 'p40pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp40pass4xml [
	"Source file: oasis/p40pass4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp40pass4xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep40pass4xml
				documentURI: 'p40pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp41fail1xml [
	"Source file: oasis/p41fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp41fail1xml.
	self
		should: [
			self
				parse: self class sourcep41fail1xml
				documentURI: 'p41fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp41fail2xml [
	"Source file: oasis/p41fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp41fail2xml.
	self
		should: [
			self
				parse: self class sourcep41fail2xml
				documentURI: 'p41fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp41fail3xml [
	"Source file: oasis/p41fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp41fail3xml.
	self
		should: [
			self
				parse: self class sourcep41fail3xml
				documentURI: 'p41fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp41pass1xml [
	"Source file: oasis/p41pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp41pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep41pass1xml
				documentURI: 'p41pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp41pass2xml [
	"Source file: oasis/p41pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp41pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep41pass2xml
				documentURI: 'p41pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp42fail1xml [
	"Source file: oasis/p42fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp42fail1xml.
	self
		should: [
			self
				parse: self class sourcep42fail1xml
				documentURI: 'p42fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp42fail2xml [
	"Source file: oasis/p42fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp42fail2xml.
	self
		should: [
			self
				parse: self class sourcep42fail2xml
				documentURI: 'p42fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp42fail3xml [
	"Source file: oasis/p42fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp42fail3xml.
	self
		should: [
			self
				parse: self class sourcep42fail3xml
				documentURI: 'p42fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp42pass1xml [
	"Source file: oasis/p42pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp42pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep42pass1xml
				documentURI: 'p42pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp42pass2xml [
	"Source file: oasis/p42pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp42pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep42pass2xml
				documentURI: 'p42pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp43fail1xml [
	"Source file: oasis/p43fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp43fail1xml.
	self
		should: [
			self
				parse: self class sourcep43fail1xml
				documentURI: 'p43fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp43fail2xml [
	"Source file: oasis/p43fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp43fail2xml.
	self
		should: [
			self
				parse: self class sourcep43fail2xml
				documentURI: 'p43fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp43fail3xml [
	"Source file: oasis/p43fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp43fail3xml.
	self
		should: [
			self
				parse: self class sourcep43fail3xml
				documentURI: 'p43fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp43pass1xml [
	"Source file: oasis/p43pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp43pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep43pass1xml
				documentURI: 'p43pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp44fail1xml [
	"Source file: oasis/p44fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44fail1xml.
	self
		should: [
			self
				parse: self class sourcep44fail1xml
				documentURI: 'p44fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp44fail2xml [
	"Source file: oasis/p44fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44fail2xml.
	self
		should: [
			self
				parse: self class sourcep44fail2xml
				documentURI: 'p44fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp44fail3xml [
	"Source file: oasis/p44fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44fail3xml.
	self
		should: [
			self
				parse: self class sourcep44fail3xml
				documentURI: 'p44fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp44fail4xml [
	"Source file: oasis/p44fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44fail4xml.
	self
		should: [
			self
				parse: self class sourcep44fail4xml
				documentURI: 'p44fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp44fail5xml [
	"Source file: oasis/p44fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44fail5xml.
	self
		should: [
			self
				parse: self class sourcep44fail5xml
				documentURI: 'p44fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp44pass1xml [
	"Source file: oasis/p44pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass1xml
				documentURI: 'p44pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp44pass2xml [
	"Source file: oasis/p44pass2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44pass2xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass2xml
				documentURI: 'p44pass2.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp44pass3xml [
	"Source file: oasis/p44pass3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44pass3xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass3xml
				documentURI: 'p44pass3.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp44pass4xml [
	"Source file: oasis/p44pass4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44pass4xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass4xml
				documentURI: 'p44pass4.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp44pass5xml [
	"Source file: oasis/p44pass5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp44pass5xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep44pass5xml
				documentURI: 'p44pass5.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp45fail1xml [
	"Source file: oasis/p45fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp45fail1xml.
	self
		should: [
			self
				parse: self class sourcep45fail1xml
				documentURI: 'p45fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp45fail2xml [
	"Source file: oasis/p45fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp45fail2xml.
	self
		should: [
			self
				parse: self class sourcep45fail2xml
				documentURI: 'p45fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp45fail3xml [
	"Source file: oasis/p45fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp45fail3xml.
	self
		should: [
			self
				parse: self class sourcep45fail3xml
				documentURI: 'p45fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp45fail4xml [
	"Source file: oasis/p45fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp45fail4xml.
	self
		should: [
			self
				parse: self class sourcep45fail4xml
				documentURI: 'p45fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp45pass1xml [
	"Source file: oasis/p45pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp45pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep45pass1xml
				documentURI: 'p45pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp46fail1xml [
	"Source file: oasis/p46fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp46fail1xml.
	self
		should: [
			self
				parse: self class sourcep46fail1xml
				documentURI: 'p46fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp46fail2xml [
	"Source file: oasis/p46fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp46fail2xml.
	self
		should: [
			self
				parse: self class sourcep46fail2xml
				documentURI: 'p46fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp46fail3xml [
	"Source file: oasis/p46fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp46fail3xml.
	self
		should: [
			self
				parse: self class sourcep46fail3xml
				documentURI: 'p46fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp46fail4xml [
	"Source file: oasis/p46fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp46fail4xml.
	self
		should: [
			self
				parse: self class sourcep46fail4xml
				documentURI: 'p46fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp46fail5xml [
	"Source file: oasis/p46fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp46fail5xml.
	self
		should: [
			self
				parse: self class sourcep46fail5xml
				documentURI: 'p46fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp46fail6xml [
	"Source file: oasis/p46fail6.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp46fail6xml.
	self
		should: [
			self
				parse: self class sourcep46fail6xml
				documentURI: 'p46fail6.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp46pass1xml [
	"Source file: oasis/p46pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp46pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep46pass1xml
				documentURI: 'p46pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp47fail1xml [
	"Source file: oasis/p47fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp47fail1xml.
	self
		should: [
			self
				parse: self class sourcep47fail1xml
				documentURI: 'p47fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp47fail2xml [
	"Source file: oasis/p47fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp47fail2xml.
	self
		should: [
			self
				parse: self class sourcep47fail2xml
				documentURI: 'p47fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp47fail3xml [
	"Source file: oasis/p47fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp47fail3xml.
	self
		should: [
			self
				parse: self class sourcep47fail3xml
				documentURI: 'p47fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp47fail4xml [
	"Source file: oasis/p47fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp47fail4xml.
	self
		should: [
			self
				parse: self class sourcep47fail4xml
				documentURI: 'p47fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp47pass1xml [
	"Source file: oasis/p47pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp47pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep47pass1xml
				documentURI: 'p47pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp48fail1xml [
	"Source file: oasis/p48fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp48fail1xml.
	self
		should: [
			self
				parse: self class sourcep48fail1xml
				documentURI: 'p48fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp48fail2xml [
	"Source file: oasis/p48fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp48fail2xml.
	self
		should: [
			self
				parse: self class sourcep48fail2xml
				documentURI: 'p48fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp48pass1xml [
	"Source file: oasis/p48pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp48pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep48pass1xml
				documentURI: 'p48pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp49fail1xml [
	"Source file: oasis/p49fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp49fail1xml.
	self
		should: [
			self
				parse: self class sourcep49fail1xml
				documentURI: 'p49fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp49pass1xml [
	"Source file: oasis/p49pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp49pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep49pass1xml
				documentURI: 'p49pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp50fail1xml [
	"Source file: oasis/p50fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp50fail1xml.
	self
		should: [
			self
				parse: self class sourcep50fail1xml
				documentURI: 'p50fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp50pass1xml [
	"Source file: oasis/p50pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp50pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep50pass1xml
				documentURI: 'p50pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp51fail1xml [
	"Source file: oasis/p51fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp51fail1xml.
	self
		should: [
			self
				parse: self class sourcep51fail1xml
				documentURI: 'p51fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp51fail2xml [
	"Source file: oasis/p51fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp51fail2xml.
	self
		should: [
			self
				parse: self class sourcep51fail2xml
				documentURI: 'p51fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp51fail3xml [
	"Source file: oasis/p51fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp51fail3xml.
	self
		should: [
			self
				parse: self class sourcep51fail3xml
				documentURI: 'p51fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp51fail4xml [
	"Source file: oasis/p51fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp51fail4xml.
	self
		should: [
			self
				parse: self class sourcep51fail4xml
				documentURI: 'p51fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp51fail5xml [
	"Source file: oasis/p51fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp51fail5xml.
	self
		should: [
			self
				parse: self class sourcep51fail5xml
				documentURI: 'p51fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp51fail6xml [
	"Source file: oasis/p51fail6.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp51fail6xml.
	self
		should: [
			self
				parse: self class sourcep51fail6xml
				documentURI: 'p51fail6.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp51fail7xml [
	"Source file: oasis/p51fail7.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp51fail7xml.
	self
		should: [
			self
				parse: self class sourcep51fail7xml
				documentURI: 'p51fail7.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp51pass1xml [
	"Source file: oasis/p51pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp51pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep51pass1xml
				documentURI: 'p51pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp52fail1xml [
	"Source file: oasis/p52fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp52fail1xml.
	self
		should: [
			self
				parse: self class sourcep52fail1xml
				documentURI: 'p52fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp52fail2xml [
	"Source file: oasis/p52fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp52fail2xml.
	self
		should: [
			self
				parse: self class sourcep52fail2xml
				documentURI: 'p52fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp52pass1xml [
	"Source file: oasis/p52pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp52pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep52pass1xml
				documentURI: 'p52pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp53fail1xml [
	"Source file: oasis/p53fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp53fail1xml.
	self
		should: [
			self
				parse: self class sourcep53fail1xml
				documentURI: 'p53fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp53fail2xml [
	"Source file: oasis/p53fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp53fail2xml.
	self
		should: [
			self
				parse: self class sourcep53fail2xml
				documentURI: 'p53fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp53fail3xml [
	"Source file: oasis/p53fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp53fail3xml.
	self
		should: [
			self
				parse: self class sourcep53fail3xml
				documentURI: 'p53fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp53fail4xml [
	"Source file: oasis/p53fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp53fail4xml.
	self
		should: [
			self
				parse: self class sourcep53fail4xml
				documentURI: 'p53fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp53fail5xml [
	"Source file: oasis/p53fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp53fail5xml.
	self
		should: [
			self
				parse: self class sourcep53fail5xml
				documentURI: 'p53fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp53pass1xml [
	"Source file: oasis/p53pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp53pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep53pass1xml
				documentURI: 'p53pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp54fail1xml [
	"Source file: oasis/p54fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp54fail1xml.
	self
		should: [
			self
				parse: self class sourcep54fail1xml
				documentURI: 'p54fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp54pass1xml [
	"Source file: oasis/p54pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp54pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep54pass1xml
				documentURI: 'p54pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp55fail1xml [
	"Source file: oasis/p55fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp55fail1xml.
	self
		should: [
			self
				parse: self class sourcep55fail1xml
				documentURI: 'p55fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp55pass1xml [
	"Source file: oasis/p55pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp55pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep55pass1xml
				documentURI: 'p55pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp56fail1xml [
	"Source file: oasis/p56fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp56fail1xml.
	self
		should: [
			self
				parse: self class sourcep56fail1xml
				documentURI: 'p56fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp56fail2xml [
	"Source file: oasis/p56fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp56fail2xml.
	self
		should: [
			self
				parse: self class sourcep56fail2xml
				documentURI: 'p56fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp56fail3xml [
	"Source file: oasis/p56fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp56fail3xml.
	self
		should: [
			self
				parse: self class sourcep56fail3xml
				documentURI: 'p56fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp56fail4xml [
	"Source file: oasis/p56fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp56fail4xml.
	self
		should: [
			self
				parse: self class sourcep56fail4xml
				documentURI: 'p56fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp56fail5xml [
	"Source file: oasis/p56fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp56fail5xml.
	self
		should: [
			self
				parse: self class sourcep56fail5xml
				documentURI: 'p56fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp56pass1xml [
	"Source file: oasis/p56pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp56pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep56pass1xml
				documentURI: 'p56pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp57fail1xml [
	"Source file: oasis/p57fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp57fail1xml.
	self
		should: [
			self
				parse: self class sourcep57fail1xml
				documentURI: 'p57fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp57pass1xml [
	"Source file: oasis/p57pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp57pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep57pass1xml
				documentURI: 'p57pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp58fail1xml [
	"Source file: oasis/p58fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp58fail1xml.
	self
		should: [
			self
				parse: self class sourcep58fail1xml
				documentURI: 'p58fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp58fail2xml [
	"Source file: oasis/p58fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp58fail2xml.
	self
		should: [
			self
				parse: self class sourcep58fail2xml
				documentURI: 'p58fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp58fail3xml [
	"Source file: oasis/p58fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp58fail3xml.
	self
		should: [
			self
				parse: self class sourcep58fail3xml
				documentURI: 'p58fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp58fail4xml [
	"Source file: oasis/p58fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp58fail4xml.
	self
		should: [
			self
				parse: self class sourcep58fail4xml
				documentURI: 'p58fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp58fail5xml [
	"Source file: oasis/p58fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp58fail5xml.
	self
		should: [
			self
				parse: self class sourcep58fail5xml
				documentURI: 'p58fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp58fail6xml [
	"Source file: oasis/p58fail6.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp58fail6xml.
	self
		should: [
			self
				parse: self class sourcep58fail6xml
				documentURI: 'p58fail6.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp58fail7xml [
	"Source file: oasis/p58fail7.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp58fail7xml.
	self
		should: [
			self
				parse: self class sourcep58fail7xml
				documentURI: 'p58fail7.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp58fail8xml [
	"Source file: oasis/p58fail8.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp58fail8xml.
	self
		should: [
			self
				parse: self class sourcep58fail8xml
				documentURI: 'p58fail8.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp58pass1xml [
	"Source file: oasis/p58pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp58pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep58pass1xml
				documentURI: 'p58pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp59fail1xml [
	"Source file: oasis/p59fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp59fail1xml.
	self
		should: [
			self
				parse: self class sourcep59fail1xml
				documentURI: 'p59fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp59fail2xml [
	"Source file: oasis/p59fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp59fail2xml.
	self
		should: [
			self
				parse: self class sourcep59fail2xml
				documentURI: 'p59fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp59fail3xml [
	"Source file: oasis/p59fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp59fail3xml.
	self
		should: [
			self
				parse: self class sourcep59fail3xml
				documentURI: 'p59fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp59pass1xml [
	"Source file: oasis/p59pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp59pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep59pass1xml
				documentURI: 'p59pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp60fail1xml [
	"Source file: oasis/p60fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp60fail1xml.
	self
		should: [
			self
				parse: self class sourcep60fail1xml
				documentURI: 'p60fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp60fail2xml [
	"Source file: oasis/p60fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp60fail2xml.
	self
		should: [
			self
				parse: self class sourcep60fail2xml
				documentURI: 'p60fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp60fail3xml [
	"Source file: oasis/p60fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp60fail3xml.
	self
		should: [
			self
				parse: self class sourcep60fail3xml
				documentURI: 'p60fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp60fail4xml [
	"Source file: oasis/p60fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp60fail4xml.
	self
		should: [
			self
				parse: self class sourcep60fail4xml
				documentURI: 'p60fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp60fail5xml [
	"Source file: oasis/p60fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp60fail5xml.
	self
		should: [
			self
				parse: self class sourcep60fail5xml
				documentURI: 'p60fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp60pass1xml [
	"Source file: oasis/p60pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp60pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep60pass1xml
				documentURI: 'p60pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp61fail1xml [
	"Source file: oasis/p61fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp61fail1xml.
	self
		should: [
			self
				parse: self class sourcep61fail1xml
				documentURI: 'p61fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp61pass1xml [
	"Source file: oasis/p61pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp61pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep61pass1xml
				documentURI: 'p61pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp62fail1xml [
	"Source file: oasis/p62fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp62fail1xml.
	self
		should: [
			self
				parse: self class sourcep62fail1xml
				documentURI: 'p62fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp62fail2xml [
	"Source file: oasis/p62fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp62fail2xml.
	self
		should: [
			self
				parse: self class sourcep62fail2xml
				documentURI: 'p62fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp62pass1xml [
	"Source file: oasis/p62pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp62pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep62pass1xml
				documentURI: 'p62pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp63fail1xml [
	"Source file: oasis/p63fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp63fail1xml.
	self
		should: [
			self
				parse: self class sourcep63fail1xml
				documentURI: 'p63fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp63fail2xml [
	"Source file: oasis/p63fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp63fail2xml.
	self
		should: [
			self
				parse: self class sourcep63fail2xml
				documentURI: 'p63fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp63pass1xml [
	"Source file: oasis/p63pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp63pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep63pass1xml
				documentURI: 'p63pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp64fail1xml [
	"Source file: oasis/p64fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp64fail1xml.
	self
		should: [
			self
				parse: self class sourcep64fail1xml
				documentURI: 'p64fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp64fail2xml [
	"Source file: oasis/p64fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp64fail2xml.
	self
		should: [
			self
				parse: self class sourcep64fail2xml
				documentURI: 'p64fail2.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp64pass1xml [
	"Source file: oasis/p64pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp64pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep64pass1xml
				documentURI: 'p64pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp66fail1xml [
	"Source file: oasis/p66fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp66fail1xml.
	self
		should: [
			self
				parse: self class sourcep66fail1xml
				documentURI: 'p66fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp66fail2xml [
	"Source file: oasis/p66fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp66fail2xml.
	self
		should: [
			self
				parse: self class sourcep66fail2xml
				documentURI: 'p66fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp66fail3xml [
	"Source file: oasis/p66fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp66fail3xml.
	self
		should: [
			self
				parse: self class sourcep66fail3xml
				documentURI: 'p66fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp66fail4xml [
	"Source file: oasis/p66fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp66fail4xml.
	self
		should: [
			self
				parse: self class sourcep66fail4xml
				documentURI: 'p66fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp66fail5xml [
	"Source file: oasis/p66fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp66fail5xml.
	self
		should: [
			self
				parse: self class sourcep66fail5xml
				documentURI: 'p66fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp66fail6xml [
	"Source file: oasis/p66fail6.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp66fail6xml.
	self
		should: [
			self
				parse: self class sourcep66fail6xml
				documentURI: 'p66fail6.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp66pass1xml [
	"Source file: oasis/p66pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp66pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep66pass1xml
				documentURI: 'p66pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp68fail1xml [
	"Source file: oasis/p68fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp68fail1xml.
	self
		should: [
			self
				parse: self class sourcep68fail1xml
				documentURI: 'p68fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp68fail2xml [
	"Source file: oasis/p68fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp68fail2xml.
	self
		should: [
			self
				parse: self class sourcep68fail2xml
				documentURI: 'p68fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp68fail3xml [
	"Source file: oasis/p68fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp68fail3xml.
	self
		should: [
			self
				parse: self class sourcep68fail3xml
				documentURI: 'p68fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp68pass1xml [
	"Source file: oasis/p68pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp68pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep68pass1xml
				documentURI: 'p68pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp69fail1xml [
	"Source file: oasis/p69fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp69fail1xml.
	self
		should: [
			self
				parse: self class sourcep69fail1xml
				documentURI: 'p69fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp69fail2xml [
	"Source file: oasis/p69fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp69fail2xml.
	self
		should: [
			self
				parse: self class sourcep69fail2xml
				documentURI: 'p69fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp69fail3xml [
	"Source file: oasis/p69fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp69fail3xml.
	self
		should: [
			self
				parse: self class sourcep69fail3xml
				documentURI: 'p69fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp69pass1xml [
	"Source file: oasis/p69pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp69pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep69pass1xml
				documentURI: 'p69pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp70fail1xml [
	"Source file: oasis/p70fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp70fail1xml.
	self
		should: [
			self
				parse: self class sourcep70fail1xml
				documentURI: 'p70fail1.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp70pass1xml [
	"Source file: oasis/p70pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp70pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep70pass1xml
				documentURI: 'p70pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp71fail1xml [
	"Source file: oasis/p71fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp71fail1xml.
	self
		should: [
			self
				parse: self class sourcep71fail1xml
				documentURI: 'p71fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp71fail2xml [
	"Source file: oasis/p71fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp71fail2xml.
	self
		should: [
			self
				parse: self class sourcep71fail2xml
				documentURI: 'p71fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp71fail3xml [
	"Source file: oasis/p71fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp71fail3xml.
	self
		should: [
			self
				parse: self class sourcep71fail3xml
				documentURI: 'p71fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp71fail4xml [
	"Source file: oasis/p71fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp71fail4xml.
	self
		should: [
			self
				parse: self class sourcep71fail4xml
				documentURI: 'p71fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp71pass1xml [
	"Source file: oasis/p71pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp71pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep71pass1xml
				documentURI: 'p71pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp72fail1xml [
	"Source file: oasis/p72fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp72fail1xml.
	self
		should: [
			self
				parse: self class sourcep72fail1xml
				documentURI: 'p72fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp72fail2xml [
	"Source file: oasis/p72fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp72fail2xml.
	self
		should: [
			self
				parse: self class sourcep72fail2xml
				documentURI: 'p72fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp72fail3xml [
	"Source file: oasis/p72fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp72fail3xml.
	self
		should: [
			self
				parse: self class sourcep72fail3xml
				documentURI: 'p72fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp72fail4xml [
	"Source file: oasis/p72fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp72fail4xml.
	self
		should: [
			self
				parse: self class sourcep72fail4xml
				documentURI: 'p72fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp72pass1xml [
	"Source file: oasis/p72pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp72pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep72pass1xml
				documentURI: 'p72pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp73fail1xml [
	"Source file: oasis/p73fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp73fail1xml.
	self
		should: [
			self
				parse: self class sourcep73fail1xml
				documentURI: 'p73fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp73fail2xml [
	"Source file: oasis/p73fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp73fail2xml.
	self
		should: [
			self
				parse: self class sourcep73fail2xml
				documentURI: 'p73fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp73fail3xml [
	"Source file: oasis/p73fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp73fail3xml.
	self
		should: [
			self
				parse: self class sourcep73fail3xml
				documentURI: 'p73fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp73fail4xml [
	"Source file: oasis/p73fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp73fail4xml.
	self
		should: [
			self
				parse: self class sourcep73fail4xml
				documentURI: 'p73fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp73fail5xml [
	"Source file: oasis/p73fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp73fail5xml.
	self
		should: [
			self
				parse: self class sourcep73fail5xml
				documentURI: 'p73fail5.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp73pass1xml [
	"Source file: oasis/p73pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp73pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep73pass1xml
				documentURI: 'p73pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp74fail1xml [
	"Source file: oasis/p74fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp74fail1xml.
	self
		should: [
			self
				parse: self class sourcep74fail1xml
				documentURI: 'p74fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp74fail2xml [
	"Source file: oasis/p74fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp74fail2xml.
	self
		should: [
			self
				parse: self class sourcep74fail2xml
				documentURI: 'p74fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp74fail3xml [
	"Source file: oasis/p74fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp74fail3xml.
	self
		should: [
			self
				parse: self class sourcep74fail3xml
				documentURI: 'p74fail3.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp74pass1xml [
	"Source file: oasis/p74pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp74pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep74pass1xml
				documentURI: 'p74pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp75fail1xml [
	"Source file: oasis/p75fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp75fail1xml.
	self
		should: [
			self
				parse: self class sourcep75fail1xml
				documentURI: 'p75fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp75fail2xml [
	"Source file: oasis/p75fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp75fail2xml.
	self
		should: [
			self
				parse: self class sourcep75fail2xml
				documentURI: 'p75fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp75fail3xml [
	"Source file: oasis/p75fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp75fail3xml.
	self
		should: [
			self
				parse: self class sourcep75fail3xml
				documentURI: 'p75fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp75fail4xml [
	"Source file: oasis/p75fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp75fail4xml.
	self
		should: [
			self
				parse: self class sourcep75fail4xml
				documentURI: 'p75fail4.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp75fail5xml [
	"Source file: oasis/p75fail5.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp75fail5xml.
	self
		should: [
			self
				parse: self class sourcep75fail5xml
				documentURI: 'p75fail5.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp75fail6xml [
	"Source file: oasis/p75fail6.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp75fail6xml.
	self
		should: [
			self
				parse: self class sourcep75fail6xml
				documentURI: 'p75fail6.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp75pass1xml [
	"Source file: oasis/p75pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp75pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep75pass1xml
				documentURI: 'p75pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp76fail1xml [
	"Source file: oasis/p76fail1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp76fail1xml.
	self
		should: [
			self
				parse: self class sourcep76fail1xml
				documentURI: 'p76fail1.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp76fail2xml [
	"Source file: oasis/p76fail2.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp76fail2xml.
	self
		should: [
			self
				parse: self class sourcep76fail2xml
				documentURI: 'p76fail2.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp76fail3xml [
	"Source file: oasis/p76fail3.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp76fail3xml.
	self
		should: [
			self
				parse: self class sourcep76fail3xml
				documentURI: 'p76fail3.xml']
		raise: self parserExceptions
]

{ #category : #'tests - exception raising' }
XMLConformanceOasisTest >> testp76fail4xml [
	"Source file: oasis/p76fail4.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp76fail4xml.
	self
		should: [
			self
				parse: self class sourcep76fail4xml
				documentURI: 'p76fail4.xml']
		raise: self parserExceptions
]

{ #category : #tests }
XMLConformanceOasisTest >> testp76pass1xml [
	"Source file: oasis/p76pass1.xml"

	self
		skipOrReturnWith: [^ self]
		ifSkippable: #testp76pass1xml.
	self
		shouldnt: [
			[self
				parse: self class sourcep76pass1xml
				documentURI: 'p76pass1.xml']
				on: self parserExceptions
				do: [:error |
					(self isIgnorableParserException: error)
						ifFalse: [error pass]]]
		raise: self parserExceptions
]
