"
This class can handle the nesting of HTML elements missing closing tags or with opening and closing tags in the wrong order.
"
Class {
	#name : #HTMLElementNester,
	#superclass : #XMLElementNester,
	#instVars : [
		'openElementsByName'
	],
	#classVars : [
		'BodySectionElements',
		'HeadSectionElements',
		'MutuallyExcludingTags',
		'NestableTagGroups',
		'NonNestableElements',
		'VoidElements'
	],
	#category : #'XML-Parser-HTML'
}

{ #category : #'class initialization' }
HTMLElementNester class >> initialize [
	"self initialize"

	super initialize.
	self
		initializeHeadSectionElements;
		initializeBodySectionElements;
		initializeNestableTagGroups;
		initializeNonNestableElements;
		initializeMutuallyExcludingTags;
		initializeVoidElements.
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeBodySectionElements [
	BodySectionElements := Set withAll:
		#('a' 'abbr' 'acronym' 'address' 'applet' 'area' 'article' 'aside' 'audio' 'b' 'basefont'
			'bdi' 'bdo' 'big' 'blockquote' 'br' 'button' 'canvas' 'caption' 'center' 'cite' 'code'
			'col' 'colgroup' 'command' 'data' 'datagrid' 'datalist' 'dd' 'del' 'details' 'dfn' 'dir'
			'div' 'dl' 'dt' 'em' 'embed' 'eventsource' 'fieldset' 'figcaption' 'figure' 'font'
			'footer' 'form' 'frame' 'frameset' 'h1' 'h2' 'h3' 'h4' 'h5' 'h6' 'header' 'hgroup' 'hr'
			'i' 'iframe' 'img' 'input' 'ins' 'kbd' 'keygen' 'label' 'legend' 'li' 'map' 'mark' 'menu'
			'meter' 'nav' 'noframes' 'noscript' 'object' 'ol' 'optgroup' 'option' 'output' 'p'
			'param' 'pre' 'progress' 'q' 'rp' 'rt' 'ruby' 's' 'samp' 'script' 'section' 'select' 'small'
			'source' 'span' 'strike' 'strong' 'style' 'sub' 'summary' 'sup' 'table' 'tbody' 'td'
			'textarea' 'tfoot' 'th' 'thead' 'time' 'tr' 'track' 'tt' 'u' 'ul' 'var' 'video' 'wbr')
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeHeadSectionElements [
	HeadSectionElements :=  Set withAll:
		#('base' 'isindex' 'link' 'meta' 'noscript' 'object' 'script' 'style' 'template' 'title')
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeMutuallyExcludingTags [
	MutuallyExcludingTags := Dictionary new.
	#(#('dd' 'dt') #('thead' 'tbody') #('th' 'td') #('rp' 'rt'))
		do: [:tagList |
			tagList do: [:tag |
				tagList do: [:each |
					(each = tag)
						ifFalse: [MutuallyExcludingTags at: each put: tag]]]]

]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeNestableTagGroups [
	NestableTagGroups := Dictionary new.

	#('dd' 'dt') do: [:each |
		NestableTagGroups at: each put: #('dl')].
	#('tr' 'th' 'td' 'thead' 'tfoot') do: [:each |
		NestableTagGroups at: each put: #('table')].
	#('rp' 'rt') do: [:each |
		NestableTagGroups at: each put: #('ruby')].

	NestableTagGroups at: 'li' put: #('ul' 'ol' 'menu' 'dir') asSet.
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeNonNestableElements [
	(NonNestableElements := Set new)
		addAll:
			#('a' 'applet' 'audio' 'button' 'footer' 'form' 'header' 'label' 'map'
				'meter' 'optgroup' 'option' 'ruby' 'select' 'video');
		addAll: NestableTagGroups keys
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeVoidElements [
	VoidElements :=
		Set withAll:
			#('area' 'base' 'br' 'col' 'command' 'embed' 'hr' 'img' 'input' 'keygen'
				'link' 'menuitem' 'meta' 'param' 'source' 'track' 'wbr')
]

{ #category : #testing }
HTMLElementNester >> cannotNestWithinSelf: anElementName [
	| tagGroup |

	(NonNestableElements includes: anElementName)
		ifFalse: [^ false].
		
	"tags like <td> can nest in each other if there is a <table> between
	them like <td><table><tr><td>...."
	((tagGroup := NestableTagGroups at: anElementName ifAbsent: [#()])
		anySatisfy: [:each | self hasOpenElement: each])
		ifFalse: [^ true].

	self openElementsReverseDo: [:each |
		each = anElementName
			ifTrue: [^ true].
		(tagGroup includes: each)
			ifTrue: [^ false]].
]

{ #category : #testing }
HTMLElementNester >> currentSectionCannotContain: anElementName [
	^ ((self hasOpenElement: 'head')
		and: [self isBodySectionOnlyElement: anElementName])
			or: [(self hasOpenElement: 'body')
				and: [self isHeadSectionOnlyElement: anElementName]]
]

{ #category : #checking }
HTMLElementNester >> elementsToEndBeforeEnding: anElementName do: aBlock [
	self openElementsReverseDo: [:each |
		each = anElementName
			ifTrue: [^ self].
		aBlock value: each].
]

{ #category : #checking }
HTMLElementNester >> elementsToEndBeforePCDataDo: aBlock [
	(self hasOpenElement: 'head')
		ifTrue: [
			self
				elementsToEndBeforeEnding: 'head'
				do: aBlock.
			aBlock value: 'head']
]

{ #category : #checking }
HTMLElementNester >> elementsToEndBeforeStarting: anElementName do: aBlock [
	| excludingElement |

	self hasOpenElements
		ifFalse: [^ self].

	(anElementName = 'body'
		or: [anElementName = 'head'
			or: [self currentSectionCannotContain: anElementName]])
		ifTrue: [^ self elementsToEndBeforeEnding: 'html' do: aBlock].

	(((self hasOpenElement: anElementName)
		and: [self cannotNestWithinSelf: anElementName])
		or: [(excludingElement := MutuallyExcludingTags at: anElementName ifAbsent: [nil]) notNil
			and: [self hasOpenElement: excludingElement]])
		ifFalse: [^ self].

	self openElementsReverseDo: [:each |
		aBlock value: each.
		((each = anElementName)
			or: [each = excludingElement])
			ifTrue: [^ self]].
]

{ #category : #checking }
HTMLElementNester >> elementsToStartBeforePCDataDo: aBlock [
	self hasOpenElements
		ifFalse: [aBlock value: 'html'].
	(self hasOpenElement: 'body')
		ifFalse: [aBlock value: 'body'].
]

{ #category : #checking }
HTMLElementNester >> elementsToStartBeforeStarting: anElementName do: aBlock [
	(anElementName = 'html')
		ifTrue: [^ self].

	self hasOpenElements
		ifFalse: [aBlock value: 'html'].
	
	(anElementName = 'body' or: [anElementName = 'head'])
		ifTrue: [^ self]. 

	(self mustStartHeadSectionFor: anElementName)
		ifTrue: [aBlock value: 'head']
		ifFalse: [
			(self mustStartBodySectionFor: anElementName)
				ifTrue: [aBlock value: 'body']].
]

{ #category : #checking }
HTMLElementNester >> endElement: anElementName [
	self openElementsByName
		at: anElementName
		put:
			((self openElementsByName
				at: anElementName
				ifAbsent: [1]) - 1 max: 0).

	super endElement: anElementName.
]

{ #category : #testing }
HTMLElementNester >> hasOpenElement: anElementName [
	^ (self openElementsByName at: anElementName ifAbsent: [0]) > 0
]

{ #category : #testing }
HTMLElementNester >> isBodySectionOnlyElement: anElementName [
	^ (BodySectionElements includes: anElementName)
		and: [(HeadSectionElements includes: anElementName) not]
]

{ #category : #testing }
HTMLElementNester >> isHeadSectionOnlyElement: anElementName [
	^ (HeadSectionElements includes: anElementName)
		and: [(BodySectionElements includes: anElementName) not]
]

{ #category : #testing }
HTMLElementNester >> isOpenUniqueElement: anElementName [
	^ (#('html' 'head' 'body') includes: anElementName)
		and: [self hasOpenElement: anElementName]
]

{ #category : #testing }
HTMLElementNester >> isVoidElement: anElementName [
	^ VoidElements includes: anElementName
]

{ #category : #testing }
HTMLElementNester >> mustStartBodySectionFor: anElementName [
	^ ((self isBodySectionOnlyElement: anElementName)
		or: [(self hasOpenElement: 'head') not])
			and: [(self hasOpenElement: 'body') not]
]

{ #category : #testing }
HTMLElementNester >> mustStartHeadSectionFor: anElementName [
	^ (self isHeadSectionOnlyElement: anElementName)
		and: [(self hasOpenElement: 'head') not]
]

{ #category : #private }
HTMLElementNester >> openElementsByName [
	^ openElementsByName ifNil: [openElementsByName := Dictionary new].
]

{ #category : #checking }
HTMLElementNester >> startElement: anElementName [
	self openElementsByName
		at: anElementName
		put:
			(self openElementsByName
				at: anElementName
				ifAbsent: [0]) + 1.

	super startElement: anElementName.
]
