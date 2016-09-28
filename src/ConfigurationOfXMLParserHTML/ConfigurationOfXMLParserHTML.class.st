"
(ConfigurationOfXMLParserHTML project version: #stable) load
 
"
Class {
	#name : #ConfigurationOfXMLParserHTML,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfXMLParserHTML
}

{ #category : #'development support' }
ConfigurationOfXMLParserHTML class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfXMLParserHTML class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfXMLParserHTML class >> catalogDescription [

	^ 'XMLParserHTML provides SAX and DOM parsers for HTML that convert possibly malformed HTML into well-formed XML.'

]

{ #category : #catalog }
ConfigurationOfXMLParserHTML class >> catalogKeyClassesAndExample [

	^ 'The main classes are ==SAXHTMLHandler== and ==XMLHTMLParser== (DOM).
	
	Here is an example:
[[[ 
	"get all links from the Pharo homepage"
	((XMLHTMLParser parseURL: ''http://pharo.org'') allElementsNamed: ''a'')
		collect: [:each | each attributeAt: ''href''].
]]]'
]

{ #category : #catalog }
ConfigurationOfXMLParserHTML class >> catalogKeywords [

	^ #( HTML SAX DOM parser web markup document)
]

{ #category : #catalog }
ConfigurationOfXMLParserHTML class >> catalogLicense [
	^ 'The MIT License (MIT)

Copyright (c) 2016 PharoExtras Team.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'
]

{ #category : #private }
ConfigurationOfXMLParserHTML class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfXMLParserHTML class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfXMLParserHTML class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfXMLParserHTML class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfXMLParserHTML class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfXMLParserHTML class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfXMLParserHTML class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfXMLParserHTML class >> validate [
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
ConfigurationOfXMLParserHTML >> baseline100: spec [
	<version: '1.0.0-baseline'>
	spec
		for: #common
		do: [ 
			spec
				blessing: #baseline;
				description: 'XML-Parser-HTML baseline';
				"migrated from PharoExtras/XMLParser to PharoExtras/XMLParserHTML"
				repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParserHTML/main'.
			spec
				project: 'XMLParser'
				with: [ 
					spec
						className: 'ConfigurationOfXMLParser';
						versionString: #stable;
						loads: #('default');
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
			spec package: 'XML-Parser-HTML-Core' with: [ spec requires: 'XMLParser' ].
			spec package: 'XML-Parser-HTML-Tests' with: [ spec requires: 'XML-Parser-HTML-Core' ].
			spec
				group: 'default' with: #('Core' 'Tests');
				group: 'Core' with: #('XML-Parser-HTML-Core');
				group: 'Tests' with: #('XML-Parser-HTML-Tests')].

	"load gemstone methods"
	spec
		for: #'gemstone'
		do: [
			spec
				package: 'XML-Parser-HTML-Core'
				with: [ spec includes: 'XML-Parser-HTML-GemstoneCompatibility' ].
			spec
				package: 'XML-Parser-HTML-GemstoneCompatibility'
				with: [ spec requires: 'XML-Parser-HTML-Core' ]. ].
]

{ #category : #baselines }
ConfigurationOfXMLParserHTML >> baseline114: spec [
	<version: '1.1.4-baseline' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ spec project: 'XMLParser' with: #'release-2.5' ].
	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec package: 'XML-Parser-HTML-GemstoneCompatibility' with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserHTML >> baseline122: spec [
	<version: '1.2.2-baseline' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ spec project: 'XMLParser' with: #'release-2.6.5' ].
	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec package: 'XML-Parser-HTML-GemstoneCompatibility' with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserHTML >> baseline124: spec [
	<version: '1.2.4-baseline' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ spec project: 'XMLParser' with: #'release-2.6.8' ].
	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec package: 'XML-Parser-HTML-GemstoneCompatibility' with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserHTML >> baseline125: spec [
	<version: '1.2.5-baseline' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ spec project: 'XMLParser' with: #'release-2.7.3' ].
	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec package: 'XML-Parser-HTML-GemstoneCompatibility' with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserHTML >> baseline126: spec [
	<version: '1.2.6-baseline' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ spec project: 'XMLParser' with: #'release-2.7.4' ].
	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec package: 'XML-Parser-HTML-GemstoneCompatibility' with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserHTML >> baseline127: spec [
	<version: '1.2.7-baseline' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ spec project: 'XMLParser' with: #'release-2.7.6' ].
	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec package: 'XML-Parser-HTML-GemstoneCompatibility' with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserHTML >> baseline128: spec [
	<version: '1.2.8-baseline' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ spec project: 'XMLParser' with: #'release-2.8.1' ].
	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec package: 'XML-Parser-HTML-GemstoneCompatibility' with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserHTML >> baseline129: spec [
	<version: '1.2.9-baseline' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ spec project: 'XMLParser' with: #'release-2.8.9' ].
	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec package: 'XML-Parser-HTML-GemstoneCompatibility' with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1' ]
]

{ #category : #baselines }
ConfigurationOfXMLParserHTML >> baseline130: spec [
	<version: '1.3.0-baseline' imports: #('1.0.0-baseline')>
	spec
		for: #common
		do: [ spec project: 'XMLParser' with: #'release-2.9' ].
	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec package: 'XML-Parser-HTML-GemstoneCompatibility' with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1' ]
]

{ #category : #accessing }
ConfigurationOfXMLParserHTML >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfXMLParserHTML >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.3.0-baseline'.
]

{ #category : #accessing }
ConfigurationOfXMLParserHTML >> project [

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
ConfigurationOfXMLParserHTML >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.3.0'.

]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version100: spec [ 
        <version: '1.0.0' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.2'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.1'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version101: spec [ 
        <version: '1.0.1' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.4'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.2'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version102: spec [ 
        <version: '1.0.2' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.6'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.2'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version103: spec [ 
        <version: '1.0.3' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.9'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.3'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version104: spec [ 
        <version: '1.0.4' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.12'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.4'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version105: spec [ 
        <version: '1.0.5' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.13'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.4'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version106: spec [ 
        <version: '1.0.6' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.14'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.4'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version107: spec [ 
        <version: '1.0.7' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.15'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.5'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version108: spec [ 
        <version: '1.0.8' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.16'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.5'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version109: spec [ 
        <version: '1.0.9' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.17'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.6'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version110: spec [ 
        <version: '1.1.0' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.18'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.7'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version111: spec [ 
        <version: '1.1.1' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.20'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.7'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version112: spec [ 
        <version: '1.1.2' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.20'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.8'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version113: spec [ 
        <version: '1.1.3' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.21'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.9'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version114: spec [ 
        <version: '1.1.4' imports: #('1.1.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.22'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.10'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version115: spec [ 
        <version: '1.1.5' imports: #('1.1.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.23'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.12'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version116: spec [ 
        <version: '1.1.6' imports: #('1.1.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.24'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.13'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version117: spec [ 
        <version: '1.1.7' imports: #('1.1.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.25'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.13'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version118: spec [ 
        <version: '1.1.8' imports: #('1.1.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.26'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.13'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version119: spec [ 
        <version: '1.1.9' imports: #('1.1.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.27'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.14'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version120: spec [ 
        <version: '1.2.0' imports: #('1.1.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.28'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.15'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version121: spec [ 
        <version: '1.2.1' imports: #('1.1.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.31'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.16'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version122: spec [ 
        <version: '1.2.2' imports: #('1.2.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.32'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version123: spec [ 
        <version: '1.2.3' imports: #('1.2.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.33'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version124: spec [ 
        <version: '1.2.4' imports: #('1.2.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.35'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version125: spec [ 
        <version: '1.2.5' imports: #('1.2.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.36'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version126: spec [ 
        <version: '1.2.6' imports: #('1.2.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.37'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version127: spec [ 
        <version: '1.2.7' imports: #('1.2.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.38'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version128: spec [ 
        <version: '1.2.8' imports: #('1.2.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.39'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.18'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version129: spec [ 
        <version: '1.2.9' imports: #('1.2.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.40'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.20'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParserHTML >> version130: spec [ 
        <version: '1.3.0' imports: #('1.3.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser-HTML-Core' with: 'XML-Parser-HTML-Core-monty.41'.
			spec package: 'XML-Parser-HTML-Tests' with: 'XML-Parser-HTML-Tests-monty.21'.
                ].
]
