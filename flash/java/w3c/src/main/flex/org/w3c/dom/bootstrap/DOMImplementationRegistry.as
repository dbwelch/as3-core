/**
	<p>Defines the interface that allows a bootstrap process
	to examine available DOM implementations.</p>
*/
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
	public interface DOMImplementationRegistry
	{
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
		function getDOMImplementation( features:String ):DOMImplementation;
		
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
		function getDOMImplementationList( features:String ):DOMImplementationList;
	}
}