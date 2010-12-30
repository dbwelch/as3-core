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
	public class CompositeFill extends Object
		implements ICompositeFill
	{
		private var _solid:ISolidFill;
		private var _gradient:IGradientFill;
		private var _bitmap:IBitmapFill;
		private var _composites:Array;
		
		/**
		* 	Creates a <code>CompositeFill</code> instance.
		*	
		*	If no solid fill is specified a default
		*	solid fill is created.
		* 
		* 	@param solid A solid color fill.
		*	@param gradient A gradient for the fill.
		*	@param bitmap A bitmap for the fill.
		*/
		public function CompositeFill(
			solid:ISolidFill = null,
			gradient:IGradientFill = null,
			bitmap:IBitmapFill = null )
		{
			super();
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
		public function get gradient():IGradientFill
		{
			return _gradient;
		}
		
		public function set gradient( gradient:IGradientFill ):void
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
		*	Gets the array of composite fills.	
		*/
		public function get composites():Array
		{
			if( _composites == null )
			{
				_composites = new Array();
			}
			
			
			if( solid != null
				&& _composites.indexOf( solid ) == -1 )
			{
				_composites.push( solid );
			}			
			
			if( gradient != null
				&& _composites.indexOf( gradient ) == -1 )
			{
				_composites.push( gradient );
			}
			
			
			if( bitmap != null
				&& _composites.indexOf( bitmap ) == -1 )
			{
				_composites.push( bitmap );
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
				//composite solid color, gradient and bitmap
				//or a custom composite collection
				var layers:Array = this.composites;
				//trace("CompositeFill::apply()", layers.length, component.id );
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
}