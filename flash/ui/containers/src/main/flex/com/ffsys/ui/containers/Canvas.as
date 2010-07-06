package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.MaskComponent;
	import com.ffsys.ui.core.IMaskComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;
	
	/**
	*	A canvas is a container that supports
	*	clipping it's content to the preferred dimensions
	*	using a mask.
	*	
	*	By default a canvas is not clipped and lays out it's
	*	children in a vertical manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class Canvas extends Container
		implements ICanvas {
		
		private var _masker:IMaskComponent;
		private var _clipped:Boolean = false;
		private var _scroller:IScroller;
		
		/**
		*	Creates a <code>Canvas</code> instance.	
		*	
		*	@param width The width of the canvas.
		*	@param height The height of the canvas.
		*	@param clipped Whether the canvas is masked
		*	at the preferred dimensions.
		*/
		public function Canvas(
			width:Number = 100,
			height:Number = 100,
			clipped:Boolean = false )
		{
			super();
			this.preferredWidth = width;
			this.preferredHeight = height;
			this.clipped = clipped;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get masker():IMaskComponent
		{
			return _masker;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get clipped():Boolean
		{
			return _clipped;
		}
		
		public function set clipped( clipped:Boolean ):void
		{
			if( clipped != _clipped )
			{
				var graphic:IComponentGraphic = null;
				
				if( _clipped && !clipped && this.masker )
				{
					if( this.contains( DisplayObject( this.masker ) ) )
					{
						graphic = this.masker.graphic;
						removeChild( DisplayObject( this.masker ) );
						this.mask = null;
						_masker = null;
					}
				}
			
				_clipped = clipped;
			
				if( this.clipped )
				{
					_masker = new MaskComponent(
						this.preferredWidth, this.preferredHeight );
					if( graphic )
					{
						_masker.graphic = graphic;
					}
					addChild( DisplayObject( _masker ) );
					this.mask = DisplayObject( _masker );
				}
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get scroller():IScroller
		{
			return _scroller;
		}
		
		public function set scroller( scroller:IScroller ):void
		{
			_scroller = scroller;
		}
	}
}