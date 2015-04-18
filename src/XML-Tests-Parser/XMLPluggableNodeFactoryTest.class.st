Class {
	#name : #XMLPluggableNodeFactoryTest,
	#superclass : #XMLNodeFactoryTest,
	#category : #'XML-Tests-Parser-Factories'
}

{ #category : #running }
XMLPluggableNodeFactoryTest class >> createDummyClasses [
	self nodeClasses
		with: self dummyClassNames
		do: [:nodeClass :dummyName |
			self
				createDummySubclassOf: nodeClass
				named: dummyName]
]

{ #category : #running }
XMLPluggableNodeFactoryTest class >> createDummySubclassOf: aNodeClass named: aName [
	(aNodeClass
		subclass: aName asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: self category)
		comment: 'A dummy subclass of ', aNodeClass name asString
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest class >> dummyClassNames [
	^ self nodeClasses collect: [:each |
		(self dummyClassPrefix,
			(each name asString allButFirst: 3)) asSymbol]
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest class >> dummyClassPrefix [
	^ 'XMLF'
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest class >> nodeClasses [
	^ #(XMLDocument XMLElement XMLString XMLCData XMLComment XMLPI)
		collect: [:each | Smalltalk at: each]
]

{ #category : #running }
XMLPluggableNodeFactoryTest class >> removeDummyClasses [
	self dummyClassNames do: [:each |
		self removeDummySubclassNamed: each]
]

{ #category : #running }
XMLPluggableNodeFactoryTest class >> removeDummySubclassNamed: aName [
	(Smalltalk at: aName asSymbol) removeFromSystem
]

{ #category : #testing }
XMLPluggableNodeFactoryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest >> cdataClass [
	^ XMLFCData
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest >> commentClass [
	^ XMLFComment
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest >> documentClass [
	^ XMLFDocument
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest >> elementClass [
	^ XMLFElement
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest >> factoryClass [
	^ XMLPluggableNodeFactory
]

{ #category : #'instance creation' }
XMLPluggableNodeFactoryTest >> newFactory [
	^ self factoryClass new
		documentClass: self documentClass;
		elementClass: self elementClass;
		stringClass: self stringClass;
		cdataClass: self cdataClass;
		commentClass: self commentClass;
		piClass: self piClass
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest >> piClass [
	^ XMLFPI
]

{ #category : #accessing }
XMLPluggableNodeFactoryTest >> stringClass [
	^ XMLFString
]

{ #category : #tests }
XMLPluggableNodeFactoryTest >> testAsPluggableNodeFactory [
	| factory pluggableFactory |

	factory := self factoryClass new.
	pluggableFactory := factory asPluggableNodeFactory.
	self
		assert: (pluggableFactory isKindOf: XMLPluggableNodeFactory);
		assert: pluggableFactory == factory.
]
