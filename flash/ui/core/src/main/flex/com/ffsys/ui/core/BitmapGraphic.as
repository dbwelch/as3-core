package com.ffsys.ui.core
{
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.core.InteractiveComponent;
	import com.ffsys.ui.css.ICssProperty;
	
	/**
	*	A container for a display object that adds the ability
	*	for the display object to be interactive and to work
	*	with some containers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public class BitmapGraphic extends InteractiveComponent
		implements ICssProperty
	{
		private var _display:DisplayObject;
		
		/**
		* 	Creates a <code>BitmapGraphic</code> instance.
		* 
		* 	@param display The display object.
		*/
		public function BitmapGraphic( display:DisplayObject = null )
		{
			super();
			this.interactive = false;
			if( display )
			{
				this.display = display;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function shouldSetCssProperty( name:String, value:* ):Boolean
		{
			return ( value is DisplayObject );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setCssProperty( name:String, value:* ):void
		{
			this.display = DisplayObject( value );
		}
		
		/**
		*	The display object for this component.
		*/
		public function get display():DisplayObject
		{
			return _display;
		}
		
		public function set display( display:DisplayObject ):void
		{
			if( this.display && this.contains( display ) )
			{
				this.removeChild( display );
			}
			
			_display = display;
			
			if( this.display )
			{
				addChild( this.display );
			}
		}
		
		/**
		* 	Custom style application logic.
		* 
		* 	This method inspects the style objects that would be applied
		* 	searching for a style that is an <code>DisplayObject</code>
		* 	implementation and adds it as a child if it corresponds to a valid
		* 	display implementation.
		* 
		* 	Only one display may be assigned at any one time so the rule is that
		* 	the first located style declaration will be used.
		* 
		* 	As the order of style application may vary this could result in unexpected
		* 	behaviour. To prevent this, only ever apply a single display style declaration
		* 	to this component.
		*/
		override public function applyStyles():Array
		{
			if( styleManager )
			{
				var styleNames:Array = styleManager.getStyleNameList( this );
				var styles:Array = styleManager.getStyleObjects( this );
				var style:Object = null;
				for( var i:int = 0;i < styles.length;i++ )
				{
					style = styles[ i ];
					if( style is DisplayObject )
					{
						this.display = DisplayObject( style );
						break;
					}
				}
			}
			return null;
		}
	}
}