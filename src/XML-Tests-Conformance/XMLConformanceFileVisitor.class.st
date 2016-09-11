"
This class can be used with a Guide to walk the file tree of a test suite and collect all file references to passing and failing XML test files and entity/DTD files.
"
Class {
	#name : #XMLConformanceFileVisitor,
	#superclass : #FileSystemVisitor,
	#instVars : [
		'failingTestFiles',
		'passingTestFiles',
		'entityFiles',
		'suite',
		'skipFilesInBase'
	],
	#category : #'XML-Tests-Conformance'
}

{ #category : #'instance creation' }
XMLConformanceFileVisitor class >> suite: aSuite skipFilesInBase: aBoolean [
	^ self new
		setSuite: aSuite
		skipFilesInBase: aBoolean
]

{ #category : #private }
XMLConformanceFileVisitor >> entityExtensions [
	^ #('.ent' '.dtd')
]

{ #category : #accessing }
XMLConformanceFileVisitor >> entityFiles [
	^ entityFiles ifNil: [entityFiles := OrderedCollection new]
]

{ #category : #private }
XMLConformanceFileVisitor >> failingTestFileBasenames [
	^ #('e2.xml') "an unsually named  OASIS failing test"
]

{ #category : #private }
XMLConformanceFileVisitor >> failingTestFileNamePatterns [
	^ #('not-wf' 'not-valid' 'notwf' 'notvalid' 'invalid' 'fail')
]

{ #category : #accessing }
XMLConformanceFileVisitor >> failingTestFiles [
	^ failingTestFiles ifNil: [failingTestFiles := OrderedCollection new]
]

{ #category : #testing }
XMLConformanceFileVisitor >> isEntityFileBasename: aBasename [
	^ self entityExtensions anySatisfy: [:each |
		aBasename endsWith: each]
]

{ #category : #testing }
XMLConformanceFileVisitor >> isFailingTestFileBasename: aBasename [
	^ self failingTestFileBasenames includes: aBasename
]

{ #category : #testing }
XMLConformanceFileVisitor >> isFailingTestFilePathSegments: aPathSegmentCollection [
	aPathSegmentCollection do: [:segment |
		self failingTestFileNamePatterns do: [:pattern |
			(segment includesSubstring: pattern)
				ifTrue: [^ true]]].
	^ false.
]

{ #category : #testing }
XMLConformanceFileVisitor >> isSkippableFilePathSegments: aPathSegmentCollection [
	(skipFilesInBase
		and: [aPathSegmentCollection allButLast last = suite])
		ifTrue: [^ true].

	"skip the xml files that describe the suite and its tests"	
	(aPathSegmentCollection asArray endsWith:
		(Array with: suite with: suite, '.xml'))
		ifTrue: [^ true].

	"skip 'out' files"
	^ aPathSegmentCollection includes: 'out'.
]

{ #category : #testing }
XMLConformanceFileVisitor >> isXMLFileBasename: aBasename [
	^ aBasename endsWith: '.xml'
]

{ #category : #accessing }
XMLConformanceFileVisitor >> passingTestFiles [
	^ passingTestFiles ifNil: [passingTestFiles := OrderedCollection new]
]

{ #category : #initialization }
XMLConformanceFileVisitor >> setSuite: aSuite skipFilesInBase: aBoolean [
	suite := aSuite.
	skipFilesInBase := aBoolean.
]

{ #category : #visiting }
XMLConformanceFileVisitor >> visitReference: aDirectoryEntry [
	| fileReference pathSegments basename |

	fileReference := aDirectoryEntry asFileReference.
	pathSegments := fileReference pathSegments.
	basename := fileReference basename asLowercase.
	(fileReference isDirectory
		or: [self isSkippableFilePathSegments: pathSegments])
		ifTrue: [^ self].

	(self isEntityFileBasename: basename)
		ifTrue: [
			self entityFiles add: fileReference.
			^ self].

	self isXMLFileBasename: basename.

	((self isFailingTestFileBasename: basename)
		or: [self isFailingTestFilePathSegments: pathSegments])
		ifTrue: [
			self failingTestFiles add: fileReference.
			^ self].
	
	self passingTestFiles add: fileReference.
]
