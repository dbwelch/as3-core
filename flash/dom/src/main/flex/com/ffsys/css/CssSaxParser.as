package com.ffsys.css
{
	import com.ffsys.net.sax.*;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.support.xml.BeanSaxParser;
	
	/**
	* 	Responsible for parsing css documents
	* 	represented as <code>XML</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class CssSaxParser extends BeanSaxParser
	{
		/**
		* 	Creates a <code>CssSaxParser</code> instance.
		*/
		public function CssSaxParser()
		{
			super();
		}

		/**
		* 	@inheritDoc
		*/
		override public function beginDocument( token:SaxToken ):void
		{
			super.beginDocument( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function endDocument( token:SaxToken ):void
		{
			super.endDocument( token );
		}
		
		override public function text( token:SaxToken ):void
		{
			//
			trace("CssSaxParser::text()", token );
		}

		/**
		* 	Invoked when parsing is complete.
		*/
		override protected function complete():void
		{
			super.complete();
		}
	}
}