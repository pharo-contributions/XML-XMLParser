Class {
	#name : #XMLHTTPResponseTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-HTTP'
}

{ #category : #tests }
XMLHTTPResponseTest >> testCharsetFromContentType [
	#(''
		'application/xml'
		'charset=utf8'
		'charset=utf8;'
		' charset = utf8 ; '
		'application/xml; charset=utf16'
		'application/xml; charset=utf16;'
		' application / xml ; charset = utf16 ; '
		'application/xml; charset=utf32; other=ignored'
		'application/xml; charset=utf32; other=ignored;'
		' application / xml ; charset = utf32 ; other = ignored ; '
		'application/xml; other=ignored; charset=utf32-le'
		'application/xml; other=ignored; charset=utf32-le;'
		' application / xml ; other = ignored ; charset = utf32-le ; '
		'charset='
		'charset=;'
		' charset =  ; ')
		with:
			#(''
				''
				'utf8'
				'utf8'
				'utf8'
				'utf16'
				'utf16'
				'utf16'
				'utf32'
				'utf32'
				'utf32'
				'utf32-le'
				'utf32-le'
				'utf32-le'
				''
				''
				'')
		do: [:contentType :encoding |
			self assert:
				(XMLHTTPResponse charsetFromContentType: contentType) = encoding]
]
