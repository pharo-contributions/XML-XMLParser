"
This class places security limits on the number and size of external parsed entities. You can set these using the configuration messages in DTDExternalEntityResolver or remove them using removeLimits.
"
Class {
	#name : #DTDExternalEntityLimits,
	#superclass : #Object,
	#instVars : [
		'maxExternalEntities',
		'maxExternalEntitySize',
		'resolvesLocalFromNonLocal'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #accessing }
DTDExternalEntityLimits class >> defaultMaxExternalEntitySize [
	^ 250000
]

{ #category : #initialization }
DTDExternalEntityLimits >> initialize [
	super initialize.

	maxExternalEntities := 12.
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
