package com.ffsys.ui.core {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.graphics.RectangleGraphic;
	import com.ffsys.ui.graphics.SolidFill;
	
	/**
	*	A component to serve specifically to be used as a mask.
	*	
	*	This component simply encapsulates a graphic and
	*	resizes the graphic when necessary.
	*	
	*	This allows for mask shapes to be switched easily on
	*	the fly, the default shape used for the graphic is a
	*	rectangle.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class MaskComponent extends UIComponent
		implements IMaskComponent {
		
		private var _graphic:IComponentGraphic;
		
		/**
		*	Creats a <code>MaskComponent</code> instance.
		*	
		*	@param width The preferred width of the mask.
		*	@param height The preferred height of the mask.
		*/
		public function MaskComponent(
			width:Number = 100,
			height:Number = 100,
			graphic:IComponentGraphic = null )
		{
			super();
			this.preferredWidth = width;
			this.preferredHeight = height;
			
			if( graphic == null )
			{
				graphic =
					new RectangleGraphic( width, height );
				graphic.fill = new SolidFill( 0x000000, 0.5 );
			}
			this.graphic = graphic;
		}
		
		/**
		*	@inheritDoc
		*/	
		public function get graphic():IComponentGraphic
		{
			return _graphic;
		}
		
		public function set graphic( value:IComponentGraphic ):void
		{
			if( this.graphic
				&& contains( DisplayObject( this.graphic ) ) )
			{
				removeChild( DisplayObject( this.graphic ) );
			}
			
			_graphic = value;
			
			if( this.graphic )
			{
				addChild( DisplayObject( this.graphic ) );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChildren(
			width:Number, height:Number ):void
		{			
			if( this.graphic )
			{
				this.graphic.draw( width, height );
			}
		}
	}
}