package com.ffsys.asdoc {

	/**
	*	A test class for <em>actionscript documentation</em>.
	* 
	* 	This class is used to verify that all the tags are working
	* 	as expected such as <strong>bold text</strong> and <i>italic text</i>.
	* 
	* 	You can instantiate a new asdoc test with:
	* 
	* 	<pre>var asdoc:AsdocTest = new AsdocTest();</pre>
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.11.2010
	*/
	public class AsdocTest extends Object {
		
		/**
		* 	A <code>protected static</code> variable.
		*/
		protected static var protectedStaticVariable:String = "protected-static-variable";
		
		/**
		* 	A <code>static</code> variable.
		*/
		public static var staticVariable:String = "static-variable";
		
		/**
		* 	A constant declaration.
		*/
		public static const CONSTANT_NAME:String = "constant";
		
		/**
		* 	A <code>public</code> property.
		*/
		public var property:String = "property";
		
		/**
		* 	A <code>protected</code> property.
		*/
		protected var protection:String = "protection";		
		
		private var _readwrite:Boolean;
		
		private var _readonly:String = "readonly";
		
		private var _writeonly:String = "writeonly";
	
		/**
		*	Creates an <code>AsdocTest</code> instance.
		*/
		public function AsdocTest()
		{	
			super();
		}
		
		/**
		* 	A protected method.
		* 
		* 	@param id The <b>identifier</b> parameter for the protected method.
		* 
		* 	@return Just <code>void</code> as this is a documentation test.
		*/
		protected function getProtectedMethod( id:String ):void
		{
			//
		}
		
		/**
		* 	A public method.
		* 
		* 	@param id The <b>identifier</b> parameter for the public method.
		* 
		* 	@return Just <code>null</code> as this is a documentation test.
		*/
		public function getPublicMethod( id:String ):Object
		{
			return null;
		}
		
		/**
		* 	A <code>readwrite</code> accessor property.
		*/
		public function get readwrite():Boolean
		{
			return _readwrite;
		}
		
		public function set readwrite(value:Boolean):void
		{
			_readwrite = value;
		}
		
		/**
		* 	A <code>readonly</code> accessor property.
		*/
		public function get readonly():String
		{
			return _readonly;
		}
		
		/**
		* 	A <code>writeonly</code> property.
		*/
		public function set writeonly(write:String):void
		{
			_writeonly = write;
		}	
	}
}