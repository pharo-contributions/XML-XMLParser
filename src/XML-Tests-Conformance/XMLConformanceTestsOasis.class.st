Class {
	#name : #XMLConformanceTestsOasis,
	#superclass : #XMLConformanceTests,
	#category : #'XML-Tests-Conformance'
}

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> allTestsToSkip [
	^#("invalid indexing caused by large unicode character being put into a stream"
		'o-p66pass1' 

		"does not reject uri fragment"
		 'o-p11pass1' )
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp01fail4xml [
	^ '<doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail10xml [
	| varChar |
	varChar:=String with: (Character codePoint: 11).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail11xml [
	| varChar |
	varChar:=String with: (Character codePoint: 12).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail12xml [
	| varChar |
	varChar:=String with: (Character codePoint: 14).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail13xml [
	| varChar |
	varChar:=String with: (Character codePoint: 15).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail14xml [
	| varChar |
	varChar:=String with: (Character codePoint: 16).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail15xml [
	| varChar |
	varChar:=String with: (Character codePoint: 17).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail16xml [
	| varChar |
	varChar:=String with: (Character codePoint: 18).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail17xml [
	| varChar |
	varChar:=String with: (Character codePoint: 19).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail18xml [
	| varChar |
	varChar:=String with: (Character codePoint: 20).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail19xml [
	| varChar |
	varChar:=String with: (Character codePoint: 21).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail1xml [
	| varChar |
	varChar:=String with: (Character codePoint: 0).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail20xml [
	| varChar |
	varChar:=String with: (Character codePoint: 22).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail21xml [
	| varChar |
	varChar:=String with: (Character codePoint: 23).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail22xml [
	| varChar |
	varChar:=String with: (Character codePoint: 24).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail23xml [
	| varChar |
	varChar:=String with: (Character codePoint: 25).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail24xml [
	| varChar |
	varChar:=String with: (Character codePoint: 26).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail25xml [
	| varChar |
	varChar:=String with: (Character codePoint: 27).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail26xml [
	| varChar |
	varChar:=String with: (Character codePoint: 28).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail27xml [
	| varChar |
	varChar:=String with: (Character codePoint: 29).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail28xml [
	| varChar |
	varChar:=String with: (Character codePoint: 30).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail29xml [
	| varChar |
	varChar:=String with: (Character codePoint: 31).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail2xml [
	| varChar |
	varChar:=String with: (Character codePoint: 1).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail30xml [
	^'<doc>￾</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail31xml [
^'<doc>￿</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail3xml [
	| varChar |
	varChar:=String with: (Character codePoint: 2).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail4xml [
	| varChar |
	varChar:=String with: (Character codePoint: 3).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail5xml [
	| varChar |
	varChar:=String with: (Character codePoint: 4).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail6xml [
	| varChar |
	varChar:=String with: (Character codePoint: 5).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail7xml [
	| varChar |
	varChar:=String with: (Character codePoint: 6).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail8xml [
	| varChar |
	varChar:=String with: (Character codePoint: 7).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp02fail9xml [
	| varChar |
	varChar:=String with: (Character codePoint: 8).
	^'<doc>',varChar,  '</doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail10xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail12xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail13xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail14xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail15xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail16xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail17xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail18xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail19xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail1xml [
	^ ' <doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail20xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail21xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail22xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail23xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail24xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail25xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail26xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail27xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail28xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail29xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail2xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail3xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail4xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail5xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail7xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail8xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp03fail9xml [
	^ '<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp04pass1xml [
	^ '<doc>
<abcdefghijklmnopqrstuvwxyz/>
<ABCDEFGHIJKLMNOPQRSTUVWXYZ/>
<A01234567890/>
<A.-:̀·/>
</doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp05pass1xml [
	^ '<doc>
<A:._-0/>
<::._-0/>
<_:._-0/>
<A/>
<_/>
<:/>
</doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp09fail3xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "asdf&#65">
]>
<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp09fail4xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY % ent1 ''a">
]>
<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp09fail5xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!ENTITY % ent1 "a''>
]>
<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp10fail2xml [
	^ '<doc a="1 &"/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp10fail3xml [
	^ '<doc a=''asd"/>
'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp11pass1xml [
	|comSimple |
	comSimple:=String with: (Character codePoint: 39).

^'<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 SYSTEM "a%a&b&#0<!ELEMENT<!--<?</>?>/\''">
<!NOTATION not2 SYSTEM ', comSimple, 'a
	b"""', comSimple ,'>
<!NOTATION not3 SYSTEM "">
<!NOTATION not4 SYSTEM ''>
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp12fail4xml [
	^ '<!--Inability to resolve a notation should not be reported as an error-->
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
<!NOTATION not1 PUBLIC ">">
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp14fail1xml [
	^ '<doc>< </doc>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp14fail2xml [
	^ '<doc>& </doc>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp16fail2xml [
	^ '<??>
<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp18fail2xml [
	^ '<doc><![CDATA [a]]></doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp23fail5xml [
	^ '<?xml version="1.0">
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp24fail1xml [
	^ '<?xml version = ''1.0"?>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp24fail2xml [
	^ '<?xml version = "1.0''?>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp25fail1xml [
	^ '<?xml version <!--bad comment--> ="1.0"?>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp27fail1xml [
	^ '<?xml version="1.0"?>
&#32;
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp32fail1xml [
	^ '<?xml version="1.0" standalone=''yes"?>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp32fail2xml [
	^ '<?xml version="1.0" standalone="yes''?>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp32fail4xml [
	^ '<?xml version="1.0" standalone=yes?>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp39fail1xml [
	^ '<doc>content'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp39fail2xml [
	^ '<doc>content</a></doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp39fail3xml [
^''
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp39fail4xml [
	^ '<?xml version="1.0">
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp39fail5xml [
	^ '<?xml version="1.0">
<!DOCTYPE doc
[
<!ELEMENT doc EMPTY>
]>

<!--comment-->
<?pi?>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp40fail3xml [
	^ '<3notname></notname>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp40fail4xml [
	^ '< doc></doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp41fail1xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc att (val|val2)>
]>
<doc att=val></doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp41fail2xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc att (val|val2)>
]>
<doc val></doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp41fail3xml [
	^ '<doc att "val"></doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp42fail1xml [
	^ '<doc></ doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp42fail2xml [
	^ '<doc></doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp42fail3xml [
	^ '<doc/doc/'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp43fail1xml [
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

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp43fail2xml [
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

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp43fail3xml [
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

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp44fail1xml [
	^ '< doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp44fail2xml [
	^ '<doc/ >'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp44fail3xml [
	^ '<doc --bad comment--/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp49fail1xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc|a?,a?)>
<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp50fail1xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc ANY>
<!ELEMENT a (doc,a?|a?)>
<doc/>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp66fail1xml [
	^ '<doc>&#65</doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp66fail2xml [
	^ '<doc>&# 65;</doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp66fail3xml [
	^ '<doc>&#A;</doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp66fail4xml [
	^ '<doc>&#x4G;</doc>'
]

{ #category : #'as yet unclassified' }
XMLConformanceTestsOasis class >> sourceoasisp66pass1xml [
	^'<doc>
	&#65;&#9;&#x41;&#x4f;&#x4F;&#0000000000000000009;
	&#x10F2ec;&#xa;
	</doc>'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp68fail1xml [
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

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp68fail2xml [
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

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp68fail3xml [
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

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp69fail1xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % pe "<!---->">
%pe<!---->
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp69fail2xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % pe "<!---->">
% pe;
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp69fail3xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % pe "<!---->">
%pe ;
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp70fail1xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY & bad "replacement text">
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp71fail2xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY -ge "replacement text">
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp71fail3xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<! ENTITY ge "replacement text">
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp72fail4xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!ENTITY % .pe "<!--replacement decl-->">
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp73fail4xml [
	^ '<!DOCTYPE doc
[
<!ELEMENT doc (#PCDATA)>
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY ge >
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp74fail2xml [
	^ '<!DOCTYPE doc
[
<!NOTATION unknot PUBLIC "Unknown">
<!ENTITY % pe>
]>
<doc/>
'
]

{ #category : #source }
XMLConformanceTestsOasis class >> sourceoasisp75fail5xml [
	^ '<!DOCTYPE doc
[
<!ENTITY ent PUBLIC "PublicID" SYSTEM "nop.ent">
]>
<doc/>
'
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop01fail4 [
	"
     document element must be complete.
    
	 See XML Spec. 1.0 section: 2.1 [1]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p01fail4'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp01fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail1 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail1'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp02fail1xml]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail10 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail10'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail10xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail11 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail11'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp02fail11xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail12 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail12'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp02fail12xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail13 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail13'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail13xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail14 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail14'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail14xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail15 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail15'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail15xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail16 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail16'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail16xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail17 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail17'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail17xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail18 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail18'])
		ifTrue:[^nil].

	self should: [self runTest:self class  sourceoasisp02fail18xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail19 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail19'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail19xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail2 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail20 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail20'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail20xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail21 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail21'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail21xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail22 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail22'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp02fail22xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail23 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail23'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail23xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail24 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail24'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail24xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail25 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail25'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp02fail25xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail26 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail26'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail26xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail27 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail27'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp02fail27xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail28 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail28'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp02fail28xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail29 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail29'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail29xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail3 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail30 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail30'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail30xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail31 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail31'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp02fail31xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail4 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail4'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp02fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail5 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail5'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail5xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail6 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail6'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail6xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail7 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail7'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail7xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail8 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail8'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail8xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop02fail9 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.2 [2]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p02fail9'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp02fail9xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail1 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail1'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp03fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail10 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail10'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail10xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail12 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail12'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail12xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail13 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail13'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail13xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail14 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail14'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail14xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail15 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail15'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail15xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail16 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail16'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail16xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail17 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail17'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail17xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail18 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail18'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail18xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail19 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail19'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp03fail19xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail2 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail20 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail20'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp03fail20xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail21 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail21'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp03fail21xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail22 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail22'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail22xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail23 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail23'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp03fail23xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail24 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail24'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail24xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail25 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail25'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp03fail25xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail26 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail26'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail26xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail27 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail27'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail27xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail28 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail28'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp03fail28xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail29 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail29'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail29xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail3 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail4 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail4'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail5 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail5'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail5xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail7 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail7'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail7xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail8 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail8'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp03fail8xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop03fail9 [
	"
    Use of illegal character within XML document.     
	 See XML Spec. 1.0 section: 2.3 [3]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p03fail9'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp03fail9xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop04pass1 [
	"
     names with all valid ASCII characters, and one from each
              other class in NameChar
    
	 See XML Spec. 1.0 section: 2.3 [4]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p04pass1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp04pass1xml]
		raise: self exceptionSet
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop05pass1 [
	"
     various valid Name constructions
    
	 See XML Spec. 1.0 section: 2.3 [5]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p05pass1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp05pass1xml]
		raise: self exceptionSet
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop09fail3 [
	"
     incomplete character reference
    
	 See XML Spec. 1.0 section: 2.3 [9]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p09fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp09fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop09fail4 [
	"
     quote types must match
    
	 See XML Spec. 1.0 section: 2.3 [9]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p09fail4'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp09fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop09fail5 [
	"
     quote types must match
    
	 See XML Spec. 1.0 section: 2.3 [9]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p09fail5'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp09fail5xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop10fail2 [
	"
     attribute values exclude '&'
    
	 See XML Spec. 1.0 section: 2.3 [10]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p10fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp10fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop10fail3 [
	"
     quote types must match
    
	 See XML Spec. 1.0 section: 2.3 [10]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p10fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp10fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop11pass1 [
	"
     system literals may not contain
    URI fragments
    
	 See XML Spec. 1.0 section: 2.3, 4.2.2 [11]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p11pass1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp11pass1xml]
		raise: self exceptionSet
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop12fail4 [
	"
     '>' excluded
    
	 See XML Spec. 1.0 section: 2.3 [12]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p12fail4'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp12fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop14fail1 [
	"
     '<' excluded
    
	 See XML Spec. 1.0 section: 2.4 [14]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p14fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp14fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop14fail2 [
	"
     '&' excluded
    
	 See XML Spec. 1.0 section: 2.4 [14]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p14fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp14fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop16fail2 [
	"
     a PITarget must be present
    
	 See XML Spec. 1.0 section: 2.6 [16]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p16fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp16fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop18fail2 [
	"
     no space after  CDATA 
    
	 See XML Spec. 1.0 section: 2.7 [18]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p18fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp18fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop23fail5 [
	"
     no SGML-type PIs
    
	 See XML Spec. 1.0 section: 2.8 [23]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p23fail5'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp23fail5xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop24fail1 [
	"
     quote types must match
    
	 See XML Spec. 1.0 section: 2.8 [24]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p24fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp24fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop24fail2 [
	"
     quote types must match
    
	 See XML Spec. 1.0 section: 2.8 [24]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p24fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp24fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop25fail1 [
	"
    Comment is illegal in VersionInfo.     
	 See XML Spec. 1.0 section: 2.8 [25]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p25fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp25fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop27fail1 [
	"
     References aren't allowed in Misc,
    even if they would resolve to valid Misc.
    
	 See XML Spec. 1.0 section: 2.8 [27]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p27fail1'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp27fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop32fail1 [
	"
     quote types must match
    
	 See XML Spec. 1.0 section: 2.9 [32]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p32fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp32fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop32fail2 [
	"
     quote types must match
    
	 See XML Spec. 1.0 section: 2.9 [32]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p32fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp32fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop32fail4 [
	"
     quotes are required
    
	 See XML Spec. 1.0 section: 2.9 [32]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p32fail4'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp32fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop39fail1 [
	"
     start-tag requires end-tag
    
	 See XML Spec. 1.0 section: 3 [39]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p39fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp39fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop39fail2 [
	"
     end-tag requires start-tag
    
	 See XML Spec. 1.0 section: 3 [39]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p39fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp39fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop39fail3 [
	"
    XML documents contain one or more elements
	 See XML Spec. 1.0 section: 3 [39]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p39fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp39fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop39fail4 [
	"
         
	 See XML Spec. 1.0 section: 3 [39]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p39fail4'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp39fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop39fail5 [
	"
         
	 See XML Spec. 1.0 section: 3 [39]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p39fail5'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp39fail5xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop40fail3 [
	"
     tags start with names, not nmtokens
    
	 See XML Spec. 1.0 section: 3.1 [40]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p40fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp40fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop40fail4 [
	"
     no space before name
    
	 See XML Spec. 1.0 section: 3.1 [40]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p40fail4'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp40fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop41fail1 [
	"
     quotes are required (contrast with SGML)
    
	 See XML Spec. 1.0 section: 3.1 [41]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p41fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp41fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop41fail2 [
	"
     attribute name is required (contrast with SGML)
    
	 See XML Spec. 1.0 section: 3.1 [41]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p41fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp41fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop41fail3 [
	"
     Eq required
    
	 See XML Spec. 1.0 section: 3.1 [41]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p41fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp41fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop42fail1 [
	"
     no space before name
    
	 See XML Spec. 1.0 section: 3.1 [42]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p42fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp42fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop42fail2 [
	"
     cannot end with  /> 
    
	 See XML Spec. 1.0 section: 3.1 [42]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p42fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp42fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop42fail3 [
	"
     no NET (contrast with SGML)
    
	 See XML Spec. 1.0 section: 3.1 [42]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p42fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp42fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop43fail1 [
	"
     no non-comment declarations
    
	 See XML Spec. 1.0 section: 3.1 [43]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p43fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp43fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop43fail2 [
	"
     no conditional sections
    
	 See XML Spec. 1.0 section: 3.1 [43]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p43fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp43fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop43fail3 [
	"
     no conditional sections
    
	 See XML Spec. 1.0 section: 3.1 [43]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p43fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp43fail3xml]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop44fail1 [
	"
    Illegal space before Empty element tag.    
	 See XML Spec. 1.0 section: 3.1 [44]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p44fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp44fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop44fail2 [
	"
    Illegal space after Empty element tag.    
	 See XML Spec. 1.0 section: 3.1 [44]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p44fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp44fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop44fail3 [
	"
    Illegal comment in Empty element tag.    
	 See XML Spec. 1.0 section: 3.1 [44]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p44fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp44fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop49fail1 [
	"
    connectors must match     
	 See XML Spec. 1.0 section: 3.2.1 [49]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p49fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp49fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop50fail1 [
	"
    connectors must match     
	 See XML Spec. 1.0 section: 3.2.1 [50]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p50fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp50fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop66fail1 [
	"
     terminating ';' is required
    
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p66fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp66fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop66fail2 [
	"
     no S after '&#'
    
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p66fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp66fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop66fail3 [
	"
     no hex digits in numeric reference
    
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p66fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp66fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop66fail4 [
	"
     only hex digits in hex references
    
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p66fail4'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp66fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop66pass1 [
	"
     valid character references
    
	 See XML Spec. 1.0 section: 4.1 [66]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p66pass1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp66pass1xml]
		raise: self exceptionSet
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop68fail1 [
	"
     terminating ';' is required
    
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p68fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp68fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop68fail2 [
	"
     no S after '&'
    
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p68fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp68fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop68fail3 [
	"
     no S before ';'
    
	 See XML Spec. 1.0 section: 4.1 [68]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p68fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp68fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop69fail1 [
	"
     terminating ';' is required
    
	 See XML Spec. 1.0 section: 4.1 [69]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p69fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp69fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop69fail2 [
	"
     no S after '%'
    
	 See XML Spec. 1.0 section: 4.1 [69]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p69fail2'])
		ifTrue:[^nil].

	self should: [self runTest: self class sourceoasisp69fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop69fail3 [
	"
     no S before ';'
    
	 See XML Spec. 1.0 section: 4.1 [69]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p69fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp69fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop70fail1 [
	"
     This is neither
    
	 See XML Spec. 1.0 section: 4.2 [70]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p70fail1'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp70fail1xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop71fail2 [
	"
     Entity name is a Name, not an NMToken
    
	 See XML Spec. 1.0 section: 4.2 [71]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p71fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp71fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop71fail3 [
	"
     no S after  <! 
    
	 See XML Spec. 1.0 section: 4.2 [71]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p71fail3'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp71fail3xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop72fail4 [
	"
     Entity name is a name, not an NMToken
    
	 See XML Spec. 1.0 section: 4.2 [72]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p72fail4'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp72fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop73fail4 [
	"
     Value is required
    
	 See XML Spec. 1.0 section: 4.2 [73]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p73fail4'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp73fail4xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop74fail2 [
	"
     value is required
    
	 See XML Spec. 1.0 section: 4.2 [74]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p74fail2'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp74fail2xml ]
		raise: self exceptionSet2
]

{ #category : #tests }
XMLConformanceTestsOasis >> testoasisop75fail5 [
	"
     only one keyword
    
	 See XML Spec. 1.0 section: 4.2.2 [75]"

	(self class shouldSkipTests and: [testsToSkip includes: 'o-p75fail5'])
		ifTrue:[^nil].

	self should: [self runTest:self class sourceoasisp75fail5xml ]
		raise: self exceptionSet2
]
