Class {
	#name : #DTDExternalEntityLimits,
	#superclass : #Object,
	#instVars : [
		'maxExternalEntities',
		'maxExternalEntitySize'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #initialization }
DTDExternalEntityLimits >> initialize [
	super initialize
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
]
