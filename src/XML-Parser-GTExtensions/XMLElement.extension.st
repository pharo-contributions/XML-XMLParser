Extension { #name : #XMLElement }

{ #category : #'*XML-Parser-GTExtensions' }
XMLElement >> formForImageEntity: imageEntity [
  | imageType parserClassName parserClass parser |
  imageType := imageEntity contentType sub.
  parserClassName := imageType asUppercase, #ReadWriter.
  parserClass := Smalltalk globals at: parserClassName asSymbol.
  parser := parserClass on: imageEntity readStream.
    ^ parser nextImage
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLElement classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDocument gtExampleXmlNode firstElement
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLElement >> gtInspectorImageIn: composite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 40>
	|client url|
	
	(aGTInspector panes size > 1) 
		ifFalse: [ ^ self ].	
	
	client := (aGTInspector panes reversed collect: [ :each | (each port: #entity) value ])
		detect: [ :each | 
			(each isKindOf: ZnClient)
				and: [each request notNil]]
		ifNone: [ ^ self ].
	url := client request absoluteUrl.
	
	^ composite morph 
		title: 'Image';
		display: [ 
			self formForImageEntity:
				(ZnClient new 
      				beOneShot;
      				get: url/ (self attributeNodes attributeValueAt: 'src');
      				entity)];
		when: [ self name = 'img' and: [(self attributeNodes attributeValueAt: 'src') notNil]]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLElement >> hasTreeNodeChildren [
	^ self hasChildren
		and: [self nodes size > 1
			or: [self nodes first isStringNode not]]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLElement >> treeNodeChildren [
	self hasTreeNodeChildren
		ifTrue: [^ self nodes]
		ifFalse: [^ #()]
]

{ #category : #'*XML-Parser-GTExtensions' }
XMLElement >> writeTreeNodeLabelXMLOn: aWriter [
	self hasTreeNodeChildren
		ifTrue: [
			aWriter startTag
				name: self name;
				setAttributes: attributes]
		ifFalse: [| tagWriter |
			(tagWriter := aWriter tag)
				name: self name;
				setAttributes: attributes.
			self hasChildren
				ifTrue: [tagWriter with: [self writeInnerXMLOn: aWriter]]].
]
