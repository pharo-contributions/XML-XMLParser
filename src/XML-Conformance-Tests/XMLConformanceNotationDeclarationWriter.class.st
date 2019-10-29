"
A notation declaration writer for the XML Conformance test suite canonical XML format that is not omittable, unlike notation declarations in regular canonical XML.
"
Class {
	#name : #XMLConformanceNotationDeclarationWriter,
	#superclass : #XMLNotationDeclarationWriter,
	#category : #'XML-Conformance-Tests-Writer'
}

{ #category : #testing }
XMLConformanceNotationDeclarationWriter >> isOmittable [
	"unlike standard canonical XML, notation declarations are never omittable
	for conformance canonical XML"
	^ false
]
