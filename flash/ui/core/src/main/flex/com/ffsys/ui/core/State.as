package com.ffsys.ui.core {
	
	import com.ffsys.core.IDestroy;
	
	/**
	*	Encapsulates constants that refer to common states
	*	for components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public class State extends Object
		implements IDestroy {
		
		/**
		* 	The delimiter used to delimit multiple state definitions.
		*/
		public static const DELIMITER:String = ":";		
		
		/**
		*	The main state for the component.
		*	
		*	This is considered the up state for buttons.
		*/
		public static const MAIN:State = new State( "main" );
		
		/**
		*	Represents a mouse over state.
		*/
		public static const OVER:State = new State( "over" );
		
		/**
		*	Represents a mouse out state.
		*/
		public static const OUT:State = new State( "out" );
		
		/**
		*	Represents a mouse down state.
		*/
		public static const DOWN:State = new State( "down" );
		
		/**
		*	Represents a selected state.
		*/
		public static const SELECTED:State = new State( "selected" );
		
		/**
		*	Represents a focused state.
		*/
		public static const FOCUSED:State = new State( "focused" );
	
		/**
		*	Represents a disabled state.
		*/
		public static const DISABLED:State = new State( "disabled" );
		
		/**
		* 	@private
		*/
		private var _parts:Array = null;
		
		/**
		* 	Creates a <code>State</code> instance.
		* 
		* 	@param state The primary state.
		* 	@param identifiers Any additional state identifiers.
		*/
		public function State( state:String = null, ...identifiers )
		{
			super();
			if( state != null || identifiers.length > 0 )
			{
				identifiers.unshift( state );
				this.setState.apply( this, identifiers );
			}
		}
		
		/**
		* 	Gets a string representation of this state.
		*/
		public function toStateString():String
		{
			if( _parts == null )
			{
				return null;
			}
			return _parts.join( DELIMITER );
		}
		
		/**
		* 	Sets the state string elements.
		* 
		* 	@param state The primary state.
		* 	@param identifiers Any additional state identifier strings.
		*/
		public function setState( state:String, ...identifiers ):Array
		{
			_parts = new Array();
			if( state != null )
			{
				_parts.push( state );
			}
			if( identifiers.length > 0 )
			{
				_parts = _parts.concat( identifiers );
			}
			return _parts;
		}
		
		/**
		* 	Cleans composite references.
		*/
		public function destroy():void
		{
			_parts = null;
		}
	}
}