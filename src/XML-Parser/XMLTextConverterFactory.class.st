"
A factory for text converter classes.
"
Class {
	#name : #XMLTextConverterFactory,
	#superclass : #Object,
	#classInstVars : [
		'converterClassesByEncodingName'
	],
	#category : #'XML-Parser-Streams'
}

{ #category : #accessing }
XMLTextConverterFactory class >> clearCachedConverterClasses [
	converterClassesByEncodingName removeAll
]

{ #category : #accessing }
XMLTextConverterFactory class >> converterClassForEncoding: anEncodingName [
	^ converterClassesByEncodingName
		at: anEncodingName
		ifAbsent: [
			converterClassesByEncodingName size >= self maxCachedConverterClasses
				ifTrue: [self clearCachedConverterClasses].
			converterClassesByEncodingName
				at: anEncodingName
				put: (self findConverterClassForEncoding: anEncodingName)]
]

{ #category : #private }
XMLTextConverterFactory class >> findConverterClassForEncoding: anEncodingName [
	^ (Smalltalk
		at: #TextConverter
		ifAbsent: [^ nil])
		defaultConverterClassForEncoding: anEncodingName asLowercase
]

{ #category : #'class initialization' }
XMLTextConverterFactory class >> initialize [
	"self initialize"

	super initialize.
	converterClassesByEncodingName := Dictionary new: self maxCachedConverterClasses.
]

{ #category : #accessing }
XMLTextConverterFactory class >> maxCachedConverterClasses [
	^ 32
]

{ #category : #'instance creation' }
XMLTextConverterFactory class >> newForEncoding: anEncodingName [
	^ (self converterClassForEncoding: anEncodingName)
		ifNotNil: [:converterClass | converterClass new]	
]
