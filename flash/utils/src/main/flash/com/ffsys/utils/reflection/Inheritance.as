package com.ffsys.utils.reflection {
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Encapsulates the inheritance hierarchy of an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	dynamic public class Inheritance extends AbstractReflectionCollection {
		
		public function Inheritance()
		{
			super();
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector( this );
			output.detail = this.join( " > " );
			return output.getComplexInspection();
		}
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
