Class {
	#name : #XMLBinaryReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLBinaryReadStreamAdapterTest >> inputCollection [
	^ super inputCollection asArray collect: [:each | each asciiValue]
]

{ #category : #accessing }
XMLBinaryReadStreamAdapterTest >> streamAdapterClass [
	^ XMLBinaryReadStreamAdapter
]

{ #category : #tests }
XMLBinaryReadStreamAdapterTest >> testOnStreamIfBinary [
	| stream adapter |

	stream := self newStreamOn: '1'.
	self assert: (self streamAdapterClass onStreamIfBinary: stream) == stream.

	stream next.
	self assert: (self streamAdapterClass onStreamIfBinary: stream) == stream.

	stream := self newStreamOn: #(1).
	adapter := self streamAdapterClass onStreamIfBinary: stream.
	self assert: adapter class == self streamAdapterClass.

	stream next.
	self assert: (self streamAdapterClass onStreamIfBinary: stream) == stream.
]
