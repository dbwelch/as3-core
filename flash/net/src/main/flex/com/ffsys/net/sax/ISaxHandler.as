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
		
		function shouldTraverseElement( token:SaxToken ):Boolean;
		
		/**
		* 	Invoked when the parser enters and element.
		* 
		* 	@param token A SAX token for the element.
		*/
		function beginElement( token:SaxToken ):void;
		
		
		/**
		* 	@inheritDoc
		*/
		function descended( token:SaxToken ):void;
		
		/**
		* 	@inheritDoc
		*/
		function sibling( token:SaxToken, previous:SaxToken ):void;
		
		/**
		* 	@inheritDoc
		*/
		function ascended( token:SaxToken ):void;		
		
		function endElement( token:SaxToken ):void;
		
		function endDocument( token:SaxToken ):void;
	}
}