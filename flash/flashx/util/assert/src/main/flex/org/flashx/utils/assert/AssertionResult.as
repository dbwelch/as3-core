package org.flashx.utils.assert {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
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
	}
}