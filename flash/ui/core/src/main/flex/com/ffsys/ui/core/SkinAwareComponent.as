package com.ffsys.ui.core
{	
	import com.ffsys.ui.skins.IComponentSkin;

	/**
	*	Represents a component that is aware of an associated skin.
	* 
	* 	Components that do not have a visual display (for example, some containers)
	* 	should extend <code>UIComponent</code> while components that
	* 	require a visual display should extend this class.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class SkinAwareComponent extends UIComponent
		implements ISkinAwareComponent
	{
		private var _skin:IComponentSkin;
		
		/**
		* 	Creates an <code>SkinAwareComponent</code> instance.
		*/
		public function SkinAwareComponent()
		{
			super();
		}
		
		/**
		* 	The skin associated with this component.
		*/
		public function get skin():IComponentSkin
		{
			return _skin;
		}
		
		public function set skin( skin:IComponentSkin ):void
		{
			_skin = skin;
		}
	}
}