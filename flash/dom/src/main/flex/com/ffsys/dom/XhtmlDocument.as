package com.ffsys.dom
{
	
	/**
	*	Represents an <code>XHTML</code> document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class XhtmlDocument extends Document
	{
		/**
		* 	Creates an <code>XhtmlDocument</code> instance.
		*/
		public function XhtmlDocument( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function prepared():void
		{
			trace("XhtmlDocument::prepared()", this, this.id );
		}
	}
}