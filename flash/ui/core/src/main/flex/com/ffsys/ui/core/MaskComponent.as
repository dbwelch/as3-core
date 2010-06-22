package com.ffsys.ui.core {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.graphics.RectangleGraphic;
	
	/**
	*	A component to serve specifically to be used as a mask.
	*	
	*	This component simply encapsulates a graphic and
	*	proxies it's draw method to the referenced graphic.
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
		*	@param width The preferred width of the graphic graphic.
		*	@param height The preferred height of the graphic graphic.
		*/
		public function MaskComponent(
			width:Number = 100, height:Number = 100 )
		{
			super();
			_graphic = new RectangleGraphic( width, height );
			this.preferredWidth = width;
			this.preferredHeight = height;
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
			var recreate:Boolean = false;
			if( this.graphic && this.contains( DisplayObject( this.graphic ) ) )
			{
				removeChild( DisplayObject( this.graphic ) );
				recreate = value != null;
			}
			
			_graphic = value;
			
			if( recreate )
			{
				createChildren();
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			if( !this.graphic )
			{
				this.graphic = new RectangleGraphic(
					preferredWidth, preferredHeight );
			}
			
			addChild( DisplayObject( this.graphic ) );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function draw(
			width:Number = NaN, height:Number = NaN ):void
		{
			if( isNaN( width ) )
			{
				width = this.preferredWidth;
			}
			
			if( isNaN( height ) )
			{
				height = preferredHeight;
			}
			
			if( this.graphic )
			{
				this.graphic.draw( width, height );
			}
		}
	}
}