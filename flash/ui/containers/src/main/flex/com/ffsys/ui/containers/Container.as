package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.core.IComponentStyleCache;
	import com.ffsys.ui.layout.ILayout;	
	
	/**
	*	Component implementation that is aware of a layout,
	*	this is the super class for all containers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class Container extends UIComponent
		implements IContainer {
		
		private var _layout:ILayout;
		
		/**
		*	Creates a <code>Container</code> instance.
		*/
		public function Container()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get layout():ILayout
		{
			return _layout;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set layout( layout:ILayout ):void
		{
			_layout = layout;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function doWithStyleCache(
			cache:IComponentStyleCache ):void
		{
			if( cache != null
			 	&& cache.main != null
				&& cache.main.spacing is Number )
			{
				this.spacing = Number( cache.main.spacing );
			}
			
			trace("Container::doWithStyleCache()", this, layout, this.parent, cache, cache.main, cache.main.spacing, this.spacing );
		}
		
		/**
		*	The spacing for this container layout.
		*/
		public function get spacing():Number
		{
			if( layout )
			{
				return layout.spacing;
			}
			return 0;
		}
		
		public function set spacing( spacing:Number ):void
		{
			if( layout )
			{
				layout.spacing = spacing;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		
		/*
		override protected function afterChildAdded(
			child:DisplayObject,
			index:int ):void
		{
			super.afterChildAdded( child, index );
			if( layout && child )
			{
				layout.added( child, this, index );
			}
		}
		*/
		
		/**
		*	@inheritDoc	
		*/
		
		/*
		override protected function afterChildRemoved(
			child:DisplayObject,
			index:int ):void
		{
			super.afterChildRemoved( child, index );
			if( layout && child )
			{
				layout.removed( child, this, index );
			}
		}
		*/
		
		public function update():void
		{
			if( layout != null )
			{
				layout.update( this );
			}			
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function finalized():void
		{
			super.finalized();
			if( numChildren > 0 )
			{
				update();
			}
		}
	}
}