Class {
	#name : 'XMLNullReadStreamTest',
	#superclass : 'XMLAbstractReadStreamTest',
	#category : 'XML-Parser-Tests-Streams',
	#package : 'XML-Parser-Tests',
	#tag : 'Streams'
}

{ #category : 'testing' }
XMLNullReadStreamTest class >> isAbstract [
	^ false
]

{ #category : 'accessing' }
XMLNullReadStreamTest >> inputCollection [
	^ ''
]

{ #category : 'accessing' }
XMLNullReadStreamTest >> streamClass [
	^ XMLNullReadStream
]

{ #category : 'tests' }
XMLNullReadStreamTest >> testNew [

	self assert: self streamClass new class identicalTo: self streamClass
]
