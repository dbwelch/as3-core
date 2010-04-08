package com.ffsys.utils.string {
	
	/**
	*	Utility methods for working with <code>String</code>
	*	values specific to <code>Class</code>
	*	instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.02.2008
	*/
	public class ClassStringUtils extends Object {
		
		/**
		*	The delimiter used to differentiate the class
		*	from the package path when working with values
		*	returned from <code>getQualifiedClassName</code>.
		*/
		static public const CLASS_DELIMITER:String = "::";
		
		/**
		*	@private	
		*/
		public function ClassStringUtils()
		{
			super();
		}
		
		/**
		*	Parses the package path portion of the
		*	value returned from a call to
		*	<code>getQualifiedClassName</code>.
		*	
		*	@param source The source <code>String</code>
		*	returned from <code>getQualifiedClassName</code>.
		*	
		*	@return The package path.
		*/
		static public function parsePackageName(
			source:String = "" ):String
		{
			var ind:int = source.lastIndexOf( CLASS_DELIMITER );
			
			if( ind > -1 )
			{
				return source.substr( 0, ind );
			}
			
			return "";			
		}
		
		/**
		*	Parses the class name portion of the
		*	value returned from a call to
		*	<code>getQualifiedClassName</code>.
		*	
		*	@param source The source <code>String</code>
		*	returned from <code>getQualifiedClassName</code>.
		*	
		*	@return The class name.
		*/		
		static public function parseClassName(
			source:String = "" ):String
		{
			var ind:int = source.lastIndexOf( CLASS_DELIMITER );
			
			if( ind > -1 )
			{
				source = source.substr( ind + CLASS_DELIMITER.length );
			}
			
			return source;
		}
		
		/**
		*	Accepts a standard Flash style to String representation
		*	and returns just the class name.
		*
		*	@example
		*	
		*	<pre>
		*	var o:Object = new Object();
		*	trace( StringUtils.getClassString( o.toString() ) );
		*	[object Object] => Object
		*	</pre>
		*/
		static public function getClassString( source:String = "" ):String
		{
			return source.replace(
				/^\[((o|O)bject|(c|C)lass) ([a-zA-Z0-9]+)\]/, "$4" );
		}	
	}	
}