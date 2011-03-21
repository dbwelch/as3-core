package org.flashx.core {
	
	/**
	*	Describes the contract for instances that maintain
	*	an <code>action</code> property.
	* 
	*	<pre>
	* 		This is some pre text.
	* 	</pre>
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.12.2007
	*/
	public interface IAction {
		
		/**
		*	An <code>action</code> associated <em>with</em> this instance.
		*/		
		function set action( val:String ):void;
		function get action():String;
	}	
}