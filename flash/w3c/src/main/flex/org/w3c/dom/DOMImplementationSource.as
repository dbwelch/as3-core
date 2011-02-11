package org.w3c.dom
{
	/**
	* 	Represents an implementation source.
	* 
	* 	This interface permits a DOM implementer
	* 	to supply one or more implementations,
	* 	based upon requested features and versions.
	* 	Each implemented DOMImplementationSource
	* 	object is listed in the binding-specific
	* 	list of available sources so that its
	* 	DOMImplementation objects are made available.
	*/
	public interface DOMImplementationSource
	{
		/**
		* 	A method to request the first DOM
		* 	implementation that supports the
		* 	specified features.
		* 
		* 	@param features A string that specifies
		* 	which features and versions are required.
		* 	This is a space separated list in which
		* 	each feature is specified by its name
		* 	optionally followed by a space and a version
		* 	number. This method returns the first item of
		* 	the list returned by getDOMImplementationList.
		* 	As an example, the string "XML 3.0 Traversal +Events 2.0"
		* 	will request a DOM implementation that supports the
		* 	module "XML" for its 3.0 version, a module that
		* 	support of the "Traversal" module for any version,
		* 	and the module "Events" for its 2.0 version.
		* 
		* 	The module "Events" must be accessible using the
		* 	method Node.getFeature() and DOMImplementation.getFeature().
		* 
		* 	@return The first DOM implementation that
		* 	support the desired features, or null if
		* 	this source has none.
		*/
		function getDOMImplementation(
			features:String ):DOMImplementation;
			
		/**
		* 	A method to request a list of DOM
		* 	implementations that support the
		* 	specified features and versions.
		* 
		* 	@param features A string that specifies which
		* 	features and versions are required.
		* 	This is a space separated list in which each
		* 	feature is specified by its name optionally
		* 	followed by a space and a version number.
		* 	This is something like: "XML 3.0 Traversal +Events 2.0".
		* 
		* 	@return A list of DOM implementations that
		* 	support the desired features.
		*/
		function getDOMImplementationList(
			features:String ):DOMImplementationList;
	}
}