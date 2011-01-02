package com.ffsys.core.processor {
	
	/**
	*	Super class for <code>IProcessor</code>
	*	implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.09.2007
	*/
	public class AbstractProcessor extends Object
		implements IProcessor {
			
		/**
		*	@private	
		*/
		protected var _parameters:Array;			
			
		/**
		*	@private	
		*/
		protected var _length:int;
		
		/**
		*	@private	
		*/
		protected var _position:int;
		
		/**
		*	@private	
		*/
		protected var _rootTarget:Object;
		
		/**
		*	@private	
		*/
		protected var _currentTarget:Object;
		
		/**
		*	@private
		*	
		*	The <code>String</code> property name
		*	at the current position.
		*/
		protected var _property:String;		
		
		private var _async:Boolean = true;
		
		private var _strict:Boolean = false;
		
		private var _targets:Vector.<Object> = new Vector.<Object>();
		
		/**
		*	Creates an <code>AbstractProcessor</code> instance.
		* 
		* 	@param target The target to start processing from.
		*/
		public function AbstractProcessor( target:Object = null )
		{
			super();
			this.rootTarget = target;
			_position = 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get async():Boolean
		{
			return _async;
		}
		
		public function set async( value:Boolean ):void
		{
			_async = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get strict():Boolean
		{
			return _strict;
		}

		public function set strict( value:Boolean ):void
		{
			_strict = value;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get targets():Vector.<Object>
		{
			return _targets;
		}
		
		/**
		*	The root target object to start processing from.
		*/		
		public function set rootTarget( val:Object ):void
		{
			_rootTarget = val;
			_currentTarget = val;
		}
		
		public function get rootTarget():Object
		{
			return _rootTarget;
		}
		
		/**
		*	The current target being processed.
		*/		
		public function set currentTarget( val:Object ):void
		{
			_currentTarget = val;
		}
		
		public function get currentTarget():Object
		{
			return _currentTarget;
		}

		/**
		*	@inheritDoc	
		*/
		public function set length( val:int ):void
		{
			_length = val;
		}
		
		public function get length():int
		{
			return _length;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set position( val:int ):void
		{
			_position = val;
		}
		
		public function get position():int
		{
			return _position;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function isFirst():Boolean
		{
			return ( position == 0 );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function isLast():Boolean
		{
			return ( this.position >= ( this.length - 1 ) );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function isFinished():Boolean
		{
			return this.position == this.length;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function next():void
		{
			trace("AbstractProcessor::next()", this.position );
			process( this.position + 1 );
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
		public function finish():void
		{
			this.position = length;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function reset():void
		{
			this.position = 0;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function start():void
		{
			reset();
			process();
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
		public function hasProperty():Boolean
		{
			return Object( currentTarget ).hasOwnProperty( property );
		}				
		
		/**
		*	@inheritDoc	
		*/		
		public function restart( target:Object, targetPosition:int = 0 ):void
		{
			currentTarget = target;
			process( targetPosition );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get nextProperty():String
		{
			return null;
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
		
		private var _completed:Boolean = false;
		
		/**
		* 	Determines whether processing completed to the
		* 	end of the processing pass.
		*/
		public function get completed():Boolean
		{
			return ( isFinished() && this.targets.length == this.length );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function process( index:int = 0 ):*
		{
			if( index > ( length - 1 ) )
			{
				trace("AbstractProcessor::process()", "SETTING AS COMPLETE ON INDEX: ", index );
				_completed = true;
				position = length;
				return false;
			}
			
			if( index == 0 )
			{
				//push the initial root target
				_targets.push( rootTarget );
			}	
			
			//
			this.position = index;
			this.property = this.nextProperty;
			var previousTarget:Object = currentTarget;
			currentTarget = this.nextTarget;
			
			//only include up until and including the penultimate target
			if( index < ( length - 1 ) )
			{
				if( currentTarget == null )
				{
					if( strict )
					{
						throw new Error( "Could not locate a target for property '"
						 	+ this.property + " on '" + previousTarget + "'."  );
					}else{
						//nothing more to do no valid current target
						position = length;
						_completed = false;
						return;
					}
				}
				_targets.push( currentTarget );
			}
			
			trace("AbstractProcessor::process()", length, index, position, property, currentTarget );
			
			if( currentTarget is IProcessorNotification )
			{
				( currentTarget as IProcessorNotification ).processed( this );
			}
		}
	}
}