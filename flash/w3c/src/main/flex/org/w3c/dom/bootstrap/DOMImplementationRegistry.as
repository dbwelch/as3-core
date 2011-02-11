package org.w3c.dom.bootstrap
{
	import org.w3c.dom.*;
	
	/**
	* 	A factory that enables applications to
	* 	obtain instances of DOMImplementation.
	*
	*	<p>Example:</p>
	*
	*	<pre>// get an instance of the DOMImplementation registry
	*	DOMImplementationRegistry registry = 
	* 	  DOMImplementationRegistry.newInstance();
	*	// get a DOM implementation the Level 3 XML module
	*	DOMImplementation domImpl =
	*	  registry.getDOMImplementation("XML 3.0");</pre>
	*
	*	<p>This provides an application with an implementation-independent
	* 	starting point. DOM implementations may modify this class
	* 	to meet new security standards or to provide *additional*
	* 	fallbacks for the list of DOMImplementationSources.</p>
	*/
	public class DOMImplementationRegistry extends Object
	{
		static private var _registry:DOMImplementationRegistry;
		
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
		* 	@param source The source to be registered, may
		* 	not be <code>null</code>.
		*/
		public function addSource( source:DOMImplementationSource ):void
		{
			//TODO
		}
	
		/**
		* 	Return the first implementation that has the desired
		* 	features, or <code>null</code> if none is found.
		* 
		* 	@param features A string that specifies which features
		*	are required. This is a space separated list in which
		*	each feature is specified by its name optionally
		* 	followed by a space and a version number. This is
		* 	something like: "XML 1.0 Traversal +Events 2.0".
		* 
		* 	@return An implementation that has the desired
		* 	features, or <code>null</code> if none was found.
		*/
		public function getDOMImplementation( features:String ):DOMImplementation
		{
			//TODO
			return null;			
		}
		
		/**
		* 	Return a list of implementations that support the desired features.
		* 
		* 	@param features A string that specifies which features are required.
		* 	This is a space separated list in which each feature is specified
		* 	by its name optionally followed by a space and a version number.
		* 	This is something like: "XML 1.0 Traversal +Events 2.0".
		* 
		* 	@return A list of DOMImplementations that support the desired features.
		*/
		public function getDOMImplementationList( features:String ):DOMImplementationList
		{
			//TODO
			return null;
		}
		
		/**
		* 	Obtain a new instance of a DOMImplementationRegistry.
		* 
		* 	The DOMImplementationRegistry is initialized by the
		* 	application or the implementation, depending on
		* 	the context, by first checking the value of the
		* 	Java system property org.w3c.dom.DOMImplementationSourceList
		* 	and the the service provider whose contents are at
		* 	"META_INF/services/org.w3c.dom.DOMImplementationSourceList".
		* 	The value of this property is a white-space separated list
		* 	of names of availables classes implementing the
		* 	DOMImplementationSource interface.
		* 	Each class listed in the class name list is
		* 	instantiated and any exceptions encountered are thrown
		* 	to the application.
		* 
		* 	@return An initialized instance of DOMImplementationRegistry.
		*/
		public static function newInstance():DOMImplementationRegistry
		{
			if( _registry == null )
			{
				_registry = new DOMImplementationRegistry();
			}
			return _registry;
		}
	}
}