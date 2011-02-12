package com.ffsys.dom
{
	import com.ffsys.dom.core.*;
	
	/**
	* 	Represents a DOM implementation for the
	* 	"XML" feature.
	*/
	public class XMLImplementationImpl extends DOMImplementationImpl
	{	
		/**
		* 	Creates an <code>XMLImplementationImpl</code> instance.
		*/
		public function XMLImplementationImpl()
		{
			super();
		}
		
		/**
		* 	Configures the supported features for this implementation.
		*/
		override protected function configureSupportedFeatures():void
		{
			this.supported.push( DOMFeature.XML_FEATURE );
		}
	}
}