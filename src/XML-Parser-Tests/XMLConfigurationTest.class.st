Class {
	#name : 'XMLConfigurationTest',
	#superclass : 'TestCase',
	#category : 'XML-Parser-Tests-Base',
	#package : 'XML-Parser-Tests',
	#tag : 'Base'
}

{ #category : 'testing' }
XMLConfigurationTest class >> shouldInheritSelectors [
	^ true
]

{ #category : 'accessing' }
XMLConfigurationTest >> configurationClass [
	^ XMLConfiguration
]

{ #category : 'accessing' }
XMLConfigurationTest >> externalEntityResolverClass [
	^ DTDCachingExternalEntityResolver
]

{ #category : 'instance creation' }
XMLConfigurationTest >> newConfiguration [
	^ self configurationClass new
]

{ #category : 'accessing' }
XMLConfigurationTest >> otherParserHandlerClass [
	^ SAX2Parser
]

{ #category : 'accessing' }
XMLConfigurationTest >> parserHandlerClass [
	^ SAXHandler
]

{ #category : 'tests' }
XMLConfigurationTest >> testCopy [

	| configuration externalEntityResolver copy |
	externalEntityResolver := self externalEntityResolverClass new.
	(configuration := self newConfiguration)
		isValidating: false;
		usesNamespaces: false;
		decodesCharacters: false;
		parserHandlerClass: self otherParserHandlerClass;
		documentReadLimit: XMLParserLimits defaultDocumentReadLimit - 1;
		maxEntityReplacementDepth:
			XMLParserLimits defaultMaxEntityReplacementDepth - 1;
		preservesUndeclaredEntityReferences: true;
		replacesContentEntityReferences: false;
		resolvesExternalEntities: true;
		externalEntityResolver: externalEntityResolver.
	copy := configuration copy.
	self
		deny: copy identicalTo: configuration;
		assert: copy isValidating equals: configuration isValidating;
		assert: copy usesNamespaces equals: configuration usesNamespaces;
		assert: copy decodesCharacters
		equals: configuration decodesCharacters;
		assert: copy requiresSchema equals: configuration requiresSchema;
		assert: copy parserHandlerClass
		identicalTo: configuration parserHandlerClass.
	self
		deny: copy parserLimits identicalTo: configuration parserLimits;
		assert: copy documentReadLimit
		equals: configuration documentReadLimit;
		assert: copy maxEntityReplacementDepth
		equals: configuration maxEntityReplacementDepth.
	self
		deny: copy entityConfiguration
		identicalTo: configuration entityConfiguration;
		assert: copy preservesUndeclaredEntityReferences
		equals: configuration preservesUndeclaredEntityReferences;
		assert: copy replacesContentEntityReferences
		equals: configuration replacesContentEntityReferences;
		assert: copy resolvesExternalEntities
		equals: configuration resolvesExternalEntities;
		deny: copy externalEntityResolver
		identicalTo: configuration externalEntityResolver;
		assert: copy externalEntityResolver class
		identicalTo: configuration externalEntityResolver class
]

{ #category : 'tests' }
XMLConfigurationTest >> testDecodesCharacters [

	| configuration |
	configuration := self newConfiguration.
	self
		assert: configuration decodesCharacters;
		assert: (configuration decodesCharacters: false)
		identicalTo: configuration;
		deny: configuration decodesCharacters;
		assert: (configuration decodesCharacters: true)
		identicalTo: configuration;
		assert: configuration decodesCharacters
]

{ #category : 'tests' }
XMLConfigurationTest >> testDocumentReadLimit [

	| configuration |
	configuration := self newConfiguration.
	self
		assert: configuration documentReadLimit
		equals: XMLParserLimits defaultDocumentReadLimit;
		assert: (configuration documentReadLimit: 100000)
		identicalTo: configuration;
		assert: configuration documentReadLimit equals: 100000;
		assert: (configuration documentReadLimit: nil)
		identicalTo: configuration;
		assert: configuration documentReadLimit isNil
]

{ #category : 'tests' }
XMLConfigurationTest >> testEntityConfiguration [

	| configuration newEntityConfiguration |
	configuration := self newConfiguration.
	self
		assert: configuration entityConfiguration class
		identicalTo: DTDEntityConfiguration.

	newEntityConfiguration := DTDEntityConfiguration new.
	self
		assert: (configuration entityConfiguration: newEntityConfiguration)
		identicalTo: configuration.
	self
		assert: configuration entityConfiguration
		identicalTo: newEntityConfiguration
]

{ #category : 'tests' }
XMLConfigurationTest >> testExternalEntityResolver [

	| configuration oldResolver newResolver |
	configuration := self newConfiguration.
	oldResolver := configuration externalEntityResolver.
	self
		assert: oldResolver class
		identicalTo: self externalEntityResolverClass.

	newResolver := self externalEntityResolverClass new.
	self
		assert: (configuration externalEntityResolver: newResolver)
		identicalTo: configuration;
		assert: configuration externalEntityResolver
		identicalTo: newResolver
]

{ #category : 'tests' }
XMLConfigurationTest >> testIsValidating [

	| configuration |
	configuration := self newConfiguration.
	self
		assert: configuration isValidating;
		assert: (configuration isValidating: false)
		identicalTo: configuration;
		deny: configuration isValidating;
		assert: (configuration isValidating: true)
		identicalTo: configuration;
		assert: configuration isValidating
]

{ #category : 'tests' }
XMLConfigurationTest >> testMaxEntityReplacementDepth [

	| configuration |
	configuration := self newConfiguration.
	self
		assert: configuration maxEntityReplacementDepth
		equals: XMLParserLimits defaultMaxEntityReplacementDepth.
	self
		assert: (configuration maxEntityReplacementDepth: 20)
		identicalTo: configuration;
		assert: configuration maxEntityReplacementDepth equals: 20;
		assert: (configuration maxEntityReplacementDepth: nil)
		identicalTo: configuration;
		assert: configuration maxEntityReplacementDepth isNil
]

{ #category : 'tests' }
XMLConfigurationTest >> testParserHandlerClass [

	| configuration |
	configuration := self newConfiguration.
	self
		assert: configuration parserHandlerClass
		identicalTo: self parserHandlerClass.
	self
		assert:
		(configuration parserHandlerClass: self otherParserHandlerClass)
		identicalTo: configuration.
	self
		assert: configuration parserHandlerClass
		identicalTo: self otherParserHandlerClass
]

{ #category : 'tests' }
XMLConfigurationTest >> testParserLimits [

	| configuration newParserLimits |
	configuration := self newConfiguration.
	self
		assert: configuration parserLimits class
		identicalTo: XMLParserLimits.

	newParserLimits := XMLParserLimits new.
	self
		assert: (configuration parserLimits: newParserLimits)
		identicalTo: configuration;
		assert: configuration parserLimits identicalTo: newParserLimits
]

{ #category : 'tests' }
XMLConfigurationTest >> testPreservesUndeclaredEntityReferences [

	| configuration |
	configuration := self newConfiguration.
	self deny: configuration preservesUndeclaredEntityReferences.

	"enabling should disable validation"
	self
		assert: (configuration preservesUndeclaredEntityReferences: true)
		identicalTo: configuration.
	self
		assert: configuration preservesUndeclaredEntityReferences;
		deny: configuration isValidating.
	self
		assert: (configuration isValidating: true)
		identicalTo: configuration;
		assert: configuration isValidating;
		deny: configuration preservesUndeclaredEntityReferences
]

{ #category : 'tests' }
XMLConfigurationTest >> testReplacesContentEntityReferences [

	| configuration |
	configuration := self newConfiguration.
	self assert: configuration replacesContentEntityReferences.
	self
		assert: (configuration replacesContentEntityReferences: false)
		identicalTo: configuration.
	self deny: configuration replacesContentEntityReferences.
	self
		assert: (configuration replacesContentEntityReferences: true)
		identicalTo: configuration.
	self assert: configuration replacesContentEntityReferences
]

{ #category : 'tests' }
XMLConfigurationTest >> testRequiresSchema [

	| configuration |
	(configuration := self newConfiguration) isValidating: false.
	self deny: configuration requiresSchema.

	"enabling should force validation"
	self
		assert: (configuration requiresSchema: true)
		identicalTo: configuration;
		assert: configuration requiresSchema;
		assert: configuration isValidating.
	self
		assert: (configuration isValidating: false)
		identicalTo: configuration;
		deny: configuration isValidating;
		deny: configuration requiresSchema
]

{ #category : 'tests' }
XMLConfigurationTest >> testResolvesExternalEntities [

	| configuration |
	configuration := self newConfiguration.
	"should not resolve external entities by default for security"
	self
		deny: configuration resolvesExternalEntities;
		assert: (configuration resolvesExternalEntities: true)
		identicalTo: configuration;
		assert: configuration resolvesExternalEntities;
		assert: (configuration resolvesExternalEntities: false)
		identicalTo: configuration;
		deny: configuration resolvesExternalEntities
]

{ #category : 'tests' }
XMLConfigurationTest >> testUsesNamespaces [

	| configuration |
	configuration := self newConfiguration.
	self
		assert: configuration usesNamespaces;
		assert: (configuration usesNamespaces: false)
		identicalTo: configuration;
		deny: configuration usesNamespaces;
		assert: (configuration usesNamespaces: true)
		identicalTo: configuration;
		assert: configuration usesNamespaces
]
