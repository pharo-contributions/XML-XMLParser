"
A WebClient content reader.
"
Class {
	#name : #XMLHTTPWebClientResponseContentReader,
	#superclass : #XMLHTTPResponseContentReader,
	#category : #'XML-Parser-HTTP'
}

{ #category : #reading }
XMLHTTPWebClientResponseContentReader >> rawReadWithLength: aContentLength upToLimit: aMaxSize [
	| rawContentWriteStream |

	rawContentWriteStream :=
		(String new:
			(aContentLength
				ifNil: [aMaxSize
					ifNil: [1024]])) writeStream.
	response webClientResponse
		streamFrom:
			(response webClientResponse stream
				ascii;
				yourself)
		to: rawContentWriteStream
		size: aContentLength
		progress:
			((aContentLength isNil
				and: [aMaxSize notNil])
				ifTrue: [
					[:ignored :total |
						total > aMaxSize
							ifTrue: [self errorContentLimitExceeded]]]
				ifFalse: [nil]).
	^ rawContentWriteStream contents.
]
