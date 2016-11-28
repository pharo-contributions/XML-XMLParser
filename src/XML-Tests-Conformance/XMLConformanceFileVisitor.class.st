"
This class can be used with a Guide to walk the file tree of a test suite and collect all file references to passing, failing, and expected output XML test source files and any associated entity/DTD source files.
"
Class {
	#name : #XMLConformanceFileVisitor,
	#superclass : #FileSystemVisitor,
	#instVars : [
		'failingTestFiles',
		'passingTestFiles',
		'entityFiles',
		'suite',
		'skipFilesInBase',
		'passingTestOutputFiles'
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
XMLConformanceFileVisitor >> isOutputFilePathSegments: aPathSegmentCollection [
	^ aPathSegmentCollection includes: 'out'
]

{ #category : #testing }
XMLConformanceFileVisitor >> isSkippableFilePathSegments: aPathSegmentCollection [
	(skipFilesInBase
		and: [aPathSegmentCollection allButLast last = suite])
		ifTrue: [^ true].

	"skip the xml files that describe the suite and its tests"	
	^ aPathSegmentCollection asArray endsWith:
		(Array with: suite with: suite, '.xml').
]

{ #category : #testing }
XMLConformanceFileVisitor >> isXMLFileBasename: aBasename [
	^ aBasename endsWith: '.xml'
]

{ #category : #accessing }
XMLConformanceFileVisitor >> passingTestFiles [
	^ passingTestFiles ifNil: [passingTestFiles := OrderedCollection new]
]

{ #category : #accessing }
XMLConformanceFileVisitor >> passingTestOutputFiles [
	^ passingTestOutputFiles ifNil: [passingTestOutputFiles := OrderedCollection new]
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

	(self isXMLFileBasename: basename)
		ifFalse: [^ self].

	((self isFailingTestFileBasename: basename)
		or: [self isFailingTestFilePathSegments: pathSegments])
		ifTrue: [
			(self isOutputFilePathSegments: pathSegments)
				ifFalse: [self failingTestFiles add: fileReference].
			^ self].

	(self isOutputFilePathSegments: pathSegments)
		ifTrue: [
			self passingTestOutputFiles add: fileReference.
			^ self].

	self passingTestFiles add: fileReference.
]
