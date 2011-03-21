package org.flashx.utils.byte {
	
	import flash.utils.ByteArray;
	
	/**
	*	Describes the contract for instances that
	*	store <code>Boolean</code> values at a
	*	bit level.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.12.2007
	*/
	public interface IBitStore {
		
		/**
		*	The underlying <code>ByteArray</code> used to
		*	store the bit flags.
		*/		
		function set bytes( val:ByteArray ):void;	
		function get bytes():ByteArray;
		
		/**
		*	The number of bytes used to store the
		*	bit flags.	
		*/		
		function set length( val:uint ):void;
		function get length():uint;
		
		/**
		*	Sets a bit at <code>index</code> to the
		*	value of <code>flag</code>.
		*	
		*	@param index The bit index.
		*	@param flag The new value for the bit.
		*/
		function setBitAt( index:int, flag:Boolean ):void;
		
		/**
		*	Gets a bit at a <code>index</code>.
		*	
		*	@param index The bit index.
		*	
		*	@return A <code>Boolean</code> indicating
		*	if the bit is set. 
		*/
		function getBitAt( index:int ):Boolean;
	}
}