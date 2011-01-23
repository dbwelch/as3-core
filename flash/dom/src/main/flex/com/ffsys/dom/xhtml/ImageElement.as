package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents an inline image, the <code>img</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.01.2011
	*/
	dynamic public class ImageElement extends InlineElement
		implements EmptyElement
	{
		private var _src:String;
		private var _alt:String;
		private var _longdesc:String;
		private var _width:String;
		private var _height:String;
		
		/**
		* 	Creates an <code>ImageElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function ImageElement( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	The source for the image.
		*/
		public function get src():String
		{
			return _src;
		}
		
		public function set src( value:String ):void
		{
			_src = value;
		}
		
		/**
		* 	The alternative text for the image.
		*/
		public function get alt():String
		{
			return _alt;
		}
		
		public function set alt( value:String ):void
		{
			_alt = value;
		}
		
		/**
		* 	A long description for this image.
		*/
		public function get longdesc():String
		{
			return _longdesc;
		}
		
		public function set longdesc( value:String ):void
		{
			_longdesc = value;
		}
		
		/**
		* 	The width of the image.
		*/
		public function get width():String
		{
			return _width;
		}
		
		public function set width( value:String ):void
		{
			_width = value;
		}
		
		/**
		* 	The height of the image.
		*/
		public function get height():String
		{
			return _height;
		}
		
		public function set height( value:String ):void
		{
			_height = value;
		}
	}
}