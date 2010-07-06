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
		private var _spacing:Number = 5;
		
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
		*	@inheritDoc	
		*/
		override public function set text( text:String ):void
		{
			super.text = text;
			if( label )
			{
				position();
			}
		}
		
		/**
		*	The spacing between the icon and the label.	
		*/
		public function get spacing():Number
		{
			return _spacing;
		}
		
		public function set spacing( spacing:Number ):void
		{
			_spacing = spacing;
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
			
			if( this.icon && !this.contains( this.icon ) )
			{
				addChild( this.icon );
				position();
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredWidth():Number
		{
			var width:Number = super.preferredWidth;
			
			var hasIcon:Boolean = ( icon != null ) && contains( icon );
			var hasLabel:Boolean = ( label != null ) && contains( label );
			
			if( isNaN( _preferredWidth ) )
			{
				//a default width if no icon and label
				if( !hasIcon && !hasLabel )
				{
					width = 18;
				}
				
				if( hasIcon && !hasLabel )
				{
					width = icon.width + paddings.left + paddings.right;
				}else if( hasIcon && hasLabel )
				{
					width = icon.width
						+ paddings.left
						+ paddings.right
						+ label.layoutWidth;
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
			
			var hasIcon:Boolean = ( icon != null ) && contains( icon );
			var hasLabel:Boolean = ( label != null ) && contains( label );			
			
			if( isNaN( _preferredHeight ) )
			{
				//a default height if no icon and label
				if( !hasIcon && !hasLabel )
				{
					height = 18;
				}

				if( hasIcon && !hasLabel )
				{
					height = icon.height + paddings.top + paddings.bottom;
				}else if( hasIcon && hasLabel )
				{
					height = icon.height
						+ paddings.top
						+ paddings.bottom
						+ label.layoutHeight;
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
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function layoutChildren(
			width:Number, height:Number ):void
		{
			position();
		}
		
		/**
		*	Positions the icon and label.
		*/
		protected function position():void
		{
			var hasIcon:Boolean = ( icon != null ) && contains( icon );
			var hasLabel:Boolean = ( label != null ) && contains( label );			
			
			var ix:Number = paddings.left;
			var iy:Number = paddings.top;
			
			var lx:Number = paddings.left;
			var ly:Number = paddings.top;
			
			if( hasIcon )
			{
				//default to centring the icon if
				//we have preferred dimensions
				if( !isNaN( _preferredWidth ) )
				{
					ix = ( _preferredWidth * 0.5 ) - ( icon.width * 0.5 );
				}
				
				if( !isNaN( _preferredHeight ) )
				{
					iy = ( _preferredHeight * 0.5 ) - ( icon.height * 0.5 );
				}
				
				if( hasLabel )
				{
					//default label positions when an icon is specified
					lx = ix + icon.width + spacing;
					ly = iy + ( icon.height * 0.5 ) - ( label.layoutHeight * 0.5 );
				}
				
				icon.x = ix;
				icon.y = iy;
			}
			
			if( hasLabel )
			{
				label.x = lx;
				label.y = ly;	
			}
		}		
	}
}