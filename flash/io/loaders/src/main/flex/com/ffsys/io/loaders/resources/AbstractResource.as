package com.ffsys.io.loaders.resources {
	
	import flash.events.EventDispatcher;
	
	import com.ffsys.core.Destroyer;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.IObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Abstract super class for all loaded resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class AbstractResource extends EventDispatcher
		implements  IResource,
		 			IObjectInspector {
			
		private var _id:String;
		private var _data:Object;
		private var _uri:String;
		
		public function AbstractResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super();
			this.data = data;
			this.uri = uri;
			this.bytesTotal = bytesTotal;
		}
		
		public function destroy():void
		{
			_data = null;
			_uri = null;
			_id = null;
		}
		
		protected var _bytesTotal:uint;
		public function set bytesTotal( val:uint ):void
		{
			_bytesTotal = val;
		}
		
		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}
		
		public function set data( val:Object ):void
		{
			_data = val;
			
			//dispatchEvent(  );
		}		
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set uri( val:String ):void
		{
			_uri = val;
		}		
		
		public function get uri():String
		{
			return _uri;
		}
		
		public function set id( val:String ):void
		{
			_id = val;
		}		
		
		public function get id():String
		{
			return _id;
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}
		
		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			return output;
		}
		
		public function getCommonStringOutputComposites():Array
		{
			var output:Array = new Array();
			return output;
		}
		
		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}
		
		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}
		
		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			output.detail = uri;
			
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}

		override public function toString():String
		{
			return getObjectString( true );
		}
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
