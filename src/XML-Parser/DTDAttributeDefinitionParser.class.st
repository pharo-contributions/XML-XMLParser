"
This class parses an attribute definition in an ATTLIST declaration and creates a validator for it.
"
Class {
	#name : #DTDAttributeDefinitionParser,
	#superclass : #Object,
	#instVars : [
		'element',
		'name',
		'type',
		'defaultDeclaration'
	],
	#classVars : [
		'NonEnumerationValidators'
	],
	#category : #'XML-Parser-DTD'
}

{ #category : #'instance creation' }
DTDAttributeDefinitionParser class >> element: anElement name: aName type: aType default: aDefaultDeclaration [
	^ self new
		setElement: anElement
		name: aName
		type: aType
		default: aDefaultDeclaration
]

{ #category : #'class initialization' }
DTDAttributeDefinitionParser class >> initialize [
	"self initialize"

	(NonEnumerationValidators := Dictionary new)
		at: 'CDATA' put: XMLCDataAttributeValidator;
		at: 'ID' put: XMLIDAttributeValidator;
		at: 'IDREF' put: XMLIDRefAttributeValidator;
		at: 'IDREFS' put: XMLIDRefsAttributeValidator;
		at: 'ENTITY' put: XMLEntityAttributeValidator;
		at: 'ENTITIES' put: XMLEntitiesAttributeValidator;
		at: 'NMTOKEN' put: XMLNameAttributeValidator;
		at: 'NMTOKENS' put: XMLNamesAttributeValidator
]

{ #category : #testing }
DTDAttributeDefinitionParser >> isNotationEnumeration: aType [
	^ aType beginsWith: 'NOTATION '
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parse [
	| validator defaultPragma defaultValue |

	defaultPragma := self parseDefaultPragma.
	defaultValue := self parseDefaultValue.
	validator :=
		self validatorClassForType
			element: element
			name: name
			defaultPragma: defaultPragma
			defaultValue: defaultValue.

	validator isEnumerationValidator
		ifTrue: [validator values: (self parseEnumerationType)].

	^ validator.
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parseDefaultPragma [
	^ (defaultDeclaration beginsWith: '#')
		ifTrue: [
			(defaultDeclaration allButFirst
				copyUpTo: Character space) asSymbol]
		ifFalse: [nil].
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parseDefaultValue [
	| quote start end |

	quote := nil.
	defaultDeclaration
		doWithIndex: [:each :i |
			(quote isNil and: [each == $" or: [each == $']])
				ifTrue: [
					quote := each.
					start := i].
			(quote notNil and: [each == quote])
				ifTrue: [end := i]].
	^ (start notNil and: [end notNil])
		ifTrue: [defaultDeclaration copyFrom: start + 1 to: end - 1]
		ifFalse: ['']
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> parseEnumerationType [
	^ (DTDEnumerationListParser on:
		((self isNotationEnumeration: type)
			ifTrue: [type copyAfter: Character space]
			ifFalse: [type])) parse
]

{ #category : #initialization }
DTDAttributeDefinitionParser >> setElement: anElement name: aName type: aType default: aDefaultDeclaration [
	element := anElement.
	name := aName.
	type := aType.
	defaultDeclaration := aDefaultDeclaration.
]

{ #category : #parsing }
DTDAttributeDefinitionParser >> validatorClassForType [
	^ NonEnumerationValidators 
		at: (type ifEmpty: ['CDATA'])
		ifAbsent: [XMLEnumerationAttributeValidator]
]
