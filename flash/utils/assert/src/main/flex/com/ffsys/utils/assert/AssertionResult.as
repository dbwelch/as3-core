package com.ffsys.utils.assert {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;	
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Represents the result of running an individual
	*	assertion.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.12.2007
	*/
	public class AssertionResult extends EventDispatcher
		implements IAssertionResult {
			
		/**
		*	@private	
		*/
		protected var _date:Date;
		
		/**
		*	@private
		*	
		*	The name of the method that was invoked
		*	to perform the assertion.
		*/		
		protected var _methodName:String;
		
		/**
		*	@private
		*	
		*	The parameters passed to the method
		*	that was invoked to perform the assertion.
		*/		
		protected var _parameters:Array;
		
		/**
		*	Creates an <code>AssertionResult</code> instance.
		*	
		*	@param methodName The assertion method name that was
		*	invoked to perform the assertion.
		*	@param parameters The parameters passed to the method
		*	that was invoked to perform the assertion.
		*/
		public function AssertionResult(
			methodName:String = "", parameters:Array = null )
		{
			super();
			
			_date = new Date();
			
			if( !parameters )
			{
				parameters = new Array();
			}
			
			this.methodName = methodName;
			this.parameters = parameters;
		}
		
		/**
		*	The <code>date</code> this assertion
		*	result was created.
		*/
		public function get date():Date
		{
			return _date;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set methodName( val:String ):void
		{
			_methodName = val;
		}
		
		public function get methodName():String
		{
			return _methodName;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set parameters( val:Array ):void
		{
			_parameters = val;
		}
		
		public function get parameters():Array
		{
			return _parameters;
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		
		/**
		*	@private	
		*/		
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		/**
		*	@private	
		*/
		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			output.methodName = methodName;
			//output.parameters = parameters;
			return output;
		}

		/**
		*	@private	
		*/
		public function getCommonStringOutputComposites():Array
		{
			var output:Array = new Array();
			return output;
		}

		/**
		*	@private	
		*/
		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}

		/**
		*	@private	
		*/
		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}

		/**
		*	@private	
		*/
		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
			
			output.detail = date;
			
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		/**
		*	@private	
		*/		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}

		/**
		*	Gets a <code>String</code> representation
		*	of this instance.
		*	
		*	@return The <code>String</code>
		*	representation of this instance.
		*/
		override public function toString():String
		{
			return getObjectString( true );
		}		
		/* END OBJECT_INSPECTOR REMOVAL */
	}
	
}
