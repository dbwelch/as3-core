package org.flashx.ui.graphics {
	
	/**
	*	Encapsulates the dimensions of a corner.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	public class Corner extends Object
		implements ICorner {
		
		private var _width:Number = 0;
		private var _height:Number = 0;
		
		/**
		*	Creates a <code>Corner</code> instance.	
		*	
		*	@param width The width of the corner.
		*	@param height The height of the corner.
		*/
		public function Corner(
			width:Number = 0, height:Number = 0 )
		{
			super();
			this.width = width;
			this.height = height;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get width():Number
		{
			return _width;
		}
		
		public function set width( value:Number ):void
		{
			_width = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get height():Number
		{
			return _height;
		}
		
		public function set height( value:Number ):void
		{
			_height = value;
		}
		
		/**
		*	@inheritDoc 
		*/
		public function update(
			width:Number = 5,
			height:Number = NaN ):void
		{
			if( isNaN( height ) )
			{
				height = width;
			}
			
			_width = width;
			_height = height;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function reset():void
		{
			_width = 0;
			_height = 0;
		}
		
		/**
		*	@inheritDoc
		*/
		public function isEmpty():Boolean
		{
			return ( width == 0 && height == 0 );
		}
		
		/**
		* 	Gets the class used to clone this implementation.
		* 
		* 	@return The class used to clone this implementation.
		*/
		public function getCloneClass():Class
		{
			return Corner;
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
		public function clone():ICorner
		{
			var corner:ICorner =
				ICorner( getCloneInstance() );
			corner.width = this.width;
			corner.height = this.height;
			return corner;
		}				
	}
}