package com.ffsys.core.processor {
	
	/**
	*	<code>IProcessor</code> implementation that
	*	looks up target <code>Object</code> instances
	*	using public member variables.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.09.2007
	*/
	public class PropertyProcessor extends AbstractProcessor
		implements IPropertyProcessor {
			
		/**
		*	@private	
		*/
		protected var _parameters:Array;
		
		/**
		*	@private
		*	
		*	The <code>String</code> property name
		*	at the current position.
		*/
		protected var _property:String;
		
		/**
		*	Creates a <code>PropertyProcessor</code>
		*	instance.
		*/
		public function PropertyProcessor()
		{
			super();
			_parameters = new Array();
		}
		
		/**
		*	@inheritDoc
		*/
		public function set property( val:String ):void
		{
			_property = val;
		}
		
		public function get property():String
		{
			return _property;
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
		
		/**
		*	@inheritDoc
		*/
		public function get nextTarget():Object
		{
			return currentTarget[ property ];
		}		
		
		/**
		*	@inheritDoc
		*/
		public function hasProperty():Boolean
		{
			return Object( currentTarget ).hasOwnProperty( property );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function process( index:int = 0 ):*
		{
			if( index > ( length - 1 ) )
			{
				return false;
			}
			
			super.process( index );
		}	
	}	
}