package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents an inline quotation, the <code>q</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class QuotationElement extends InlineElement
	{
		private var _cite:String;
		
		/**
		* 	Creates a <code>QuotationElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function QuotationElement( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	A citation for the quote.
		*/
		public function get cite():String
		{
			return _cite;
		}
		
		public function set cite( value:String ):void
		{
			_cite = value;
		}
	}
}