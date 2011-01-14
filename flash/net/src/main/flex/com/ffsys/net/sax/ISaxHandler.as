package com.ffsys.net.sax
{
	
	public interface ISaxHandler
	{
		
		/**
		* 	Invoked when the parser encounters a processing
		* 	instruction.
		* 	
		* 	@param token A SAX token for the processing instruction.
		*/
		function doWithProcessingInstruction( token:SaxToken ):void;
		
		/**
		* 	Invoked when parsing begins on the document.
		* 
		* 	@param token A SAX token for th element.
		*/
		function beginDocument( token:SaxToken ):void;
		
		/**
		* 	Invoked to determine whether child nodes
		* 	of an element should be traversed.
		* 
		* 	@param token A SAX token for th element.
		*/
		function shouldTraverseElement( token:SaxToken ):Boolean;
		
		/**
		* 	Invoked when the parser enters an element.
		* 
		* 	@param token A SAX token for the element.
		*/
		function beginElement( token:SaxToken ):void;
		
		/**
		* 	Invoked whenever a leaf node of any type
		* 	is encountered.
		* 
		* 	@param token A SAX token for the element.
		*/
		function leaf( token:SaxToken ):void;
		
		/**
		* 	Invoked whenever a comment node is encountered.
		* 
		* 	@param token A SAX token for the element.
		*/
		function comment( token:SaxToken ):void;
		
		/**
		* 	Invoked whenever a leaf text node is encountered.
		* 
		* 	@param token A SAX token for the element.
		*/
		function text( token:SaxToken ):void;		
		
		/**
		* 	Invoked when the parser leaves an element.
		* 
		* 	@param token A SAX token for the element.
		*/
		function endElement( token:SaxToken ):void;
		
		/**
		* 	Invoked when parsing ends on the document.
		* 
		* 	@param token A SAX token for the element.
		*/
		function endDocument( token:SaxToken ):void;
	}
}