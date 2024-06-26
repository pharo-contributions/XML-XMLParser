Class {
	#name : 'XMLLimitedReadStreamAdapterTest',
	#superclass : 'XMLReadStreamAdapterTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'accessing' }
XMLLimitedReadStreamAdapterTest >> basicInputCollection [
	^ super basicInputCollection, super basicInputCollection
]

{ #category : 'accessing' }
XMLLimitedReadStreamAdapterTest >> basicOutputCollection [
	^ self basicInputCollection
		copyFrom: 1
		to: self inputCollectionLimit
]

{ #category : 'accessing' }
XMLLimitedReadStreamAdapterTest >> inputCollectionLimit [
	^ self inputCollection size / 2
]

{ #category : 'instance creation' }
XMLLimitedReadStreamAdapterTest >> newStreamAdapterOn: aStream [
	^ self
		newStreamAdapterOn: aStream
		limit: self inputCollectionLimit
]

{ #category : 'instance creation' }
XMLLimitedReadStreamAdapterTest >> newStreamAdapterOn: aStream limit: aLimit [
	^ self streamAdapterClass
		on: aStream
		limit: aLimit
]

{ #category : 'accessing' }
XMLLimitedReadStreamAdapterTest >> streamAdapterClass [
	^ XMLLimitedReadStreamAdapter
]

{ #category : 'tests' }
XMLLimitedReadStreamAdapterTest >> testAtLimitedEnd [
	| adapter unlimitedOutputCollectionSize |

	adapter := self newStreamAdapter.
	self outputCollection size timesRepeat: [
		self deny: adapter atLimitedEnd.
		adapter next].
	self
		assert: adapter atEnd;
		assert: adapter atLimitedEnd.

	unlimitedOutputCollectionSize := self outputCollection size * 2.
	adapter :=
		self
			newStreamAdapterOn: self newStream
			limit: unlimitedOutputCollectionSize.
	unlimitedOutputCollectionSize timesRepeat: [
		self deny: adapter atLimitedEnd.
		adapter next].
	self
		assert: adapter atEnd;
		deny: adapter atLimitedEnd
]

{ #category : 'tests' }
XMLLimitedReadStreamAdapterTest >> testLimit [

	| adapter |
	adapter := self newStreamAdapter.
	self
		assert: adapter limit equals: self inputCollectionLimit;
		assert: (adapter limit: self inputCollectionLimit + 1)
		identicalTo: adapter;
		assert: adapter limit equals: self inputCollectionLimit + 1
]

{ #category : 'tests' }
XMLLimitedReadStreamAdapterTest >> testReset [

	| adapter |
	super testReset.

	adapter := self newStreamAdapter.
	adapter
		upToEnd;
		reset.
	self assert: adapter limit equals: self inputCollectionLimit
]
