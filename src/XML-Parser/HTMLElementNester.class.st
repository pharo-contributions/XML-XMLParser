"
This class can handle the nesting of HTML elements missing closing tags or with opening and closing tags in the wrong order.
"
Class {
	#name : #HTMLElementNester,
	#superclass : #XMLElementNester,
	#instVars : [
		'openElementsByName',
		'elementsToStart',
		'elementsToEnd'
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
		initializeNonNestableElements;
		initializeNestableTagGroups;
		initializeMutuallyExcludingTags;
		initializeVoidElements
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
	#('li') do: [:each |
		NestableTagGroups at: each put: #('ul' 'ol' 'menu' 'dir')].
	#('rp' 'rt') do: [:each |
		NestableTagGroups at: each put: #('ruby')].
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeNonNestableElements [
	NonNestableElements := Set withAll:
		#('a' 'applet' 'audio' 'button' 'footer' 'form' 'header' 'label' 'map'
			'meter' 'optgroup' 'option' 'ruby' 'select' 'video')
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeVoidElements [
	VoidElements :=
		Set withAll:
			#('area' 'base' 'br' 'col' 'command' 'embed' 'hr' 'img' 'input' 'keygen'
				'link' 'menuitem' 'meta' 'param' 'source' 'track' 'wbr')
]

{ #category : #testing }
HTMLElementNester >> canNestWithinSelf: anElementName [
	^ (NonNestableElements includes: anElementName) not
]

{ #category : #private }
HTMLElementNester >> elementsToEnd [
	^ elementsToEnd ifNil: [elementsToEnd := OrderedCollection new]
]

{ #category : #checking }
HTMLElementNester >> elementsToEndBeforeEnding: anElementName [
	self elementsToEnd reset.

	self openElementsReverseDo: [:each |
		each = anElementName
			ifTrue: [^ self elementsToEnd]
			ifFalse: [self elementsToEnd addLast: each]].

	^ self elementsToEnd.
]

{ #category : #checking }
HTMLElementNester >> elementsToEndBeforePCData [
	^ (self hasOpenElement: 'head')
		ifTrue: [
			(self elementsToEndBeforeEnding: 'head')
				addLast: 'head';
				yourself]
		ifFalse: [#()]
]

{ #category : #checking }
HTMLElementNester >> elementsToEndBeforeStarting: anElementName [
	| excludingElement |

	(anElementName = 'body'
		or: [anElementName = 'head'
			or: [self headOrBodyCannotContain: anElementName]])
		ifTrue: [^ self elementsToEndBeforeEnding: 'html'].

	self elementsToEnd reset.
	(self canNestWithinSelf: anElementName)
		ifTrue: [^ self elementsToEnd].

	excludingElement := self excludingElementFor: anElementName.
	((self hasOpenElement: anElementName)
		or: [excludingElement notEmpty
			and: [self hasOpenElement: excludingElement]])
		ifFalse: [^ self elementsToEnd].

	self openElementsReverseDo: [:each |
		((NestableTagGroups includesKey: anElementName)
			and: [(NestableTagGroups at: anElementName) includes: each])
			ifTrue: [^ #()].

		self elementsToEnd addLast: each.
		((each = anElementName)
			or: [excludingElement notEmpty
				and: [excludingElement = each]])
			ifTrue: [^ self elementsToEnd]].

	^ self elementsToEnd.
	
]

{ #category : #private }
HTMLElementNester >> elementsToStart [
	^ elementsToStart ifNil: [elementsToStart := OrderedCollection new]
]

{ #category : #checking }
HTMLElementNester >> elementsToStartBeforePCData [
	self elementsToStart reset.

	self hasOpenElements
		ifFalse: [self elementsToStart addLast: 'html'].
	(self hasOpenElement: 'body')
		ifFalse: [self elementsToStart addLast: 'body'].

	^ self elementsToStart.
]

{ #category : #checking }
HTMLElementNester >> elementsToStartBeforeStarting: anElementName [
	self elementsToStart reset.

	self hasOpenElements
		ifFalse: [
			(anElementName = 'html')
				ifTrue: [^ self elementsToStart].
			self elementsToStart addLast: 'html'].

	(anElementName = 'body' or: [anElementName = 'head'])
		ifTrue: [^ self elementsToStart]. 

	(self mustStartHeadSectionFor: anElementName)
		ifTrue: [self elementsToStart addLast: 'head']
		ifFalse: [
			(self mustStartBodySectionFor: anElementName)
				ifTrue: [self elementsToStart addLast: 'body']].

	^ self elementsToStart.
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

{ #category : #accessing }
HTMLElementNester >> excludingElementFor: anElementName [
	^ MutuallyExcludingTags at: anElementName ifAbsent: ['']

	
]

{ #category : #testing }
HTMLElementNester >> hasOpenElement: anElementName [
	^ (self openElementsByName at: anElementName ifAbsent: [0]) > 0
]

{ #category : #testing }
HTMLElementNester >> headOrBodyCannotContain: anElementName [
	^ ((self hasOpenElement: 'head')
		and: [self isBodySectionOnlyElement: anElementName])
			or: [(self hasOpenElement: 'body')
				and: [self isHeadSectionOnlyElement: anElementName]]
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
