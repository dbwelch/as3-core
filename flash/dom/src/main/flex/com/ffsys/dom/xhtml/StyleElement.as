package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;	

	/**
	*	Represents a style, the <code>style</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.01.2011
	*/
	public class StyleElement extends Element
		implements TextElement
	{
		private var _type:String;
		private var _media:String;
		
		/**
		* 	Creates a <code>StyleElement</code> instance.
		*/
		public function StyleElement()
		{
			super();
		}
		
		/**
		*	The <code>MIME</code> type of the style.
		*/
		public function get type():String
		{
			return _type;
		}
		
		public function set type( value:String ):void
		{
			_type = value;
		}
		
		/**
		* 	The style media.
		*/
		public function get media():String
		{
			return _media;
		}
		
		public function set media( value:String ):void
		{
			_media = value;
		}
	}
}