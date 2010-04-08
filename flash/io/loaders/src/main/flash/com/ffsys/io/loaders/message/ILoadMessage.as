package com.ffsys.io.loaders.message {
	
	import com.ffsys.core.IStringIdentifier;
	
	/**
	*	Describes the methods and properties
	*	available to instances that encapsulate a
	*	<code>message</code> to be displayed
	*	while loading a resource.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.09.2007
	*/
	public interface ILoadMessage
		extends ILoadMessageFormatter,
		 		IStringIdentifier {
		
		/**
		*	The <code>String</code> message assigned
		*	to this instance.
		*/
		function set message( val:String ):void;
		function get message():String;
		
		/**
		*	An <code>ILoadMessageFormatter</code>
		*	reference that should be used to perform
		*	formatting of the message.
		*/
		function set formatter( val:ILoadMessageFormatter ):void;
		function get formatter():ILoadMessageFormatter;
		
		/**
		*	Determines whether a <code>message</code> has
		*	been assigned to this instance.
		*	
		*	@return A <code>Boolean</code> indicating
		*	whether a <code>message</code> has been assigned.
		*/
		function hasMessage():Boolean;
		
		/* @deprecate */
		
		/**
		*	Creates an exact <code>clone</code>
		*	of this instance.
		*	
		*	@return The cloned instance.
		*/
		function clone():ILoadMessage;
	}
}