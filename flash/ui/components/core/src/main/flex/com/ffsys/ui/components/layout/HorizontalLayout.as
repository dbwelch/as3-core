package com.ffsys.ui.components.layout
{
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.components.core.IComponent;
	
	/**
	*	Handles laying out components in a horizontal
	*	manner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class HorizontalLayout extends AbstractLayout
	{	
		/**
		* 	Creates a <code>HorizontalLayout</code> instance.
		*/
		public function HorizontalLayout()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		override public function added( child:DisplayObject ):void
		{
			//TODO
			trace("HorizontalLayout::added(), ", child, child.parent );
			
			var x:Number = 0;
			
			var previous:DisplayObject = getPreviousDisplayObject(
				child.parent, child );
				
			if( previous )
			{
				x = previous.x + previous.width;
			}
			
			if( child is IComponent )
			{
				var component:IComponent = IComponent( child );
				trace("HorizontalLayout::added(), component: ", component );
				
				//TODO: add style additions here
			}
			
			child.x = x;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function removed( child:DisplayObject ):void
		{
			//TODO
			trace("HorizontalLayout::removed(), ", child, child.parent );
			
			if( child is IComponent )
			{
				var component:IComponent = IComponent( child );
				trace("HorizontalLayout::removed(), component: ", component );
			}			
		}
	}
}