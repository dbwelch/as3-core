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
	* 	An <code>AsdocDynamic</code> reference and an <code>IAsdocUndocumented</code> reference.
	* 
	* 	A reference to a constant <code>CONSTANT_NAME</code> to check double
	* 	escaping.
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
		* 	The escape character.
		*/
		public static const ESCAPE_DECLARATION:String = "\\";
		
		/**
		* 	A hyphen.
		*/
		public static const HYPHEN:String = "-";
		
		/**
		* 	A tilde.
		*/
		public static const TILDE:String = "~";	
		
		/**
		* 	A left brace.
		*/
		public static const LEFT_BRACE:String = "{";
	
		/**
		* 	A right brace.
		*/
		public static const RIGHT_BRACE:String = "}";
		
		/**
		* 	A set of characters used to test escaping.
		*/
		public static const CHARACTERS:String = "{~-\\^}";				
		
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
		* 	A protected variable with an underscore.
		*/
		protected var _underscore:String;
		
		/**
		* 	A protected variable with a dollar and an underscore.
		*/
		protected var $_underscore:String;
	
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
		* 	This method is used to test xref within parameters
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
		* 	An accessor getter that returns an xref.
		*/
		public function get copy():AsdocTest
		{
			return this;
		}
		
		/**
		* 	An accessor setter that has an xref as it's parameter.
		*/
		public function set insert(value:AsdocTest):void
		{
			//
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
		* 	Overriden to add no functionality whatsoever.
		* 
		* 	@inheritDoc
		*/		
		override public function get id():String
		{
			return super.id;
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
		* 	@throws AsdocError A custom <code>error</code> to indicate this method failed.
		* 
		* 	@return A <code>boolean</code> that will in fact never be returned as
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
		* 	A <code>writeonly</code> property for <code>AsdocTest</code> to check inline
		* 	auto xref logic in property short descriptions.
		*/
		public function set writeonly(write:String):void
		{
			_writeonly = write;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function flush():void
		{
			//
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