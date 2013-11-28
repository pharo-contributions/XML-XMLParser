"
(ConfigurationOfXMLParser project version: #stable) load: 'Tests'

(ConfigurationOfXMLParser project version: '1.3') load

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
- next action is to remov deprecated methods

[[[ 
expiry := 1 year.
(SystemNavigation default allClassesInPackageNamed: ''XML-Parser'')
	do: [:class |
	class selectors do: [:selector | | compiledMethod timeStamp |
	compiledMethod := class compiledMethodAt: selector.
	timeStamp := compiledMethod timeStamp copyAfter: Character space.
	(compiledMethod isDeprecated
		and: [(DateAndTime now - (DateAndTime fromString: timeStamp)) > expiry])
			ifTrue: [class removeSelector: selector]]].
]]]

and may be separate the HTMLParser into its own package.



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

	^ 'XMLParser allows you to parse and validate well-formed XML documents. The package contains a SAX Driver and a XMLDOMParser. If you are interested by XML parsing we also suggest to have a look at the XMLPullParser package.'

]

{ #category : #catalog }
ConfigurationOfXMLParser class >> catalogKeyClassesAndExample [

^ 'The main entry point is the class ==XMLParser==. There is also the =XMLParserTest== which is a good starting point.

- For validation have a look at ==DTDDocumentValidator==.

- You can get a ==SAXDriver== for streaming nodes or ==XMLDOMParser== for getting the complete tree in memory.

This package is large so have a look. There is also an ==HTMLParser==.
'
]

{ #category : #catalog }
ConfigurationOfXMLParser class >> catalogKeywords [

	^ #( XML parser validation DOM SAX DTD HTML )
					

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

{ #category : #baselines }
ConfigurationOfXMLParser >> baseline10: spec [
	<version: '1.0-baseline'>
	spec
		for: #common
		do: [ 
			spec
				blessing: #baseline;
				description: 'Migrated to SmalltalkHub';
				author: 'StephaneDucasse';
				timestamp: '04/30/2013';
				repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main'.

			spec project: 'XMLWriter'
					with: [ spec 
								className: 'ConfigurationOfXMLWriter';
								versionString: #stable;
								repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLWriter/main'.].

			spec project: 'BitmapCharacterSet'
					with: [ spec 
								className: 'ConfigurationOfBitmapCharacterSet';
								versionString: #stable;
								repository: 'http://www.smalltalkhub.com/mc/PharoExtras/BitmapCharacterSet/main'.].

		spec project: 'OrderPreservingDictionary' with: [
			spec 
				className: 'ConfigurationOfOrderPreservingDictionary';
				versionString: #stable; 
				loads: #('Core'); 
				repository: 'http://smalltalkhub.com/mc/PharoExtras/OrderPreservingDictionary/main'].	

			spec 
				package: 'XML-Parser' 
				with: [spec 
						requires: #('BitmapCharacterSet' 'OrderPreservingDictionary')].	
			spec package: 'XML-Tests-Parser'
					with: [ spec requires: #('XML-Parser' 'XMLWriter') ].
			
			spec
				group: 'default' with: #('Core' 'Tests');
				"default by default is equivalent to loading 'ALL' the packages still we added explicitly Tests to be loaded"
				group: 'Core' with: #('XML-Parser');
				group: 'Tests' with: #('XML-Tests-Parser') ].

]

{ #category : #'symbolic versions' }
ConfigurationOfXMLParser >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.3.2'.
	
]

{ #category : #accessing }
ConfigurationOfXMLParser >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfXMLParser >> stable: spec [
	<symbolicVersion: #stable>
	spec for: #common version: '1.3.2'.
	spec for: #'pharo1.x' version: '1.2'
]

{ #category : #versions }
ConfigurationOfXMLParser >> version100: spec [
	<version: '1.0' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-NorbertHartl.141';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-JAA.14' 
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version101: spec [
	<version: '1.1' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-StephaneDucasse.142';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-StephaneDucasse.15' 
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version102: spec [
	<version: '1.2' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-DamienCassou.143';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-StephaneDucasse.15' 
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version130: spec [
	<version: '1.3' imports: #('1.0-baseline')>
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

{ #category : #versions }
ConfigurationOfXMLParser >> version131: spec [
	<version: '1.3.1' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.186';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.29' 
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version132: spec [
	<version: '1.3.2' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.187';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.29' 
				].
	
	
]
