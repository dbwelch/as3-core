package com.ffsys.css
{
	import com.ffsys.dom.core.*;
	
	/**
	* 	Represents a css style property.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class StyleProperty extends Element
	{	
		
		/**
		* 	The prefix used for vendor specific properties
		* 	not included as part of the specification.
		*/
		public static const VENDOR_STYLE_PROPERTY_PREFIX:String
			= "-as-";
		
		/**
		* 	A map of the supported css properties.
		*/
		public static var SUPPORTED:Object = {
			fontSize: true,
			fontFamily: true,
			margin: true,
			padding: true,
			color: true,
			background: true,
			backgroundColor: true
		};
		
		/**
		* 	The attribute used to store the style property name.
		*/
		public static const NAME_ATTRIBUTE:String = "name";
		
		/**
		* 	The attribute used to store the style property value.
		*/
		public static const VALUE_ATTRIBUTE:String = "value";
		
		private var _data:Object;
		
		/**
		* 	Creates a <code>StyleProperty</code> instance.
		*/
		public function StyleProperty()
		{
			super();
		}
		
		/**
		* 	Determines whether this style property is supported.
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
		* 	The style property name.
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
		* 	The style property value.
		*/
		public function get value():String
		{
			return getAttribute( VALUE_ATTRIBUTE );			
		}
		
		public function set value( value:String ):void
		{
			setAttribute( VALUE_ATTRIBUTE, value );
			
			if( value != null )
			{
				this.data = parse( value );
			}
		}
		
		/**
		* 	@private
		* 
		* 	Parses a value into this property.
		* 
		* 	@param value The string value.
		* 
		* 	@return The parsed data object.
		*/
		private function parse( value:String ):Object
		{
			var output:Object = value;
			
			//convert to a style unit if necessary
			if( StyleUnit.isUnit( value ) )
			{
				output = new StyleUnit();
				output.expression = value;
			}
			
			return output;
		}
		
		/**
		* 	A representation of the value converted
		* 	to either a primtive value or a complex
		* 	object used to represent the value.
		*/
		public function get data():Object
		{
			return _data;
		}
		
		public function set data( value:Object ):void
		{
			_data = value;
		}

		/**
		* 	Gets a string representation of this
		* 	selector.
		* 
		* 	@return A string representation of this selector.
		*/
		override public function toString():String
		{
			return "[object " + getClass().name + "(" + nodeName + "=\"" + value + "\")]";
		}		
	}
}