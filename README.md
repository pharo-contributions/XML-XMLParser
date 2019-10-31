# XML-XMLParser
XML Parser for Pharo

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