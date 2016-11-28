"
A formatter for the XML Conformance test suite canonical XML format.
"
Class {
	#name : #XMLConformanceCanonicalWriterFormatter,
	#superclass : #XMLWriterFormatter,
	#category : #'XML-Tests-Conformance-Writer'
}

{ #category : #formatting }
XMLConformanceCanonicalWriterFormatter >> formatAfterDeclaration: aDeclarationWriter [
	self writeLineBreak
]

{ #category : #formatting }
XMLConformanceCanonicalWriterFormatter >> formatAfterDoctypeDeclaration: aDoctypeDeclaration [
	self writeLineBreak
]

{ #category : #formatting }
XMLConformanceCanonicalWriterFormatter >> formatBeforeInternalSubset: aDoctypeDeclarationWriter [
	self writeLineBreak
]
