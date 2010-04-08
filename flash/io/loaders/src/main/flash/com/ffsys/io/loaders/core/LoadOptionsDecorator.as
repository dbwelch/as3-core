package com.ffsys.io.loaders.core {
	
	/**
	*	Decorates instances with common
	*	<code>ILoadOptions</code> properties.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.09.2007
	*/
	public class LoadOptionsDecorator extends Object
		implements ILoadOptionsDecorator {
		
		/**
		*	@private	
		*/
		private var _silent:Boolean;
		
		/**
		*	@private	
		*/		
		private var _fatal:Boolean;
		
		/**
		*	@private	
		*/
		public function LoadOptionsDecorator()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set silent( val:Boolean ):void
		{
			_silent = val;
		}
		
		public function get silent():Boolean
		{
			return _silent;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set fatal( val:Boolean ):void
		{
			_fatal = val;
		}
		
		public function get fatal():Boolean
		{
			return _fatal;
		}
	}
}