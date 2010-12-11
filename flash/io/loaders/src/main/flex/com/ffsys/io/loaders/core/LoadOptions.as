package com.ffsys.io.loaders.core {
	
	/**
	*	Encapsulates options available when
	*	loading resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.07.2007
	*/
	public class LoadOptions extends Object
		implements ILoadOptions {
		
		private var _silent:Boolean;
		private var _fatal:Boolean;
		private var _autoGenerateId:Boolean;
		private var _continueOnResourceNotFound:Boolean;
		private var _quietOnResourceNotFound:Boolean;
		
		/**
		*	Creates a <code>LoadOptions</code> instance.	
		*/
		public function LoadOptions()
		{
			super();
			this.continueOnResourceNotFound = true;
			this.quietOnResourceNotFound = false;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set silent( val:Boolean ):void
		{
			_silent = val;
			if( val )
			{
				this.continueOnResourceNotFound = val;
				this.quietOnResourceNotFound = val;
			}			
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
		
		/**
		*	@inheritDoc	
		*/		
		public function set autoGenerateId( val:Boolean ):void
		{
			_autoGenerateId = val;
		}
		
		public function get autoGenerateId():Boolean
		{
			return _autoGenerateId;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set continueOnResourceNotFound( val:Boolean ):void
		{
			_continueOnResourceNotFound = val;
		}
		
		public function get continueOnResourceNotFound():Boolean
		{
			return _continueOnResourceNotFound;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set quietOnResourceNotFound( val:Boolean ):void
		{
			_quietOnResourceNotFound = val;
		}
		
		public function get quietOnResourceNotFound():Boolean
		{
			return _quietOnResourceNotFound;
		}
	}
}