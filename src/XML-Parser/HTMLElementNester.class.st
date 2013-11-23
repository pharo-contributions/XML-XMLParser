Class {
	#name : #HTMLElementNester,
	#superclass : #XMLElementNester,
	#instVars : [
		'openElementsByName'
	],
	#classVars : [
		'MutuallyExcludingTags',
		'NestableTagGroups',
		'NestableTags',
		'SelfClosingTags'
	],
	#category : #'XML-Parser-HTML'
}

{ #category : #'class initialization' }
HTMLElementNester class >> initialize [
	"self initialize"

	self
		initializeSelfClosingTags;
		initializeNestableTags;
		initializeNestableTagGroups;
		initializeMutuallyExcludingTags
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeMutuallyExcludingTags [
	MutuallyExcludingTags := Dictionary new.
	#(#('dd' 'dt') #('thead' 'tbody') #('th' 'td'))
		do: [:tagList |
			tagList do: [:tag |
				tagList do: [:each |
					(each = tag)
						ifFalse: [MutuallyExcludingTags at: each put: tag]]]]

]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeNestableTagGroups [
	NestableTagGroups := Dictionary new.

	#('dt' 'dd') do: [:each |
		NestableTagGroups at: each put: #('dl')].
	#('tr' 'th' 'td' 'thead' 'tfoot') do: [:each |
		NestableTagGroups at: each put: #('table')].
	#('li') do: [:each |
		NestableTagGroups at: each put: #('ul' 'ol' 'menu' 'dir')].
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeNestableTags [
	NestableTags :=
		Set withAll:
			#('div' 'table' 'ul' 'ol' 'menu' 'dir' 'blockquote' 'a' 'b' 'big' 'code' 'em'
			'font' 'i' 'nobr' 's' 'small' 'strike' 'strong' 'tt' 'u' 'h1' 'h2' 'h3' 'h4' 'h5' 'h6')
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeSelfClosingTags [
	SelfClosingTags :=
		Set withAll:
			#('area' 'base' 'br' 'col' 'command' 'embed' 'hr' 'img'
			'input' 'keygen' 'link' 'meta' 'param' 'source' 'track' 'wbr')
]

{ #category : #testing }
HTMLElementNester >> canNestWithinSelf: anElementName [
	^ NestableTags includes: anElementName
]

{ #category : #accessing }
HTMLElementNester >> elementsToEndBeforeEnding: anElementName [
	| toClose |

	toClose := OrderedCollection new.
	self openElements reverseDo: [:each |
		each = anElementName
			ifTrue: [^ toClose]
			ifFalse: [toClose addLast: each]].
	^ toClose.
]

{ #category : #accessing }
HTMLElementNester >> elementsToEndBeforeStarting: anElementName [
	| toClose excludingElement |

	(self canNestWithinSelf: anElementName)
		ifTrue: [^ #()].

	excludingElement := self excludingElementFor: anElementName.
	((self hasOpenElement: anElementName)
		or: [excludingElement notEmpty
			and: [self hasOpenElement: excludingElement]])
		ifFalse: [^ #()].

	toClose := OrderedCollection new.
	self openElements reverseDo: [:each |
		((NestableTagGroups includesKey: anElementName)
			and: [(NestableTagGroups at: anElementName) includes: each])
			ifTrue: [^ #()].
		toClose addLast: each.
		((each = anElementName)
			or: [excludingElement notEmpty
				and: [excludingElement = each]])
			ifTrue: [^ toClose]].
	^ toClose.

	
]

{ #category : #checking }
HTMLElementNester >> endedElement: anElementName [
	self openElements removeLast.
	self openElementsByName
		at: anElementName
		put:
			((self openElementsByName
				at: anElementName
				ifAbsent: [1]) - 1 max: 0).
]

{ #category : #checking }
HTMLElementNester >> ensureNoElementsRemainOpen [
]

{ #category : #accessing }
HTMLElementNester >> excludingElementFor: anElementName [
	^ MutuallyExcludingTags at: anElementName ifAbsent: ['']

	
]

{ #category : #testing }
HTMLElementNester >> hasOpenElement: anElementName [
	^ (self openElementsByName at: anElementName ifAbsent: [0]) > 0
]

{ #category : #testing }
HTMLElementNester >> hasOpenSelfClosingTag [
	^ SelfClosingTags includes: self currentElement
]

{ #category : #accessing }
HTMLElementNester >> openElementsByName [
	^ openElementsByName ifNil: [openElementsByName := Dictionary new].
]

{ #category : #checking }
HTMLElementNester >> startedElement: anElementName [
	self openElements addLast: anElementName.
	self openElementsByName
		at: anElementName
		put:
			(self openElementsByName
				at: anElementName
				ifAbsent: [0]) + 1.
]
