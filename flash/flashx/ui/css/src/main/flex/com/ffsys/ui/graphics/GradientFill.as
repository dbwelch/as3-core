package com.ffsys.ui.graphics {
	
	import flash.display.Graphics;
	
	/**
	*	Represents a gradient fill.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class GradientFill extends Object
		implements IGradientFill {
			
		private var _gradient:IGradient;
		
		/**
		*	Creates a <code>GradientFill</code> instance.
		*	
		*	@param gradient The gradient for the fill.
		*/
		public function GradientFill(
			gradient:IGradient = null )
		{
			super();
			
			if( !gradient )
			{
				gradient = new Gradient();
			}
			
			this.gradient = gradient;
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
		* 	@inheritDoc
		*/
		public function apply(
			graphics:Graphics,
			component:IComponentGraphic,
			width:Number,
			height:Number ):void
		{
			if( graphics && gradient )
			{
				gradient.fill( graphics, width, height );
			}
		}
		
		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return GradientFill;
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
			var fill:IGradientFill =
				IGradientFill( getCloneInstance() );
			if( this.gradient != null )
			{
				fill.gradient = this.gradient.clone();
			}
			return fill;
		}			
	}
}