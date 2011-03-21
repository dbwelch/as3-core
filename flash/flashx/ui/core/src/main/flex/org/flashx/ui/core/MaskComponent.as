package org.flashx.ui.core {
	
	import flash.display.DisplayObject;
	
	import org.flashx.ui.graphics.IComponentGraphic;
	import org.flashx.ui.graphics.RectangleGraphic;
	import org.flashx.ui.graphics.SolidFill;
	
	/**
	*	A component to serve specifically to be used as a mask.
	*	
	*	This component simply uses the <code>background</code> graphic and
	*	resizes the graphic when necessary.
	*	
	*	This allows for mask shapes to be switched easily on
	*	the fly, the default shape used for the graphic is a
	*	rectangle.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.06.2010
	*/
	public class MaskComponent extends UIComponent
		implements IMaskComponent {
			
		private var _target:DisplayObject;
		
		/**
		*	Creats a <code>MaskComponent</code> instance.
		*	
		*	@param width The preferred width of the mask.
		*	@param height The preferred height of the mask.
		* 	@param background A background graphic to use.
		*/
		public function MaskComponent(
			width:Number = 100,
			height:Number = 100,
			background:IComponentGraphic = null )
		{
			super();
			this.width = width;
			this.height = height;
			this.background = background;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get target():DisplayObject
		{
			return _target;
		}
		
		public function set target( value:DisplayObject ):void
		{
			if( _target != null
			 	&& value == null )
			{
				_target.mask = null;
			}
			
			_target = value;
			
			if( _target != null )
			{
				_target.mask = this;
			}
		}

		/**
		* 	Ensures the background graphic is kept in sync
		* 	with the dimensions of this component.
		*/
		override public function set background( value:IComponentGraphic ):void
		{
			super.background = value;
			applyBackground();
		}
	}
}