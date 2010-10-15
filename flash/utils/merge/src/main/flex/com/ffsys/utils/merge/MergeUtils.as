package com.ffsys.utils.merge {
	
	import com.ffsys.utils.array.ArrayUtils;
	import com.ffsys.utils.object.ClassUtils;
	
	/**
	*	Utility methods for merging
	*	<code>IMergable</code> instances.
	*	
	*	@see com.ffsys.utils.IMergable
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Kelvin Luck
	*/	
	public class MergeUtils {
		
		/**
		*	Deals with recursively merging two <code>IMergable</code> instances.
		* 
		* 	@param source The source object. Any properties
		*	which are set on this object will
		* 	overwrite (or merge with if the property
		*	value is <code>IMergable</code>) the properties
		*	on the dest object.
		*	
		* 	@param dest The destination object.
		*	
		* 	@return The destination object after the merge has occured.
		*/	
		static public function simpleMerge( source:IMergable, dest:IMergable ):IMergable
		{
			if( typeof( dest ) != typeof( source ) )
			{
				//-->
				throw new Error( 'Trying to use MergeUtils.simpleMerge on two objects of different types!!' );
				return;
			}
			
			var publicProps:XML =
				ClassUtils.getPublicVariables( dest );
			
			var propName:String;
			var val:Object;
			var propNode:XML;
			
			for each ( propNode in publicProps.children() )
			{
				propName = propNode.@name;
				val = source[propName];

				if( !ArrayUtils.contains( dest.mergeExcludedProperties, propName ) )
				{
								
					if( val == null )
					{
						// leave dest as is...
					}else if ( dest[ propName ] == null )
					{
						dest[ propName ] = val;
					}else if( ClassUtils.isSimplePrimitive( val ) )
					{
						dest[ propName ] = val;
					}else if( val is IMergable )
					{
						dest[ propName ] =
							( val as IMergable ).mergeInto( dest[ propName ] );
					}else if( val is Array )
					{
						dest[ propName ].concat( val );
					}else
					{
						dest[ propName ] = val;
					}
					
				}
			}
			
			return dest;
		}
	}
}