"
This class generates processing instructions.
"
Class {
	#name : #XMLPIWriter,
	#superclass : #XMLMarkupWriter,
	#instVars : [
		'target',
		'data'
	],
	#category : #'XML-Parser-Writers'
}

{ #category : #accessing }
XMLPIWriter >> data [
	^ data ifNil: ['']
]

{ #category : #accessing }
XMLPIWriter >> data: aString [
	data := aString
]

{ #category : #accessing }
XMLPIWriter >> target [
	^ target ifNil: ['']
]

{ #category : #accessing }
XMLPIWriter >> target: aTarget [
	target := aTarget
]

{ #category : #private }
XMLPIWriter >> writeBody [
	self writer
		space;
		nextPutAll: self data.
]

{ #category : #private }
XMLPIWriter >> writeEpilogue [
	self writer nextPutAll: '?>'
]

{ #category : #private }
XMLPIWriter >> writePrologue [
	self writer
		cr;
		nextPutAll: '<?';
		writeName: self target
]
