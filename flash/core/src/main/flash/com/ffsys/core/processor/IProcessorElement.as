package com.ffsys.core.processor {
	
	/**
	*	Describes functionality common to
	*	the <code>IProcessor</code> and
	*	<code>IProcessorState</code> interfaces.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.09.2007
	*/
	public interface IProcessorElement
		extends IProcessorStateQuery {
		
		/**
		*	The root target <code>Object</code> that processing
		*	should begin from.
		*/
		function set rootTarget( val:Object ):void;
		function get rootTarget():Object;
		
		/**
		*	The current target <code>Object</code> the processor
		*	is operating on.
		*/
		function set currentTarget( val:Object ):void;
		function get currentTarget():Object;
		
		/**
		*	The number of items to be processed.	
		*/
		function set length( val:int ):void;
		function get length():int;
		
		function set position( val:int ):void;
		/* function get position():int; */
		
		/**
		*	Instructs the processor to move on to the next item
		*	to be processed.
		*/		
		function next():void;
		
		/**
		*	Instructs the processor to finish, bypassing any items
		*	that have not been processed.
		*/		
		function finish():void;
		
		/**
		*	Resets the processor ready to start.
		*/
		function reset():void;
		
		/**
		*	Instructs the instance to start processing.	
		*/
		function start():void;	
	}
}