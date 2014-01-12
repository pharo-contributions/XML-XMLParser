"
This class handles file requests by converting paths into XML source selectors.
"
Class {
	#name : #XMLConformanceVirtualFileHandle,
	#superclass : #XMLFileHandle,
	#category : #'XML-Tests-Conformance'
}

{ #category : #retrieving }
XMLConformanceVirtualFileHandle >> getFromClass: aVirtualFileClass [
	| sourceSelector |

	sourceSelector := aVirtualFileClass sourceSelelctorFromSegments: ($/ split: path).
	(aVirtualFileClass respondsTo: sourceSelector)
		ifFalse: [XMLFileException signal: 'Cannot retrieve ', self path].

	^ (aVirtualFileClass perform: sourceSelector) readStream.
]
