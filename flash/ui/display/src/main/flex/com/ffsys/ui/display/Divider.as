package com.ffsys.ui.display
{
	import flash.display.DisplayObject;	
	import flash.geom.Rectangle;
	
	import com.ffsys.ui.common.Border;
	import com.ffsys.ui.common.ComponentIdentifiers;
	import com.ffsys.ui.common.IBorder;	
	import com.ffsys.ui.core.Graphic;
	import com.ffsys.ui.graphics.*;

	/**
	*	Represents a graphical divider.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.01.2011
	*/
	public class Divider extends Graphic
	{
		private var _vertical:Boolean = false;
		private var _size:Number = 1;
		
		/**
		* 	Creatrs a <code>Divider</code> instance.
		* 
		* 	@param width The preferred width.
		* 	@param height The preferred height.
		*/
		public function Divider(
			width:Number = NaN,
			height:Number = NaN )
		{
			super();
			this.preferredWidth = width;
			this.preferredHeight = height;
		}
		
		public function get size():Number
		{
			return _size;
		}
		
		public function set size( value:Number ):void
		{
			_size = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function set graphic( graphic:DisplayObject ):void
		{
			super.graphic = graphic;
			
			if( this.graphic is IBorderGraphic )
			{
				var border:IBorder = new Border();
				
				/*
				if( this.graphic.fill
				 	&& this.graphic.fill is SolidFill )
				{
					border.color = SolidFill( this.graphic.fill ).color;
					border.alpha = SolidFill( this.graphic.fill ).alpha;
				}
				*/
				
				if( vertical )
				{
					border.left = ( size / 2 );
					border.right = ( size / 2 );
				}else{
					border.top = ( size / 2 );
					border.bottom = ( size / 2 );					
				}
				IBorderGraphic( graphic ).border = border;
			}
		}		
		
		/**
		* 	@inheritDoc
		*/
		override public function get preferredWidth():Number
		{
			var w:Number = super.preferredWidth;
			if( isNaN( w )
			 	&& this.parent != null )
			{
				return this.parent.width;
			}
			
			return w;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function draw(
			width:Number = NaN, height:Number = NaN ):void
		{
			if( graphic is IComponentGraphic )
			{
				var component:IComponentGraphic = IComponentGraphic( graphic );
				var r:Rectangle = getGraphicRect();
				component.preferredWidth = r.width;
				component.preferredHeight = r.height;				
				component.draw();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get preferredHeight():Number
		{
			var h:Number = super.preferredHeight;			
			if( isNaN( h )
			 	&& this.parent != null )
			{
				return this.parent.height;
			}
			
			return h;
		}
		
		/**
		* 	Whether this divider is being rendered as a vertical
		* 	layout.
		*/
		public function get vertical():Boolean
		{
			return _vertical;
		}
		
		public function set vertical( value:Boolean ):void
		{
			_vertical = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function prefinalize():void
		{
			if( this.graphic == null )
			{
				this.graphic = getComponentBean(
					ComponentIdentifiers.DIVIDER_GRAPHIC ) as DisplayObject;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutWidth():Number
		{
			return this.vertical
				? this.size + paddings.width + border.width
				: this.preferredWidth;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutHeight():Number
		{
			//trace("Divider::get layoutHeight()", this, this.vertical, this.size, paddings.height, border.height );
			return this.vertical
				? this.preferredHeight
				: this.size + paddings.height + border.height;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function finalized():void
		{
			super.finalized();
			if( this.graphic != null )
			{
				this.graphic.x = paddings.left + border.left;
				this.graphic.y = paddings.top + border.top;
						
				draw();
					
					/*			
				trace("Divider::finalized()",
					this.graphic,
					this.graphic.preferredWidth,
					this.graphic.preferredHeight,
					this.graphic.fill,
					SolidFill( this.graphic.fill ).color,
					SolidFill( this.graphic.fill ).alpha,
					graphic.width,
					graphic.height );
				*/
			}
		}
		
		/**
		* 	Gets a rectangle that describes the graphic
		* 	display dimensions.
		* 
		* 	@return The rectange for the graphic.
		*/
		public function getGraphicRect():Rectangle
		{
			var w:Number = preferredWidth;
			var h:Number = preferredHeight;
			if( this.vertical )
			{
				w = size;
				h = preferredHeight - paddings.height - border.height;
			}else{
				w = preferredWidth - paddings.width - border.width;
				h = size;
			}
			return new Rectangle( 0, 0, w, h );
		}
	}
}