package com.ffsys.w3c.dom.css
{	
	import org.w3c.dom.css.CSS2Properties;
	
	/**
	* 	Represents all the style properties available to CSS2.
	*/
	public class CSS2PropertiesImpl extends CSSStyleDeclarationImpl
		implements CSS2Properties
	{
		/**
		* 	The name of the XML attribute used to store
		* 	the name of the property.
		*/
		public static const PROPERTY_NAME_ATTR:String = "name";
		
		/**
		* 	Creates a <code>CSS2PropertiesImpl</code> instance.
		*/
		public function CSS2PropertiesImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get azimuth():String
		{
			return getAttribute( PROPERTY_NAME_ATTR );
		}
		
		public function set azimuth( value:String ):void
		{
			setAttribute( PROPERTY_NAME_ATTR, value );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get background():String
		{
			return getAttribute( PROPERTY_NAME_ATTR );
		}
		
		public function set background( value:String ):void
		{
			setAttribute( PROPERTY_NAME_ATTR, value );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get backgroundAttachment():String
		{
			return getAttribute( PROPERTY_NAME_ATTR );			
		}
		
		public function set backgroundAttachment( value:String ):void
		{
			setAttribute( PROPERTY_NAME_ATTR, value );
		}
		
		//TOOD: declare all CSS2 properties
	}
}