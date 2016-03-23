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

{ #category : #accessing }
XMLConformanceFileVisitor >> entityExtensions [
	^ #('.ent' '.dtd')
]

{ #category : #accessing }
XMLConformanceFileVisitor >> entityFiles [
	^ entityFiles ifNil: [entityFiles := OrderedCollection new]
]

{ #category : #accessing }
XMLConformanceFileVisitor >> failingNamePatterns [
	^ #('not-wf' 'not-valid' 'notwf' 'notvalid' 'invalid' 'fail')
]

{ #category : #accessing }
XMLConformanceFileVisitor >> failingNames [
	^ #('e2.xml') "an unsually named  OASIS failing test"
]

{ #category : #accessing }
XMLConformanceFileVisitor >> failingTestFiles [
	^ failingTestFiles ifNil: [failingTestFiles := OrderedCollection new]
]

{ #category : #testing }
XMLConformanceFileVisitor >> isFailingTestFilePathSegments: aPathSegmentCollection [
	(self failingNames includes: aPathSegmentCollection last)
		ifTrue: [^ true].

	aPathSegmentCollection do: [:segment |
		(self failingNamePatterns anySatisfy: [:pattern |
			segment includesSubstring: pattern])
			ifTrue: [^ true]].

	^ false.
]

{ #category : #accessing }
XMLConformanceFileVisitor >> passingTestFiles [
	^ passingTestFiles ifNil: [passingTestFiles := OrderedCollection new]
]

{ #category : #accessing }
XMLConformanceFileVisitor >> setSuite: aSuite skipFilesInBase: aBoolean [
	suite := aSuite.
	skipFilesInBase := aBoolean.
]

{ #category : #accessing }
XMLConformanceFileVisitor >> suite: aSuite [
	suite := aSuite
]

{ #category : #visiting }
XMLConformanceFileVisitor >> visitReference: aDirectoryEntry [
	| fileReference pathSegments basename |

	fileReference := aDirectoryEntry asFileReference.
	pathSegments := fileReference pathSegments.
	basename := fileReference basename asLowercase.
	(fileReference isDirectory
		or: [(skipFilesInBase and: [pathSegments allButLast last = suite])
			or: [basename = (suite, '.xml')
				or: [pathSegments includes: 'out']]])
		ifTrue: [^ self].

	(self entityExtensions anySatisfy: [:extension |
		basename endsWith: extension])
		ifTrue: [
			self entityFiles add: fileReference.
			^ self].

	(basename endsWith: '.xml')
		ifFalse: [^ self].
	(self isFailingTestFilePathSegments: pathSegments)
		ifTrue: [self failingTestFiles add: fileReference]
		ifFalse: [self passingTestFiles add: fileReference].
]
