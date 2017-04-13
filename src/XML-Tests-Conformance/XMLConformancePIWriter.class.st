"
A PI writer for the XML Conformance test suite canonical XML format that always outputs a space after the target, even if the data is empty, unlike the regular PI writer.
"
Class {
	#name : #XMLConformancePIWriter,
	#superclass : #XMLPIWriter,
	#category : #'XML-Tests-Conformance-Writer'
}

{ #category : #testing }
XMLConformancePIWriter >> isDataOmittable [
	"unlike standard canonical XML, PI data is never omittable
	for conformance canonical XML"
	^ self isCanonical not
]
