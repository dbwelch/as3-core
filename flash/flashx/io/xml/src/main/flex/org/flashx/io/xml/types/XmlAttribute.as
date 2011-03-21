package org.flashx.io.xml.types {
	
	/**
	*	Defines a type that can be used by an
	*	XML serialization contract to declare
	*	that a given property should be serialized
	*	as an attribute.
	*	
	*	By default during serialization all properties
	*	will be serialized as child XML elements.
	*	
	*	By declaring a property as an <code>XmlAttribute</code>
	*	type the serialization process will bypass the default
	*	behaviour and serialize the declared property as an
	*	XML attribute.
	*	
	*	@see com.ffsys.io.xml.ISerializeContract
	*	@see com.ffsys.io.xml.SerializeContract
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.05.2007
	*/
	public class XmlAttribute extends Object {

		/**
		*	Creates an <code>XmlAttribute</code> instance.
		*	
		*	You should never instantiate this <code>Class</code>
		*	directly as it is by declaring this as the type of
		*	a property in an <code>ISerializeContract</code>
		*	implementation that indicates that the given property
		*	should be serialized as an XML attribute.
		*/
		public function XmlAttribute()
		{
			super();
		}
	}
}