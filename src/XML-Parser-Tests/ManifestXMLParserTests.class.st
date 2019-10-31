"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestXMLParserTests,
	#superclass : #PackageManifest,
	#category : #'XML-Parser-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestXMLParserTests class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'XML-Parser-Tests')) #'2019-10-31T19:52:06.524161+01:00') )
]
