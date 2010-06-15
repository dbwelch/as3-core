package com.ffsys.utils.text
{
	import flash.text.TextField;
	
	/**
	*	Utility class for examining a single line textfield
	* 	and calculating the string to display concatenated
	* 	with an ellipsis.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class TextfieldEllipsis extends Object
	{
		/**
		* 	The default ellipsis used when none has been specified.
		*/
		static public const DEFAULT_ELLIPSIS:String = "...";
		
		/**
		* 	@private
		*/
		private var _ellipsis:String = DEFAULT_ELLIPSIS;
		
		/**
		* 	Creates a <code>TextfieldEllipsis</code> instance.
		*/
		public function TextfieldEllipsis()
		{
			super();
		}
		
		/**
		* 	Gets the ellipsis string.
		*/
		public function get ellipsis():String
		{
			return _ellipsis;
		}
		
		/**
		* 	Sets the ellipsis string.
		*/
		public function set ellipsis( ellipsis:String ):void
		{
			_ellipsis = ellipsis;
		}
		
		/**
		* 	Calculates the string value that will fit with the ellipsis
		* 	if the value parameter does not already fit within the textfield.
		* 
		* 	@param text The single line textfield to use for the calculation.
		* 	@param value The string value being assigned to the textfield.
		* 	@param forwards Whether calculation should be attempted in a forwards direction.
		* 
		* 	@return The original string if it does not exceed the width of the single line
		* 	textfield or a substring of the value concatenated with the ellipsis to fit within
		* 	the textfield.
		*/
		public function single(
			text:TextField,
			value:String,
			forwards:Boolean = true ):String
		{
			return forwards
				? calculateForwards( text, value )
				: calculateBackwards( text, value );
		}
		
		/**
		* 	@private
		*/
		private function calculateForwards(
			text:TextField,
			value:String ):String
		{
			var c:int = 1;
			var output:String = new String( value.substr( 0, c ) );
			text.text = output + ellipsis;
			
			while( text.maxScrollH == 0 )
			{
				output = value.substr( 0, c );
				trace("TextfieldEllipsis::set ellipsis()", output, c, value.length );
				text.text = output + ellipsis;
				
				if( text.maxScrollH > 0 )
				{
					output = value.substr( 0, c - 1 ) + ellipsis;
					break;
				}
				
				if( c == value.length )
				{
					
					break;
				}
				
				c++;
			}
			
			text.text = value;
			return output;
		}
		
		/**
		* 	@private
		*/
		private function calculateBackwards(
			text:TextField,
			value:String ):String
		{
			var output:String = new String( value );
			text.text = output;
			
			while( text.maxScrollH > 0 )
			{
				output = output.substr( 0, output.length - 1 );
				text.text = output + ellipsis;
			}
			
			output += ellipsis;
			return output;
		}
	}
}