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

^ 'The main classes are ==SAXHandler== for streaming nodes or ==XMLDOMParser== for getting the complete tree in memory.

==XMLNode== and its subclasses implement a DOM API. Read the class comments for more information.

Validation and namespace checking are enabled by default, but not resolution of external entities.'
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

			spec
				project: 'XMLWriter'
				with: [
					spec 
						className: 'ConfigurationOfXMLWriter';
						versionString: #stable;
						loads: #('default'); 
						repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLWriter/main'.].

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
				package: 'XML-Parser' 
				with: [spec requires: #('BitmapCharacterSet' 'OrderPreservingDictionary')].	
			spec
				package: 'XML-Tests-Parser'
				with: [ spec requires: #('XML-Parser' 'XMLWriter') ].
			
			spec
				group: 'default' with: #('Core' 'Tests');
				"default by default is equivalent to loading 'ALL' the packages still we added explicitly Tests to be loaded"
				group: 'Core' with: #('XML-Parser');
				group: 'Tests' with: #('XML-Tests-Parser') ].
			
	spec
		for: #'pharo2.x'
		do: [ 
			spec 
				package: 'XML-Pharo2-Parser';
				package: 'XML-Parser' with: [ 
					spec requires: #( 'XML-Pharo2-Parser' ) ] ]

]

{ #category : #baselines }
ConfigurationOfXMLParser >> baseline183: spec [ 
        <version: '1.8.3-baseline' imports: #('1.0-baseline')>
        
        spec for: #common do: [
                spec blessing: #baseline.
                spec project: 'XMLWriter' with: '2.4.6'. ].
]

{ #category : #baselines }
ConfigurationOfXMLParser >> baseline187: spec [ 
        <version: '1.8.7-baseline' imports: #('1.0-baseline')>
        
        spec for: #common do: [
                spec blessing: #baseline.
                spec project: 'XMLWriter' with: '2.4.7'. ].
]

{ #category : #baselines }
ConfigurationOfXMLParser >> baseline188: spec [ 
        <version: '1.8.8-baseline' imports: #('1.0-baseline')>
        
        spec for: #common do: [
                spec blessing: #baseline.
                spec project: 'XMLWriter' with: '2.4.8'. ].
]

{ #category : #'symbolic versions' }
ConfigurationOfXMLParser >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.8.8-baseline'.

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
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.8.9'.
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

{ #category : #versions }
ConfigurationOfXMLParser >> version157: spec [
	<version: '1.5.7' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.222';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.55'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version158: spec [
	<version: '1.5.8' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.223';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.56'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version159: spec [
	<version: '1.5.9' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.224';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.56'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version160: spec [
	<version: '1.6.0' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.225';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.57'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version161: spec [
	<version: '1.6.1' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.226';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.58'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version162: spec [
	<version: '1.6.2' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.227';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.58'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version163: spec [
	<version: '1.6.3' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #release.
			spec
				package: 'XML-Parser' with: 'XML-Parser-monty.228';
				package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.58'
				].
	
]

{ #category : #versions }
ConfigurationOfXMLParser >> version164: spec [
	<version: '1.6.4' imports: #('1.0-baseline')>
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

{ #category : #versions }
ConfigurationOfXMLParser >> version165: spec [
	<version: '1.6.5' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version166: spec [
	<version: '1.6.6' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version167: spec [
	<version: '1.6.7' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version168: spec [
	<version: '1.6.8' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version169: spec [
	<version: '1.6.9' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version170: spec [
	<version: '1.7.0' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version171: spec [
	<version: '1.7.1' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version172: spec [
	<version: '1.7.2' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version173: spec [
	<version: '1.7.3' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version174: spec [
	<version: '1.7.4' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version175: spec [
	<version: '1.7.5' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version176: spec [
	<version: '1.7.6' imports: #('1.0-baseline' )>

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

{ #category : #versions }
ConfigurationOfXMLParser >> version177: spec [
	<version: '1.7.7' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec 
			project: 'XMLWriter' with: '2.4.3';
			package: 'XML-Parser' with: 'XML-Parser-monty.243';
			package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.71'.]
]

{ #category : #versions }
ConfigurationOfXMLParser >> version178: spec [ 
        <version: '1.7.8' imports: #('1.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.4'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.244'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.72'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version179: spec [ 
        <version: '1.7.9' imports: #('1.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.4'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.245'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.73'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version180: spec [ 
        <version: '1.8.0' imports: #('1.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.4'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.246'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.74'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version181: spec [ 
        <version: '1.8.1' imports: #('1.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.4'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.247'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.75'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version182: spec [ 
        <version: '1.8.2' imports: #('1.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec project: 'XMLWriter' with: '2.4.5'.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.248'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.76'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version183: spec [ 
        <version: '1.8.3' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.250'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.77'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version184: spec [ 
        <version: '1.8.4' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.251'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.78'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version185: spec [ 
        <version: '1.8.5' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.252'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.79'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version186: spec [ 
        <version: '1.8.6' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.253'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.80'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version187: spec [ 
        <version: '1.8.7' imports: #('1.8.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.254'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.81'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version188: spec [ 
        <version: '1.8.8' imports: #('1.8.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.255'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.82'.
                ].
]

{ #category : #versions }
ConfigurationOfXMLParser >> version189: spec [ 
        <version: '1.8.9' imports: #('1.8.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XML-Parser' with: 'XML-Parser-monty.257'.
			spec package: 'XML-Tests-Parser' with: 'XML-Tests-Parser-monty.83'.
                ].
]
