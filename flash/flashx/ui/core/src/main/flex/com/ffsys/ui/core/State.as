package com.ffsys.ui.core {
	
	import com.ffsys.core.IDestroy;
	import com.ffsys.utils.array.UniqueArray;
	
	/**
	*	Encapsulates constants that refer to common states
	*	for components and provides a mechanism for concatenating
	* 	multiple state elements into a string representation.
	* 
	* 	This functionality is used when components retrieve
	* 	styles for a state.
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
		* 	The delimiter used to delimit multiple state elements.
		*/
		public static const DELIMITER:String = ":";		
		
		/**
		*	The identifier for the main state.
		*/
		public static const MAIN_ID:String = "main";

		/**
		*	The identifier for a mouse over state.
		*/
		public static const OVER_ID:String = "over";

		/**
		*	The identifier for a mouse out state.
		*/
		public static const OUT_ID:String = "out";

		/**
		*	The identifier for a mouse down state.
		*/
		public static const DOWN_ID:String = "down";

		/**
		*	The identifier for a selected state.
		*/
		public static const SELECTED_ID:String = "selected";

		/**
		*	The identifier for a focused state.
		*/
		public static const FOCUSED_ID:String = "focused";

		/**
		*	The identifier for a disabled state.
		*/
		public static const DISABLED_ID:String = "disabled";
		
		/**
		*	The main state for the component.
		*	
		*	This is considered the up state for buttons.
		*/
		public static const MAIN:State = new State( MAIN_ID );
		
		/**
		*	Represents a mouse over state.
		*/
		public static const OVER:State = new State( OVER_ID );
		
		/**
		*	Represents a mouse out state.
		*/
		public static const OUT:State = new State( OUT_ID );
		
		/**
		*	Represents a mouse down state.
		*/
		public static const DOWN:State = new State( DOWN_ID );
		
		/**
		*	Represents a selected state.
		*/
		public static const SELECTED:State = new State( SELECTED_ID );
		
		/**
		*	Represents a focused state.
		*/
		public static const FOCUSED:State = new State( FOCUSED_ID );
	
		/**
		*	Represents a disabled state.
		*/
		public static const DISABLED:State = new State( DISABLED_ID );
		
		/**
		* 	@private
		*/
		private var _parts:Array = null;
		private var _primary:String;
		private var _elements:Array;
		
		/**
		* 	Creates a <code>State</code> instance.
		* 
		* 	@param primary The primary state.
		* 	@param elements Any additional state elements.
		*/
		public function State( primary:String = null, elements:Array = null )
		{
			super();
			setStateElements( primary, elements );
		}
		
		/**
		* 	Gets a string representation of this state
		* 	with state elements separated by the <code>DELIMITER</code>.
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
		* 	Gets the state elements as an array.
		* 
		* 	@return An array of the state elements.
		*/
		public function getStateElements():Array
		{
			return _parts;
		}
		
		/**
		* 	Sets the state elements.
		* 
		* 	@param primary The primary state.
		* 	@param identifiers Any additional state elements.
		* 
		* 	@return An array of all the state elements.
		*/
		public function setState( primary:String, ...identifiers ):Array
		{
			_elements = identifiers;
			_parts = new Array();
			if( primary != null )
			{
				_parts.push( primary );
			}
			if( identifiers.length > 0 )
			{
				_parts = _parts.concat( identifiers );
			}
			_parts = new UniqueArray().unique( _parts );
			_primary = primary;
			return _parts;
		}
		
		/**
		* 	The primary state element.
		*/
		public function get primary():String
		{
			return _primary;
		}
		
		public function set primary( value:String ):void
		{
			_primary = value;
		}
		
		/**
		* 	Any state elements specified after the primary
		* 	state identfier.
		*/
		public function get elements():Array
		{
			return _elements;
		}
		
		/**
		* 	Sets the state elements.
		* 
		* 	@param primary The primary state.
		* 	@param elements An array containing state elements.
		*/
		public function setStateElements( primary:String, elements:Array ):Array
		{
			if( elements == null )
			{
				elements = new Array();
			}
			elements.unshift( primary );
			return this.setState.apply( this, elements );
		}
		
		/**
		* 	Creates a clone of this state.
		* 
		* 	@return A clone of this state.
		*/
		public function clone():State
		{
			return new State( this.primary, this.elements );
		}
		
		/**
		* 	Cleans composite references.
		*/
		public function destroy():void
		{
			_parts = null;
			_primary = null;
		}
	}
}