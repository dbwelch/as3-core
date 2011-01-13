package com.ffsys.net.sax
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
			trace("[BEGIN DOCUMENT] SaxHandler::beginDocument()", token.name, token.type );
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
			trace("[START ELEMENT] SaxHandler::beginElement()", token.name, token.type );
		}
		
		
		/**
		* 	@inheritDoc
		*/
		public function descended( token:SaxToken ):void
		{
			//			
		}	
		
		/**
		* 	@inheritDoc
		*/
		public function doWithProcessingInstruction( token:SaxToken ):void
		{
			trace("[PROCESSING-INSTRUCTION] SaxHandler::doWithProcessingInstruction()", token.name, token.type );
		}	
		
		/**
		* 	@inheritDoc
		*/
		public function sibling( token:SaxToken, previous:SaxToken ):void
		{
			//
		}
		
		/**
		* 	@inheritDoc
		*/
		public function ascended( token:SaxToken ):void
		{
			//		
		}				
		
		/**
		* 	@inheritDoc
		*/
		public function endElement( token:SaxToken ):void
		{
			trace("[END ELEMENT] SaxHandler::endElement()", token.name, token.type );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function endDocument( token:SaxToken ):void
		{
			trace("[END DOCUMENT] SaxHandler::endDocument()", token.name, token.type );
		}
	}
}