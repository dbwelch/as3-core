package com.ffsys.swat.configuration.rsls
{
	import com.ffsys.io.loaders.core.*;
	
	import com.ffsys.swat.configuration.IPaths;
	import com.ffsys.swat.configuration.IConfigurationElement;
	import com.ffsys.swat.configuration.locale.IConfigurationLocale;
	import com.ffsys.swat.core.IConfigurationAware;
	
	import com.ffsys.ioc.BeanManager;
	import com.ffsys.ioc.IBeanDocument;	
	import com.ffsys.ioc.IBeanManager;
	
	/**
	*	Encapsulates the resources for a component definition.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.12.2010
	*/
	dynamic public class ComponentResourceCollection extends ResourceCollection
		implements IConfigurationAware
	{
		private var _configuration:IConfigurationElement;
		
		private var _rsls:RslCollection;
		private var _beans:BeanCollection;
		private var _css:CssCollection;
		private var _xmlBeans:XmlBeanCollection;
		private var _beanManager:IBeanManager;
		
		/**
		* 	Creates a <code>ComponentResourceCollection</code> instance.
		*/
		public function ComponentResourceCollection()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfigurationElement
		{
			return _configuration;
		}
		
		public function set configuration( value:IConfigurationElement ):void
		{
			_configuration = value;
		}
		
		/**
		* 	A bean manager for this component.
		*/
		public function get beanManager():IBeanManager
		{
			if( _beanManager == null )
			{
				_beanManager = new BeanManager();
			}
			return _beanManager;
		}
		
		/**
		* 	The bean document containing the bean definitions
		* 	for the xml document.
		*/
		public function get document():IBeanDocument
		{
			return this.beanManager.document;
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
			//include any normal resource definitions as prerequisites
			var queue:ILoaderQueue = super.getLoaderQueue();
			
			//trace("ComponentResourceCollection::getLoaderQueue() original length:", queue.length );
			
			/*
			trace("ComponentResourceCollection::getLoaderQueue()", "CHECKING COMPOSITE QUEUES",
				this.rsls, this.beans, this.css, this.xmlBeans );
			*/
			
			//trace("ComponentResourceCollection::getLoaderQueue()", this.document, configuration, configuration.resources );
			
			//add a bean document xref to the component
			//bean document pointing to the main bean document
			if( this.document != null
				&& configuration != null
				&& configuration.resources != null
				&& configuration.resources.document != null )
			{		
				var main:IBeanDocument = configuration.resources.document;
				
				//main document xrefs
				this.document.xrefs.push( main );
				
				//TODO: check composite xrefs are available
				
				//copy composite xrefs
				for( var i:int = 0;i < main.xrefs.length;i++ )
				{
					this.document.xrefs.push( main.xrefs[ i ] );
				}
				
				/*
				trace("ComponentResourceCollection::getLoaderQueue(), ADDING BEAN DOCUMENT XREF!!!!",
					this.document, this.document.xrefs, this.document.xrefs.length );
				*/
			}
			
			//TODO: integrate with the bean manager so references are resolved
			
			if( this.rsls != null )
			{
				queue.addLoader(
					this.rsls.getLoaderQueue( paths, locale ) );
			}
			
			if( this.beans != null )
			{
				queue.addLoader(
					this.beans.getLoaderQueue( paths, locale ) );
			}
			
			if( this.css != null )
			{
				queue.addLoader(
					this.css.getLoaderQueue( paths, locale ) );
			}
			
			if( this.xmlBeans != null )
			{
				queue.addLoader(
					this.xmlBeans.getLoaderQueue( paths, locale ) );
			}
			
			/*
			var loaders:Array = queue.getAllLoaders();
			for( var i:int = 0;i < loaders.length;i++ )
			{
				trace("ComponentResourceCollection::getLoaderQueue()", loaders[ i ], ILoader( loaders[ i ] ).uri );
			}
			*/
			
			//trace("ComponentResourceCollection::getLoaderQueue() ultimate length:", queue.length, queue.id );
			
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
			if( value != null )
			{
				value.document = this.document;
			}			
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
		* 	The xml bean documents for this component.
		*/
		public function get xmlBeans():XmlBeanCollection
		{
			return _xmlBeans;
		}
		
		public function set xmlBeans( value:XmlBeanCollection ):void
		{
			_xmlBeans = value;
			if( value != null )
			{
				value.document = this.document;
			}
		}
	}
}