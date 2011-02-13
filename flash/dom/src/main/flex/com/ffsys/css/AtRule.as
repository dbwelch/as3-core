package com.ffsys.css
{
	import com.ffsys.dom.core.Element;
	
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
			"fontFace": true
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
		* 	The symbol that represents an at rule.
		*/
		public static const SYM:String = "@";
		
		/**
		* 	Represents the import at rule.
		*/
		public static const IMPORT:String = "import";
		
		/**
		* 	Represents the page at rule.
		*/
		public static const PAGE:String = "page";
		
		/**
		* 	Represents the media at rule.
		*/
		public static const MEDIA:String = "media";
		
		/**
		* 	Represents the font-face at rule.
		*/
		public static const FONT_FACE:String = "font-face";		
		
		/**
		* 	Represents the charset at rule.
		*/
		public static const CHARSET:String = "charset";		
		
		/**
		* 	Represents the namespace at rule.
		*/
		public static const NAMESPACE:String = "namespace";
		
		/**
		* 	Creates an <code>AtRule</code> instance.
		*/
		public function AtRule()
		{
			super();
		}
		
		/**
		* 	Determines whether this at rule represents
		* 	a namespace declaration.
		*/
		public function isNameSpace():Boolean
		{
			return this.name == NAMESPACE;
		}
		
		/**
		* 	If this rule is a namespace declaration
		* 	this method will retrieve a Namespace
		* 	representation of the rule.
		* 	
		* 	@return A namespace representation of this rule.
		*/
		public function getNameSpace():Namespace
		{
			var ns:Namespace = null;
			if( isNameSpace() )
			{
				var parts:Array = data.split( /\s/ );
				var prefix:String = parts.length > 0 ? parts[ 0 ] : null;
				
				var index:int = /^url\(/.test( prefix ) ? 0 : 1;
				
				var uri:String = parts.length > 1 ? parts.slice( index ).join( "" ) : data;
				
				//TODO: parse the url value
				trace("AtRule::getNameSpace()", parts, prefix, uri );
				
				ns = new Namespace( prefix, uri )
			}
			return ns;
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
			}
		}
		
		/**
		* 	Gets a string representation of this
		* 	selector.
		* 
		* 	@return A string representation of this selector.
		*/
		override public function toString():String
		{
			return "[object " + getClass().name + "(@" + nodeName + " " + data + ")]";
		}
	}
}