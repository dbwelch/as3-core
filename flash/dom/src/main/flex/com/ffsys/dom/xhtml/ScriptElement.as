package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;	

	/**
	*	Represents a script, the <code>script</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.01.2011
	*/
	public class ScriptElement extends Element
		implements TextElement
	{
		private var _src:String;
		private var _type:String;
		private var _defer:String;
		private var _charset:String;
		
		//Other: src xmlns defer charset xmlns:xsi type id
		
		/**
		* 	Creates a <code>ScriptElement</code> instance.
		*/
		public function ScriptElement()
		{
			super();
		}
		
		/**
		* 	A source for the script.
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
		*	The <code>MIME</code> type of the script.
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
		* 	A defer value for the script.
		*/
		public function get defer():String
		{
			return _defer;
		}
		
		public function set defer( value:String ):void
		{
			_defer = value;
		}
		
		/**
		* 	A character set for the script.
		*/
		public function get charset():String
		{
			return _charset;
		}
		
		public function set charset( value:String ):void
		{
			_charset = value;
		}
	}
}