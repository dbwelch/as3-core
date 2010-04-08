package com.ffsys.utils.string {
	
	/**
	*	Lightweight helper class for replacing
	*	<code>template</code> values with
	*	replacement <code>String</code> instances.
	*	
	*	@see com.ffsys.utils.string.StringHelper
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.01.2008
	*/
	public class StringSubstitutor extends StringHelper {
		
		/**
		*	The default <code>template</code> to use
		*	when performing substitutions.
		*/
		static public var defaultTemplateString:String = "%s";
		
		/**
		*	@private	
		*/
		protected var _template:String;
		
		/**
		*	Creates a <code>StringSubstitutor</code> instance.
		*	
		*	@param source The <code>String</code> value to perform
		*	substitution on.
		*	@param template The <code>String</code> value to search
		*	for when performing substitutions.
		*/
		public function StringSubstitutor(
			source:String = "",
			template:String = null )
		{
			super( source );
			
			if( !template )
			{
				template = defaultTemplateString;
			}
			
			this.template = template;
		}
		
		/**
		*	The template <code>String</code> to be searched
		*	for when performing substitution.
		*/
		public function set template( val:String ):void
		{
			_template = val;
		}
		
		public function get template():String
		{
			return _template;
		}
		
		/**
		*	Substitutes all occurences of <code>template</code>
		*	in the <code>input</code> with the subsequent
		*	parameters passed.
		*/
		public function substitute(
			input:String = null, ...args ):String
		{
			if( input == null )
			{
				input = source;
			}
			
			var c:int = 0;
			while( input.match( template ) &&
				( c >= 0 && c <= ( args.length - 1 ) ) )
			{
				input = input.replace( new RegExp( template ), args[ c ] );
				c++;
			}
			
			return input;
		}
		
		public function replace(
			input:String = null,
			parameters:Array = null ):String
		{
			if( !parameters )
			{
				parameters = new Array();
			}
			
			parameters.unshift( input );
			
			return this.substitute.apply( this, parameters );
		}
	}
}