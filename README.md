# XML-XMLParser

[![Build Status](https://travis-ci.org/pharo-contributions/XML-XMLParser.svg?branch=master)](https://travis-ci.org/pharo-contributions/XML-XMLParser) [![Coverage Status](https://coveralls.io/repos/github/pharo-contributions/XML-XMLParser/badge.svg?branch=master)](https://coveralls.io/github/pharo-contributions/XML-XMLParser?branch=master)

XML Parser for Pharo

## Installation

```Smalltalk
Metacello new
	baseline: 'XMLParser';
	repository: 'github://pharo-contributions/XML-XMLParser/src';
	load.
```	

## How to use

```Smalltalk
|xml|
xml := (ZnEasy get: 'https://gist.github.com/nathanhornby/4727009/raw/86eea19828e19455fe4082a989521f32f7006e9a/XML%2520Country%2520List') contents.
(XMLDOMParser parse: xml) document  
```

## Screenshot

![alt text](doc/images/screen001.png "Screenshot")

## LICENSE
[MIT License](LICENSE)
