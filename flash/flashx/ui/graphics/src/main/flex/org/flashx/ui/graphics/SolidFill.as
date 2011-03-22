package org.flashx.ui.graphics {
	
	import flash.display.Graphics;
	
	/**
	*	Represents a solid fill.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class SolidFill extends Object
		implements ISolidFill {
		
		private var _color:Number;
		private var _alpha:Number;
		
		/**
		*	Creates a <code>SolidFill</code> instance.
		*	
		*	@param color The color value.
		*	@param alpha THe alpha amount.
		*/
		public function SolidFill(
			color:Number = 0x999999,
			alpha:Number = 1 )
		{
			super();
			this.color = color;
			this.alpha = alpha;
		}
		
		/**
		* 	@inheritDoc
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
		* 	@inheritDoc
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
			component:IComponentGraphic,
			width:Number,
			height:Number ):void
		{		
			graphics.beginFill( color, alpha );
		}
		
		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return SolidFill;
		}
		
		/**
		* 	Gets an instance for use as a clone.
		* 
		* 	@return The instance to use as a clone.
		*/
		public function getCloneInstance():Object
		{
			var clazz:Class = getCloneClass();
			return new clazz();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clone():IFill
		{
			var fill:ISolidFill =
				ISolidFill( getCloneInstance() );
			fill.color = this.color;
			fill.alpha = this.alpha;
			return fill;
		}
	}
}