"
This class is a null read stream that is already #atEnd and also makes sending #atEnd after #close or sending #close more than once safe, which is needed for the XMLNestedStreamReader null stream.
"
Class {
	#name : #XMLNullReadStream,
	#superclass : #Object,
	#category : #'XML-Parser-Streams'
}

{ #category : #testing }
XMLNullReadStream >> atEnd [
	^ true
]

{ #category : #private }
XMLNullReadStream >> basicNext [
	^ nil
]

{ #category : #closing }
XMLNullReadStream >> close [
]

{ #category : #accessing }
XMLNullReadStream >> contents [
	^ String new
]

{ #category : #testing }
XMLNullReadStream >> isBinary [
	^ false
]

{ #category : #testing }
XMLNullReadStream >> isStream [
	^ true
]

{ #category : #accessing }
XMLNullReadStream >> next [
	^ nil
]

{ #category : #accessing }
XMLNullReadStream >> peek [
	^ nil
]

{ #category : #positioning }
XMLNullReadStream >> position [
	^ 0
]

{ #category : #positioning }
XMLNullReadStream >> position: anInteger [
]

{ #category : #positioning }
XMLNullReadStream >> reset [
]

{ #category : #accessing }
XMLNullReadStream >> upToEnd [
	^ String new
]
