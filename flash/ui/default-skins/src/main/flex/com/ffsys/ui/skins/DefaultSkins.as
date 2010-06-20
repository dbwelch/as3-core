package com.ffsys.ui.skins
{
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.skins.*;
	import com.ffsys.ui.states.*;
	import com.ffsys.ui.buttons.*;
	
	/**
	*	Encapsulates the default skins.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class DefaultSkins extends SkinCollection
	{
		/**
		* 	Creates a <code>DefaultSkins</code> instance.
		*/
		public function DefaultSkins()
		{
			super();
			
			var main:IViewState = null;
			var skin:IComponentSkin = null;
			
			skin = new ComponentSkin();
			main = new IconBackgroundState();
			IconBackgroundState( main ).background = new RectangleGraphic();
			
			skin.states.main = main;
			
			addComponentClassSkin( IconButton, skin );
		}
	}
}