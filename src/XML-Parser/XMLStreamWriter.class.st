Class {
	#name : #XMLStreamWriter,
	#superclass : #Object,
	#instVars : [
		'streams',
		'nextStream'
	],
	#classVars : [
		'CarriageReturn',
		'DigitTable',
		'LineFeed',
		'SeparatorTable'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #growing }
XMLStreamWriter >> grow [
	streams := streams, self newStreams
]

{ #category : #initialization }
XMLStreamWriter >> initialize [
	streams := self newStreams.
	nextStream := 1.
]

{ #category : #growing }
XMLStreamWriter >> newStreams [
	^ (1 to: 10) collect: [:i | WriteStream on: (String new: 128)]
]

{ #category : #writing }
XMLStreamWriter >> writeWith: aBlock [
	| writeStream res|

	(nextStream = streams size)
		ifTrue: [self grow].
	(writeStream := streams at: nextStream) reset.
	nextStream := nextStream + 1.
	^ [aBlock value: writeStream] ensure: [nextStream := nextStream - 1].
]
