package com.ffsys.w3c.dom.ls.serialize
{
	import org.w3c.dom.DOMConfiguration;
	import org.w3c.dom.ls.LSSerializer;
	
	import com.ffsys.w3c.dom.DOMConfigurationImpl;
	
	/**
	* 	TODO
	*/
	public class DOMSerializerImpl extends DOMConfigurationImpl
		implements LSSerializer, DOMConfiguration
	{
		/**
		* 	The bean name for this serializer implementation.
		*/
		public static const NAME:String = "dom-ls-serializer";		
		
		/**
		* 	Creates <code>DOMSerializerImpl</code> instance.
		*/
		public function DOMSerializerImpl()
		{
			super();
		}
	}
}