package com.ffsys.w3c.dom
{
	import org.w3c.dom.Element;
	import org.w3c.dom.NodeList;
	import org.w3c.dom.NodeSelector;

	/**
	* 	An implementation of the NodeSelector interface that
	* 	can be used as a decorator by the concrete implementations
	* 	that must adhere to this contract.
	*/
	public class NodeSelectorImpl extends Object
		implements NodeSelector
	{
		/**
		* 	Creates a <code>NodeSelectorImpl</code> instance.
		*/
		public function NodeSelectorImpl()
		{
			super();
		}
		
		/**
		* 	@private
		* 
		* 	Extracts the reference nodes into a node
		* 	list using the algorithm described by the specification.
		* 
		*	The steps to determine contextual reference nodes are as follows:
		* 
		* 	<ol>
		* 		<li>Let input be the value that is being processed, if any.</li>
		* 		<li>Let result be an intially empty collection of Element nodes.</li>
		*		<li>If the input is an Element node, then that append that element to the result collection.</li>
		*		<li>If input is a NodeList or HTMLCollection, then append each Element node contained within it to the result collection.</li>
		*		<li>If input is an Array or other object with indexable properties, then iterate through input to find and append each Element node contained within it to the result collection.</li>
		*		<li>If results is still an empty collection and the context node is an Element node, append the context node to the result collection.</li>
		*		<li>Otherwise, if results is still an empty collection and the context node is a Document node, then append the documentElement of the given document, if any, to the result collection.</li>
		* 		<li>Return result.</li>
		* 	</ol>
		*/
		protected function extractElementNodes( referenceNodes:Array ):NodeList
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function querySelector(
			selectors:String, ...referenceNodes ):Element
		{
			//TODO
			return null;
		}
			
		/**
		* 	@inheritDoc
		*/
		public function querySelectorAll(
			selectors:String, ...referenceNodes ):NodeList
		{
			//TODO
			return null;			
		}
			
		/**
		* 	@inheritDoc
		*/
		public function queryScopedSelector(
			selectors:String ):Element
		{
			//TODO
			return null;			
		}
			
		/**
		* 	@inheritDoc
		*/
		public function queryScopedSelectorAll(
			selectors:String ):NodeList
		{
			//TODO
			return null;
		}
	}
}