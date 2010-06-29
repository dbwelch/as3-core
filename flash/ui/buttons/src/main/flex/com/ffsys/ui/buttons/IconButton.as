package com.ffsys.ui.buttons
{
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.states.IViewState;
	import com.ffsys.ui.states.ViewState;
	import com.ffsys.ui.states.State;	
	import com.ffsys.ui.text.Label;

	/**
	*	Represents a button that contains an icon.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class IconButton extends Button
	{
		private var _icon:DisplayObject;
		
		/**
		* 	Creates an <code>IconButton</code> instance.
		*	
		*	@param icon The display object to use as the icon.
		*	@param text The text for the button label.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function IconButton(
			icon:DisplayObject = null,
			text:String = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( text, width, height );
			if( icon )
			{
				this.icon = icon;
			}
		}	
		
		/**
		*	The icon for this button.	
		*/
		public function get icon():DisplayObject
		{
			return _icon;
		}
		
		public function set icon( icon:DisplayObject ):void
		{
			if( this.icon && this.contains( this.icon ) )
			{
				removeChild( this.icon );
			}
			
			_icon = icon;
			
			trace("IconButton::icon setter(), ", "SETTING ICON ", icon );
			
			if( this.icon && !this.contains( this.icon ) )
			{
				trace("IconButton::icon(), ", "ADDING THE ICON TO THE DISPLAY LIST",
					icon.width, icon.height );
				addChild( this.icon );
				icon.x = paddings.left;
				icon.y = paddings.top;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredWidth():Number
		{
			var width:Number = super.preferredWidth;
			
			if( isNaN( _preferredWidth ) )
			{
				//a default width if no icon and label
				width = 18;
				if( icon && contains( icon ) )
				{
					width = icon.width + paddings.left + paddings.right;
				}
			}
			
			return width;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredHeight():Number
		{
			var height:Number = super.preferredHeight;
			
			if( isNaN( _preferredHeight ) )
			{
				//a default height if no icon and label
				height = 18;
				if( icon && contains( icon ) )
				{
					height = icon.height + paddings.top + paddings.bottom;
				}
			}
			
			return height;
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function configureDefaultSkin():void
		{
			//main state for this component
			var main:IViewState = new ViewState();
			
			main.graphics.push(
				new RectangleGraphic(
					width,
					height ) );
					
			main.fills.push(
				new SolidFill( 0x212121 ) );
			
			this.skin.addState( main );
			
			var over:IViewState = new ViewState( 
			 	State.OVER );
					
			over.fills.push(
				new SolidFill( 0x62592e ) );
			
			this.skin.addState( over );
	
			trace("IconButton::configureDefaultSkin(), ", "CONFIGURING DEFAULT SKIN", this.skin.length );			
		}		
	}
}