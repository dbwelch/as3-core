package com.ffsys.core.processor {
	
	import com.ffsys.core.IQueryPosition;
	import com.ffsys.core.processor.IProcessor;
	
	/**
	*	Encapsulates information containing the state
	*	of a processor pass.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.09.2007
	*/
	public class AbstractProcessorState extends Object
		implements 	IProcessorState {
		
		/**
		*	@private
		*	
		*	The processor that this state is representing.
		*/
		protected var _processor:IProcessor;
		
		/**
		*	@private
		*	
		*	The current position for this processing pass.
		*/
		protected var _position:int;
		
		/**
		*	@private
		*	
		*	The total number of items to be processed.
		*/
		protected var _length:int;
		
		/**
		*	Creates an <code>AbstractProcessorState</code>
		*	instance.
		*	
		*	@param processor The <code>IProcessor</code>
		*	implementation that created this state.
		*/
		public function AbstractProcessorState(
			processor:IProcessor )
		{
			super();
			this.processor = processor;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set processor( val:IProcessor ):void
		{
			_processor = val;
			_position = ( processor as IQueryPosition ).position;
			_length = processor.length;
		}
		
		public function get processor():IProcessor
		{
			return _processor;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set rootTarget( val:Object ):void
		{
			_processor.rootTarget = val;
		}
		
		public function get rootTarget():Object
		{
			return _processor.rootTarget;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set currentTarget( val:Object ):void
		{
			_processor.currentTarget = val;
		}
		
		public function get currentTarget():Object
		{
			return _processor.currentTarget;
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
			return ( position == ( length - 1 ) );
		}
		
		/**
		*	@inheritDoc
		*/		
		public function isFinished():Boolean
		{
			return _processor.isFinished();
		}
		
		/**
		*	@inheritDoc
		*/
		public function reset():void
		{
			_processor.reset();
		}
		
		/**
		*	@inheritDoc
		*/		
		public function start():void
		{
			_processor.start();
		}	
		
		/**
		*	@inheritDoc
		*/		
		public function next():void
		{
			_processor.next();
		}
		
		/**
		*	@inheritDoc
		*/		
		public function finish():void
		{
			_processor.finish();
		}
	}	
}