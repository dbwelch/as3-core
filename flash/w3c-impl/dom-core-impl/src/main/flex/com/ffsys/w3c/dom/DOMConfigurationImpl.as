package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;	
	
	/**
	* 	TODO
	*/
	public class DOMConfigurationImpl extends Object
		implements DOMConfiguration
	{
		/**
		* 	@private
		*/
		protected var parameters:Object = new Object();
		
		/**
		* 	Creates a <code>DOMConfigurationImpl</code> instance.
		*/
		public function DOMConfigurationImpl()
		{
			super();
		}
		
		/**
		* 	Copies this configuration into another configuration.
		* 
		* 	@param config The configuration to copy into.
		* 
		* 	@return The configuration being copied into.
		*/
		public function copy( config:DOMConfiguration ):DOMConfiguration
		{
			if( config != null )
			{
				var names:DOMStringList = parameterNames;
				var nm:String = null;
				for( var i:int = 0;i < names.length;i++ )
				{
					nm = names[ i ];
					config.setParameter( nm, getParameter( nm ) );
				}
			}
			return config;
		}
	
		/**
		* 	@inheritDoc
		*/
		public function get parameterNames():DOMStringList
		{
			var list:DOMStringListImpl = new DOMStringListImpl();
			for( var z:String in parameters )
			{
				list.add( z );
			}
			return list;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setParameter( name:String, value:* ):void
		{
			if( canSetParameter( name, value ) )
			{
				parameters[ name ] = value;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getParameter( name:String ):*
		{
			return parameters[ name ];
		}
		
		/**
		* 	@inheritDoc
		*/
		public function canSetParameter( name:String, value:* ):Boolean
		{
			return true;
		}
	}
}