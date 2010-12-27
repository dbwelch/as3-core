package com.ffsys.swat.configuration.rsls
{
	
	/**
	*	Encapsulates the resources for a component definition.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.12.2010
	*/
	public class ComponentResource extends RuntimeResource
	{
		private var _rsls:RslCollection;
		private var _beans:BeanCollection;
		private var _css:CssCollection;
		private var _xml:XmlCollection;
		
		/**
		* 	Creates a <code>ComponentResource</code> instance.
		*/
		public function ComponentResource()
		{
			super();
		}
		
		/**
		* 	The runtime shared library resources for this component.
		*/
		public function get rsls():RslCollection
		{
			return _rsls;
		}
		
		public function set rsls( value:RslCollection ):void
		{
			_rsls = value;
		}
		
		/**
		* 	The bean documents for this component.
		*/
		public function get beans():BeanCollection
		{
			return _beans;
		}
		
		public function set beans( value:BeanCollection ):void
		{
			_beans = value;
		}
		
		/**
		* 	The stylesheets for this component.
		*/
		public function get css():CssCollection
		{
			return _css;
		}
		
		public function set css( value:CssCollection ):void
		{
			_css = value;
		}
		
		/**
		* 	The xml documents for this component.
		*/
		public function get xml():XmlCollection
		{
			return _xml;
		}
		
		public function set xml( value:XmlCollection ):void
		{
			_xml = value;
		}
	}
}