"
The class is the standard key-value cache implementation used on Pharo/Squeak.
"
Class {
	#name : #XMLStandardKeyValueCache,
	#superclass : #XMLKeyValueCache,
	#category : #'XML-Parser-Utils'
}

{ #category : #testing }
XMLStandardKeyValueCache class >> isSupportedImplementation [
	^ XMLReentrantMutex hasSupportedImplementation
		and: [
			"Must use the transient class on GS to avoid persisting"
			XMLTransientKeyValueCache isSupportedImplementation not]
]

{ #category : #accessing }
XMLStandardKeyValueCache >> collection [
	^ collection
]

{ #category : #initialization }
XMLStandardKeyValueCache >> setCollection: aKeyValueCollection [
	collection := aKeyValueCollection
]
