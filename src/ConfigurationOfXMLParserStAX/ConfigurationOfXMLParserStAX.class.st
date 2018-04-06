"
Loads the XMLParserStAX library and related packages:
	(ConfigurationOfXMLParserStAX project version: #stable) load: #('default')

The loadable groups are:
	default - XMLParserStAX, XMLParser, and XMLWriter with tests.
	Core - XMLParserStAX and XMLParser without XMLWriter  or tests.
	CoreWithWriting - XMLParserStAX, XMLParser, and XMLWriter without tests.
"
Class {
	#name : #ConfigurationOfXMLParserStAX,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfXMLParserStAX
}

{ #category : #'development support' }
ConfigurationOfXMLParserStAX class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfXMLParserStAX class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfXMLParserStAX class >> catalogDescription [

^ 'XMLParserStAX is a pull parser for XMLParser that provides a streaming interface for "pulling" XML events and also supports pull-style DOM parsing for dynamically converting events into DOM nodes.'
]

{ #category : #catalog }
ConfigurationOfXMLParserStAX class >> catalogKeyClassesAndExample [

	^ 'The main classes are ==StAXParser== and the ==StAXEvent== subclasses.

Example:
[[[ 
	| parser item |
	parser := StAXParser on:
		''<list>
			<item>one</item>
			<item>two</item>
		</list>''.

	"get the first item as an XMLElement"
	item := parser nextElementNamed: ''item''.
]]]'
]

{ #category : #catalog }
ConfigurationOfXMLParserStAX class >> catalogKeywords [

	^ #( XML DOM StAX DTD HTML XHTML pull parser #'pull-parser' XMLPullParser validation web markup document )
]

{ #category : #catalog }
ConfigurationOfXMLParserStAX class >> catalogLicense [
	^ 'The MIT License (MIT)

Copyright (c) 2016 PharoExtras Team.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'
]

{ #category : #private }
ConfigurationOfXMLParserStAX class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfXMLParserStAX class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfXMLParserStAX class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfXMLParserStAX class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfXMLParserStAX class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfXMLParserStAX class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfXMLParserStAX class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfXMLParserStAX class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline100: spec [ 
	<version: '1.0.0-baseline' imports: #('1-master-baseline')>
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline112: spec [
	<version: '1.1.2-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.4' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline117: spec [
	<version: '1.1.7-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.6.5' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline118: spec [
	<version: '1.1.8-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.7.3' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline120: spec [
	<version: '1.2.0-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.7.4' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline121: spec [
	<version: '1.2.1-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.7.6' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline122: spec [
	<version: '1.2.2-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.8.1' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline123: spec [
	<version: '1.2.3-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.8.3' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline124: spec [
	<version: '1.2.4-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.8.6' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline125: spec [
	<version: '1.2.5-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.8.7' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline126: spec [
	<version: '1.2.6-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3.0.6' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline127: spec [
	<version: '1.2.7-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3.1.7' ].

	spec
		for: #gemstone
		do: [
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline127. ].
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline129: spec [
	<version: '1.2.9-baseline' imports: #('1-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3.2.9' ].

	spec
		for: #gemstone
		do: [
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline127. ].
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline130: spec [
	<version: '1.3.0-baseline' imports: #('1.3-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3.3' ].

	spec
		for: #gemstone
		do: [
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline127. ].
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baseline132: spec [
	<version: '1.3.2-baseline' imports: #('1.3-master-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3.4.8' ].

	spec
		for: #gemstone
		do: [
			"force initialization of lazy-initialized class and class isnt
			vars to avoid write conflicts on GS"
			spec postLoadDoIt: #initializeClassesForGSBaseline127. ].
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baselineMaster13: spec [ 
	<version: '1.3-master-baseline'>

	"renamed packages from 'Parser-StAX' to 'ParserStAX' for portability"
	spec for: #'common' do: [
		spec blessing: #'baseline'.
		"migrated to PharoExtras/XMLParserStAX from PharoExtras/XMLParser"
		spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParserStAX/main'.
			spec
				project: 'XMLParser'
				with: [ 
					spec
						className: 'ConfigurationOfXMLParser';
						versionString: #stable;
						loads: #('Core');
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
			spec
				project: 'XMLParserCoreWithWriting'
				copyFrom: 'XMLParser'
				with: [ spec loads: #('CoreWithWriting') ].
			spec
				project: 'XMLParserTests'
				copyFrom: 'XMLParser'
				with: [ spec loads: #('Tests') ].
		spec package: 'XML-ParserStAX-Core' with: [ spec requires: 'XMLParser' ].
		spec package: 'XML-ParserStAX-Tests' with: [
			spec requires: #('XMLParserTests' 'XML-ParserStAX-Core') ].
		spec
			group: 'default' with: #('CoreWithWriting' 'Tests');
			group: 'Core' with: #('XML-ParserStAX-Core');
			group: 'CoreWithWriting' with: #('XMLParserCoreWithWriting' 'XML-ParserStAX-Core');
			group: 'Tests' with: #('XML-ParserStAX-Tests')]
]

{ #category : #baselines }
ConfigurationOfXMLParserStAX >> baselineMaster1: spec [ 
	<version: '1-master-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		"migrated to PharoExtras/XMLParserStAX from PharoExtras/XMLParser"
		spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParserStAX/main'.
			spec
				project: 'XMLParser'
				with: [ 
					spec
						className: 'ConfigurationOfXMLParser';
						versionString: #stable;
						loads: #('Core');
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
			spec
				project: 'XMLParserCoreWithWriting'
				copyFrom: 'XMLParser'
				with: [ spec loads: #('CoreWithWriting') ].
			spec
				project: 'XMLParserTests'
				copyFrom: 'XMLParser'
				with: [ spec loads: #('Tests') ].
		spec package: 'XML-Parser-StAX-Core' with: [ spec requires: 'XMLParser' ].
		spec package: 'XML-Parser-StAX-Tests' with: [
			spec requires: #('XMLParserTests' 'XML-Parser-StAX-Core') ].
		spec
			group: 'default' with: #('CoreWithWriting' 'Tests');
			group: 'Core' with: #('XML-Parser-StAX-Core');
			group: 'CoreWithWriting' with: #('XMLParserCoreWithWriting' 'XML-Parser-StAX-Core');
			group: 'Tests' with: #('XML-Parser-StAX-Tests')]
]

{ #category : #accessing }
ConfigurationOfXMLParserStAX >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfXMLParserStAX >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.3.2-baseline'.
]

{ #category : #doits }
ConfigurationOfXMLParserStAX >> initializeClassesForGSBaseline127 [
	StAXStatelessEvent allSubclassesDo: [:each |
		each instance]
]

{ #category : #accessing }
ConfigurationOfXMLParserStAX >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfXMLParserStAX >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.3.4'.
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version100: spec [ 
        <version: '1.0.0' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.2'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.1'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version101: spec [ 
        <version: '1.0.1' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.3'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.2'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version102: spec [ 
        <version: '1.0.2' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.4'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.3'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version103: spec [ 
        <version: '1.0.3' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.5'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.4'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version104: spec [ 
        <version: '1.0.4' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.6'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.5'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version105: spec [ 
        <version: '1.0.5' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.7'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.6'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version106: spec [ 
        <version: '1.0.6' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.7'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.7'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version107: spec [ 
        <version: '1.0.7' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.8'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.8'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version108: spec [ 
        <version: '1.0.8' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.9'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.8'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version109: spec [ 
        <version: '1.0.9' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.10'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.8'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version110: spec [ 
        <version: '1.1.0' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.11'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.9'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version111: spec [ 
        <version: '1.1.1' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.12'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.10'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version112: spec [ 
        <version: '1.1.2' imports: #('1.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.14'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.10'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version113: spec [ 
        <version: '1.1.3' imports: #('1.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.15'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.11'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version114: spec [ 
        <version: '1.1.4' imports: #('1.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.16'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.12'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version115: spec [ 
        <version: '1.1.5' imports: #('1.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.17'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.13'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version116: spec [ 
        <version: '1.1.6' imports: #('1.1.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.19'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.14'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version117: spec [ 
        <version: '1.1.7' imports: #('1.1.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.20'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.15'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version118: spec [ 
        <version: '1.1.8' imports: #('1.1.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.21'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.16'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version119: spec [ 
        <version: '1.1.9' imports: #('1.1.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.22'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.16'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version120: spec [ 
        <version: '1.2.0' imports: #('1.2.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.23'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.16'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version121: spec [ 
        <version: '1.2.1' imports: #('1.2.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.24'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version122: spec [ 
        <version: '1.2.2' imports: #('1.2.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.25'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version123: spec [ 
        <version: '1.2.3' imports: #('1.2.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.26'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version124: spec [ 
        <version: '1.2.4' imports: #('1.2.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.27'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.18'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version125: spec [ 
        <version: '1.2.5' imports: #('1.2.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.28'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.18'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version126: spec [ 
        <version: '1.2.6' imports: #('1.2.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.29'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.19'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version127: spec [ 
        <version: '1.2.7' imports: #('1.2.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.30'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.20'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version128: spec [ 
        <version: '1.2.8' imports: #('1.2.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.31'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.20'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version129: spec [ 
        <version: '1.2.9' imports: #('1.2.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-StAX-Core' with: 'XML-Parser-StAX-Core-monty.32'.
			spec package: 'XML-Parser-StAX-Tests' with: 'XML-Parser-StAX-Tests-monty.21'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version130: spec [ 
        <version: '1.3.0' imports: #('1.3.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-ParserStAX-Core' with: 'XML-ParserStAX-Core-monty.1'.
			spec package: 'XML-ParserStAX-Tests' with: 'XML-ParserStAX-Tests-monty.1'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version131: spec [ 
        <version: '1.3.1' imports: #('1.3.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-ParserStAX-Core' with: 'XML-ParserStAX-Core-monty.2'.
			spec package: 'XML-ParserStAX-Tests' with: 'XML-ParserStAX-Tests-monty.1'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version132: spec [ 
        <version: '1.3.2' imports: #('1.3.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-ParserStAX-Core' with: 'XML-ParserStAX-Core-monty.3'.
			spec package: 'XML-ParserStAX-Tests' with: 'XML-ParserStAX-Tests-monty.2'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version133: spec [ 
        <version: '1.3.3' imports: #('1.3.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-ParserStAX-Core' with: 'XML-ParserStAX-Core-monty.4'.
			spec package: 'XML-ParserStAX-Tests' with: 'XML-ParserStAX-Tests-monty.2'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserStAX >> version134: spec [ 
        <version: '1.3.4' imports: #('1.3.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-ParserStAX-Core' with: 'XML-ParserStAX-Core-monty.5'.
			spec package: 'XML-ParserStAX-Tests' with: 'XML-ParserStAX-Tests-monty.2'.
                ].
]
