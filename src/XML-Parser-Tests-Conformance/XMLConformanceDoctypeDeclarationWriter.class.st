"
A doctype writer for the XML Conformance test suite canonical XML format that is not omittable, unlike doctypes in regular canonical XML.
"
Class {
	#name : #XMLConformanceDoctypeDeclarationWriter,
	#superclass : #XMLDoctypeDeclarationWriter,
	#category : #'XML-Parser-Tests-Conformance-Writer'
}

{ #category : #testing }
XMLConformanceDoctypeDeclarationWriter >> isExternalIDOmittable [
	"unlike standard canonical XML, doctype external IDs are always omittable
	for conformance canonical XML"
	^ self isCanonical
]

{ #category : #testing }
XMLConformanceDoctypeDeclarationWriter >> isOmittable [
	"unlike standard canonical XML, doctypes are never omittable
	for conformance canonical XML"
	^ false
]
