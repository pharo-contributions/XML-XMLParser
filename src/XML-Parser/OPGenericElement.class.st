Class {
	#name : #OPGenericElement,
	#superclass : #Object,
	#instVars : [
		'tag',
		'attributes',
		'children',
		'characters'
	],
	#category : #'XML-Parser-Opax'
}

{ #category : #'instance creation' }
OPGenericElement class >> newElementWithTag: aString [
	"returns an instance of a generic element or of a subclass"
	| wantedClass |
	wantedClass := self allSubclasses
		detect: [:each | each xmlTags includes: aString] ifNone: [ self ].
	^ wantedClass new tag: aString
]

{ #category : #'instance creation' }
OPGenericElement class >> xmlTags [
	"returns the xml tags that are to be handled by the element"
	^OrderedCollection new
]

{ #category : #accessing }
OPGenericElement >> addChildLast: anElement [
	self children addLast: anElement
]

{ #category : #accessing }
OPGenericElement >> allChildren [

	| all |
	all := OrderedCollection new.
	self allChildrenDo: [:each | all addLast: each].
	^all
]

{ #category : #accessing }
OPGenericElement >> allChildrenDo: aBlock [

	self children do: [:each |
		aBlock value: each.
		each allChildrenDo: aBlock
	]
]

{ #category : #accessing }
OPGenericElement >> attributeAt: aString [
	| result |
	result := self attributes at: aString.
	^ result isEmpty ifFalse: [result] ifTrue: [nil].
]

{ #category : #accessing }
OPGenericElement >> attributeAt: aString ifPresent: aBlock [
	^ self attributes at: aString ifPresent: aBlock
]

{ #category : #accessing }
OPGenericElement >> attributeNamed: aString [
	^ self attributeAt: aString
]

{ #category : #accessing }
OPGenericElement >> attributes [
	^attributes
]

{ #category : #accessing }
OPGenericElement >> attributes: anObject [
	attributes := anObject.
	attributes associationsDo: [:assoc |
		attributes at: assoc key asLowercase put: assoc value ]
]

{ #category : #accessing }
OPGenericElement >> characters [
	^characters ifNil: ['']
]

{ #category : #accessing }
OPGenericElement >> characters: aString [
	characters := aString
]

{ #category : #accessing }
OPGenericElement >> children [
	^children isNil 
		ifTrue: [children := OrderedCollection new]
		ifFalse: [children].
]

{ #category : #accessing }
OPGenericElement >> childrenNamed: aTag do: aBlock [
	self allChildrenDo: [:each |
		each tag asLowercase = aTag asLowercase ifTrue: [ 
			aBlock value: each ] ]
]

{ #category : #accessing }
OPGenericElement >> deepChildNamed: aTag do: aBlock [

	self allChildrenDo: [:each |
		each tag = aTag ifTrue: [
			aBlock value: each.
			^ self ]
	]
]

{ #category : #testing }
OPGenericElement >> hasTag: aTag [
	^ self tag asLowercase = aTag asLowercase
]

{ #category : #printing }
OPGenericElement >> printAttributesOn: aStream [
	self attributes ifNotNil: [
		self attributes keys do: [ :key | aStream nextPutAll: ' ', key asString, '="', (attributes at: key) asString, '"' ]
	].
]

{ #category : #printing }
OPGenericElement >> printChildrenOn: aStream [
	| childStream |

	aStream nextPut: Character cr.
	childStream := ReadWriteStream on: String new.

	self children do: [ :each | each printOn: childStream ].

	childStream reset.
	[ childStream atEnd ] whileFalse: [
		aStream nextPutAll: '    '.
		aStream nextPutAll: (childStream upTo: Character cr).
		aStream nextPut: Character cr.
	
	]
]

{ #category : #printing }
OPGenericElement >> printLongTagOn: aStream [
	aStream nextPutAll: '<', self tag.
	self printAttributesOn: aStream.
	aStream nextPutAll: '>'.

	self children isEmpty ifTrue: [
		aStream nextPutAll: self characters.
	] ifFalse: [
		self printChildrenOn: aStream.
	].

	aStream nextPutAll: '</', self tag, '>','
'
]

{ #category : #printing }
OPGenericElement >> printOn: aStream [
"	(self children isEmpty & self characters trimSeparators isEmpty)
		ifTrue: [ self printShortTagOn: aStream ]
		ifFalse: [ "
			
			self printLongTagOn: aStream.
			 "]."
]

{ #category : #printing }
OPGenericElement >> printShortTagOn: aStream [
	aStream nextPutAll: '<', self tag.
	self printAttributesOn: aStream.
	aStream nextPutAll: '/>'.
]

{ #category : #accessing }
OPGenericElement >> tag [
	^tag
]

{ #category : #accessing }
OPGenericElement >> tag: anObject [
	tag := anObject
]
