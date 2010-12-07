package com.ffsys.asdoc {

	/**
	*	A test class for deprecated declarations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.12.2010
	*/
	public class AsdocDeprecated extends AsdocSuper {
	
		/**
		*	Creates an <code>AsdocDeprecated</code> instance.
		*/
		public function AsdocDeprecated()
		{	
			super();
		}
		
		/**
		* 	A getter method to see also.
		*/
		public function get seethis():Object
		{
			return null;
		}
		
		/**
		* 	A getter method to see from.
		* 
		* 	@see com.ffsys.asdoc.AsdocDeprecated#seethis
		*/
		public function get fromsee():String
		{
			return null;
		}
		
		/**
		* 	A java style deprecated declaration.
		* 	
		* 	@deprecated amazing
		*/
		public function jdeprecated():void
		{
			//
		}
		
		/**
		* 	A deprecated method.
		*/
		[Deprecated(replacement="amazing")]
		public function deprecated():void
		{
			//
		}
				
		/**
		* 	An amazing method to replace the deprecated one.
		* 
		* 	@see com.ffsys.asdoc.AsdocDeprecated#deprecated
		* 	@see com.ffsys.asdoc.AsdocDeprecated#jdeprecated
		*/
		public function amazing():void
		{
			//
		}
	}
}