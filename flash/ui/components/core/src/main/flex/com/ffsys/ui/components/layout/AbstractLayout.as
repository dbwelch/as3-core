package com.ffsys.ui.components.layout
{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	*	Abstract super class for layout implmentations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class AbstractLayout extends Object
		implements ILayout
	{	
		/**
		* 	Creates an <code>AbstractLayout</code> instance.
		*/
		public function AbstractLayout()
		{
			super();
		}
		
		protected function getPreviousDisplayObject(
			parent:DisplayObjectContainer, child:DisplayObject ):DisplayObject
		{
			var index:int = parent.getChildIndex( child );
			
			if( index > 0 )
			{
				return parent.getChildAt( index - 1 );
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function added( child:DisplayObject ):void
		{
			//
		}
		
		/**
		*	@inheritDoc
		*/
		public function removed( child:DisplayObject ):void
		{
			//
		}
	}
}