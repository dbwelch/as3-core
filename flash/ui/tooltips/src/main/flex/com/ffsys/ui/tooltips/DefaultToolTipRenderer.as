package com.ffsys.ui.tooltips
{
	import flash.display.GradientType;
	
	import com.ffsys.ui.common.Orientation;
	import com.ffsys.ui.text.Label;
	import com.ffsys.ui.graphics.*;
	
	/**
	*	A default concrete implementation of the tooltip renderer
	* 	contract.
	* 
	* 	This implementation encapsulates a label for displaying
	* 	the tooltip text and a background graphic renderered behind
	* 	the tooltip.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  25.06.2010
	*/
	public class DefaultToolTipRenderer extends ToolTipRenderer
	{
		private var _label:Label;

		/**
		* 	Creates a <code>DefaultToolTipRenderer</code> instance.
		*/
		public function DefaultToolTipRenderer()
		{
			super();
			this.paddings.padding = 4;
			
			var fill:IFill = new GradientFill( new Gradient(
				GradientType.LINEAR, [ 0x121212, 0x232021 ] ) );
			var stroke:IStroke = new Stroke( 1, 0x00ff00, 1 );
			stroke.gradient = new Gradient(
				GradientType.LINEAR, [ 0x242424, 0x333333 ] );
			
			graphic = new RectangleGraphic(
					NaN, NaN, stroke, fill );
			this.pointer = new ArrowPointer();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function show( text:String ):void
		{
			label = new Label( text, maximumTextWidth, maximumTextHeight );
			var w:Number = label.layoutWidth + paddings.left + paddings.right;
			var h:Number = label.layoutHeight + paddings.top + paddings.bottom;
			
			if( !label.textfield.multiline )
			{
				w += 2;
			}
			
			if( graphic )
			{
				graphic.preferredWidth = w;
				graphic.preferredHeight = h;
				
				if( graphic.pointer )
				{
					if( graphic.pointer.edge == Orientation.TOP
					 	|| graphic.pointer.edge == Orientation.BOTTOM )
					{
						graphic.pointer.offset = w / 2;
					}else if(
						graphic.pointer.edge == Orientation.LEFT
						|| graphic.pointer.edge == Orientation.RIGHT )
					{
						graphic.pointer.offset = h / 2;
						
						/*
						trace("RectangleGraphic::doDraw(), setting vertical offset: ",
							pointer.offset, height );
						*/
					}					
				}
				
				graphic.setSize( w, h );
				background = graphic;
				
				preferredWidth = w;
				preferredHeight = h;
			}
			
			label.x = paddings.left + 1;
			label.y = paddings.top;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function hide():void
		{
			if( this.parent
				&& this.parent.contains( this ) )
			{
				this.parent.removeChild( this );
			}
			super.hide();
		}
		
		/**
		* 	The label used to display the text for the tooltip.
		*/
		public function get label():Label
		{
			return _label;
		}
		
		public function set label( label:Label ):void
		{
			if( this.label && contains( this.label ) )
			{
				removeChild( this.label );
			}
			
			_label = label;
			
			if( this.label )
			{
				this.label.mouseEnabled = false;
				this.label.mouseChildren = false;
				addChild( label );
			}
		}
	}
}