package org.flashx.ui.text.core
{
	import flash.text.TextField;
	
	/**
	*	Utility class for examining a textfield
	* 	and if the textfield scrolls calculate an
	*	alternative string value containing an ellipsis
	*	that will prevent the textfield from being scrollable
	*	and indicate that some content was removed from
	*	the textfield contents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class TextFieldEllipsis extends Object
	{
		/**
		*	Constant representing the forwards direction.
		*	
		*	When calculation is done using the forwards direction
		*	the string value is concatenated a character at a time with
		*	the ellipsis until the textfield scrolls.
		*/
		public static const FORWARDS:String = "forwards";
		
		/**
		*	Constant representing the backwards direction.
		*	
		*	When calculation is done using the backwards direction
		*	a character is removed and concatenated with the ellipsis
		*	until there is no scroll.
		*/
		public static const BACKWARDS:String = "backwards";
		
		/**
		*	Constant representing the <code>maxScrollH</code> property.
		*/
		public static const MAX_SCROLL_H:String = "maxScrollH";
		
		/**
		*	Constant representing the <code>maxScrollV</code> property.
		*/
		public static const MAX_SCROLL_V:String = "maxScrollV";
		
		/**
		*	Constant representing the <code>text</code> property.
		*/
		public static const TEXT_PROPERTY:String = "text";
		
		/**
		*	Constant representing the <code>htmlText</code> property.
		*/
		public static const HTML_TEXT_PROPERTY:String = "htmlText";
		
		/**
		* 	The default ellipsis used when none has been specified.
		*/
		public static const DEFAULT_ELLIPSIS:String = "...";
		
		/**
		* 	@private
		*/
		private var _ellipsis:String;
		
		/**
		*	@private	
		*/
		private var _html:Boolean = false;
		
		/**
		*	@private
		*/
		private var _direction:String = BACKWARDS;
		
		/**
		* 	Creates a <code>TextFieldEllipsis</code> instance.
		*/
		public function TextFieldEllipsis()
		{
			super();
		}
		
		/**
		* 	Gets the ellipsis string.
		*/
		public function get ellipsis():String
		{
			if( !_ellipsis )
			{
				return DEFAULT_ELLIPSIS;
			}
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
		*	Determines whether to apply values as html text.
		*	
		*	@return Whether textfield values are applied as html text
		*	or normal text. The default value is <code>false</code>.
		*/
		public function get html():Boolean
		{
			return _html;
		}
		
		/**
		*	Sets whether html text values are applied.
		*	
		*	@param html Whether textfield values are applied as html.
		*/
		public function set html( html:Boolean ):void
		{
			_html = html;
		}
		
		/**
		*	Gets the direction that calculation takes place.	
		*/
		public function get direction():String
		{
			return _direction;
		}
		
		/**
		*	Sets the direction that calculation takes place.
		*/
		public function set direction( direction:String ):void
		{
			if( !( direction == FORWARDS || direction == BACKWARDS ) )
			{
				throw new Error( "The ellipsis calculation direction should be"
				 	+ " either '" + FORWARDS + "' or '" + BACKWARDS + "'." );
			}
			
			_direction = direction;
		}
		
		/**
		* 	Examines a single line textfield and compares against the
		*	<code>maxScrollH</code> property.
		* 
		* 	@param text The single line textfield to use for the calculation.
		* 	@param value The string value being assigned to the textfield.
		* 	@param replace Whether to replace the textfield text with the ellipsis
		*	version if a scroll was found.
		* 
		* 	@return The original string if it does not exceed the width of the single line
		* 	textfield or a substring of the value concatenated with the ellipsis to fit within
		* 	the textfield.
		*/
		public function single(
			text:TextField,
			value:String,
			replace:Boolean = true ):String
		{
			return ( direction == FORWARDS )
				? calculateForwards( text, value, replace )
				: calculateBackwards( text, value, replace );
		}
		
		/**
		* 	@private
		*/
		private function calculateForwards(
			text:TextField,
			value:String,
			replace:Boolean = true,
			property:String = MAX_SCROLL_H ):String
		{
			var textProperty:String = html ? HTML_TEXT_PROPERTY : TEXT_PROPERTY;
			var c:int = 1;
			var output:String = new String( value.substr( 0, c ) );
			
			//shortcut early if there is no scroll
			text[ textProperty ] = value;
			if( text[ property ] == 0 )
			{
				return value;
			}
			
			text[ textProperty ] = output + ellipsis;
			
			while( text[ property ] == 0 )
			{
				output = value.substr( 0, c );
				text[ textProperty ] = output + ellipsis;
				
				if( text[ property ] > 0 )
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
			
			text[ textProperty ] = replace ? output : value;
			return output;
		}
		
		/**
		* 	@private
		*/
		private function calculateBackwards(
			text:TextField,
			value:String,
			replace:Boolean = true,
			property:String = MAX_SCROLL_H ):String
		{
			var textProperty:String = html ? HTML_TEXT_PROPERTY : TEXT_PROPERTY;
			var output:String = new String( value );
			
			//shortcut early if there is no scroll
			text[ textProperty ] = value;
			if( text[ property ] == 0 )
			{
				return value;
			}
			
			while( text[ property ] > 0 )
			{
				output = output.substr( 0, output.length - 1 );
				text[ textProperty ] = output + ellipsis;
			}
			
			output += ellipsis;
			
			text[ textProperty ] = replace ? output : value;
			return output;
		}
	}
}