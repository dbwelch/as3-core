package com.ffsys.utils.properties {
	
	/**
	*	Utility class for merging the properties of objects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class PropertiesMerge extends Object {
		
		/**
		*	Creates a <code>PropertiesMerge</code> instance.	
		*/
		public function PropertiesMerge()
		{
			super();
		}
		
		/**
		*	Merges the properties of a source object into
		*	a target object. This method copies the values from
		*	the source object only if the target object has the
		*	corresponding property. In addition, this method uses
		*	a for loop so the properties must be enumerable in the
		*	source object.
		*	
		*	@param target The target object.
		*	@param source The source object.
		*/
		public function merge(
			target:Object, source:Object ):void
		{
			if( target && source )
			{
				//trace("PropertiesMerge::merge()", target, source );
				
				var z:String = null;
				for( z in source )
				{
					//trace("PropertiesMerge::merge()", z );
					if( target.hasOwnProperty( z ) )
					{
						target[ z ] = source[ z ];
						//trace("PropertiesMerge::merged()", z , target[ z ], target );
					}
				}
			}
		}
	}
}