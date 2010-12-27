package com.ffsys.swat.configuration.rsls
{
	import com.ffsys.io.loaders.core.*;
	
	import com.ffsys.swat.configuration.IPaths;	
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	
	/**
	*	Encapsulates the resources for a component definition.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.12.2010
	*/
	dynamic public class ComponentResource extends ResourceCollection
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
		* 	Gets a loader queue for the resources associated with this
		* 	component.
		* 
		* 	@return A loader queue for all the resources
		*/
		override public function getLoaderQueue(
			paths:IPaths = null,
			locale:IConfigurationLocale = null ):ILoaderQueue
		{
			var queue:ILoaderQueue = super.getLoaderQueue();
			
			/*
			trace("ComponentResource::getLoaderQueue()", "CHECKING COMPOSITE QUEUES",
				this.rsls, this.beans, this.css, this.xml );
			*/
			
			if( this.rsls != null )
			{
				queue.addLoader( this.rsls.getLoaderQueue() );
			}
			
			if( this.beans != null )
			{
				queue.addLoader( this.beans.getLoaderQueue() );
			}
			
			if( this.css != null )
			{
				queue.addLoader( this.css.getLoaderQueue() );
			}
			
			if( this.xml != null )
			{
				queue.addLoader( this.xml.getLoaderQueue() );
			}
			
			/*
			var loaders:Array = queue.getAllLoaders();
			for( var i:int = 0;i < loaders.length;i++ )
			{
				trace("ComponentResource::getLoaderQueue()", loaders[ i ], ILoader( loaders[ i ] ).uri );
			}
			*/
			
			return queue;
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