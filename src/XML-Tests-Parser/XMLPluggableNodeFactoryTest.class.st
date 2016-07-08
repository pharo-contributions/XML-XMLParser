Class {
	#name : #XMLPluggableNodeFactoryTest,
	#superclass : #XMLNodeFactoryTest,
	#category : #'XML-Tests-Parser-Factories'
}

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
