package com.ffsys.ui.skins
{
	import flash.utils.Dictionary;
	
	import com.ffsys.ui.states.IViewState;
	
	/**
	*	Represents a component skin.
	* 
	* 	This class encapsulates the skin states and
	* 	provides access to the current state.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class ComponentSkin extends Object
		implements IComponentSkin
	{
		private var _states:Vector.<IViewState> = new Vector.<IViewState>;
		private var _indexes:Dictionary = new Dictionary();
		
		/**
		* 	Creates a <code>ComponentSkin</code> instance.
		*/
		public function ComponentSkin()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeStateById( id:String ):Boolean
		{
			var state:IViewState = null;
			try
			{
				var index:uint = _indexes[ id ];
				state = getStateById( id );
				
				if( state )
				{
					//remove the state
					_states.splice( index, 1 );
					
					//clean the index
					return ( delete _indexes[ id ] );
				}
			}catch( e:Error )
			{
				//fail silently as we return false
			}
			
			return false;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStateById( id:String ):IViewState
		{
			if( id )
			{
				var index:uint = _indexes[ id ];
				if( index is uint )
				{
					if( index >= _states.length )
					{
						throw new Error( "Could not locate a state at index " + index );
					}
					
					return _states[ index ];
				}
			}
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function addState( state:IViewState ):Boolean
		{
			if( !state || !state.id )
			{
				throw new Error( "Cannot add a null state or a state with no identfier." );
			}
			return addStateById( state.id, state );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function hasState( id:String ):Boolean
		{
			return ( _indexes[ id ] is Number );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function addStateById(
			id:String, state:IViewState ):Boolean
		{
			if( id && state
				&& _states.indexOf( state ) == -1
				&& !_indexes[ id ] )
			{
				var length:uint = _states.push( state );
				_indexes[ id ] = ( length - 1 );
				return true;
			}
			return false;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get length():uint
		{
			return _states.length;
		}
	}
}