"
This class finds the files of a  test suite and classifies tham as passing test files, failing test files, passing test expected output XML files,  and entity/DTD source files.

It uses FileSystem's visitor API internally to walk the directory tree, but it is not a subclass of FileSystemVisitor to avoid loading errors on Squeak or GS which don't have FileSystem.
"
Class {
	#name : #XMLConformanceFileFinder,
	#superclass : #Object,
	#instVars : [
		'suite',
		'root',
		'failingTestFiles',
		'passingTestFiles',
		'entityFiles',
		'passingTestOutputFiles'
	],
	#category : #'XML-Tests-Conformance-Files'
}

{ #category : #'instance creation' }
XMLConformanceFileFinder class >> suite: aSuite root: aFileReference [
	^ self new
		setSuite: aSuite
		root: aFileReference
]

{ #category : #private }
XMLConformanceFileFinder >> classifyFile: aFileReference [
	| pathSegments basename |

	pathSegments := aFileReference pathSegments.
	basename := aFileReference basename asLowercase.

	(self isEntityFileBasename: basename)
		ifTrue: [
			self entityFiles addLast: aFileReference.
			^ self].

	(self isXMLFileBasename: basename)
		ifFalse: [^ self].

	((self isFailingTestFileBasename: basename)
		or: [self isFailingTestFilePathSegments: pathSegments])
		ifTrue: [
			(self isOutputFilePathSegments: pathSegments)
				ifFalse: [self failingTestFiles addLast: aFileReference].
			^ self].

	(self isOutputFilePathSegments: pathSegments)
		ifTrue: [
			self passingTestOutputFiles addLast: aFileReference.
			^ self].

	self passingTestFiles addLast: aFileReference.
]

{ #category : #private }
XMLConformanceFileFinder >> entityExtensions [
	^ #('.ent' '.dtd')
]

{ #category : #accessing }
XMLConformanceFileFinder >> entityFiles [
	^ entityFiles ifNil: [entityFiles := OrderedCollection new]
]

{ #category : #private }
XMLConformanceFileFinder >> failingTestFileBasenames [
	^ #('e2.xml') "an unsually named  OASIS failing test"
]

{ #category : #private }
XMLConformanceFileFinder >> failingTestFileNamePatterns [
	^ #('not-wf' 'not-valid' 'notwf' 'notvalid' 'invalid' 'fail')
]

{ #category : #accessing }
XMLConformanceFileFinder >> failingTestFiles [
	^ failingTestFiles ifNil: [failingTestFiles := OrderedCollection new]
]

{ #category : #finding }
XMLConformanceFileFinder >> findFiles [
	^ self findFilesSkippingBase: false
]

{ #category : #finding }
XMLConformanceFileFinder >> findFilesSkippingBase [
	^ self findFilesSkippingBase: true
]

{ #category : #private }
XMLConformanceFileFinder >> findFilesSkippingBase: aBoolean [
	| directoryEntries |

	directoryEntries :=
		"avoid direct references to SelectVisitor so the package does not
		raise errors during loading on Squeak or GS"
		(XMLClassFinder classNamed: #SelectVisitor)
			preorder: self root
			select: [:each | | pathSegments |
				"ignore directories, the xml file describing the suite,
				and other bases files if needed"
				(each isDirectory
					or: [
						pathSegments := each pathSegments.
						aBoolean
							ifTrue: [pathSegments allButLast last = self suite]
							ifFalse: [
								pathSegments endsWith:
									(Array
										with: self suite
										with: self suite, '.xml')]]) not].
	directoryEntries do: [:each |
		self classifyFile: each asFileReference].
]

{ #category : #testing }
XMLConformanceFileFinder >> isEntityFileBasename: aBasename [
	^ self entityExtensions anySatisfy: [:each |
		aBasename endsWith: each]
]

{ #category : #testing }
XMLConformanceFileFinder >> isFailingTestFileBasename: aBasename [
	^ self failingTestFileBasenames includes: aBasename
]

{ #category : #testing }
XMLConformanceFileFinder >> isFailingTestFilePathSegments: aPathSegmentCollection [
	aPathSegmentCollection do: [:segment |
		self failingTestFileNamePatterns do: [:pattern |
			(segment includesSubstring: pattern)
				ifTrue: [^ true]]].
	^ false.
]

{ #category : #testing }
XMLConformanceFileFinder >> isOutputFilePathSegments: aPathSegmentCollection [
	^ aPathSegmentCollection includes: 'out'
]

{ #category : #testing }
XMLConformanceFileFinder >> isXMLFileBasename: aBasename [
	^ aBasename endsWith: '.xml'
]

{ #category : #accessing }
XMLConformanceFileFinder >> passingTestFiles [
	^ passingTestFiles ifNil: [passingTestFiles := OrderedCollection new]
]

{ #category : #accessing }
XMLConformanceFileFinder >> passingTestOutputFiles [
	^ passingTestOutputFiles ifNil: [passingTestOutputFiles := OrderedCollection new]
]

{ #category : #accessing }
XMLConformanceFileFinder >> root [
	^ root
]

{ #category : #initialization }
XMLConformanceFileFinder >> setSuite: aSuite root: aFileReference [
	suite := aSuite.
	root := aFileReference.
]

{ #category : #accessing }
XMLConformanceFileFinder >> suite [
	^ suite
]
