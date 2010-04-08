package com.ffsys.utils.reflection {
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;	
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Represents a super class in a reflection hierarchy.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class SuperClass extends AbstractReflection {
		
		public function SuperClass()
		{
			super();
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function toObjectString():String
		{
			if( !getClass() )
			{
				return super.toString();
			}
			
			return getSanitizedToString( getClass().toString() );
			
			var output:ObjectInspector = new ObjectInspector( this );
			output.detail = getClass();
			return output.getComplexInspection();
		}
		/* END OBJECT_INSPECTOR REMOVAL */
		
	}
	
}
