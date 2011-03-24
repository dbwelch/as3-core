package org.flashx.utils.page
{
	/**
	*	Value object to represent pagination information returned
	* 	from a server.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.05.2010
	*/
	public class PageInfo extends Object
	{
		
		/**
		* 	The record selection offset.
		*/
		public var offset:int;

		/**
		* 	The maximum number of records per page.
		*/
		public var limit:int;

		/**
		* 	The total number of records in the data source.
		*/
		public var total:int;
		
		/**
		* 	The number of records returned in the current request.
		*/
		public var count:int;
		
		/**
		* 	Creates a <code>PageInfo</code> instance.
		*/
		public function PageInfo()
		{
			super();
		}
	}
}