"
This class handles file requests by converting paths into selectors of test suite class methods.
"
Class {
	#name : #XMLConformanceVirtualFileHandle,
	#superclass : #Object,
	#instVars : [
		'virtualPath',
		'sourceClass'
	],
	#category : #'XML-Tests-Conformance'
}

{ #category : #'instance creation' }
XMLConformanceVirtualFileHandle class >> virtualPath: aPath sourceClass: aClass [
	^ self new
		setVirtualPath: aPath
		sourceClass: aClass
]

{ #category : #retrieving }
XMLConformanceVirtualFileHandle >> get [
	| sourceSelector |

	sourceSelector := sourceClass sourceSelectorForPath: virtualPath.
	(sourceClass respondsTo: sourceSelector)
		ifFalse: [XMLFileException signal: 'Cannot retrieve ', virtualPath].
	^ sourceClass perform: sourceSelector.
]

{ #category : #initialization }
XMLConformanceVirtualFileHandle >> setVirtualPath: aPath sourceClass: aClass [
	virtualPath := aPath.
	sourceClass := aClass.
]

{ #category : #retrieving }
XMLConformanceVirtualFileHandle >> streamGet [
	^ self get readStream
]
