"
This is an abstract class for resolved external entity replacements.
"
Class {
	#name : 'DTDResolvedExternalParsedEntityReplacement',
	#superclass : 'Object',
	#category : 'XML-Parser-DTD',
	#package : 'XML-Parser',
	#tag : 'DTD'
}

{ #category : 'converting' }
DTDResolvedExternalParsedEntityReplacement >> asString [

	^ self contents
]

{ #category : 'accessing' }
DTDResolvedExternalParsedEntityReplacement >> contents [

	self subclassResponsibility
]

{ #category : 'testing' }
DTDResolvedExternalParsedEntityReplacement >> isEmpty [

	self subclassResponsibility
]

{ #category : 'testing' }
DTDResolvedExternalParsedEntityReplacement >> isNotEmpty [

	^ self isEmpty not
]

{ #category : 'testing' }
DTDResolvedExternalParsedEntityReplacement >> notEmpty [

	self
		deprecated: 'Please use #isNotEmpty instead.'
		transformWith: '`@receiver notEmpty' -> '`@receiver isNotEmpty'.

	^ self isNotEmpty
]

{ #category : 'accessing' }
DTDResolvedExternalParsedEntityReplacement >> readStream [

	self subclassResponsibility
]
