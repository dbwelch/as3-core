package com.ffsys.swat.configuration.rsls {

	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	
	/**
	*	Abstract super class for configuration collections
	*	that encapsulate a set of runtime resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.06.2010
	*/
	dynamic public class RuntimeResourceCollection extends Array
		implements IRuntimeResourceCollection {
			
		/**
		*	@private	
		*/
		protected var _queue:ILoaderQueue;
		
		/**
		*	Creates an <code>RuntimeResourceCollection</code> instance.
		*/
		public function RuntimeResourceCollection()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderQueue():ILoaderQueue
		{
			return _queue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getLoader( request:URLRequest ):ILoader
		{
			throw new Error(
				"You must specify the loader type in your concrete implementation." );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function setDeserializedProperty(
			name:String, value:Object ):void
		{
			if( value is IRuntimeResource )
			{
				//store the library reference
				this.push( IRuntimeResource( value ) );
			}
		}
	}
}