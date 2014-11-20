Class {
	#name : #XMLDocumentTest,
	#superclass : #XMLNodeWithElementsTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLDocumentTest class >> isAbstract [
	^ false
]

{ #category : #assertions }
XMLDocumentTest >> assertDocument: aDocument hasDoctype: aDoctype version: aVersion encoding: anEncoding [
	self
		assert: aDocument doctypeDeclaration = aDoctype;
		assert: aDocument version = aVersion;
		assert: aDocument encoding = anEncoding
]

{ #category : #accessing }
XMLDocumentTest >> nodeClass [
	^ XMLDocument
]

{ #category : #tests }
XMLDocumentTest >> test11documentTest [
	| doc root doctype |

	doc := XMLDocument new.
	root := XMLElement new.
	doctype := XMLDoctypeDeclaration root: 'root' publicID: 'public' systemID: 'system'.
	self
		assert: doc isDocument;
		assert: doc root isNil;
		assert: (doc addNode: root; root) = root;
		assertDocument: doc hasDoctype: nil version: nil encoding: 'UTF-8'.

	self
		assertDocument: (doc doctypeDeclaration: doctype)
		hasDoctype: doctype
		version: nil
		encoding: 'UTF-8'.
	self
		assertDocument: (doc version: 1.0)
		hasDoctype: doctype
		version: 1.0
		encoding: 'UTF-8'.
	self
		assertDocument: (doc encoding: 'ISO Latin-1')
		hasDoctype: doctype
		version: 1.0
		encoding: 'ISO Latin-1'.
]

{ #category : #tests }
XMLDocumentTest >> testIsDocument [
	self assert: self nodeClass new isDocument
]
