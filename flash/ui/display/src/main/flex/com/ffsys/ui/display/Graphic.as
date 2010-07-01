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
		implements IGraphic
	{
		private var _graphic:IComponentGraphic;
		
		/**
		* 	Creates a <code>Graphic</code> instance.
		* 
		* 	@param graphic The graphical shape.
		*/
		public function Graphic( graphic:IComponentGraphic = null )
		{
			super();
			this.interactive = false;
			if( graphic )
			{
				this.graphic = graphic;
			}
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
				if( isNaN( this.graphic.preferredWidth ) )
				{
					this.graphic.preferredWidth = preferredWidth;
				}
				
				if( isNaN( this.graphic.preferredHeight ) )
				{
					this.graphic.preferredHeight = preferredHeight;
				}
				
				addChild( DisplayObject( this.graphic ) );
			}
		}
		
		/**
		* 	Proxies drawing to the encapsulated graphic
		*	if it exists.
		*
		*	@param width The width of the graphic.
		*	@param height The height of the graphic.
		*/
		public function draw(
			width:Number = NaN, height:Number = NaN ):void
		{
			if( graphic )
			{
				graphic.draw( width, height );
			}
		}
	}
}