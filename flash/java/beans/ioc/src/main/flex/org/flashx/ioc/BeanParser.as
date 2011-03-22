package org.flashx.ioc
{
	import flash.net.URLRequest;

	/**
	*	Abstract super class for parsing bean documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanParser extends Object
		implements IBeanParser
	{
		private var _document:IBeanDocument;
		
		/**
		* 	Creates a <code>BeanTextParser</code> instance.
		* 
		* 	@param document The document that the parsed beans will be placed in.
		*/
		public function BeanParser( document:IBeanDocument = null )
		{
			super();
			if( document == null )
			{
				document = new BeanDocument();
			}
			this.document = document;
		}
		
		/**
		* 	The bean document to parse into.
		*/
		public function get document():IBeanDocument
		{
			return _document;
		}
		
		public function set document( value:IBeanDocument ):void
		{
			_document = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function parse( text:String ):IBeanDocument
		{
			return this.document;
		}
	}
}