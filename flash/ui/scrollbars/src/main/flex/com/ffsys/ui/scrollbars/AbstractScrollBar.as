package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	import com.ffsys.ui.common.Direction;
	import com.ffsys.ui.containers.Container;
	
	/**
	*	Abstract super class for scroll bar implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.06.2010
	*/
	public class AbstractScrollBar extends Container {
		
		/**
		*	@private	
		*/
		protected var _direction:String;
		
		/**
		*	@private	
		*/
		protected var _size:Number;
		
		private var _target:DisplayObject;
		
		/**
		*	Creates an <code>AbstractScrollBar</code> instance.
		*	
		*	@param target The target to be scrolled.
		*	@param size The size of the scroll area.
		*/
		public function AbstractScrollBar(
			target:DisplayObject = null,
			size:Number = 100 )
		{
			super();
			if( target )
			{
				this.target = target;
			}
			_size = size;
		}
		
		/**
		*	The target being scrolled.	
		*/
		public function get target():DisplayObject
		{
			return _target;
		}
		
		public function set target( target:DisplayObject ):void
		{
			_target = target;
		}
		
		/**
		*	The direction this scroll bar is operating in.	
		*/
		public function get direction():String
		{
			return _direction;
		}
		
		public function set direction( direction:String ):void
		{
			_direction = direction;
		}
		
		/**
		*	Gets the property that will set the scroll
		*	for the target.	This value depends upon whether
		*	the target is a textfield and the direction of this
		*	scroll bar.
		*/
		public function get targetScrollProperty():String
		{
			var output:String = null;
			if( target is TextField )
			{
				output = ( direction == Direction.HORIZONTAL )
					? "scrollH" : "scrollV";
			}else{
				output = ( direction == Direction.HORIZONTAL )
					? "x" : "y";
			}
			return output;
		}
		
		/**
		*	Gets the property that measures the size of the
		*	target being scrolled.
		*/
		public function get targetMeasureProperty():String
		{
			var output:String = null;
			if( target is TextField )
			{
				output = ( direction == Direction.HORIZONTAL )
					? "maxScrollH" : "maxScrollV";
			}else{
				output = ( direction == Direction.HORIZONTAL )
					? "width" : "height";
			}
			return output;
		}		
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			trace("AbstractScrollBar::createChildren(), ", 
				target, targetScrollProperty, targetMeasureProperty );
		}
	}
}