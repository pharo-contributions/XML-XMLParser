"
This class handles file requests by converting paths into XML source selectors.
"
Class {
	#name : #XMLConformanceVirtualFileClient,
	#superclass : #XMLFileSystemClient,
	#instVars : [
		'testCaseClass'
	],
	#category : #'XML-Tests-Conformance'
}

{ #category : #'instance creation' }
XMLConformanceVirtualFileClient class >> testCaseClass: aClass [
	^ self new testCaseClass: aClass
]

{ #category : #retrieving }
XMLConformanceVirtualFileClient >> get: aPath [
	| segments sourceSelector |

	segments := self pathSeparator split: aPath.
	sourceSelector := XMLConformanceTests sourceSelelctorFromSegments: segments.
	(testCaseClass respondsTo: sourceSelector)
		ifFalse: [XMLFileIOException signal: 'Cannot retrieve ', aPath].

	^ (testCaseClass perform: sourceSelector) readStream.
]

{ #category : #accessing }
XMLConformanceVirtualFileClient >> testCaseClass: aClass [
	testCaseClass := aClass
]
