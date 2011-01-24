package com.ffsys.dom
{
	/**
	*	Represents an entity reference.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class EntityReference extends Node
	{
		/**
		* 	Creates an <code>EntityReference</code> instance.
		*/
		public function EntityReference( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return Node.ENTITY_REFERENCE_NODE;
		}
	}
}