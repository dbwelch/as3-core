package com.ffsys.w3c.dom.bootstrap
{
	import org.w3c.dom.DOMImplementation;
	import org.w3c.dom.DOMImplementationList;
	import org.w3c.dom.DOMImplementationSource;
	
	/**
	* 	A registry for DOM implementations.
	*/
	public class DOMImplementationRegistry extends Object
		implements DOMImplementationSource
	{
		/**
		* 	The implementation registry singleton.
		*/
		static private var _registry:DOMImplementationRegistry;
		
		/**
		* 	@private
		*/
		private var _sources:Vector.<DOMImplementationSource> =
			new Vector.<DOMImplementationSource>();
		
		/**
		* 	@private
		* 	
		* 	Creates a <code>DOMImplementationRegistry</code> instance.
		* 
		* 	@param enforcer A reference to the private singleton enforcer class.
		*/
		public function DOMImplementationRegistry( enforcer:SingletonEnforcer )
		{
			super();
		}
		
		/**
		* 	Removes all registered sources.
		*/
		public function clear():void
		{
			_sources = new Vector.<DOMImplementationSource>();
		}
		
		/**
		* 	Register an implementation.
		* 
		* 	@param source The source to be registered, may not be null.
		*/
		public function addSource( source:DOMImplementationSource ):void
		{
			if( source != null
				&& _sources.indexOf( source ) == -1 )
			{
				_sources.push( source );
			}
		}
		
		/**
		* 	Retrieves the underlying collection of implementation
		* 	sources.
		* 
		* 	Modifying this collection will modify the sources represented
		* 	by this implementation registry and vice versa.
		*/
		public function get sources():Vector.<DOMImplementationSource>
		{
			return _sources;
		}
	
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementation( features:String ):DOMImplementation
		{
			var source:DOMImplementationSource = null;
			var impl:DOMImplementation = null;
			for( var i:int = 0;i < _sources.length;i++ )
			{
				source = _sources[ i ];
				impl = source.getDOMImplementation( features );
				if( impl != null )
				{	
					return impl;
				}
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getDOMImplementationList( features:String ):DOMImplementationList
		{
			var source:DOMImplementationSource = null;
			var impl:DOMImplementationList = null;
			for( var i:int = 0;i < _sources.length;i++ )
			{
				source = _sources[ i ];
				impl = source.getDOMImplementationList( features );
				if( impl != null )
				{	
					return impl;
				}
			}
			return null;			
		}
		
		/**
		*	Obtain a new instance of a DOMImplementationRegistry.
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
			if( _registry == null )
			{
				_registry = new DOMImplementationRegistry( new SingletonEnforcer() );
			}
			return _registry;
		}
	}
}
class SingletonEnforcer{};