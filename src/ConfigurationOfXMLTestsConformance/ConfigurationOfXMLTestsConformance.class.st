"
ConfigurationOfXMLTestsConformance load
"
Class {
	#name : #ConfigurationOfXMLTestsConformance,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfXMLTestsConformance
}

{ #category : #'development support' }
ConfigurationOfXMLTestsConformance class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfXMLTestsConformance class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfXMLTestsConformance class >> catalogDescription [

	^ 'XMLTestsConformance is an extra test suite for XMLParser generated from the W3C conformance test suite: http://www.w3.org/XML/Test/'
]

{ #category : #catalog }
ConfigurationOfXMLTestsConformance class >> catalogLicense [
	^ 'The MIT License (MIT)

Copyright (c) 2016 PharoExtras Team.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'
]

{ #category : #private }
ConfigurationOfXMLTestsConformance class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfXMLTestsConformance class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfXMLTestsConformance class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfXMLTestsConformance class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfXMLTestsConformance class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfXMLTestsConformance class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfXMLTestsConformance class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfXMLTestsConformance class >> validate [
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
ConfigurationOfXMLTestsConformance >> baseline100: spec [
	<version: '1.0.0-baseline'>
	spec
		for: #common
		do: [ 
			spec
				blessing: #baseline;
				description: 'XML-Tests-Conformance baseline';
				repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main'.
			spec
				project: 'XMLParser'
				with: [ 
					spec
						className: 'ConfigurationOfXMLParser';
						versionString: #'stable';
						loads: #('default');
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
			spec package: 'XML-Tests-Conformance' with: [ spec requires: 'XMLParser' ].
			spec group: 'Tests' with: #('XML-Tests-Conformance').
			spec group: 'default' with: #('Tests')].
]

{ #category : #accessing }
ConfigurationOfXMLTestsConformance >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfXMLTestsConformance >> development: spec [
	<symbolicVersion: #development>
	
	spec for: #'common' version: '1.0.0-baseline'.
]

{ #category : #accessing }
ConfigurationOfXMLTestsConformance >> project [

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
ConfigurationOfXMLTestsConformance >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.2.1'.
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version100: spec [ 
        <version: '1.0.0' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.11'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version101: spec [ 
        <version: '1.0.1' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.12'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version102: spec [ 
        <version: '1.0.2' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.13'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version103: spec [ 
        <version: '1.0.3' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.14'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version104: spec [ 
        <version: '1.0.4' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.15'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version105: spec [ 
        <version: '1.0.5' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.16'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version106: spec [ 
        <version: '1.0.6' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version107: spec [ 
        <version: '1.0.7' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.18'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version108: spec [ 
        <version: '1.0.8' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.19'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version109: spec [ 
        <version: '1.0.9' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.21'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version110: spec [ 
        <version: '1.1.0' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.22'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version111: spec [ 
        <version: '1.1.1' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.23'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version112: spec [ 
        <version: '1.1.2' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.24'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version113: spec [ 
        <version: '1.1.3' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.25'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version114: spec [ 
        <version: '1.1.4' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.26'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version115: spec [ 
        <version: '1.1.5' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.27'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version116: spec [ 
        <version: '1.1.6' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.28'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version117: spec [ 
        <version: '1.1.7' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.29'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version118: spec [ 
        <version: '1.1.8' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.30'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version119: spec [ 
        <version: '1.1.9' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.31'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version120: spec [ 
        <version: '1.2.0' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.32'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLTestsConformance >> version121: spec [ 
        <version: '1.2.1' imports: #('1.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Tests-Conformance' with: 'XML-Tests-Conformance-monty.32'.
                ].
]
