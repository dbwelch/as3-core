package com.ffsys.ui.display
{
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.InteractiveComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;
	
	/**
	*	A container for a graphic that adds the ability
	*	for the graphic to be interactive and to work
	*	with some containers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class Graphic extends InteractiveComponent
	{
		private var _graphic:IComponentGraphic;
		
		/**
		* 	Creates a <code>Graphic</code> instance.
		* 
		* 	@param graphic The graphical shape.
		*/
		public function Graphic( graphic:IComponentGraphic )
		{
			super();
			this.interactive = false;
			this.graphic = graphic;
		}
		
		/**
		*	The graphic for this component.
		*/
		public function get graphic():IComponentGraphic
		{
			return _graphic;
		}
		
		public function set graphic( graphic:IComponentGraphic ):void
		{
			if( this.graphic && this.contains( DisplayObject( graphic ) ) )
			{
				this.removeChild( DisplayObject( graphic ) );
			}
			
			_graphic = graphic;
			
			if( this.graphic )
			{
				addChild( DisplayObject( this.graphic ) );
			}
			
			if( this.layout )
			{
				this.layout.update( this );
			}
		}
	}
}