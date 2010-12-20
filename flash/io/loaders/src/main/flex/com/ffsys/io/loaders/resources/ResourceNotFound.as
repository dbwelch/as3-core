package com.ffsys.io.loaders.resources
{
	/**
	*	Represents a loaded resource that could not be found.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class ResourceNotFound extends AbstractResource
	{
		/**
		* 	Creates a <code>ResourceNotFound</code> instance.
		*/
		public function ResourceNotFound(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		/**
		*	Overriden to ensure that attempts to access
		* 	the data associated with this resource fail.
		* 
		* 	@throws Error An error indicating that a resource
		* 	not found resource does not have any data.
		*/
		override public function get data():Object
		{
			throw new Error( "A missing resource does not have any associated data." );
		}		
	}
}