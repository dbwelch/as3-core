package com.ffsys.css
{
	import com.ffsys.dom.*;	
	
	/**
	* 	Represents a <code>CSS</code> selector.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class Selector extends Object
	{
		/**
		* 	A regular expression used to determine whether
		* 	a expression contains attribute selector filters.
		*/
		public static const ATTRIBUTE_SELECTOR:RegExp = /\[([^\]]+)\]/g;
		
		/**
		* 	The delimiter between multiple selectors.
		*/
		public static const DELIMITER:String = ",";
		
		/**
		* 	The wildcard selector used to select all elements.
		*/
		public static const UNIVERSAL:String = "*";
		
		/**
		* 	The character that defines an identifier selector.
		*/
		public static const IDENTIFIER:String = "#";
		
		/**
		* 	The character that defines a class level selector.
		*/
		public static const CLASS:String = ".";
		
		/**
		* 	The character that defines a child selector.
		*/
		public static const CHILD:String = ">";
		
		/**
		* 	The character that defines an adjacent sibling selector.
		*/
		public static const ADJACENT_SIBLING:String = "+";
		
		/**
		* 	The character that defines an adjacent sibling selector.
		*/
		public static const GENERAL_SIBLING:String = "~";
		
		/**
		* 	The character that defines a descendant selector.
		*/
		public static const DESCENDANT:String = " ";
		
		private var _expression:String;
		private var _specificity:uint = 0;
		
		private var _selectors:Vector.<Selector>;
		
		/**
		* 	Creates a <code>Selector</code> instance.
		* 
		* 	@param expression A selector expression.
		*/
		public function Selector( expression:String = null )
		{
			super();
			if( expression != null )
			{
				this.expression = expression;
			}
		}
		
		/**
		* 	A string representing a selector expression.
		* 
		* 	Assigning to this property will parse the expression
		* 	into this selector.
		*/
		public function get expression():String
		{
			return _expression;
		}
		
		public function set expression( value:String ):void
		{
			_expression = value;
			
			if( value != null )
			{
				parse( value );
			}
		}
		
		/**
		* 	A prefix for this selector.
		*/
		public function get prefix():String
		{
			return "";
		}
		
		/**
		* 	The specificity of this selector.
		*/
		public function get specificity():uint
		{
			return _specificity;
		}
		
		/**
		* 	Selectors belonging to this selector.
		*/
		public function get selectors():Vector.<Selector>
		{
			if( _selectors == null )
			{
				_selectors = new Vector.<Selector>();
			}
			return _selectors;
		}
		
		/**
		* 	Determines whether this selector matches
		* 	the specified node.
		* 
		* 	@return Whether this selector matches the selected
		* 	node.
		*/
		public function test( candidate:Node ):Boolean
		{
			return false;
		}
		
		/**
		* 	@private
		* 
		* 	Parses a expression, including multiple selectors.
		* 
		* 	@param expression The expression to parse into this selector.
		*/
		protected function parse( expression:String ):void
		{
			if( expression != null )
			{
				var candidates:Array = expression.split( DELIMITER );
				for( var i:int = 0;i < candidates.length;i++ )
				{
					parseSelector(
						stripWhitespace( candidates[ i ] ) );
				}
			}
		}
		
		/**
		* 	@private
		* 
		* 	Removes leading and trailing whitespace.
		* 
		* 	@param expression The expression to strip of whitespace.
		* 
		* 	@return The expression with whitespace stripped.
		*/
		protected function stripWhitespace( expression:String ):String
		{
			if( expression != null )
			{
				expression = expression.replace( /^\s+/, "" );
				expression = expression.replace( /\s+$/, "" );		
			}
			return expression;
		}
		
		/**
		* 	@private
		* 
		* 	Parses a expression.
		* 
		* 	@param expression The expression to parse into this selector.
		*/
		protected function parseSelector( expression:String ):void
		{
			if( expression != null )
			{
				trace("Selector::parseSelector()", expression );
			}
		}
	}
}