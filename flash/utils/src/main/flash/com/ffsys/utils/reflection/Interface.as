package com.ffsys.utils.reflection {
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Encapsulates an interface implemented by an instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.08.2007
	*/
	public class Interface extends AbstractReflection {
		
		public function Interface()
		{
			super();
		}
		
		public function getActionscriptString():String
		{
			return getClassName();
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function toObjectString():String
		{
			var options:ObjectInspectorOptions = new ObjectInspectorOptions();
			
			var output:ObjectInspector = new ObjectInspector( this, options );
			output.detail = getClass();
			return output.getComplexInspection();
		}
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
