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
	* 	But that would be insane as this class is useless to code.
	* 
	* 	@see com.ffsys.asdoc.AsdocSuper
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.11.2010
	*/
	public class AsdocTest extends AsdocSuper {
		
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
		* 
		* 	@param num An integer for this class.
		* 
		* 	@throws Error An error to indicate this class cannot be instantiated.
		*/
		public function AsdocTest( num:int )
		{	
			super();
			throw new Error( "You cannot instantiate this class as it is for testing documentation." );
		}
		
		/*
		* 	Oops, no return type. Naughty.
		*/
		
		/*
		public function stupid()
		{
			//
		}
		*/
		
		/**
		* 	A method with zero parameters.
		*/
		protected function zero():void
		{
			//
		}
		
		/**
		* 	This method os used to test xref within parameters
		* 	and return types.
		* 
		* 	@param target An instance to <b>not</b> copy into this instance.
		* 
		* 	@return Always returns this instance.
		*/
		public function getCopy( target:AsdocTest ):AsdocTest
		{
			return this;
		}
		
		/**
		* 	Overriden to add no functionality whatsoever.
		* 
		* 	@inheritDoc
		*/
		override public function set id(value:String):void
		{
			super.id = value;
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
		*/
		public function amazing():void
		{
			//
		}
		
		/**
		* 	A method that will always fail.
		* 
		* 	@throws AsdocError A custom error to indicate this method failed.
		* 
		* 	@return A boolean that will in fact never be returned as
		* 	this method will consistently throw an error.
		*/
		public function fail():Boolean
		{
			throw new AsdocError( "Failed." );
			return true;
		}
		
		/**
		* 	A protected method.
		* 
		* 	@param id The <b>identifier</b> parameter for the protected method.
		*/
		protected function getProtectedMethod( id:String ):void
		{
			//
		}
		
		/**
		* 	A public method.
		* 
		* 	@param id The <b>identifier</b> parameter for the public method.
		* 	@param another Another parameter for this method.
		* 
		* 	@return Just <code>null</code> as this is a documentation test.
		*/
		public function getPublicMethod( id:String, another:Boolean ):Object
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

/**
*	An attempt to document an inner class.
*/
class AsdocError extends Error {
	
	/**
	* 	Creates an <code>AsdocError</code> instance.
	*/
	public function AsdocError( message:String )
	{
		super( message );
	}
}