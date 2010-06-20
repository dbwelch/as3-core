package com.ffsys.ui.graphics
{
	import flash.display.Graphics;
	
	/**
	*	Repesents a fill that encapsulates a solid fill and
	*	optionally a gradient and bitmap fill.
	*	
	*	Allows compositing of the various encapsulated fills
	*	when the composite property is true.
	*	
	*	The default order for compositing is solid, then any
	*	gradient followed by a bitmap fill if availble.
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
		private var _composite:Boolean;
		private var _composites:Array;
		private var _solid:ISolidFill;
		private var _gradient:IGradient;
		private var _bitmap:IBitmapFill;
		
		/**
		* 	Creates a <code>Fill</code> instance.
		*	
		*	If no solid fill is specified a default
		*	solid fill is created.
		* 
		* 	@param solid A solid color fill.
		*	@param gradient A gradient for the fill.
		*	@param bitmap A bitmap for the fill.
		*/
		public function Fill(
			solid:ISolidFill = null,
			gradient:IGradient = null,
			bitmap:IBitmapFill = null )
		{
			super();
			
			if( !solid )
			{
				solid = new SolidFill();
			}
			
			this.solid = solid;
			this.gradient = gradient;
			this.bitmap = bitmap;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get solid():ISolidFill
		{
			return _solid;
		}
		
		public function set solid( solid:ISolidFill ):void
		{
			_solid = solid;
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
		*	@inheritDoc
		*/
		public function get bitmap():IBitmapFill
		{
			return _bitmap;
		}
		
		public function set bitmap( bitmap:IBitmapFill ):void
		{
			_bitmap = bitmap;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get composite():Boolean
		{
			return _composite;
		}
		
		public function set composite( composite:Boolean ):void
		{
			_composite = composite;
		}
		
		/**
		*	Gets the array of composite fills.	
		*/
		public function get composites():Array
		{
			if( !_composites )
			{
				var output:Array = new Array();
				
				if( solid )
				{
					output.push( solid );
				}
				
				if( gradient )
				{
					output.push( gradient );
				}
				
				if( bitmap )
				{
					output.push( bitmap );
				}
				
				return output;
			}
			
			return _composites;
		}
		
		public function set composites( composites:Array ):void
		{
			_composites = composites;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function apply(
			graphics:Graphics,
			component:IComponentGraphic,
			width:Number,
			height:Number ):void
		{
			if( graphics )
			{
				if( !composite )
				{
					if( !gradient && solid )
					{
						solid.apply( graphics, component, width, height );
					}else if( gradient )
					{
						applyGradient( graphics );
					}
				}else{
					
					//composite solid color, gradient and bitmap
					//or a custom composite collection
					var layers:Array = this.composites;
					var layer:IGraphicElement = null;
					for( var i:int = 0;i < layers.length;i++ )
					{
						layer = layers[ i ] as IGraphicElement;
						if( layer )
						{
							layer.apply( graphics, component, width, height );
							component.render( width, height );
							graphics.endFill();
						}
					}
				}
			}
		}
		
		/**
		*	@private	
		*/
		private function applyGradient( graphics:Graphics ):void
		{
			if( gradient )
			{
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