package com.ffsys.swat.configuration {
	
	/**
	*	Represents a runtime shared library.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public class RuntimeSharedLibrary extends Object {
		
		private var _url:String;
		private var _trusted:Boolean;
		
		/**
		*	Creates a <code>RuntimeSharedLibrary</code> instance.
		*/
		public function RuntimeSharedLibrary()
		{
			super();
		}
		
		/**
		*	Gets the URL to the runtime swf file to load.
		*	
		*	@return The rsl URL.
		*/
		public function get url():String
		{
			return _url;
		}
		
		/**
		*	Sets the URL to the runtime swf file to load.
		*	
		*	@param url The rsl URL.
		*/		
		public function set url( url:String ):void
		{
			_url = url;
		}
		
		public function get trusted():Boolean
		{
			return _trusted;
		}
		
		public function set trusted( trusted:Boolean ):void
		{
			_trusted = trusted;
		}
	}
}