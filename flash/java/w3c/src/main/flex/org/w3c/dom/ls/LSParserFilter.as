package org.w3c.dom.ls
{
	
	/**
	* 	LSParserFilter(s) provide applications the ability to
	* 	examine nodes as they are being constructed while parsing.
	* 
	* 	<p>As each node is examined, it may be modified or removed, or
	* 	the entire parse may be terminated early.</p>
	* 
	* 	<p>At the time any of the filter methods are called by
	* 	the parser, the owner Document and DOMImplementation objects
	* 	exist and are accessible. The document element is never
	* 	passed to the LSParserFilter methods, i.e. it is not
	* 	possible to filter out the document element. Document,
	* 	DocumentType, Notation, Entity, and Attr nodes are never
	* 	passed to the acceptNode method on the filter. The child
	* 	nodes of an EntityReference node are passed to the filter if
	* 	the parameter "entities" is set to false. Note that, as
	* 	described by the parameter " entities", unexpanded entity
	* 	reference nodes are never discarded and are always
	* 	passed to the filter.</p>
	* 
	* 	<p>All validity checking while parsing a document occurs on
	* 	the source document as it appears on the input stream,
	* 	not on the DOM document as it is built in memory.
	* 	With filters, the document in memory may be a subset of
	* 	the document on the stream, and its validity may have
	* 	been affected by the filtering.</p>
	* 
	* 	<p>All default attributes must be present on elements when
	* 	the elements are passed to the filter methods.
	* 	All other default content must be passed to the filter methods.</p>
	* 
	* 	<p>DOM applications must not raise exceptions in a filter.
	* 	The effect of throwing exceptions from a filter is DOM
	* 	implementation dependent.</p>
	* 
	* 	<p>See also the Document Object Model (DOM) Level 3 Load and Save Specification.</p>
	*/
	public interface LSParserFilter
	{
	
	}
}