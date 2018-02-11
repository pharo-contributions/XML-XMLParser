"
A disabled version of the superclass.
"
Class {
	#name : #GLMXMLDisabledRubricHighlightedTextPresentation,
	#superclass : #GLMRubricHighlightedTextPresentation,
	#category : #'XML-ParserGTExtensions-Highlighting-Parser'
}

{ #category : #accessing }
GLMXMLDisabledRubricHighlightedTextPresentation >> acceptsSelection [
	^ false
]

{ #category : #rendering }
GLMXMLDisabledRubricHighlightedTextPresentation >> renderGlamorouslyOn: aRenderer [
	| result oldBackgroundColor |

	result := (super renderGlamorouslyOn: aRenderer).
	oldBackgroundColor := result backgroundColor.
	"make it read-only, and also change the background to imply it's disabled"
	^ result
		beReadOnly;
		backgroundColor:
			(oldBackgroundColor brightness < 0.5
				ifTrue: [oldBackgroundColor lighter]
				ifFalse: [oldBackgroundColor darker]);
		yourself.
]
