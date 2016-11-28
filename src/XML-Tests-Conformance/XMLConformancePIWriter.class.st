"
A PI writer for the XML Conformance test suite canonical XML format that always outputs a space after the target, even if the data is empty, unlike the regular PI writer.
"
Class {
	#name : #XMLConformancePIWriter,
	#superclass : #XMLPIWriter,
	#category : #'XML-Tests-Conformance-Writer'
}

{ #category : #private }
XMLConformancePIWriter >> writeBody [
	self isOmittable
		ifFalse: [
			self writer
				space;
				nextPutAll: self data]
]
