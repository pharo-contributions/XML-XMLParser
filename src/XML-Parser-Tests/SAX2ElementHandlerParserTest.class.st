Class {
	#name : #SAX2ElementHandlerParserTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-Tests-ElementHandlers'
}

{ #category : #source }
SAX2ElementHandlerParserTest >> sampleBooksXML [
	^ '
		<books>
			<book>
				<title>Smalltalk-80: The Language and its Implementation</title>
				<isbn>0201113716</isbn>
				<authors>
					<author>Adele Goldberg</author>
					<author>David Robson</author>
				</authors>
			</book>
			<book>
				<title>Pharo By Example</title>
				<isbn>3952334146</isbn>
				<authors>
					<author>Andrew P. Black</author>
					<author>Stephane Ducasse</author>
					<author>Oscar Nierstrasz</author>
					<author>Damien Pollet</author>
					<author>Damien Cassou</author>
					<author>Marcus Denker</author>
				</authors>
			</book>
		</books>
	'
]

{ #category : #source }
SAX2ElementHandlerParserTest >> samplePersonXML [
	^ '
		<person>
			<name>Tim Bray</name>
			<date-of-birth>June 21, 1955</date-of-birth>
			<contacts>
				<email address="tbray@textuality.com"/>
				<email address="tbray@tbray.org"/>
			</contacts>
			<residence>Vancouver, British Columbia, Canada</residence>
		</person>
	'
]

{ #category : #tests }
SAX2ElementHandlerParserTest >> testParsingSampleBooks [
	"Basic factory-style parsing, with one factory for the entire document"

	| books |
	books := (SAX2ElementParser on: self sampleBooksXML)
		         elementHandlerFactory:
			         (SAX2PluggableElementHandlerFactory new
				          handleElement: 'books'
				          withClass: SAX2HBooksElementHandler;
				          handleElement: 'book'
				          withClass: SAX2HBookElementHandler;
				          handleElement: 'title'
				          withClass: SAX2HTitleElementHandler;
				          handleElement: 'isbn'
				          withClass: SAX2HISBNElementHandler;
				          handleElement: 'author'
				          withClass: SAX2HAuthorElementHandler);
		         parseDocument.
	self
		assert: books class identicalTo: OrderedCollection;
		assert: books size equals: 2;
		assert: books first class identicalTo: SAX2SampleBook;
		assert: books first title
		equals: 'Smalltalk-80: The Language and its Implementation';
		assert: books first isbn equals: '0201113716';
		assert: books first authors asArray
		equals: #( 'Adele Goldberg' 'David Robson' );
		assert: books second class identicalTo: SAX2SampleBook;
		assert: books second title equals: 'Pharo By Example';
		assert: books second isbn equals: '3952334146';
		assert: books second authors asArray
		equals: #( 'Andrew P. Black' 'Stephane Ducasse' 'Oscar Nierstrasz'
			   'Damien Pollet' 'Damien Cassou' 'Marcus Denker' )
]

{ #category : #tests }
SAX2ElementHandlerParserTest >> testParsingSamplePerson [
	"FSM-style parsing, with element handlers being the states and
	the factories mapped to them being the transitions"

	| person rootFactory personFactory contactsFactory factoryMapper |
	rootFactory := SAX2PluggableElementHandlerFactory new
		               handleElement: 'person'
		               withClass: SAX2HPersonElementHandler.
	personFactory := SAX2PluggableElementHandlerFactory new
		                 handleElement: 'name'
		                 withClass: SAX2HNameElementHandler;
		                 handleElement: 'date-of-birth'
		                 withClass: SAX2HDateOfBirthElementHandler;
		                 handleElement: 'contacts'
		                 withClass: SAX2HContactsElementHandler;
		                 handleElement: 'residence'
		                 withClass: SAX2HResidenceElementHandler.
	contactsFactory := SAX2PluggableElementHandlerFactory new
		                   handleElement: 'email'
		                   withClass: SAX2HEmailElementHandler.
	factoryMapper := SAX2PluggableElementHandlerFactoryMapper new
		                 mapElementHandlerClass: SAX2HPersonElementHandler
		                 toFactory: personFactory;
		                 mapElementHandlerClass: SAX2HContactsElementHandler
		                 toFactory: contactsFactory.
	person := (SAX2ElementParser on: self samplePersonXML)
		          elementHandlerFactory: rootFactory;
		          elementHandlerFactoryMapper: factoryMapper;
		          parseDocument.
	self
		assert: person class identicalTo: SAX2SamplePerson;
		assert: person name equals: 'Tim Bray';
		assert: person dateOfBirth
		equals: (Date year: 1955 month: 6 day: 21);
		assert: person emailAddresses asArray
		equals: #( 'tbray@textuality.com' 'tbray@tbray.org' );
		assert: person residence
		equals: 'Vancouver, British Columbia, Canada'
]
