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
		*	a target object. This method uses a for loop so
		*	the properties must be enumerable in the source object.
		*	
		*	By default the merge logic works in strict mode, meaning
		*	that the target property is set only if the target has
		*	the corresponding property.
		*	
		*	Set strict to false when you want to merge into dynamic classes
		*	that can have any property set and you want all of the source
		*	properties merged into the target dynamic class.
		*	
		*	@param target The target object.
		*	@param source The source object.
		*	@param strict A boolean indicating whether we should
		*	be strict.
		*/
		public function merge(
			target:Object,
			source:Object,
			strict:Boolean = true ):void
		{
			if( target && source )
			{
				var z:String = null;
				for( z in source )
				{
					if( !strict || ( strict && target.hasOwnProperty( z ) ) )
					{
						target[ z ] = source[ z ];
					}
				}
			}
		}
	}
}