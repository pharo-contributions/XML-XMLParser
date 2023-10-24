"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestXMLParserTests,
	#superclass : #PackageManifest,
	#category : #'XML-Parser-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestXMLParserTests class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestXMLParserTests class' #ManifestXMLParserTests)) #'2023-10-24T12:30:04.498987+02:00') )
]

{ #category : #'code-critics' }
ManifestXMLParserTests class >> ruleModifiesCollectionRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#XMLReadStreamAdapterTest #testUpTo #false)) #'2023-10-24T12:30:21.815298+02:00') #(#(#RGMethodDefinition #(#XMLReadStreamAdapterTest #testContents #false)) #'2023-10-24T12:30:30.437128+02:00') #(#(#RGMethodDefinition #(#XMLReadStreamAdapterTest #testSkipTo #false)) #'2023-10-24T12:30:40.474679+02:00') )
]

{ #category : #'code-critics' }
ManifestXMLParserTests class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'XML-Parser-Tests')) #'2019-10-31T19:52:06.524161+01:00') )
]

{ #category : #'code-critics' }
ManifestXMLParserTests class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#XMLFileHandleTest #testIsXMLDocumentFile #false)) #'2023-10-24T11:41:15.116549+02:00') )
]
