package com.ffsys.ui.tooltips
{
	import flash.display.GradientType;
	
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
		}
		
		/**
		* 	Gets the background graphic that will be assigned to the
		* 	background of this component.
		* 
		* 	@param width The width for the background graphic.
		* 	@param height The height for the background graphic.
		* 
		* 	@return The graphic to use as the background for this tooltip.
		* 	
		*/
		protected function getBackgroundGraphic(
			width:Number, height:Number ):IComponentGraphic
		{
			var fill:IFill = new GradientFill( new Gradient(
				GradientType.LINEAR, [ 0x121212, 0x232021 ] ) );
			var stroke:IStroke = new Stroke( 1, 0x00ff00, 1 );
			stroke.gradient = new Gradient(
				GradientType.LINEAR, [ 0x242424, 0x333333 ] );
				
			var graphic:RectangleGraphic = new RectangleGraphic(
				width, height, stroke, fill );
			return graphic;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function show( text:String ):void
		{
			label = new Label( text );
			var w:Number = label.layoutWidth + paddings.left + paddings.right + 2;
			var h:Number = label.layoutHeight + paddings.top + paddings.bottom;
			background = getBackgroundGraphic( w, h );
			label.x = paddings.left + 1;
			label.y = paddings.top;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function hide():void
		{
			if( this.parent && this.parent.contains( this ) )
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