package org.flashx.utils.display {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	*	Utility methods for working with
	*	instances on the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class DisplayUtils extends Object {
		
		/**
		*	@private
		*/
		public function DisplayUtils()
		{
			super();
		}

		/**
		*	Recursively finds <code>DisplayObject</code> instances
		*	that are of a given <code>Class</code>.	
		*	
		*	@param parent The <code>DisplayObjectContainer</code> to start the search from.
		*	@param classReference The <code>Class</code> to test against.
		*	@param output An optional output <code>Array</code>.
		*	
		*	@return An <code>Array</code> of all the
		*	<code>DisplayObject</code> instances that are of
		*	type <code>classReference</code>.
		*/
		static public function getChildObjectsByClass(
			parent:DisplayObjectContainer,
			classReference:Class,
			output:Array = null ):Array
		{
			if( !output )
			{
				output = new Array();
			}
			
			var i:int = 0;
			var l:int = parent.numChildren;
			
			var child:DisplayObject;
			
			for( ;i < l;i++ )
			{
				child = parent.getChildAt( i );
				
				if( child is classReference )
				{
					output.push( child );
				}
				
				if( child is DisplayObjectContainer )
				{
					getChildObjectsByClass(
						child as DisplayObjectContainer, classReference, output );
				}
			}
			
			return output;
		}
	}
}