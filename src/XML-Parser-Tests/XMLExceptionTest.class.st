Class {
	#name : 'XMLExceptionTest',
	#superclass : 'TestCase',
	#category : 'XML-Parser-Tests-Exceptions',
	#package : 'XML-Parser-Tests',
	#tag : 'Exceptions'
}

{ #category : 'asserting' }
XMLExceptionTest class >> shouldInheritSelectors [
	^ true
]

{ #category : 'accessing' }
XMLExceptionTest >> errorMessage [
	^ 'an error occurred'
]

{ #category : 'accessing' }
XMLExceptionTest >> exceptionClass [
	^ XMLException
]

{ #category : 'instance creation' }
XMLExceptionTest >> newException [
	^ self exceptionClass new
]

{ #category : 'instance creation' }
XMLExceptionTest >> newExceptionWithErrorMessage [
	^ self newException
		messageText: self errorMessage;
		yourself
]

{ #category : 'instance creation' }
XMLExceptionTest >> newOtherException [
	^ self otherExceptionClass new
]

{ #category : 'instance creation' }
XMLExceptionTest >> newOtherExceptionWithErrorMessage [
	^ self newOtherException
		messageText: self errorMessage;
		yourself
]

{ #category : 'accessing' }
XMLExceptionTest >> otherExceptionClass [
	^ Error
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatMessageWith [

	| exception |
	exception := self newException.
	self
		assert: (exception formatMessage: '{1}' with: 'one')
		identicalTo: exception.
	self assert: exception messageText equals: 'one'
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatMessageWithArguments [

	| exception |
	exception := self newException.
	self
		assert: (exception
				 formatMessage: '{1} {2} {3} {4}'
				 withArguments: #( 'one' 2 'three' 4 ))
		identicalTo: exception.
	self assert: exception messageText equals: 'one 2 three 4'
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatMessageWithWith [

	| exception |
	exception := self newException.
	self
		assert: (exception formatMessage: '{1} {2}' with: 'one' with: 2)
		identicalTo: exception.
	self assert: exception messageText equals: 'one 2'
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatMessageWithWithWith [

	| exception |
	exception := self newException.
	self
		assert: (exception
				 formatMessage: '{1} {2} {3}'
				 with: 'one'
				 with: 2
				 with: 'three')
		identicalTo: exception.
	self assert: exception messageText equals: 'one 2 three'
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatMessageWithWithWithWith [

	| exception |
	exception := self newException.
	self
		assert: (exception
				 formatMessage: '{1} {2} {3} {4}'
				 with: 'one'
				 with: 2
				 with: 'three'
				 with: 4)
		identicalTo: exception.
	self assert: exception messageText equals: 'one 2 three 4'
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatSignalWith [

	(Array with: self exceptionClass with: self newException) do: [ :each |
		| raisedException |
		[ each formatSignal: '{1}' with: 1 ]
			on: Error
			do: [ :exception | raisedException := exception ].
		self
			assert: raisedException isNotNil;
			assert: raisedException class identicalTo: self exceptionClass;
			assert: raisedException messageText equals: '1' ]
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatSignalWithArguments [

	(Array with: self exceptionClass with: self newException) do: [ :each |
		| raisedException |
		[
		each
			formatSignal: '{1} {2} {3} {4}'
			withArguments: #( 1 'two' 3 'four' ) ]
			on: Error
			do: [ :exception | raisedException := exception ].
		self
			assert: raisedException isNotNil;
			assert: raisedException class identicalTo: self exceptionClass;
			assert: raisedException messageText equals: '1 two 3 four' ]
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatSignalWithWith [

	(Array with: self exceptionClass with: self newException) do: [ :each |
		| raisedException |
		[ each formatSignal: '{1} {2}' with: 1 with: 'two' ]
			on: Error
			do: [ :exception | raisedException := exception ].
		self
			assert: raisedException isNotNil;
			assert: raisedException class identicalTo: self exceptionClass;
			assert: raisedException messageText equals: '1 two' ]
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatSignalWithWithWith [

	(Array with: self exceptionClass with: self newException) do: [ :each |
		| raisedException |
		[
		each
			formatSignal: '{1} {2} {3}'
			with: 1
			with: 'two'
			with: 3 ]
			on: Error
			do: [ :exception | raisedException := exception ].
		self
			assert: raisedException isNotNil;
			assert: raisedException class identicalTo: self exceptionClass;
			assert: raisedException messageText equals: '1 two 3' ]
]

{ #category : 'tests' }
XMLExceptionTest >> testFormatSignalWithWithWithWith [

	(Array with: self exceptionClass with: self newException) do: [ :each |
		| raisedException |
		[
		each
			formatSignal: '{1} {2} {3} {4}'
			with: 1
			with: 'two'
			with: 3
			with: 'four' ]
			on: Error
			do: [ :exception | raisedException := exception ].
		self
			assert: raisedException isNotNil;
			assert: raisedException class identicalTo: self exceptionClass;
			assert: raisedException messageText equals: '1 two 3 four' ]
]

{ #category : 'tests' }
XMLExceptionTest >> testInheritMessageFrom [

	| exception otherException |
	exception := self newException.
	otherException := self newOtherExceptionWithErrorMessage.
	self
		assert: (exception inheritMessageFrom: otherException)
		identicalTo: exception;
		assert: exception messageText equals: ('({1}) {2}' format:
					 (Array
						  with: self otherExceptionClass name
						  with: self errorMessage))
]

{ #category : 'tests' }
XMLExceptionTest >> testSignalMessageFrom [

	| otherException |
	otherException := self newOtherExceptionWithErrorMessage.
	(Array with: self exceptionClass with: self newException) do: [ :each |
		| raisedException |
		[ each signalMessageFrom: otherException ]
			on: Error
			do: [ :exception | raisedException := exception ].
		self
			assert: raisedException isNotNil;
			assert: raisedException class identicalTo: self exceptionClass;
			assert: raisedException messageText equals: ('({1}) {2}' format:
						 (Array
							  with: self otherExceptionClass name
							  with: self errorMessage)) ]
]
