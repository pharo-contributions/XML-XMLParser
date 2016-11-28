"
A doctype writer for the XML Conformance test suite canonical XML format that is not omittable, unlike doctypes in regular canonical XML.
"
Class {
	#name : #XMLConformanceDoctypeDeclarationWriter,
	#superclass : #XMLDoctypeDeclarationWriter,
	#category : #'XML-Tests-Conformance-Writer'
}

{ #category : #testing }
XMLConformanceDoctypeDeclarationWriter >> isExternalIDOmittable [
	^ self isCanonical
]

{ #category : #testing }
XMLConformanceDoctypeDeclarationWriter >> isOmittable [
	^ false
]
