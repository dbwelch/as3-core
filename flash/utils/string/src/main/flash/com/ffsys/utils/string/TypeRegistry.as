package com.ffsys.utils.string {
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	/**
	*	Used to access and cache results from describeType() calls.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.05.2007
	*/
	dynamic public class TypeRegistry extends Dictionary {
		
		/**
		*	@private
		*
		*	Stores a reference to the Singleton instance created.
		*/
		static private var instance:TypeRegistry;
		
		/**
		*	@private
		*/
		public function TypeRegistry( weakReference:Boolean = true )
		{
			super( weakReference );
		};
		
		/**
		*	Gets the Singleton TypeRegistry instance.
		*
		*	@return the Singleton TypeRegistry instance
		*/
		static public function getInstance():TypeRegistry
		{
			if( !instance )
			{
				instance = new TypeRegistry();
			}
			return instance;
		}
		
		/**
		*	@private
		*
		*	Store the XML type information for an instance and returns the
		*	type information stored.
		*
		*	@param obj the instance to gather type information for
		*
		*	@return the stored XML type information
		*/
		private function setType( obj:Object ):XML
		{
			var c:Class = ClassUtils.getClass( obj );
			var x:XML = describeType( obj );
			this[ c ] = x;
			return x;
		}
		
		/**
		*	@private
		*
		*	@param obj the instance to get the type information for
		*
		*	@return the XML type information
		*/
		private function getType( obj:Object ):XML
		{
			var c:Class = ClassUtils.getClass( obj );
			return this[ c ];
		}
		
		/**
		*	Gets the XML type information for an instance.
		*
		*	@param obj the Object to get the describeType() XML result for
		*
		*	@return the XML returned from a describeType( obj ) call
		*/		
		public function describe( instance:Object ):XML
		{
			var val:XML = getType( instance );
			if( val )
			{
				return val;
			}
			
			//var cache:ClassTypeCache = new ClassTypeCache( instance );
			
			return setType( instance );
		}
		
		/**
		*	Static access point for the Singleton instance method.
		*
		*	@param obj the Object to get the describeType() XML result for
		*
		*	@return the XML returned from a describeType( obj ) call
		*/
		static public function describe( obj:Object ):XML
		{
			return getInstance().describe( obj );
		}
				
	}
	
}
