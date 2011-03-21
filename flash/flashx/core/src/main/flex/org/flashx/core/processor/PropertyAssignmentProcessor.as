package org.flashx.core.processor
{
	
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Responsible for locating a property by string
	* 	path and assigning a value to the property.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.01.2011
	*/
	public class PropertyAssignmentProcessor extends AddressPathProcessor
	{
		private var _value:*;
		
		/**
		* 	Creates a <code>PropertyAssignmentProcessor</code> instance.
		*/
		public function PropertyAssignmentProcessor(
			address:String = null,
			target:Object = null,
			value:* = null,
			delimiter:String = "." )
		{
			super( address, target, delimiter );
			this.value = value;
			this.async = false;
		}
		
		/**
		* 	The value to assign to the property.
		*/
		public function get value():*
		{
			return _value;
		}
		
		public function set value( value:* ):void
		{
			_value = value;
		}
		
		/**
		* 	Assigns the value to the located property
		* 	when processing is complete.
		*/
		protected function assignProperty():void
		{
			//the last target
			var target:Object = this.targets[ this.targets.length - 1 ];
			//the current property name
			var name:String = this.property;
			
			/*
			trace("PropertyAssignmentProcessor::assignProperty()",
				target,
				getQualifiedClassName( target ),
				name,
				this.value, target.hasOwnProperty( name ) );
			*/
			
			try
			{
				target[ name ] = this.value;
			}catch( e:Error )
			{
				//the property should exist if we got to this point
				//but there may be a coercion error
				throw e;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function process( index:int = 0 ):*
		{			
			//trace("PropertyAssignmentProcessor::process() PROCESSING INDEX ", index );
			
			super.process( index );
			
			//trace("PropertyAssignmentProcessor::process() length/index/position", this.completed, this.length, index, this.position, this.currentTarget, index > this.length - 1 );
			
			//
			if( completed )
			{
				assignProperty();
			}
			
			//not running asynchronously continue processing
			if( !isFinished() && !async )
			{
				//trace("PropertyAssignmentProcessor::process() CALLING NEXT ");
				next();
			}			
		}			
	}
}