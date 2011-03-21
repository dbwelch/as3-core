package org.flashx.net.asax
{
	
	public class SaxHandler extends Object
		implements ISaxHandler
	{
		/**
		* 	Creates a <code>SaxHandler</code> instance.
		*/
		public function SaxHandler()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function beginDocument( token:SaxToken ):void
		{
			//trace("[BEGIN DOCUMENT] SaxHandler::beginDocument()", token.name, token.type );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function shouldTraverseElement( token:SaxToken ):Boolean
		{
			return true;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function beginElement( token:SaxToken ):void
		{
			//trace("[START ELEMENT] SaxHandler::beginElement()", token.name, token.type );
		}	
		
		/**
		* 	@inheritDoc
		*/
		public function instruction( token:SaxToken ):void
		{
			//trace("[PROCESSING-INSTRUCTION] SaxHandler::instruction()", token.name, token.type );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function leaf( token:SaxToken ):void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		public function comment( token:SaxToken ):void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		public function cdata( token:SaxToken ):void
		{
			//			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function text( token:SaxToken ):void
		{
			//			
		}				
		
		/**
		* 	@inheritDoc
		*/
		public function endElement( token:SaxToken ):void
		{
			//trace("[END ELEMENT] SaxHandler::endElement()", token.name, token.type );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function endDocument( token:SaxToken ):void
		{
			//trace("[END DOCUMENT] SaxHandler::endDocument()", token.name, token.type );
		}
	}
}