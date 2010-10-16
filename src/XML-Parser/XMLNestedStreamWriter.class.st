"
This class handles the allocation and reuse of multiple WriteStreams. It uses a single execute-around method, #writeWith:, which takes a block that it evaluates with a ready-to-use WriteStream.

"
Class {
	#name : #XMLNestedStreamWriter,
	#superclass : #Object,
	#instVars : [
		'streams',
		'nextStreamIndex'
	],
	#category : #'XML-Parser'
}

{ #category : #'instance creation' }
XMLNestedStreamWriter class >> new [
	^ self new: 5
]

{ #category : #'instance creation' }
XMLNestedStreamWriter class >> new: aNumberOfStreams [
	^ self basicNew initialize: aNumberOfStreams
]

{ #category : #private }
XMLNestedStreamWriter >> acquireStream [
	| stream |

	(nextStreamIndex <= streams size)
		 ifFalse: [self grow].

	(stream := streams at: nextStreamIndex) reset.
	nextStreamIndex := nextStreamIndex + 1.
	^ stream.
]

{ #category : #private }
XMLNestedStreamWriter >> grow [
	streams :=
		(Array new: ((streams size * 2) max: 10))
			replaceFrom: 1
			to: streams size
			with: streams
			startingAt: 1.
	nextStreamIndex to: streams size do: [:i | streams at: i put: self newStream].
]

{ #category : #initialization }
XMLNestedStreamWriter >> initialize: aNumberOfStreams [
	streams := Array new: aNumberOfStreams.
	1 to: aNumberOfStreams do: [:i | streams at: i put: self newStream].
	nextStreamIndex := 1.
]

{ #category : #private }
XMLNestedStreamWriter >> newStream [
	^ WriteStream on: (String new: 128)
]

{ #category : #private }
XMLNestedStreamWriter >> releaseStream [
	nextStreamIndex := nextStreamIndex - 1
]

{ #category : #writing }
XMLNestedStreamWriter >> writeWith: aBlock [
	| result |

	"Avoid ensure: for performance"
	result := aBlock value: self acquireStream.
	self releaseStream.
	^ result.
]
