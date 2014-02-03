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

^ 'The main classes are ==SAXHandler== for streaming nodes or ==XMLDOMParser== for getting the complete tree in memory. There is also an ==HTMLHandler== and ==HTMLParser==, which provide the same interfaces but for HTML.

==XMLNode== and its subclasses implement a DOM API. Read the class comments for more information.

Validation against internal and external DTD subsets, namespace checking, and resolution of external entities is enabled by default.'
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

	spec for: #'common' version: '1.5.6'.
	
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
	spec for: #common version: '1.5.6'.
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

{ #category : #versions }
ConfigurationOfXMLParser >> version133: spec [
	<version: '1.3.3' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.189';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.31'
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version134: spec [
	<version: '1.3.4' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.190';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.31'
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version135: spec [
	<version: '1.3.5' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.191';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.33'
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version136: spec [
	<version: '1.3.6' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.192';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.33'
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version137: spec [
	<version: '1.3.7' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.193';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.34'
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version138: spec [
	<version: '1.3.8' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.195';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.36'
				].
	
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version139: spec [
	<version: '1.3.9' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.196';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.36'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version140: spec [
	<version: '1.4.0' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.197';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.37'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version141: spec [
	<version: '1.4.1' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.198';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.38'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version142: spec [
	<version: '1.4.2' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.200';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.39'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version143: spec [
	<version: '1.4.3' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.201';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.40'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version144: spec [
	<version: '1.4.4' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.203';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.41'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version145: spec [
	<version: '1.4.5' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.205';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.43'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version146: spec [
	<version: '1.4.6' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.205';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-StephaneDucasse.44'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version147: spec [
	<version: '1.4.7' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.208';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.46'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version148: spec [
	<version: '1.4.8' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.210';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.47'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version149: spec [
	<version: '1.4.9' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.211';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.47'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version150: spec [
	<version: '1.5.0' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.213';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.48'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version151: spec [
	<version: '1.5.1' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.215';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.48'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version152: spec [
	<version: '1.5.2' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.216';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.49'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version153: spec [
	<version: '1.5.3' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.218';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.51'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version154: spec [
	<version: '1.5.4' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.219';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.52'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version155: spec [
	<version: '1.5.5' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.220';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.53'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version156: spec [
	<version: '1.5.6' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.221';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.54'
				].
	
]
