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
		//private var _scroller:IScroller;
		
		/**
		*	Creates a <code>Canvas</code> instance.	
		*	
		*	@param width The width of the canvas.
		*	@param height The height of the canvas.
		*	@param clipped Whether the canvas is masked
		*	at the preferred dimensions.
		*/
		public function Canvas(
			width:Number = NaN,
			height:Number = NaN,
			clipped:Boolean = false )
		{
			super();
			this.width = width;
			this.height = height;
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
					/*
				if( _clipped && !clipped && this.masker )
				{
					if( this.contains( DisplayObject( this.masker ) ) )
					{
						_masker.target = null;
						removeChild( DisplayObject( this.masker ) );
						this.mask = null;
						_masker = null;
					}
				}
			*/
			
				_clipped = clipped;
			
				/*
				if( this.masker )
				{
					_masker = new MaskComponent(
						this.preferredWidth, this.preferredHeight );
					_masker.target = this;
					addChild( DisplayObject( _masker ) );
				}
				*/
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		
		/*
		public function get scroller():IScroller
		{
			return _scroller;
		}
		
		public function set scroller( scroller:IScroller ):void
		{
			if( this.scroller && contains( DisplayObject( this.scroller ) ) )
			{
				removeChild( DisplayObject( this.scroller ) );
			}
			
			_scroller = scroller;
			
			if( this.scroller )
			{
				this.scroller.preferredWidth = preferredWidth - paddings.right;
				this.scroller.preferredHeight = preferredHeight - paddings.bottom;
				addChild( DisplayObject( this.scroller ) );
			}
		}
		*/
	}
}