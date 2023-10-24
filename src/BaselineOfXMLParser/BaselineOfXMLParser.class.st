"
Baseline for XML Parser (https://github.com/pharo-contributions/XML-XMLParser)
"
Class {
	#name : #BaselineOfXMLParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfXMLParser
}

{ #category : #baselines }
BaselineOfXMLParser >> baselineOf: spec [

	<baseline>
	spec
		for: #common
		do: [
			
			self 
				bitmapCharacterSetOn: spec;
				orderPreservingDictionaryOn: spec;
				xmlWriterOn: spec.		
			
			"Packages"
			spec 
				package: 'XML-Parser' with: [ spec requires: #('OrderPreservingDictionary' 'BitmapCharacterSet') ];
				package: 'XML-Parser-Tests' with: [ spec requires: #('XML-Parser' 'OrderPreservingDictionary Tests' 'BitmapCharacterSet Tests') ];
				package: 'XML-Parser-Tests-Conformance' with: [ spec requires: #('XML-Parser' 'XMLWriter Tests' 'XML-Parser-Tests') ]";
				package: 'XML-Parser-GTExtensions' with: [ spec requires: #('XML-Parser') ]".
			
			"Groups"
			spec
				group: 'Core' with: #('XML-Parser');
				group: 'Tools' with: #(OrderPreservingDictionary Tools 'XMLWriter Tools' "'XML-Parser-GTExtensions'"); 
				group: 'Tests' with: #('XML-Parser-Tests' 'XML-Parser-Tests-Conformance');	
				group: 'all' with: #('Core' 'Tools' 'Tests');
				group: 'default' with: #('all')	
	]
]

{ #category : #'prerequisites ' }
BaselineOfXMLParser >> bitmapCharacterSetOn: spec [
			
	spec
		baseline: 'BitmapCharacterSet'
      with: [ 
			spec
				loads: #('Core');
				repository: 'github://pharo-contributions/BitmapCharacterSet:1.2.x/src' ]. 
				
	spec project: 'BitmapCharacterSet Tests' copyFrom: 'BitmapCharacterSet' with: [ spec loads: #('Tests') ] 			
				
			
]

{ #category : #'prerequisites ' }
BaselineOfXMLParser >> orderPreservingDictionaryOn: spec [

	spec
		baseline: 'OrderPreservingDictionary'
      with: [ 
			spec
				loads: #('Core');
				repository: 'github://pharo-contributions/OrderPreservingDictionary:1.6.x/src' ]. 
				
	spec 
		project: 'OrderPreservingDictionary Tests' copyFrom: 'OrderPreservingDictionary' with: [ spec loads: #('Tests') ];			
		project: 'OrderPreservingDictionary Tools' copyFrom: 'OrderPreservingDictionary' with: [ spec loads: #('Tools') ]
]

{ #category : #'prerequisites ' }
BaselineOfXMLParser >> xmlWriterOn: spec [

	spec
		baseline: 'XMLWriter'
      with: [ 
			spec
				loads: #('Core');
				repository: 'github://pharo-contributions/XML-XMLWriter:3.0.x/src' ]. 
				
	spec 
		project: 'XMLWriter Tests' copyFrom: 'XMLWriter' with: [ spec loads: #('Tests') ]; 	
		project: 'XMLWriter Tools' copyFrom: 'XMLWriter' with: [ spec loads: #('Tools') ] 
]
