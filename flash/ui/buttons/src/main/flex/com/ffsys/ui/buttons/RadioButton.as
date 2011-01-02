package com.ffsys.ui.buttons
{
	import com.ffsys.ui.core.IGroupManagerAware;
	import com.ffsys.ui.core.IComponentGroupManager;
	
	/**
	*	Represents a radio button.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2010
	*/
	public class RadioButton extends ToggleButton
		implements IGroupManagerAware
	{
		private var _groupManager:IComponentGroupManager;
		
		/**
		* 	Creates a <code>RadioButton</code> instance.
		*/
		public function RadioButton()
		{
			super();
		}
		
		/**
		* 	A radio button group manager.
		*/
		public function get groupManager():IComponentGroupManager
		{
			return _groupManager;
		}
		
		public function set groupManager( value:IComponentGroupManager ):void
		{
			if( value == null
			 	&& _groupManager != null
				&& _groupManager.hasComponent( this ) )
			{
				_groupManager.removeComponent( this );
			}
			
			_groupManager = value;
			
			if( _groupManager != null
			 	&& !_groupManager.hasComponent( this ) )
			{
				_groupManager.addComponent( this );
			}
		}
	}
}