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
			return ( position >= ( length - 1 ) );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function isFinished():Boolean
		{
			return position > ( length - 1 );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function next():void
		{
			++this.position;
			process( this.position );
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
		public function restart( target:Object, targetPosition:int = 0 ):void
		{
			currentTarget = target;
			process( targetPosition );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function process( index:int = 0 ):*
		{
			//
			position = index;
			
			if( currentTarget is IProcessorNotification )
			{
				( currentTarget as IProcessorNotification ).processed( this );
			}
		}	
	}
}