Class {
	#name : 'XMLDOMConfigurationTest',
	#superclass : 'XMLConfigurationTest',
	#category : 'XML-Parser-Tests-Base',
	#package : 'XML-Parser-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
XMLDOMConfigurationTest >> configurationClass [
	^ XMLDOMConfiguration
]

{ #category : 'accessing' }
XMLDOMConfigurationTest >> nodeFactoryClass [
	^ XMLNodeFactory
]

{ #category : 'accessing' }
XMLDOMConfigurationTest >> parserHandlerClass [
	^ XMLDOMParser
]

{ #category : 'tests' }
XMLDOMConfigurationTest >> testCopy [

	| configuration nodeFactory copy |
	super testCopy.

	nodeFactory := self nodeFactoryClass new.
	(configuration := self newConfiguration)
		preservesCDataNodes: true;
		preservesCommentNodes: true;
		preservesIgnorableWhitespace: true;
		nodeFactory: nodeFactory.
	copy := configuration copy.
	self
		assert: copy preservesCDataNodes
		equals: configuration preservesCDataNodes;
		assert: copy preservesCommentNodes
		equals: configuration preservesCommentNodes;
		assert: copy preservesIgnorableWhitespace
		equals: configuration preservesIgnorableWhitespace;
		deny: copy nodeFactory identicalTo: configuration nodeFactory;
		assert: copy nodeFactory class
		equals: configuration nodeFactory class
]

{ #category : 'tests' }
XMLDOMConfigurationTest >> testNodeFactory [

	| configuration oldNodeFactory newNodeFactory |
	configuration := self newConfiguration.
	oldNodeFactory := configuration nodeFactory.
	self assert: oldNodeFactory class identicalTo: self nodeFactoryClass.

	newNodeFactory := self nodeFactoryClass new.
	self
		assert: (configuration nodeFactory: newNodeFactory)
		identicalTo: configuration;
		assert: configuration nodeFactory identicalTo: newNodeFactory
]

{ #category : 'tests' }
XMLDOMConfigurationTest >> testPreservesCDataNodes [

	| configuration |
	configuration := self newConfiguration.
	self
		deny: configuration preservesCDataNodes;
		assert: (configuration preservesCDataNodes: true)
		identicalTo: configuration;
		assert: configuration preservesCDataNodes;
		assert: (configuration preservesCDataNodes: false)
		identicalTo: configuration;
		deny: configuration preservesCDataNodes
]

{ #category : 'tests' }
XMLDOMConfigurationTest >> testPreservesCommentNodes [

	| configuration |
	configuration := self newConfiguration.
	self
		deny: configuration preservesCommentNodes;
		assert: (configuration preservesCommentNodes: true)
		identicalTo: configuration;
		assert: configuration preservesCommentNodes;
		assert: (configuration preservesCommentNodes: false)
		identicalTo: configuration;
		deny: configuration preservesCommentNodes
]

{ #category : 'tests' }
XMLDOMConfigurationTest >> testPreservesIgnorableWhitespace [

	| configuration |
	configuration := self newConfiguration.
	configuration isValidating: false.
	"should enable validation"
	self
		deny: configuration preservesIgnorableWhitespace;
		assert: (configuration preservesIgnorableWhitespace: true)
		identicalTo: configuration;
		assert: configuration preservesIgnorableWhitespace;
		assert: configuration isValidating.

	"disabling validation should disable it"
	self
		assert: (configuration isValidating: false)
		identicalTo: configuration;
		deny: configuration preservesIgnorableWhitespace;
		deny: configuration isValidating
]
