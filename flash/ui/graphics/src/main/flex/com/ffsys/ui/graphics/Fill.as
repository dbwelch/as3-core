package com.ffsys.ui.graphics
{
	import flash.display.Graphics;
	
	/**
	*	Repesents a solid fill.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class Fill extends Object
		implements IFill
	{
		private var _gradient:IGradient;
		private var _color:Number;
		private var _alpha:Number;
		
		/**
		* 	Creates a <code>Fill</code> instance.
		* 
		* 	@param color The color for the fill.
		* 	@param alpha The alpha for the fill.
		*	@param gradient A gradient for the fill.
		*/
		public function Fill(
			color:Number = 0x999999,
			alpha:Number = 1,
			gradient:IGradient = null )
		{
			super();
			this.color = color;
			this.alpha = alpha;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get gradient():IGradient
		{
			return _gradient;
		}
		
		public function set gradient( gradient:IGradient ):void
		{
			_gradient = gradient;
		}		
		
		/**
		* 	The color for the fill.
		*/
		public function get color():Number
		{
			return _color;
		}
		
		public function set color( color:Number ):void
		{
			_color = color;
		}
		
		/**
		* 	The alpha for the fill.
		*/
		public function get alpha():Number
		{
			return _alpha;
		}

		public function set alpha( alpha:Number ):void
		{
			_alpha = alpha;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function apply(
			graphics:Graphics,
			component:IComponentGraphic ):void
		{
			if( graphics )
			{
				if( !gradient )
				{
					graphics.beginFill( color, alpha );
				}else{
					graphics.beginGradientFill(
						gradient.type,
						gradient.colors,
						gradient.alphas,
						gradient.ratios,
						gradient.matrix,
						gradient.spreadMethod,
						gradient.interpolationMethod,
						gradient.focalPointRatio );
				}
			}
		}
	}
}