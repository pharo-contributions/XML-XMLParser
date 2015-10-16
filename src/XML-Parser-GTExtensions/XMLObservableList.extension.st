Extension { #name : #XMLObservableList }

{ #category : #'*XML-Parser-GTExtensions' }
XMLObservableList >> addOrderedListTableToComposite: aComposite paneTitle: aPaneTitle columnTitle: aColumnTitle [
	"Adapted from SequenceableCollection>>gtInspectorItemsIn:"
	^ aComposite table
		title: aPaneTitle;
		display: [:aCollection |
			[(1 to: self size) collect: [:index | index -> (self at: index)]]
				on: Error
				do: [#()]];
		beMultiple;
		searchOn: [:text :each | 
			Smalltalk compiler
				evaluate: ' | entity each | each := self. entity := each.', text
				for: each value
				logged: false];
		column: 'Index' evaluated: [:assoc | assoc key printString];
		column: aColumnTitle evaluated: [:assoc | assoc value treeNodeLabelText];
		send: [:result |
			result ifNotNil: [
				result value size = 1 
					ifTrue: [result anyOne value]
					ifFalse: [
						self species withAll:
							(result collect: [:each | each value])]]];
		showOnly: 50;
		helpMessage:
			'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'
]
