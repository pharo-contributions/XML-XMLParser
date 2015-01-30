"
This class places security limits on the number and size of external parsed entities. You can set these using the configuration messages in DTDExternalEntityResolver or remove them using removeLimits.
"
Class {
	#name : #DTDExternalEntityLimits,
	#superclass : #Object,
	#instVars : [
		'externalSubsetReadLimit',
		'maxExternalEntities',
		'maxExternalEntitySize',
		'resolvesLocalFromNonLocal'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #accessing }
DTDExternalEntityLimits class >> defaultExternalSubsetReadLimit [
	^ XMLParserLimits defaultReadLimit
		ifNotNil: [:limit | (limit / 4) asInteger]
]

{ #category : #accessing }
DTDExternalEntityLimits class >> defaultMaxExternalEntitySize [
	^ 2500000
]

{ #category : #accessing }
DTDExternalEntityLimits >> externalSubsetReadLimit [
	^ externalSubsetReadLimit
]

{ #category : #accessing }
DTDExternalEntityLimits >> externalSubsetReadLimit: aLimit [
	externalSubsetReadLimit := aLimit
]

{ #category : #initialization }
DTDExternalEntityLimits >> initialize [
	super initialize.

	externalSubsetReadLimit := self class defaultExternalSubsetReadLimit.
	maxExternalEntities := 16.
	maxExternalEntitySize := self class defaultMaxExternalEntitySize.
	resolvesLocalFromNonLocal := false.
]

{ #category : #accessing }
DTDExternalEntityLimits >> maxExternalEntities [
	^ maxExternalEntities
]

{ #category : #accessing }
DTDExternalEntityLimits >> maxExternalEntities: aLimit [
	maxExternalEntities := aLimit
]

{ #category : #accessing }
DTDExternalEntityLimits >> maxExternalEntitySize [
	^ maxExternalEntitySize
]

{ #category : #accessing }
DTDExternalEntityLimits >> maxExternalEntitySize: aLimit [
	maxExternalEntitySize := aLimit
]

{ #category : #removing }
DTDExternalEntityLimits >> removeAll [
	externalSubsetReadLimit := nil.
	maxExternalEntities := nil.
	maxExternalEntitySize := nil.
	resolvesLocalFromNonLocal := nil.
]

{ #category : #accessing }
DTDExternalEntityLimits >> resolvesLocalFromNonLocal [
	^ resolvesLocalFromNonLocal
]

{ #category : #accessing }
DTDExternalEntityLimits >> resolvesLocalFromNonLocal: aBoolean [
	resolvesLocalFromNonLocal := aBoolean
]
