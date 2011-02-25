package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.*;
		
	import com.ffsys.w3c.dom.DOMImplementationSourceImpl;	
	import com.ffsys.w3c.dom.support.AbstractNodeProxyImpl;	
	
	import org.w3c.dom.*;
	import org.w3c.dom.DOMImplementationSource;
	
	/**
	* 	@inheritDoc
	*/
	public class DOMImplementationRegistry extends AbstractNodeProxyImpl
		implements DOMImplementationSource
	{
		/**
		* 	The bean name for a DOM registry.
		*/
		public static const NAME:String = "dom-registry";
		
		/**
		* 	@private
		*/
		static private var _bootstrap:DOMBootstrap;
		
		/**
		* 	@private
		*/
		static private var __sources:Vector.<DOMImplementationSource> =
			new Vector.<DOMImplementationSource>();
		
		/**
		* 	Creates a <code>DOMImplementationRegistry</code> instance.
		*/
		public function DOMImplementationRegistry()
		{
			super();
		}
		
		/**
		* 	Register an implementation.
		* 
		* 	@param source The source to be registered, may not be null.
		*/
		public function addSource( source:DOMImplementationSource ):void
		{
			if( source != null
				&& __sources.indexOf( source ) == -1 )
			{
				__sources.push( source );
			}
		}
	
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementation( features:String ):DOMImplementation
		{
			var src:Vector.<DOMImplementationSource> = __sources;
			if( src != null )
			{
				var source:DOMImplementationSource = null;
				var impl:DOMImplementation = null;
				for( var i:int = 0;i < src.length;i++ )
				{
					source = src[ i ];
					impl = source.getDOMImplementation( features );
					
					//trace("DOMImplementationRegistry::getDOMImplementation()", impl );
					
					if( impl != null )
					{
						/*
						trace("[FOUND IMPLEMENTATION] DOMImplementationRegistry::getDOMImplementation()",
							features, beanName, document, src, impl );
						*/
							
						return impl;
					}
				}			
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementationList( features:String ):DOMImplementationList
		{
			var output:DOMImplementationList = null;
			return output;
		}
		
		/**
		* 	Retrieves the bootstrap bean document.
		* 	
		* 	Upon retrieval, if no bootstrap bean document
		* 	has been explicitly set, a default document
		* 	is created and cached.
		*/
		public static function get bootstrap():DOMBootstrap
		{
			if( _bootstrap == null )
			{
				_bootstrap = new DOMBootstrap();
			}
			return _bootstrap;
		}
		
		public static function set bootstrap( value:DOMBootstrap ):void
		{
			_bootstrap = value;
		}
		
		/**
		*	 Obtain a new instance of a DOMImplementationRegistry.
		* 
		* 	The DOMImplementationRegistry is initialized by the application
		* 	or the implementation, depending on the context, by first
		* 	checking the value of the Java system property
		* 	org.w3c.dom.DOMImplementationSourceList and the the service
		* 	provider whose contents are at "META_INF/services/org.w3c.dom.DOMImplementationSourceList".
		* 	The value of this property is a white-space separated list
		* 	of names of availables classes implementing the DOMImplementationSource
		* 	interface. Each class listed in the class name list is instantiated
		* 	and any exceptions encountered are thrown to the application.
		* 
		* 	@throws ClassNotFoundException If any specified class can not be found.
		* 	@throws InstantiationException If any specified class is an interface or abstract class.
		* 	@throws IllegalAccessException If the default constructor of a specified class is not accessible.
		* 	@throws ClassCastException If any specified class does not implement DOMImplementationSource.
		* 
		* 	@return An initialized instance of DOMImplementationRegistry.
		*/
		public static function newInstance():DOMImplementationRegistry
		{
			var bean:Object = bootstrap.getBean( NAME );
				
			var registry:DOMImplementationRegistry = DOMImplementationRegistry( bean );
			
			//TODO: add source(s) dynamically from system properties etc.
				
			var source:DOMImplementationSource = DOMImplementationSource( bootstrap.getBean(
				DOMImplementationSourceImpl.NAME ) );
			registry.addSource( source );
			
			return registry;
		}
	}
}