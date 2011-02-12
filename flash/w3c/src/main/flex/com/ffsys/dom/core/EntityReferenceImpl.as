package com.ffsys.dom.core
{
	import org.w3c.dom.*;
		
	/**
	*	Represents an entity reference.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class EntityReferenceImpl extends NodeImpl
		implements EntityReference
	{
		/**
		* 	Creates an <code>EntityReferenceImpl</code> instance.
		*/
		public function EntityReferenceImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.ENTITY_REFERENCE_NODE;
		}
	}
}