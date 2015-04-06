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

	^ #( HTML SAX DOM parser web )
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
				repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main'.
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

		spec for: #gemstone do: [
			spec blessing: #baseline.
			spec
				package: 'XML-Parser-HTML-GemstoneCompatibility'
				with: 'XML-Parser-HTML-GemstoneCompatibility-monty.1'. ].
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

	spec for: #'common' version: '1.1.4-baseline'.
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

	spec for: #'common' version: '1.1.5'.

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
