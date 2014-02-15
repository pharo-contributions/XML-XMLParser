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
		'HtmlTagInformation',
		'UniqueElements',
		'VoidElements'
	],
	#category : #'XML-Parser-HTML'
}

{ #category : #private }
HTMLElementNester class >> bodySectionElements [
	^ #('a' 'abbr' 'acronym' 'address' 'applet' 'area' 'article' 'aside' 'audio' 'b' 'basefont'
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

{ #category : #private }
HTMLElementNester class >> headSectionElements [
	^ #('base' 'isindex' 'link' 'meta' 'noscript' 'object' 'script' 'style' 'template' 'title')
]

{ #category : #private }
HTMLElementNester class >> htmlTagInfoFor: aName [
	^ HtmlTagInformation
		at: aName
		ifAbsentPut: [HTMLTagInformation named: aName]
]

{ #category : #'class initialization' }
HTMLElementNester class >> initialize [
	"self initialize"

	super initialize.
	self
		initializeUniqueElements;
		initializeVoidElements;
		initializeHTMLTagInformation.
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeHTMLTagInformation [
	HtmlTagInformation := Dictionary new.

	self bodySectionElements do: [:each |
		(self htmlTagInfoFor: each) isBodySectionTag: true].
	self headSectionElements do: [:each |
		(self htmlTagInfoFor: each) isHeadSectionTag: true].

	self mutuallyExcludingTags keysAndValuesDo: [:key :value |
		(self htmlTagInfoFor: key) mutuallyExcludingTag: value].
	self nestableTagGroups keysAndValuesDo: [:key :value |
		(self htmlTagInfoFor: key) nestableTagGroup: value].

	self nonNestableElements do: [:each |
		(self htmlTagInfoFor: each) isNonNestable: true].
	self uniqueElements do: [:each | self htmlTagInfoFor: each].
	self voidElements do: [:each |
		(self htmlTagInfoFor: each) isSelfClosing: true].
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeUniqueElements [
	UniqueElements := self uniqueElements
]

{ #category : #'class initialization' }
HTMLElementNester class >> initializeVoidElements [
	VoidElements := Set withAll: self voidElements
]

{ #category : #private }
HTMLElementNester class >> mutuallyExcludingTags [
	| mutuallyExcludingTags |

	mutuallyExcludingTags := Dictionary new.
	#(#('dd' 'dt') #('thead' 'tbody') #('th' 'td') #('rp' 'rt'))
		do: [:tagList |
			tagList do: [:tag |
				tagList do: [:each |
					(each = tag)
						ifFalse: [mutuallyExcludingTags at: each put: tag]]]].
	^ mutuallyExcludingTags.
]

{ #category : #private }
HTMLElementNester class >> nestableTagGroups [
	| nestableTagGroups |

	nestableTagGroups := Dictionary new.

	#('dd' 'dt') do: [:each |
		nestableTagGroups at: each put: #('dl')].
	#('tr' 'th' 'td' 'thead' 'tfoot') do: [:each |
		nestableTagGroups at: each put: #('table')].
	#('rp' 'rt') do: [:each |
		nestableTagGroups at: each put: #('ruby')].
	nestableTagGroups at: 'li' put: #('ul' 'ol' 'menu' 'dir') asSet.

	^ nestableTagGroups.
]

{ #category : #private }
HTMLElementNester class >> nonNestableElements [
	^ #('a' 'applet' 'audio' 'button' 'footer' 'form' 'header' 'label' 'map'
		'meter' 'optgroup' 'option' 'ruby' 'select' 'video'),
		self nestableTagGroups keys asArray
]

{ #category : #private }
HTMLElementNester class >> uniqueElements [
	^ #('html' 'head' 'body')
]

{ #category : #private }
HTMLElementNester class >> voidElements [
	^ #('area' 'base' 'br' 'col' 'command' 'embed' 'hr' 'img' 'input' 'keygen'
		'link' 'menuitem' 'meta' 'param' 'source' 'track' 'wbr')
]

{ #category : #checking }
HTMLElementNester >> beforeEnding: anElementName elementsToEndDo: aBlock [
	self openElementsReverseDo: [:each |
		each = anElementName
			ifTrue: [^ self].
		aBlock value: each].
]

{ #category : #checking }
HTMLElementNester >> beforePCDataElementsToEndDo: aFirstBlock elementsToStartDo: aSecondBlock [
	(self hasOpenElement: 'head')
		ifTrue: [
			self
				beforeEnding: 'head'
				elementsToEndDo: aFirstBlock.
			aFirstBlock value: 'head'].

	self hasOpenElements
		ifFalse: [aSecondBlock value: 'html'].
	(self hasOpenElement: 'body')
		ifFalse: [aSecondBlock value: 'body'].
]

{ #category : #checking }
HTMLElementNester >> beforeStarting: anElementName elementsToEndDo: aFirstBlock elementsToStartDo: aSecondBlock [
	| htmlTag |

	htmlTag :=
		HtmlTagInformation
			at: anElementName
			ifAbsent: [HTMLTagInformation named: anElementName].
			
	self hasOpenElements
		ifTrue: [
			self
				elementsToEndBeforeStartTag: htmlTag
				do: aFirstBlock].
	self
		elementsToStartBeforeStartTag: htmlTag
		do: aSecondBlock.
]

{ #category : #private }
HTMLElementNester >> cannotSelfNestTag: anHtmlTagInfo [
	| tagGroup |

	(anHtmlTagInfo isNonNestable)
		ifFalse: [^ false].
		
	"tags like <td> can nest in each other if there is a <table> between
	them like <td><table><tr><td>...."
	((tagGroup := anHtmlTagInfo nestableTagGroup)
		anySatisfy: [:each | self hasOpenElement: each])
		ifFalse: [^ true].

	self openElementsReverseDo: [:each |
		each = anHtmlTagInfo name
			ifTrue: [^ true].
		(tagGroup includes: each)
			ifTrue: [^ false]].
]

{ #category : #private }
HTMLElementNester >> currentSectionCannotContainTag: anHtmlTagInfo [
	^(anHtmlTagInfo isBodySectionOnlyTag
		and: [self hasOpenElement: 'head'])
			or: [anHtmlTagInfo isHeadSectionOnlyTag
				and: [self hasOpenElement: 'body']]
]

{ #category : #private }
HTMLElementNester >> elementsToEndBeforeStartTag: anHtmlTagInfo do: aBlock [
	| excludingTag |

	(anHtmlTagInfo isHeadOrBodyTag
		or: [self currentSectionCannotContainTag: anHtmlTagInfo])
		ifTrue: [^ self beforeEnding: 'html' elementsToEndDo: aBlock].

	(((self hasOpenElement: anHtmlTagInfo name)
		and: [self cannotSelfNestTag: anHtmlTagInfo])
		or: [(excludingTag := anHtmlTagInfo mutuallyExcludingTag) notNil
			and: [self hasOpenElement: excludingTag]])
		ifTrue: [
			self openElementsReverseDo: [:each |
				aBlock value: each.
				((each = anHtmlTagInfo name)
					or: [each = excludingTag])
					ifTrue: [^ self]]].
]

{ #category : #private }
HTMLElementNester >> elementsToStartBeforeStartTag: anHtmlTagInfo do: aBlock [
	(anHtmlTagInfo name = 'html')
		ifTrue: [^ self].
	self hasOpenElements
		ifFalse: [aBlock value: 'html'].
	anHtmlTagInfo isHeadOrBodyTag
		ifTrue: [^ self]. 

	(self mustStartHeadSectionForTag: anHtmlTagInfo)
		ifTrue: [aBlock value: 'head']
		ifFalse: [
			(self mustStartBodySectionForTag: anHtmlTagInfo)
				ifTrue: [aBlock value: 'body']].
]

{ #category : #checking }
HTMLElementNester >> endElement: anElementName [
	| association |

	association :=
		self openElementsByName
			associationAt: anElementName
			ifAbsent: [self openElementsByName add: (anElementName -> 1)].
	association value: (association value - 1 max: 0).

	super endElement: anElementName.
]

{ #category : #testing }
HTMLElementNester >> hasOpenElement: anElementName [
	^ (self openElementsByName at: anElementName ifAbsent: [0]) > 0
]

{ #category : #testing }
HTMLElementNester >> isOpenUniqueElement: anElementName [
	^ (UniqueElements includes: anElementName)
		and: [self hasOpenElement: anElementName]
]

{ #category : #testing }
HTMLElementNester >> isVoidElement: anElementName [
	^ (HtmlTagInformation at: anElementName ifAbsent: [^ false]) isSelfClosing
]

{ #category : #private }
HTMLElementNester >> mustStartBodySectionForTag: anHtmlTagInfo [
	^ (anHtmlTagInfo isBodySectionOnlyTag
		or: [(self hasOpenElement: 'head') not])
			and: [(self hasOpenElement: 'body') not]
]

{ #category : #private }
HTMLElementNester >> mustStartHeadSectionForTag: anHtmlTagInfo [
	^ anHtmlTagInfo isHeadSectionOnlyTag 
		and: [(self hasOpenElement: 'head') not]
]

{ #category : #private }
HTMLElementNester >> openElementsByName [
	^ openElementsByName ifNil: [openElementsByName := Dictionary new].
]

{ #category : #checking }
HTMLElementNester >> startElement: anElementName [
	| association |

	association :=
		self openElementsByName
			associationAt: anElementName
			ifAbsent: [self openElementsByName add: (anElementName -> 0)].
	association value: association value + 1.

	super startElement: anElementName.
]
