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
				orderPreservingDictionaryOn: spec.		
			
			"Packages"
			spec 
				package: 'XML-Parser' with: [ spec requires: #('OrderPreservingDictionary' 'BitmapCharacterSet') ];
				package: 'XML-Parser-Tests' with: [ spec requires: #('XML-Parser' 'OrderPreservingDictionary Tests' 'BitmapCharacterSet Tests') ].
			
			"Groups"
			spec
				group: 'Core' with: #('XML-Parser');
				group: 'Tests' with: #('XML-Parser-Tests'); 
				group: 'default' with: #('Core' 'Tests');
				group: 'all' with: #('all')
			
	]
]

{ #category : #'prerequisites ' }
BaselineOfXMLParser >> bitmapCharacterSetOn: spec [
			
	spec
		baseline: 'BitmapCharacterSet'
      with: [ 
			spec
				loads: #('Core');
				repository: 'github://pharo-contributions/BitmapCharacterSet:1.4.x/src' ]. 
				
	spec project: 'BitmapCharacterSet Tests' copyFrom: 'BitmapCharacterSet' with: [ spec loads: #('Tests') ] 			
				
			
]

{ #category : #'prerequisites ' }
BaselineOfXMLParser >> orderPreservingDictionaryOn: spec [

	spec
		baseline: 'OrderPreservingDictionary'
      with: [ 
			spec
				loads: #('Core');
				repository: 'github://pharo-contributions/OrderPreservingDictionary:v1.4.x/src' ]. 
				
	spec project: 'OrderPreservingDictionary Tests' copyFrom: 'OrderPreservingDictionary' with: [ spec loads: #('Tests') ] 			
				
	
]
