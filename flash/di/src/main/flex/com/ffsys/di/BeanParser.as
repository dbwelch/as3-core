package com.ffsys.di
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
		private var _delimiter:String;
		
		/**
		* 	Creates a <code>BeanTextParser</code> instance.
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
		* 	@inheritDoc
		*/
		public function get delimiter():String
		{
			return _delimiter;
		}
		
		public function set delimiter( value:String ):void
		{
			_delimiter = value;
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