package com.ffsys.ui.dom
{

	public class EntityReference extends Node
	{
		
		/**
		* 	Creates an <code>EntityReference</code> instance.
		*/
		public function EntityReference( xml:XML = null )
		{
			_nodeType = Node.ENTITY_REFERENCE_NODE;
			super( xml );
		}
	}
}