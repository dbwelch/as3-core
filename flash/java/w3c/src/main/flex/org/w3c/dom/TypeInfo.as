package org.w3c.dom
{
	
	/**
	* 	Represents type information.
	* 
	* 	The TypeInfo interface represents a
	* 	type referenced from Element or Attr nodes,
	* 	specified in the schemas associated with
	* 	the document. The type is a pair of a
	* 	namespace URI and name properties, and
	* 	depends on the document's schema.
	*
	*	If the document's schema is an XML DTD [XML 1.0],
	* 	the values are computed as follows:
	* 
	* 	<ul>
	* 		<li>If this type is referenced from an Attr node,
	* 		typeNamespace is "http://www.w3.org/TR/REC-xml"
	* 		and typeName represents the [attribute type] property
	* 		in the [XML Information Set]. If there is no
	* 		declaration for the attribute, typeNamespace
	* 		and typeName are null.</li>
	* 		<li>If this type is referenced from an Element node,
	* 		typeNamespace and typeName are null.</li>
	* 	</ul>
	* 
	* 	If the document's schema is an XML Schema
	* 	[XML Schema Part 1] , the values are computed as
	* 	follows using the post-schema-validation
	* 	infoset contributions (also called PSVI contributions):
	* 
	* 	<ul>
	* 		<li>If the [validity] property exists AND is "invalid"
	* 			or "notKnown": the {target namespace} and {name}
	* 			properties of the declared type if available, otherwise null.
	*			Note: At the time of writing, the XML Schema specification
	* 			does not require exposing the declared type.
	* 			Thus, DOM implementations might choose not to provide type
	* 			information if validity is not valid.</li>
	* 		<li>If the [validity] property exists and is "valid": TODO</li>
	* 	</ul>
	*/
	public interface TypeInfo
	{
		/**
		* 	The name of a type declared for the
		* 	associated element or attribute,
		* 	or null if unknown.
		*/
		function get typeName():String;
		
		/**
		* 	The namespace of the type declared for
		* 	the associated element or attribute or
		* 	null if the element does not have declaration
		* 	or if no namespace information is available.
		*/
		function get typeNamespace():String;
		
		/**
		* 	This method returns if there is a derivation
		* 	between the reference type definition, i.e. the
		* 	TypeInfo on which the method is being called,
		* 	and the other type definition, i.e. the one
		* 	passed as parameters.
		* 	
		* 	@param typeNamespaceArg The namespace of the other
		* 	type definition.
		* 	@param typeNameArg The name of the other type definition.
		* 	@param derivationMethod The type of derivation and
		* 	conditions applied between two types, as described
		* 	in the list of constants provided in this interface.
		* 
		* 	@return If the document's schema is a DTD or
		* 	no schema is associated with the document,
		* 	this method will always return false. If the
		* 	document's schema is an XML Schema, the method
		* 	will true if the reference type definition is derived
		* 	from the other type definition according to the derivation
		* 	parameter. If the value of the parameter is 0
		* 	(no bit is set to 1 for the derivationMethod parameter),
		* 	the method will return true if the other type definition
		* 	can be reached by recursing any combination of 
		* 	{base type definition}, {item type definition},
		* 	or {member type definitions} from the reference type definition.
		*/
		function isDerivedFrom(
			typeNamespaceArg:String,
			typeNameArg:String,
			derivationMethod:int ):Boolean;
	}
}