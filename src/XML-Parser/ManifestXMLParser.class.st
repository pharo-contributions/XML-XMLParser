"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestXMLParser',
	#superclass : 'PackageManifest',
	#category : 'XML-Parser-Manifest',
	#package : 'XML-Parser',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestXMLParser class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#DTDElementContentModelParser #applyOperator: #false)) #'2023-10-26T00:29:04.983936+02:00') )
]

{ #category : 'code-critics' }
ManifestXMLParser class >> ruleExcessiveArgumentsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#DTDDoctypeDefinition #addExternalParameterEntity:resolver:publicID:systemID:baseURI: #false)) #'2023-10-26T00:32:13.375878+02:00') #(#(#RGMethodDefinition #(#DTDDoctypeDefinition #addStandaloneExternalExternalGeneralEntity:resolver:publicID:systemID:baseURI: #false)) #'2023-10-26T00:32:40.310435+02:00') #(#(#RGMethodDefinition #(#DTDDoctypeDefinition #addStandaloneExternalValidatorForAttributeIn:named:type:defaultPragma:defaultValue: #false)) #'2023-10-26T00:33:20.394652+02:00') #(#(#RGMethodDefinition #(#DTDDoctypeDefinition #addValidatorForAttributeIn:named:type:defaultPragma:defaultValue: #false)) #'2023-10-26T00:34:18.241313+02:00') )
]

{ #category : 'code-critics' }
ManifestXMLParser class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestXMLParser class' #ManifestXMLParser)) #'2023-10-26T01:11:45.317214+02:00') )
]
