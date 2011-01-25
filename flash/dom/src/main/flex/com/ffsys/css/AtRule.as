package com.ffsys.css
{
	import com.ffsys.dom.Element;
	
	/**
	* 	Represents an at rule.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class AtRule extends Element
	{
		/**
		* 	A map of the supported css at rules.
		*/
		public static var SUPPORTED:Object = {
			"charset": true,
			"namespace": true,
			"import": true,
			"font-face": true
		};
		
		/**
		* 	The attribute used to store the rule expression.
		*/
		public static const EXPRESSION_ATTRIBUTE:String = "expression";	
		
		/**
		* 	The attribute used to store the rule name.
		*/
		public static const NAME_ATTRIBUTE:String = "name";
	
		/**
		* 	The attribute used to store the rule data.
		*/
		public static const DATA_ATTRIBUTE:String = "data";	
		
		/**
		* 	Represents the charset at rule.
		*/
		public static const CHARSET:String = "charset";
		
		/**
		* 	Represents the import at rule.
		*/
		public static const IMPORT:String = "import";
		
		/**
		* 	Represents the font-face at rule.
		*/
		public static const FONT_FACE:String = "font-face";
		
		/**
		* 	Creates an <code>AtRule</code> instance.
		*/
		public function AtRule()
		{
			super();
		}
		
		/**
		* 	Determines whether this at rule is supported.
		* 
		* 	@param feature The feature name.
		* 	@param version A version for the feature.
		* 
		* 	@return Whether the feature is supported.
		*/
		override public function isSupported(
			feature:String = null,
			version:String = null ):Boolean
		{
			if( feature == null )
			{
				feature = propertyName;
			}
			return ( SUPPORTED[ feature ] === true );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get localName():String
		{
			return this.name;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return this.name;
		}
		
		/**
		* 	The rule expression.
		*/
		public function get expression():String
		{
			return getAttribute( EXPRESSION_ATTRIBUTE );
		}
		
		public function set expression( value:String ):void
		{
			setAttribute( EXPRESSION_ATTRIBUTE, value );
			if( value != null )
			{
				parse( value );
			}
		}
	
		/**
		* 	The rule name.
		*/
		public function get name():String
		{
			return getAttribute( NAME_ATTRIBUTE );
		}

		public function set name( value:String ):void
		{
			setAttribute( NAME_ATTRIBUTE, value );
		}
		
		/**
		* 	The rule data.
		*/
		public function get data():String
		{
			return getAttribute( DATA_ATTRIBUTE );
		}

		public function set data( value:String ):void
		{
			setAttribute( DATA_ATTRIBUTE, value );
		}
		
		/**
		* 	Parses an at rule expression into
		* 	this rule.
		*/
		public function parse( expression:String ):void
		{
			if( expression != null )
			{
				expression = expression.replace( /^@/, "" );
				var nm:String = expression.replace( /^([^\s]+)\s+.*$/, "$1" );
				var data:String = expression.replace( /^[^\s]+\s+(.*)$/, "$1" );
				this.name = nm;
				this.data = data;
				
				trace("AtRule::parse()", nm, data );
			}
		}
	}
}