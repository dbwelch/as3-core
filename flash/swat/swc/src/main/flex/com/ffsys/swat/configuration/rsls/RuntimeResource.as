package com.ffsys.swat.configuration.rsls {
	
	/**
	*	Represents a runtime resource definition.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.07.2010
	*/
	public class RuntimeResource extends Object
		implements IRuntimeResource {
			
		private var _id:String;
		private var _url:String;
		
		/**
		*	Creates a <code>RuntimeResource</code> instance.
		*/
		public function RuntimeResource()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( id:String ):void
		{
			_id = id;
		}
				
		/**
		*	@inheritDoc
		*/
		public function get url():String
		{
			return _url;
		}
	
		public function set url( url:String ):void
		{
			_url = url;
		}		
	}
}