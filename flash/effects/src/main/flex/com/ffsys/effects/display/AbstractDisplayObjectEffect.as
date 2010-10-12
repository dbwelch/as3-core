package com.ffsys.effects.display {

	import flash.display.DisplayObject;
	
	import com.ffsys.effects.AbstractObjectEffect;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Abstract base class for DisplayObject effects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class AbstractDisplayObjectEffect extends AbstractObjectEffect {
	
		protected var _displayObject:DisplayObject;
		
		public function AbstractDisplayObjectEffect( displayObject:DisplayObject, properties:Array )
		{
			super( properties );
			this.displayObject = displayObject;
		}
		
		public function set displayObject( val:DisplayObject ):void
		{
			_displayObject = val;
		}
		
		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		override public function toString():String
		{
			var options:ObjectInspectorOptions = new ObjectInspectorOptions();
			var output:ObjectInspector = new ObjectInspector( this, options );
			output.composites = [ displayObject ];
			return output.getComplexInspection();
		}
		/* END OBJECT_INSPECTOR REMOVAL */
		
	}
	
}
