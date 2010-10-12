package com.ffsys.effects.tween {
	
	/**
	*	Describes the contract for Tween instances that
	*	can be queried for status information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.08.2007
	*/
	public interface ITweenStatus {
	
		/**
		*	Sets whether the ITween is currently playing.
		*
		*	@param val a Boolean indicating whether the ITween is playing
		*/
		function set playing( val:Boolean ):void;	
		
		/**
		*	Determines whether the ITween is currently playing.
		*
		*	@return a Boolean indicating whether the ITween is playing
		*/
		function get playing():Boolean;
		
		/**
		*	Sets whether the ITween is currently complete.
		*
		*	@param val a Boolean indicating whether the ITween is complete
		*/
		function set complete( val:Boolean ):void;		
		
		/**
		*	Determines whether the ITween is complete.
		*
		*	@return a Boolean indicating whether the ITween is complete		
		*/		
		function get complete():Boolean;
		
		/**
		*	Sets whether the ITween is currently paused.
		*
		*	@param val a Boolean indicating whether the ITween is paused
		*/
		function set paused( val:Boolean ):void;		
		
		/**
		*	Determines whether the ITween is paused.
		*
		*	@return a Boolean indicating whether the ITween is paused		
		*/		
		function get paused():Boolean;
	}
	
}
