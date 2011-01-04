package com.ffsys.ui.display {
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.core.Graphic;
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.graphics.RectangleGraphic;
	import com.ffsys.ui.graphics.Stroke;
	
	import com.ffsys.ui.layout.IFixedLayout;
	
	/**
	*	A utiity component that draws a rectangle
	*	for the bounds of a component around the margins,
	*	another rectangle around the object dimensions
	*	and the last around the padding.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class BoxModelComponent extends UIComponent
		implements IFixedLayout {
		
		private var _outer:Number;
		private var _component:Number;
		private var _inner:Number;
		
		/**
		*	Creates a <code>BoxModelComponent</code> instance.
		*	
		*	@param outer A color for the outer rectangle.
		*	@param component A color for the component rectangle.
		*	@param inner A color for the inner rectangle.
		*/
		public function BoxModelComponent(
			outer:Number = 0xff0000,
			component:Number = 0x00ff00, 
			inner:Number = 0x0000ff )
		{
			super();
			this.outer = outer;
			this.component = component;
			this.inner = inner;
		}
		
		/**
		*	A colour for the outer rectangle.	
		*/
		public function get outer():Number
		{
			return _outer;
		}
		
		public function set outer( outer:Number ):void
		{
			_outer = outer;
		}
		
		/**
		*	A colour for the component rectangle.	
		*/
		public function get component():Number
		{
			return _component;
		}

		public function set component( component:Number ):void
		{
			_component = component;
		}
		
		/**
		*	A colour for the inner rectangle.	
		*/
		public function get inner():Number
		{
			return _inner;
		}

		public function set inner( inner:Number ):void
		{
			_inner = inner;
		}	
		
		/**
		*	@inheritDoc	
		*/
		override public function finalized():void
		{
			var component:IComponent = IComponent( this.parent );
			var graphic:IComponentGraphic = null;
			
			var rect:Rectangle = component.getRectangle();
			
			//trace("BoxModelComponent::finalized()", rect );
			
			graphic = new RectangleGraphic(
				rect.width,
				rect.height,
				new Stroke( 0, this.component, 1 ) );
				
			graphic.tx = rect.x;
			graphic.ty = rect.y;
			addChild( DisplayObject( new Graphic( DisplayObject( graphic ) ) ) );
			
			rect = component.getPaddingRectangle();
						
			graphic = new RectangleGraphic(
				rect.width,
				rect.height,
				new Stroke( 0, this.inner, 1 ) );
				
			graphic.tx = rect.x;
			graphic.ty = rect.y;
			addChild( DisplayObject( new Graphic( DisplayObject( graphic ) ) ) );
			
			rect = component.getMarginRectangle();
						
			graphic = new RectangleGraphic(
				rect.width,
				rect.height,
				new Stroke( 0, this.outer, 1 ) );
				
			graphic.tx = rect.x;
			graphic.ty = rect.y;
			addChild( DisplayObject( new Graphic( DisplayObject( graphic ) ) ) );
		}
	}
}