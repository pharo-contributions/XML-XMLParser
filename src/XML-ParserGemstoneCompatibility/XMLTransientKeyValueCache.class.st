"
This class is a key-value cache implementation for Gemstone that uses a transient internal collection.
"
Class {
	#name : #XMLTransientKeyValueCache,
	#superclass : #XMLKeyValueCache,
	#category : #'XML-ParserGemstoneCompatibility'
}

{ #category : #testing }
XMLTransientKeyValueCache class >> isSupportedImplementation [
	^ XMLReentrantMutex hasSupportedImplementation
		and: [XMLClassFinder hasClassNamed: #TransientValue]
]

{ #category : #accessing }
XMLTransientKeyValueCache >> collection [
	^ collection value
		ifNil: [
			collection
				value: self collectionClass new;
				value]
]

{ #category : #initialization }
XMLTransientKeyValueCache >> setCollection: aKeyValueCollection [
	collection :=
		(XMLClassFinder classNamed: #TransientValue) value:
			aKeyValueCollection
]
