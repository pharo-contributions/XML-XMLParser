"
Loads the XMLParser library and related packages:
	(ConfigurationOfXMLParser project version: #stable) load: #('default')

The loadable groups are:
	'default' - XMLParser, XMLWriter, and tests.
	'Core' - XMLParser without XMLWriter or tests.
	'CoreWithWriting' - XMLParser and XMLWriter, but without tests.

Users should prefer #stable unless they rely on XMLParser internals,
but it will delegate to a specific #release version from now on.
"
Class {
	#name : #ConfigurationOfXMLParser,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfXMLParser
}

{ #category : #private }
ConfigurationOfXMLParser class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #catalog }
ConfigurationOfXMLParser class >> catalogChangeLog [

^ '

- Version 1.3 - 2013-11-22 Monty''s Enhancements
These updates add validation against internal and external DTDs, proper replacement of general and parameter entites, customizable resolution of external parsed entities using Zinc and FileSystem, awareness of notations and unparsed entities, preservation of the internal DTD subset by the DOM parser (so printing a parsed doc with a DTD will produce approximately what was input), line numbers reporting in error messages, and better well-formed and validity constraints.

I had to largely rewrite the tokenizer to make everything work, but I followed the spec closely, and it is about the same speed as long as there is no DTD to validate against.

[[[ 
	(ConfigurationOfXMLParser project version: ''1.3'') load
]]]


- Version 1.2- 2013-04-30 Removing dependency on XMLWriter.

[[[ 
	(ConfigurationOfXMLParser project version: ''1.2'') load
]]]


'
]

{ #category : #catalog }
ConfigurationOfXMLParser class >> catalogDescription [

	^ 'XMLParser provides validating SAX and DOM parsers for well-formed XML documents on Pharo, Squeak, and Gemstone. It also provides a DOM API for manipulating documents, namespace support, and an optional XMLWriter for writing documents. Validation and namespace checking are enabled by default, but not resolution of external entities.

Implements:
	http://www.w3.org/TR/REC-xml/
	http://www.w3.org/TR/REC-xml-names/
	http://www.w3.org/TR/xml-id/
	http://www.w3.org/TR/xmlbase/
	https://www.w3.org/TR/xml-c14n
'
]

{ #category : #catalog }
ConfigurationOfXMLParser class >> catalogKeyClassesAndExample [

^ 'The main classes are ==SAXHandler==, ==XMLDOMParser==, and ==XMLNode== and its subclasses. Read the class comments for more information.

Validation and namespace checking are enabled by default, but not resolution of external entities.

Examples
[[[ 
	| doc |
	"Get all article titles from the content of the <title> child of each <entry>"
	((doc := (XMLDOMParser parseURL: ''http://pharo.org/news/atom.xml''))
		allElementsNamed: ''entry'')
			collect: [:each | each contentStringAt: ''title''].

	"Get feed title from first <title> anywhere in the doc"
	(doc findElementNamed: ''title'') contentString.
	
	"Get all article links"
	(doc allElementsNamed: ''entry'') collect: [:each |
		(each elementAt: ''link'') attributeAt: ''href'' ].
]]]
'
]

{ #category : #catalog }
ConfigurationOfXMLParser class >> catalogKeywords [

	^ #( XML DOM SAX DTD HTML XHTML parser validation web markup document )
					

]

{ #category : #catalog }
ConfigurationOfXMLParser class >> catalogLicense [
	^ 'The MIT License (MIT)

Copyright (c) 2016 PharoExtras Team.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'
]

{ #category : #private }
ConfigurationOfXMLParser class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), bootstrap ConfigurationOfMetacello (using old Gofer API), then load the latest 
	version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
			self bootstrapPackage: 'Gofer-Core-lr.115' from: 'http://seaside.gemstone.com/ss/metacello' ].
		Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
			gofer := goferClass new
				url: 'http://seaside.gemstone.com/ss/metacello';
				yourself.
			[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
			gofer load ].
		"load 'default' group of Metacello"
		(Smalltalk at: #ConfigurationOfMetacello) perform: #load ]
]

{ #category : #private }
ConfigurationOfXMLParser class >> findLazyInitializedClassStateInPackage: aPackageName [
	"This method tries to find all classes in aPackageName with class and
	class instance vars that are lazy initialized and require explicit
	initialization on GS to prevent write conflicts. This is a hueristic.

		self findLazyInitializedClassStateInPackage: 'XML-Parser'

	"
	| classesAndLazyInitializedClassState |

	classesAndLazyInitializedClassState := OrderedCollection new.
	(SystemNavigation default allClassesInPackageNamed: aPackageName)
		do: [:classInPackage |
			| superclassInPackage metaClassInPackage newClassAndClassInstVars |

			superclassInPackage := classInPackage superclass.
			metaClassInPackage := classInPackage class.
			newClassAndClassInstVars := Set new.
			classInPackage classVariables do: [:each |
				(superclassInPackage classVariables includes: each)
					ifFalse: [newClassAndClassInstVars add: each key]].
			metaClassInPackage instanceVariables do: [:each |
				newClassAndClassInstVars add: each].
			newClassAndClassInstVars
				ifNotEmpty: [
					(metaClassInPackage includesSelector: #initialize)
						ifTrue: [| classInitializationMethods |
							classInitializationMethods :=
								Set with: (metaClassInPackage compiledMethodAt: #initialize).
							[classInitializationMethods isEmpty]
								whileFalse: [| method |
									method := classInitializationMethods anyOne.
									method ast nodesDo: [:each |
										each isAssignment
											ifTrue: [
												((newClassAndClassInstVars includes: each variable name)
													and: [each value isLiteralNode not
														or: [each value value notNil]])
													ifTrue: [newClassAndClassInstVars remove: each variable name]]
											ifFalse: [
												(each isMessage
													and: [each receiver isSelf
														and: [each isUnary]])
													ifTrue: [
														(metaClassInPackage lookupSelector: each selector)
															ifNotNil: [:newMethod |
																classInitializationMethods add: newMethod]]]].
									classInitializationMethods remove: method]]].
			newClassAndClassInstVars
				ifNotEmpty: [
					classesAndLazyInitializedClassState addLast:
						classInPackage -> newClassAndClassInstVars]].

	^ classesAndLazyInitializedClassState sort: [:a :b |
		(b key inheritsFrom: a key)
			ifTrue: [true]
			ifFalse: [a key name <= b key name]].
]

{ #category : #'metacello tool support' }
ConfigurationOfXMLParser class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfXMLParser class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfXMLParser class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #loading }
ConfigurationOfXMLParser class >> loadDefault [
	"self loadDefault"

	^ self loadMostRecentCoreWithTests
]

{ #category : #loading }
ConfigurationOfXMLParser class >> loadMostRecentCoreWithTests [
	^self project lastVersion load: #('Core' 'Tests')
]

{ #category : #'metacello tool support' }
ConfigurationOfXMLParser class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfXMLParser class >> project [

	^self new project
]

{ #category : #'unloading Metacello' }
ConfigurationOfXMLParser class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #'development support' }
ConfigurationOfXMLParser class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline100: spec [
	<version: '1.0.0-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.4.5' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline183: spec [
	<version: '1.8.3-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.4.6' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline187: spec [
	<version: '1.8.7-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.4.7' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline188: spec [
	<version: '1.8.8-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.4.8' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline191: spec [
	<version: '1.9.1-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.4.8' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.1' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline193: spec [
	<version: '1.9.3-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.4.8' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.2' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline194: spec [
	<version: '1.9.4-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.2' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.3' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline196: spec [
	<version: '1.9.6-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.2' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.4' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline198: spec [
	<version: '1.9.8-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.2' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.5' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline200: spec [
	<version: '2.0.0-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.3' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.6' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline201: spec [
	<version: '2.0.1-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.4' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.6' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline205: spec [
	<version: '2.0.5-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.4' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.7' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline213: spec [
	<version: '2.1.3-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.5' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.7' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline216: spec [
	<version: '2.1.6-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.6' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.8' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline221: spec [
	<version: '2.2.1-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.6' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.9' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline231: spec [
	<version: '2.3.1-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.6'.
			"requires concrete versions from now on"
			spec project: 'BitmapCharacterSet' with: '1.1.5' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.10' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline239: spec [
	<version: '2.3.9-baseline' imports: #('1.9-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.5.9'.
			spec project: 'BitmapCharacterSet' with: '1.1.5' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.10' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline241: spec [
	<version: '2.4.1-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.0'.
			spec project: 'BitmapCharacterSet' with: '1.1.5' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.10' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.1' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline244: spec [
	<version: '2.4.4-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.3'.
			spec project: 'BitmapCharacterSet' with: '1.1.5' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.10' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.1' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline248: spec [
	<version: '2.4.8-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.3'.
			spec project: 'BitmapCharacterSet' with: '1.1.5' ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.10' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-AndreiChis.7' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline250: spec [
	<version: '2.5.0-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.4'.
			"#stable BitmapCharacterSet is ok now because XMLParser isn't extending it anymore" ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.11' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.8' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline251: spec [
	<version: '2.5.1-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.5'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.11' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.24' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline253: spec [
	<version: '2.5.3-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.6'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.11' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-TudorGirba.29' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline260: spec [
	<version: '2.6.0-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.6'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.12' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.30' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline263: spec [
	<version: '2.6.3-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.8'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.14' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.30' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline266: spec [
	<version: '2.6.6-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.8'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.15' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.31' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline268: spec [
	<version: '2.6.8-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.9'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.16' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.32' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline270: spec [
	<version: '2.7.0-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.9'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.16' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.33' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline273: spec [
	<version: '2.7.3-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.9'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.17' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.33' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline274: spec [
	<version: '2.7.4-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.6.9'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.18' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.34' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline276: spec [
	<version: '2.7.6-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.7.0'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.19' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-TudorGirba.36' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline277: spec [
	<version: '2.7.7-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.7.2'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.19' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-TudorGirba.36' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline283: spec [
	<version: '2.8.3-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.7.2'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.20' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-TudorGirba.36' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline288: spec [
	<version: '2.8.8-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.7.2'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.21' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-TudorGirba.36' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline291: spec [
	<version: '2.9.1-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.7.2'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.21' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.37' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline294: spec [
	<version: '2.9.4-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.7.2'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.22' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.38' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline295: spec [
	<version: '2.9.5-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.7.2'. ].
	spec
		for: #gemstone
		do: [ spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.22' ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.39' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline297: spec [
	<version: '2.9.7-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.7.5'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.22'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline297. ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.40' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline302: spec [
	<version: '3.0.2-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.7.9'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.22'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline297. ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.53' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline306: spec [
	<version: '3.0.6-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.0'. ].
	"need a newer version for the Lazy classes"
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.3.7'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.22'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline297. ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.59' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline311: spec [
	<version: '3.1.1-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.1'. ].
	"need a newer version for the Lazy classes"
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.3.7'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.24'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline297. ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-PavelKrivanek.60' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline312: spec [
	<version: '3.1.2-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.2'. ].
	"need a newer version for the Lazy classes"
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.3.7'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.24'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline312. ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-PavelKrivanek.60' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline319: spec [
	<version: '3.1.9-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.3'. ].
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.3.8'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.25'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline312. ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.61' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline321: spec [
	<version: '3.2.1-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.3'. ].
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.3.8'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.25'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline321. ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.62' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline329: spec [
	<version: '3.2.9-baseline' imports: #('2.4-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.3'. ].
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.3.8'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-Parser-GemstoneCompatibility' with: 'XML-Parser-GemstoneCompatibility-monty.25'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline321. ].
	spec
		for: #gt
		do: [ spec package: 'XML-Parser-GTExtensions' with: 'XML-Parser-GTExtensions-monty.64' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline330: spec [
	<version: '3.3.0-baseline' imports: #('3.3-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.3'. ].
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.4.0'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-ParserGemstoneCompatibility' with: 'XML-ParserGemstoneCompatibility-monty.1'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline321. ].
	spec
		for: #gt
		do: [
			spec package: 'XML-ParserGTExtensions' with: 'XML-ParserGTExtensions-monty.1' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline332: spec [
	<version: '3.3.2-baseline' imports: #('3.3-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.3'. ].
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.4.0'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-ParserGemstoneCompatibility' with: 'XML-ParserGemstoneCompatibility-monty.2'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline332. ].
	spec
		for: #gt
		do: [
			spec package: 'XML-ParserGTExtensions' with: 'XML-ParserGTExtensions-monty.2' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline333: spec [
	<version: '3.3.3-baseline' imports: #('3.3-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.3'. ].
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.4.0'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-ParserGemstoneCompatibility' with: 'XML-ParserGemstoneCompatibility-monty.3'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline332. ].
	spec
		for: #gt
		do: [
			spec package: 'XML-ParserGTExtensions' with: 'XML-ParserGTExtensions-TorstenBergmann.5' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline339: spec [
	<version: '3.3.9-baseline' imports: #('3.3-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.3'. ].
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.4.0'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-ParserGemstoneCompatibility' with: 'XML-ParserGemstoneCompatibility-monty.3'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline332. ].
	spec
		for: #gt
		do: [
			spec package: 'XML-ParserGTExtensions' with: 'XML-ParserGTExtensions-monty.6' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline342: spec [
	<version: '3.4.2-baseline' imports: #('3.3-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.3'. ].
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.4.0'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-ParserGemstoneCompatibility' with: 'XML-ParserGemstoneCompatibility-monty.4'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline332. ].
	spec
		for: #gt
		do: [
			spec package: 'XML-ParserGTExtensions' with: 'XML-ParserGTExtensions-monty.7' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baseline348: spec [
	<version: '3.4.8-baseline' imports: #('3.3-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLWriter' with: '2.8.4'. ].
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'OrderPreservingDictionary' with: '1.4.0'. ].
	spec
		for: #gemstone
		do: [
			spec package: 'XML-ParserGemstoneCompatibility' with: 'XML-ParserGemstoneCompatibility-monty.4'.
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline332. ].
	spec
		for: #gt
		do: [
			spec package: 'XML-ParserGTExtensions' with: 'XML-ParserGTExtensions-monty.8' ]
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baselineMaster19: spec [
	<version: '1.9-master-baseline' imports: #('1-master-baseline')>

	spec
		for: #gemstone
		do: [
			"load gemstone compatibility methods"
			spec
				package: 'XML-Parser'
				with: [ spec includes: 'XML-Parser-GemstoneCompatibility' ].
			spec
				package: 'XML-Parser-GemstoneCompatibility'
				with: [ spec requires: 'XML-Parser' ]. ].
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baselineMaster1: spec [
	<version: '1-master-baseline'>

	"default baseline inherited by others, describes basic dependencies.
	other baselines that inherit pick concrete project versions
	if loading #stable isn't enough"
	spec
		for: #common
		do: [ 
			spec
				blessing: #baseline;
				description: 'Migrated to SmalltalkHub';
				author: 'StephaneDucasse';
				timestamp: '04/30/2013';
				repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main'.

			"other baselines choose concrete versions because this package changes
			with XMLParser to be backwards incompatible"
			spec
				project: 'XMLWriter'
				with: [
					spec 
						className: 'ConfigurationOfXMLWriter';
						versionString: #stable;
						loads: #('Core'); 
						repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLWriter/main'.].
			spec
				project: 'XMLWriterTests'
				copyFrom: 'XMLWriter'
				with: [ spec loads: #('Tests') ].

			spec
				project: 'BitmapCharacterSet'
				with: [
					spec 
						className: 'ConfigurationOfBitmapCharacterSet';
						versionString: #stable;
						loads: #('Core'); 
						repository: 'http://www.smalltalkhub.com/mc/PharoExtras/BitmapCharacterSet/main'.].

			spec
				project: 'OrderPreservingDictionary'
				with: [
					spec 
						className: 'ConfigurationOfOrderPreservingDictionary';
						versionString: #stable; 
						loads: #('Core'); 
						repository: 'http://smalltalkhub.com/mc/PharoExtras/OrderPreservingDictionary/main'].
			spec
				project: 'OrderPreservingDictionaryTests'
				copyFrom: 'OrderPreservingDictionary'
				with: [ spec loads: #('Tests') ].

			spec 
				package: 'XML-Parser' 
				with: [spec requires: #('BitmapCharacterSet' 'OrderPreservingDictionary')].
			"some XML-Tests-Parser TestCases inherit from OrderPreservingDictionary TestCases"
			spec
				package: 'XML-Tests-Parser'
				with: [ spec requires: #('OrderPreservingDictionaryTests' 'XMLWriterTests' 'XML-Parser') ].
			
			"Core was made to only load XMLParser, CoreWithWriting loads XMLParser and XMLWriter"
			spec
				group: 'default' with: #('CoreWithWriting' 'Tests');
				group: 'Core' with: #('XML-Parser');
				group: 'CoreWithWriting' with: #('XMLWriter' 'XML-Parser');
				group: 'Tests' with: #('XML-Tests-Parser') ].
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baselineMaster24: spec [
	<version: '2.4-master-baseline' imports: #('1.9-master-baseline')>

	"load GT extension methods"
	spec
		for: #gt
		do: [
			"the extensions require XMLWriter"
			spec
				group: 'CoreWithWriting' with: #('XMLWriter' 'XML-Parser' 'XML-Parser-GTExtensions');
				group: 'Tests' with: #('XML-Tests-Parser' 'XML-Parser-GTExtensions').
			spec
				package: 'XML-Parser-GTExtensions'
				with: [ spec requires: 'XML-Parser' ]. ].
]

{ #category : #'obsolete - baselines' }
ConfigurationOfXMLParser >> baselineMaster33: spec [
	<version: '3.3-master-baseline' imports: #('1-master-baseline')>

	spec
		for: #gemstone
		do: [
			"load gemstone compatibility methods"
			spec
				package: 'XML-Parser'
				with: [ spec includes: 'XML-ParserGemstoneCompatibility' ].
			"renamed from 'XML-Parser-GemstoneCompatibility'"
			spec
				package: 'XML-ParserGemstoneCompatibility'
				with: [ spec requires: 'XML-Parser' ]. ].

	"load GT extension methods"
	spec
		for: #gt
		do: [
			"the extensions require XMLWriter"
			spec
				group: 'CoreWithWriting' with: #('XMLWriter' 'XML-Parser' 'XML-ParserGTExtensions');
				group: 'Tests' with: #('XML-Tests-Parser' 'XML-ParserGTExtensions').
			"renamed from 'XML-Parser-GTExtensions'"
			spec
				package: 'XML-ParserGTExtensions'
				with: [ spec requires: 'XML-Parser' ]. ].
]

{ #category : #accessing }
ConfigurationOfXMLParser >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

	(Smalltalk includesKey: #GTInspector)
		ifTrue: [ ^ #(gt) ]
		ifFalse: [ ^ #() ]
]

{ #category : #'symbolic versions' }
ConfigurationOfXMLParser >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' do: [ 
		spec
			baseline: 'XMLWriter' with: [ 
				spec 
					className: 'BaselineOfXMLParser';
					repository: 'github://pharo-contributions/XML-XMLParser:master/src' ]]
]

{ #category : #doits }
ConfigurationOfXMLParser >> initializeClassesForGSBaseline297 [
	"All lazily initialized class and class instance variables must be
	explicitly initialized on GS during installation to prevent write
	conflicts between Gems later on. 
	
	This can help identify classes that use lazy initialization:
		self findLazyInitializedClassStateInPackage: 'XML-Parser'
	"

	DTDCachingExternalEntityResolver entityCache.
	XMLAbstractFactory allSubclassesDo: [:each |
		each hasSupportedImplementation
			ifTrue: [each implementation]].
	XMLFileHandle xmlDocumentFileExtensions.
	XMLParserLimits defaultDocumentReadLimit.
	XMLStreamConverter
		encodingNamesAndClassesCache;
		preferredClasses;
		encodingNames;
		allSubclassesDo: [:each | each encodingNames].
	"removed"
	(XMLClassFinder classNamed: #XMLTextConverterStreamConverter)
		encodingNamesAndTextConverterClassesCache.
	"renamed"
	(XMLClassFinder classNamed: #XMLTokenContext) allSubclassesDo: [:each |
		each instance].
]

{ #category : #doits }
ConfigurationOfXMLParser >> initializeClassesForGSBaseline312 [
	"All lazily initialized class and class instance variables must be
	explicitly initialized on GS during installation to prevent write
	conflicts between Gems later on. 
	
	This can help identify classes that use lazy initialization:
		self findLazyInitializedClassStateInPackage: 'XML-Parser'
	"

	DTDCachingExternalEntityResolver entityCache.
	XMLAbstractFactory allSubclassesDo: [:each |
		each hasSupportedImplementation
			ifTrue: [each implementation]].
	XMLFileHandle xmlDocumentFileExtensions.
	XMLParserLimits defaultDocumentReadLimit.
	XMLStatelessStreamConverter allSubclassesDo: [:each |
		each instance].
	XMLStreamConverter
		encodingNamesAndClassesCache;
		preferredClasses;
		encodingNames;
		allSubclassesDo: [:each | each encodingNames].
	"removed"
	(XMLClassFinder classNamed: #XMLTextConverterStreamConverter)
		encodingNamesAndTextConverterClassesCache.
	"renamed"
	(XMLClassFinder classNamed: #XMLTokenContext) allSubclassesDo: [:each |
		each instance].
]

{ #category : #doits }
ConfigurationOfXMLParser >> initializeClassesForGSBaseline321 [
	"All lazily initialized class and class instance variables must be
	explicitly initialized on GS during installation to prevent write
	conflicts between Gems later on. 
	
	This can help identify classes that use lazy initialization:
		self findLazyInitializedClassStateInPackage: 'XML-Parser'
	"

	DTDCachingExternalEntityResolver entityCache.
	XMLAbstractFactory allSubclassesDo: [:each |
		each hasSupportedImplementation
			ifTrue: [each implementation]].
	XMLFileHandle xmlDocumentFileExtensions.
	XMLParserLimits defaultDocumentReadLimit.
	XMLStatelessStreamConverter allSubclassesDo: [:each |
		each instance].
	XMLStreamConverter
		encodingNamesAndClassesCache;
		preferredClasses;
		encodingNames;
		allSubclassesDo: [:each | each encodingNames].
	"removed"
	(XMLClassFinder classNamed: #XMLTextConverterStreamConverter)
		encodingNamesAndTextConverterClassesCache.
	XMLTokenizerState allSubclassesDo: [:each |
		each instance].
]

{ #category : #doits }
ConfigurationOfXMLParser >> initializeClassesForGSBaseline332 [
	"All lazily initialized class and class instance variables must be
	explicitly initialized on GS during installation to prevent write
	conflicts between Gems later on. 
	
	This can help identify classes that use lazy initialization:
		self findLazyInitializedClassStateInPackage: 'XML-Parser'
	"

	DTDCachingExternalEntityResolver entityCache.
	XMLAbstractFactory allSubclassesDo: [:each |
		each hasSupportedImplementation
			ifTrue: [each implementation]].
	XMLFileHandle xmlDocumentFileExtensions.
	XMLParserLimits defaultDocumentReadLimit.
	XMLStreamConverter
		encodingNamesAndClassesCache;
		preferredClasses;
		encodingNames;
		allSubclassesDo: [:each | each encodingNames].
	XMLStatelessStreamConverter allSubclassesDo: [:each |
		each instance].
	XMLTokenizerState allSubclassesDo: [:each |
		each instance].
]

{ #category : #accessing }
ConfigurationOfXMLParser >> project [
	^ project
		ifNil: [ 
			| constructor |
			"Bootstrap Metacello if it is not already loaded"
			self class ensureMetacello.
			project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Construct Metacello project"
			constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
			project loadType: #linear.	"change to #atomic if desired"
			project ]
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release24: spec [
	<symbolicVersion: #'release-2.4'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.4.9'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release253: spec [
	<symbolicVersion: #'release-2.5.3'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.5.4'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release255: spec [
	<symbolicVersion: #'release-2.5.5'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.5.9'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release25: spec [
	<symbolicVersion: #'release-2.5'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.5.2'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release263: spec [
	<symbolicVersion: #'release-2.6.3'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.6.4'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release265: spec [
	<symbolicVersion: #'release-2.6.5'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.6.7'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release268: spec [
	<symbolicVersion: #'release-2.6.8'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.7.2'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release26: spec [
	<symbolicVersion: #'release-2.6'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.6.2'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release273: spec [
	<symbolicVersion: #'release-2.7.3'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.7.3'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release274: spec [
	<symbolicVersion: #'release-2.7.4'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.7.5'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release276: spec [
	<symbolicVersion: #'release-2.7.6'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.7.6'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release277: spec [
	<symbolicVersion: #'release-2.7.7'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.7.9'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release281: spec [
	<symbolicVersion: #'release-2.8.1'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.8.2'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release283: spec [
	<symbolicVersion: #'release-2.8.3'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.8.5'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release286: spec [
	<symbolicVersion: #'release-2.8.6'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.8.6'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release287: spec [
	<symbolicVersion: #'release-2.8.7'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.8.8'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release289: spec [
	<symbolicVersion: #'release-2.8.9'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.8.9'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release292: spec [
	<symbolicVersion: #'release-2.9.2'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.9.3'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release294: spec [
	<symbolicVersion: #'release-2.9.4'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.9.4'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release295: spec [
	<symbolicVersion: #'release-2.9.5'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.9.6'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release297: spec [
	<symbolicVersion: #'release-2.9.7'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.9.7'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release298: spec [
	<symbolicVersion: #'release-2.9.8'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.0.1'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release29: spec [
	<symbolicVersion: #'release-2.9'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.9.1'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release2: spec [
	<symbolicVersion: #'release-2'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '2.4.7'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release306: spec [
	<symbolicVersion: #'release-3.0.6'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.1.6'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release317: spec [
	<symbolicVersion: #'release-3.1.7'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.1.8'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release319: spec [
	<symbolicVersion: #'release-3.1.9'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.2.0'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release321: spec [
	<symbolicVersion: #'release-3.2.1'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.2.1'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release322: spec [
	<symbolicVersion: #'release-3.2.2'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.2.8'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release329: spec [
	<symbolicVersion: #'release-3.2.9'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.2.9'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release332: spec [
	<symbolicVersion: #'release-3.3.2'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.3.3'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release334: spec [
	<symbolicVersion: #'release-3.3.4'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.3.7'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release338: spec [
	<symbolicVersion: #'release-3.3.8'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.3.8'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release339: spec [
	<symbolicVersion: #'release-3.3.9'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.4.7'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release33: spec [
	<symbolicVersion: #'release-3.3'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.3.1'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release348: spec [
	<symbolicVersion: #'release-3.4.8'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.5.0'.
]

{ #category : #'obsolete - releases' }
ConfigurationOfXMLParser >> release3: spec [
	<symbolicVersion: #'release-3'>

	"Users should prefer #stable unless they rely on XMLParser internals"
	spec for: #'common' version: '3.0.5'.
]

{ #category : #'symbolic versions' }
ConfigurationOfXMLParser >> stable: spec [
	<symbolicVersion: #'stable'>

		"Old STHub version"
	spec for: #'pharo4.x' version: 'release-3.4.8'.
	spec for: #'pharo5.x' version: 'release-3.4.8'.
	spec for: #'pharo6.x' version: 'release-3.4.8'.	
		
	spec for: #'common' version: #'3.5.0'.
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version100: spec [
	<version: '1.0.0' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-NorbertHartl.141';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-JAA.14' 
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version101: spec [
	<version: '1.0.1' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-StephaneDucasse.142';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-StephaneDucasse.15' 
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version102: spec [
	<version: '1.0.2' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-DamienCassou.143';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-StephaneDucasse.15' 
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version130: spec [
	<version: '1.3.0' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec description: 'Enhancements made by Monty. These updates add validation against internal and external DTDs, proper replacement of general and parameter entites, customizable resolution of external parsed entities using Zinc and FileSystem, awareness of notations and unparsed entities, preservation of the internal DTD subset by the DOM parser (so printing a parsed doc with a DTD will produce approximately what was input), line numbers reporting in error messages, and better well-formed and validity constraints.

I had to largely rewrite the tokenizer to make everything work, but I followed the spec closely, and it is about the same speed as long as there is no DTD to validate against.'.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.184';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.28' 
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version131: spec [
	<version: '1.3.1' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.186';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.29' 
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version132: spec [
	<version: '1.3.2' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.187';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.29' 
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version133: spec [
	<version: '1.3.3' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.189';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.31'
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version134: spec [
	<version: '1.3.4' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.190';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.31'
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version135: spec [
	<version: '1.3.5' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.191';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.33'
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version136: spec [
	<version: '1.3.6' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.192';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.33'
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version137: spec [
	<version: '1.3.7' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.193';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.34'
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version138: spec [
	<version: '1.3.8' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.195';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.36'
				].
	
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version139: spec [
	<version: '1.3.9' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.196';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.36'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version140: spec [
	<version: '1.4.0' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.197';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.37'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version141: spec [
	<version: '1.4.1' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.198';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.38'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version142: spec [
	<version: '1.4.2' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.200';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.39'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version143: spec [
	<version: '1.4.3' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.201';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.40'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version144: spec [
	<version: '1.4.4' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.203';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.41'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version145: spec [
	<version: '1.4.5' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.205';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.43'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version146: spec [
	<version: '1.4.6' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.205';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-StephaneDucasse.44'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version147: spec [
	<version: '1.4.7' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.208';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.46'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version148: spec [
	<version: '1.4.8' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.210';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.47'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version149: spec [
	<version: '1.4.9' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.211';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.47'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version150: spec [
	<version: '1.5.0' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.213';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.48'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version151: spec [
	<version: '1.5.1' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.215';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.48'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version152: spec [
	<version: '1.5.2' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.216';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.49'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version153: spec [
	<version: '1.5.3' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.218';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.51'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version154: spec [
	<version: '1.5.4' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.219';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.52'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version155: spec [
	<version: '1.5.5' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.220';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.53'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version156: spec [
	<version: '1.5.6' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.221';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.54'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version157: spec [
	<version: '1.5.7' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.222';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.55'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version158: spec [
	<version: '1.5.8' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.223';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.56'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version159: spec [
	<version: '1.5.9' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.224';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.56'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version160: spec [
	<version: '1.6.0' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.225';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.57'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version161: spec [
	<version: '1.6.1' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.226';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.58'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version162: spec [
	<version: '1.6.2' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.227';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.58'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version163: spec [
	<version: '1.6.3' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.228';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.58'
				].
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version164: spec [
	<version: '1.6.4' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ 
			spec
				blessing: #release;
				description: 'Added a pharo2 specific method to fix tests'.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.228';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.58' ].
	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version165: spec [
	<version: '1.6.5' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: 'version 1.6.5'.
		spec author: 'GuillaumeLarcheveque'.
		spec timestamp: '6/27/2014 16:14'.
		spec 
			project: 'XMLWriter' with: '2.3.10';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.228';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.58'. ].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version166: spec [
	<version: '1.6.6' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: 'version 1.6.6'.
		spec 
			project: 'XMLWriter' with: '2.3.10';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.229';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.60'. ].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version167: spec [
	<version: '1.6.7' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: 'version 1.6.7'.
		spec 
			project: 'XMLWriter' with: '2.3.10';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.230';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.60'. ].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version168: spec [
	<version: '1.6.8' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: 'version 1.6.8'.
		spec 
			project: 'XMLWriter' with: '2.3.10';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.231';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.60'. ].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version169: spec [
	<version: '1.6.9' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.3.10';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.234';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.62'.].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version170: spec [
	<version: '1.7.0' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.4.1';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.235';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.63'.].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version171: spec [
	<version: '1.7.1' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.4.1';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2.1'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.236';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.64'.].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version172: spec [
	<version: '1.7.2' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.4.1';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2.1'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.237';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.65'.].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version173: spec [
	<version: '1.7.3' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.4.1';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2.3'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.238';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.66'.].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version174: spec [
	<version: '1.7.4' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.4.1';
			project: 'BitmapCharacterSet' with: '1.1';
			project: 'OrderPreservingDictionary' with: '1.2.3'.
		spec 
			package: 'XML-Parser' with: 'XML-Parser-monty.240';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.68'.].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version175: spec [
	<version: '1.7.5' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.4.2';
			package: 'XML-Parser' with: 'XML-Parser-monty.241';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.69'.].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version176: spec [
	<version: '1.7.6' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.4.3';
			package: 'XML-Parser' with: 'XML-Parser-monty.242';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.70'.].

	spec for: #'pharo2.x'
		do: [ 
			spec package: 'XML-Pharo2-Parser' with: 'XML-Pharo2-Parser-DiegoLont.1' ]
	

]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version177: spec [
	<version: '1.7.7' imports: #('1.0.0-baseline')>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.4.3';
			package: 'XML-Parser' with: 'XML-Parser-monty.243';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.71'.]
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version178: spec [ 
        <version: '1.7.8' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.4'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.244'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.72'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version179: spec [ 
        <version: '1.7.9' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.4'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.245'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.73'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version180: spec [ 
        <version: '1.8.0' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.4'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.246'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.74'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version181: spec [ 
        <version: '1.8.1' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.4'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.247'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.75'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version182: spec [ 
        <version: '1.8.2' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.5'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.248'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.76'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version183: spec [ 
        <version: '1.8.3' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.250'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.77'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version184: spec [ 
        <version: '1.8.4' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.251'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.78'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version185: spec [ 
        <version: '1.8.5' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.252'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.79'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version186: spec [ 
        <version: '1.8.6' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.253'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.80'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version187: spec [ 
        <version: '1.8.7' imports: #('1.8.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.254'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.81'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version188: spec [ 
        <version: '1.8.8' imports: #('1.8.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.255'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.82'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version189: spec [ 
        <version: '1.8.9' imports: #('1.8.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.257'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.83'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version190: spec [ 
        <version: '1.9.0' imports: #('1.8.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.258'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.83'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version191: spec [ 
        <version: '1.9.1' imports: #('1.9.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.259'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.84'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version192: spec [ 
        <version: '1.9.2' imports: #('1.9.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.259'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.85'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version193: spec [ 
        <version: '1.9.3' imports: #('1.9.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.260'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.86'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version194: spec [ 
        <version: '1.9.4' imports: #('1.9.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.261'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.86'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version195: spec [ 
        <version: '1.9.5' imports: #('1.9.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.262'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.86'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version196: spec [ 
        <version: '1.9.6' imports: #('1.9.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.263'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.86'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version197: spec [ 
        <version: '1.9.7' imports: #('1.9.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.264'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.87'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version198: spec [ 
        <version: '1.9.8' imports: #('1.9.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.265'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.88'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version199: spec [ 
        <version: '1.9.9' imports: #('1.9.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.266'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.89'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version200: spec [ 
        <version: '2.0.0' imports: #('2.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.268'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.91'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version201: spec [ 
        <version: '2.0.1' imports: #('2.0.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.269'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.91'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version202: spec [ 
        <version: '2.0.2' imports: #('2.0.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.270'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.92'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version203: spec [ 
        <version: '2.0.3' imports: #('2.0.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.271'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.93'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version204: spec [ 
        <version: '2.0.4' imports: #('2.0.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.272'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.94'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version205: spec [ 
        <version: '2.0.5' imports: #('2.0.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.273'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.95'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version206: spec [ 
        <version: '2.0.6' imports: #('2.0.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.274'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.96'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version207: spec [ 
        <version: '2.0.7' imports: #('2.0.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.275'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.97'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version208: spec [ 
        <version: '2.0.8' imports: #('2.0.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.275'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.98'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version209: spec [ 
        <version: '2.0.9' imports: #('2.0.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.276'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.99'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version210: spec [ 
        <version: '2.1.0' imports: #('2.0.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.277'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.100'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version211: spec [ 
        <version: '2.1.1' imports: #('2.0.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.278'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.100'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version212: spec [ 
        <version: '2.1.2' imports: #('2.0.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.279'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.100'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version213: spec [ 
        <version: '2.1.3' imports: #('2.1.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.280'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.103'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version214: spec [ 
        <version: '2.1.4' imports: #('2.1.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.281'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.104'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version215: spec [ 
        <version: '2.1.5' imports: #('2.1.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.282'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.105'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version216: spec [ 
        <version: '2.1.6' imports: #('2.1.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.283'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.105'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version217: spec [ 
        <version: '2.1.7' imports: #('2.1.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.284'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.106'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version218: spec [ 
        <version: '2.1.8' imports: #('2.1.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.285'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.106'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version219: spec [ 
        <version: '2.1.9' imports: #('2.1.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.286'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.107'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version220: spec [ 
        <version: '2.2.0' imports: #('2.1.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.287'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.108'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version221: spec [ 
        <version: '2.2.1' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.288'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.109'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version222: spec [ 
        <version: '2.2.2' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.290'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.109'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version223: spec [ 
        <version: '2.2.3' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.291'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.110'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version224: spec [ 
        <version: '2.2.4' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.292'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.111'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version225: spec [ 
        <version: '2.2.5' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.293'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.112'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version226: spec [ 
        <version: '2.2.6' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.294'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.113'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version227: spec [ 
        <version: '2.2.7' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.295'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.114'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version228: spec [ 
        <version: '2.2.8' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.296'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.115'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version229: spec [ 
        <version: '2.2.9' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.298'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.115'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version230: spec [ 
        <version: '2.3.0' imports: #('2.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.299'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.115'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version231: spec [ 
        <version: '2.3.1' imports: #('2.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.300'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.116'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version232: spec [ 
        <version: '2.3.2' imports: #('2.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.300'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.117'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version233: spec [ 
        <version: '2.3.3' imports: #('2.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.301'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.118'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version234: spec [ 
        <version: '2.3.4' imports: #('2.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.302'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.119'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version235: spec [ 
        <version: '2.3.5' imports: #('2.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.303'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.120'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version236: spec [ 
        <version: '2.3.6' imports: #('2.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.304'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.121'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version237: spec [ 
        <version: '2.3.7' imports: #('2.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.305'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.121'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version238: spec [ 
        <version: '2.3.8' imports: #('2.3.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.306'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.122'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version239: spec [ 
        <version: '2.3.9' imports: #('2.3.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.307'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.122'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version240: spec [ 
        <version: '2.4.0' imports: #('2.3.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.308'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.123'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version241: spec [ 
        <version: '2.4.1' imports: #('2.4.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.309'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.124'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version242: spec [ 
        <version: '2.4.2' imports: #('2.4.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.310'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.125'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version243: spec [ 
        <version: '2.4.3' imports: #('2.4.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.311'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.126'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version244: spec [ 
        <version: '2.4.4' imports: #('2.4.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.314'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.127'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version245: spec [ 
        <version: '2.4.5' imports: #('2.4.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.315'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.128'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version246: spec [ 
        <version: '2.4.6' imports: #('2.4.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.316'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.129'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version247: spec [ 
        <version: '2.4.7' imports: #('2.4.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.317'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.130'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version248: spec [ 
        <version: '2.4.8' imports: #('2.4.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.318'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.131'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version249: spec [ 
        <version: '2.4.9' imports: #('2.4.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.319'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.132'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version250: spec [ 
        <version: '2.5.0' imports: #('2.5.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.321'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.133'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version251: spec [ 
        <version: '2.5.1' imports: #('2.5.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.322'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.133'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version252: spec [ 
        <version: '2.5.2' imports: #('2.5.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.323'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.134'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version253: spec [ 
        <version: '2.5.3' imports: #('2.5.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.324'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.135'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version254: spec [ 
        <version: '2.5.4' imports: #('2.5.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.325'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.136'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version255: spec [ 
        <version: '2.5.5' imports: #('2.5.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.326'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.137'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version256: spec [ 
        <version: '2.5.6' imports: #('2.5.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.327'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.138'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version257: spec [ 
        <version: '2.5.7' imports: #('2.5.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.328'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.139'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version258: spec [ 
        <version: '2.5.8' imports: #('2.5.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.329'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.140'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version259: spec [ 
        <version: '2.5.9' imports: #('2.5.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.330'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.140'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version260: spec [ 
        <version: '2.6.0' imports: #('2.6.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.331'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.141'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version261: spec [ 
        <version: '2.6.1' imports: #('2.6.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.331'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.143'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version262: spec [ 
        <version: '2.6.2' imports: #('2.6.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.333'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.144'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version263: spec [ 
        <version: '2.6.3' imports: #('2.6.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.335'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.145'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version264: spec [ 
        <version: '2.6.4' imports: #('2.6.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.336'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.146'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version265: spec [ 
        <version: '2.6.5' imports: #('2.6.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.338'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.147'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version266: spec [ 
        <version: '2.6.6' imports: #('2.6.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.340'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.150'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version267: spec [ 
        <version: '2.6.7' imports: #('2.6.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.341'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.151'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version268: spec [ 
        <version: '2.6.8' imports: #('2.6.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.342'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.153'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version269: spec [ 
        <version: '2.6.9' imports: #('2.6.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.344'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.155'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version270: spec [ 
        <version: '2.7.0' imports: #('2.7.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.345'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.157'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version271: spec [ 
        <version: '2.7.1' imports: #('2.7.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.347'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.157'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version272: spec [ 
        <version: '2.7.2' imports: #('2.7.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.349'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.159'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version273: spec [ 
        <version: '2.7.3' imports: #('2.7.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.351'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.160'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version274: spec [ 
        <version: '2.7.4' imports: #('2.7.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.352'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.161'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version275: spec [ 
        <version: '2.7.5' imports: #('2.7.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.353'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.162'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version276: spec [ 
        <version: '2.7.6' imports: #('2.7.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.354'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.163'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version277: spec [ 
        <version: '2.7.7' imports: #('2.7.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.355'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.164'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version278: spec [ 
        <version: '2.7.8' imports: #('2.7.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.356'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.165'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version279: spec [ 
        <version: '2.7.9' imports: #('2.7.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.357'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.165'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version280: spec [ 
        <version: '2.8.0' imports: #('2.7.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.358'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.166'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version281: spec [ 
        <version: '2.8.1' imports: #('2.7.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.359'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.167'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version282: spec [ 
        <version: '2.8.2' imports: #('2.7.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.360'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.168'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version283: spec [ 
        <version: '2.8.3' imports: #('2.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.361'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.169'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version284: spec [ 
        <version: '2.8.4' imports: #('2.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.362'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.170'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version285: spec [ 
        <version: '2.8.5' imports: #('2.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.363'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.171'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version286: spec [ 
        <version: '2.8.6' imports: #('2.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.364'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.173'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version287: spec [ 
        <version: '2.8.7' imports: #('2.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.366'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.176'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version288: spec [ 
        <version: '2.8.8' imports: #('2.8.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.367'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.180'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version289: spec [ 
        <version: '2.8.9' imports: #('2.8.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.369'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.181'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version290: spec [ 
        <version: '2.9.0' imports: #('2.8.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.371'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.182'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version291: spec [ 
        <version: '2.9.1' imports: #('2.9.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.372'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.183'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version292: spec [ 
        <version: '2.9.2' imports: #('2.9.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.373'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.184'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version293: spec [ 
        <version: '2.9.3' imports: #('2.9.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.374'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.185'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version294: spec [ 
        <version: '2.9.4' imports: #('2.9.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.376'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.186'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version295: spec [ 
        <version: '2.9.5' imports: #('2.9.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.377'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.187'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version296: spec [ 
        <version: '2.9.6' imports: #('2.9.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.379'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.188'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version297: spec [ 
        <version: '2.9.7' imports: #('2.9.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.380'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.189'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version298: spec [ 
        <version: '2.9.8' imports: #('2.9.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.381'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.191'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version299: spec [ 
        <version: '2.9.9' imports: #('2.9.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.382'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.191'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version300: spec [ 
        <version: '3.0.0' imports: #('2.9.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.383'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.192'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version301: spec [ 
        <version: '3.0.1' imports: #('2.9.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.387'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.193'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version302: spec [ 
        <version: '3.0.2' imports: #('3.0.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.389'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.195'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version303: spec [ 
        <version: '3.0.3' imports: #('3.0.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.390'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.196'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version304: spec [ 
        <version: '3.0.4' imports: #('3.0.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.392'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.197'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version305: spec [ 
        <version: '3.0.5' imports: #('3.0.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.393'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.198'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version306: spec [ 
        <version: '3.0.6' imports: #('3.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.394'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.199'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version307: spec [ 
        <version: '3.0.7' imports: #('3.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.395'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.199'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version308: spec [ 
        <version: '3.0.8' imports: #('3.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.397'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.200'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version309: spec [ 
        <version: '3.0.9' imports: #('3.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.398'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.200'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version310: spec [ 
        <version: '3.1.0' imports: #('3.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.399'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.201'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version311: spec [ 
        <version: '3.1.1' imports: #('3.1.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.400'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.202'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version312: spec [ 
        <version: '3.1.2' imports: #('3.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.404'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.203'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version313: spec [ 
        <version: '3.1.3' imports: #('3.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.405'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.204'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version314: spec [ 
        <version: '3.1.4' imports: #('3.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.406'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.204'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version315: spec [ 
        <version: '3.1.5' imports: #('3.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.407'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.204'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version316: spec [ 
        <version: '3.1.6' imports: #('3.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.408'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.206'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version317: spec [ 
        <version: '3.1.7' imports: #('3.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.409'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.207'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version318: spec [ 
        <version: '3.1.8' imports: #('3.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.410'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.207'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version319: spec [ 
        <version: '3.1.9' imports: #('3.1.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.411'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.208'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version320: spec [ 
        <version: '3.2.0' imports: #('3.1.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.412'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.209'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version321: spec [ 
        <version: '3.2.1' imports: #('3.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.413'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.209'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version322: spec [ 
        <version: '3.2.2' imports: #('3.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.414'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.210'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version323: spec [ 
        <version: '3.2.3' imports: #('3.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.416'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.210'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version324: spec [ 
        <version: '3.2.4' imports: #('3.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.417'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.211'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version325: spec [ 
        <version: '3.2.5' imports: #('3.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.418'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.211'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version326: spec [ 
        <version: '3.2.6' imports: #('3.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.420'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.212'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version327: spec [ 
        <version: '3.2.7' imports: #('3.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.421'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.213'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version328: spec [ 
        <version: '3.2.8' imports: #('3.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.421'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.214'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version329: spec [ 
        <version: '3.2.9' imports: #('3.2.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.425'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.216'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version330: spec [ 
        <version: '3.3.0' imports: #('3.3.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.425'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.216'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version331: spec [ 
        <version: '3.3.1' imports: #('3.3.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.426'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.217'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version332: spec [ 
        <version: '3.3.2' imports: #('3.3.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.428'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.218'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version333: spec [ 
        <version: '3.3.3' imports: #('3.3.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.429'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.219'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version334: spec [ 
        <version: '3.3.4' imports: #('3.3.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.431'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.220'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version335: spec [ 
        <version: '3.3.5' imports: #('3.3.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.432'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.221'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version336: spec [ 
        <version: '3.3.6' imports: #('3.3.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.433'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.222'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version337: spec [ 
        <version: '3.3.7' imports: #('3.3.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.435'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.223'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version338: spec [ 
        <version: '3.3.8' imports: #('3.3.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.437'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.224'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version339: spec [ 
        <version: '3.3.9' imports: #('3.3.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.438'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.224'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version340: spec [ 
        <version: '3.4.0' imports: #('3.3.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.439'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.224'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version341: spec [ 
        <version: '3.4.1' imports: #('3.3.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.440'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.224'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version342: spec [ 
        <version: '3.4.2' imports: #('3.4.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.441'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.225'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version343: spec [ 
        <version: '3.4.3' imports: #('3.4.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.442'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.226'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version344: spec [ 
        <version: '3.4.4' imports: #('3.4.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.443'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.226'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version345: spec [ 
        <version: '3.4.5' imports: #('3.4.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.444'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.227'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version346: spec [ 
        <version: '3.4.6' imports: #('3.4.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.445'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.227'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version347: spec [ 
        <version: '3.4.7' imports: #('3.4.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.446'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.228'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version348: spec [ 
        <version: '3.4.8' imports: #('3.4.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.447'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.229'.
                ].
]

{ #category : #'obsolete - versions' }
ConfigurationOfXMLParser >> version349: spec [ 
        <version: '3.4.9' imports: #('3.4.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.448'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.229'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version350: spec [
	<version: '3.5.0'>

	spec for: #'common' do: [ 
		spec
			baseline: 'XMLWriter' with: [ 
				spec 
					className: 'BaselineOfXMLParser';
					repository: 'github://pharo-contributions/XML-XMLParser:3.5.0/src' ]]
]
