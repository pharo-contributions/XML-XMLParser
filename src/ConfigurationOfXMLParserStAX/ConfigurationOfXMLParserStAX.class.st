"
ConfigurationOfXMLParserStAX load
 
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

^ 'XMLParserStAX is a pull-parser based on XMLParser that provides a stream-like interface to parsing XML and also supports partial DOM construction.'
]

{ #category : #catalog }
ConfigurationOfXMLParserStAX class >> catalogKeyClassesAndExample [

	^ 'The main classes are ==StAXParser== and the ==StAXEvent== subclasses.

Examples:
[[[ 
	"get first book element as an XMLElement object:"
	element := 
		(parser := StAXParser on: xml)
			skipUntil: [parser peek isStartTag: ''book''];
			nextDOM.
]]]'
]

{ #category : #catalog }
ConfigurationOfXMLParserStAX class >> catalogKeywords [

	^ #( XML parser pull-parser validation DOM StAX DTD )
				
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
	<version: '1.0.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main'.
		spec project: 'XMLParser' with: [ 
			spec
				className: 'ConfigurationOfXMLParser';
				loads: #('default');	
				versionString: #'stable';
				repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
		spec package: 'XML-Parser-StAX-Core' with: [ spec requires: 'XMLParser' ].
		spec package: 'XML-Parser-StAX-Tests' with: [ spec requires: 'XML-Parser-StAX-Core' ].
		spec
			group: 'default' with: #('Core' 'Tests');
			group: 'Core' with: #('XML-Parser-StAX-Core');
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

	spec for: #'common' version: '1.0.0-baseline'.
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

	spec for: #'common' version: '1.0.8'.

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
