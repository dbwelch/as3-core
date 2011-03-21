package org.flashx.swat.configuration.rsls {
	
	/**
	*	Represents a runtime shared library.
	*	
	*	A runtime shared library is a flash movie
	*	with assets required by the application.
	*	
	*	The assets may be code, fonts, sounds or any
	*	other type of embedded asset that flash supports.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	public class RuntimeSharedLibrary extends RuntimeResource {
		
		private var _trusted:Boolean;
		
		/**
		*	Creates a <code>RuntimeSharedLibrary</code> instance.
		*/
		public function RuntimeSharedLibrary()
		{
			super();
		}
		
		/**
		*	Whether the rsl is trusted.
		*/
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