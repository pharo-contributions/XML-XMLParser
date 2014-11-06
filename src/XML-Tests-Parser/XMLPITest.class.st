Class {
	#name : #XMLPITest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #assertions }
XMLPITest >> assertPI: aNode hasTarget: aTarget data: aData [
	self
		assert: aNode target = aTarget;
		assert: aNode data = aData;
		assert: aNode printString = ('<?', aTarget, ' ', aData, '?>')
]

{ #category : #accessing }
XMLPITest >> nodeClass [
	^ XMLPI
]

{ #category : #accessing }
XMLPITest >> nodeTypes [
	^ #(isPI)
]

{ #category : #tests }
XMLPITest >> test3processingInstructionNodes [
	| pi t d |

	pi := XMLPI new.
	t := 'target'.
	d := 'data'.
	self
		assertPI: pi hasTarget: '' data: '';
		assertPI: (pi target: t) hasTarget: t data: '';
		assertPI: (pi data: d) hasTarget: t data: d;
		assertPI: (XMLPI target: t data: d) hasTarget: t data: d.
]
