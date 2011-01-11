package com.ffsys.ui.buttons
{
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import com.ffsys.ui.text.*;
	
	import com.ffsys.ioc.*;
		
	import com.ffsys.ui.common.ComponentIdentifiers;
	import com.ffsys.ui.core.IComponentDimensions;	
	import com.ffsys.ui.css.ICssTextFieldProxy;

	/**
	*	Represents a button that consists of a label.
	* 
	* 	This component does not include a background graphic
	* 	in the default styles.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class TextButton extends ButtonComponent
		implements  ICssTextFieldProxy
	{
		private var _text:String;
		private var _label:ITextComponent;
		
		/**
		* 	Creates a <code>TextButton</code> instance.
		*	
		*	@param text The text for the button.
		*	@param width The preferred width of the button.
		*	@param height The preferred height of the button.
		*/
		public function TextButton(
			text:String = null,
			width:Number = NaN,
			height:Number = NaN )
		{
			super( width, height );
			if( text != null )
			{
				this.text = text;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutWidth():Number
		{
			//some border data - use border dimensions
			if( this.border.valid() )
			{
				return getBorderDimensions().width;
			}else if( this.background != null )
			{
				return this.background.preferredWidth;
			}else if( this.label != null
			 	&& this.label.text != null
			 	&& this.label.text.length > 0 )
			{ 
				return this.label.layoutWidth;
			}
			
			return super.layoutWidth;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get layoutHeight():Number
		{
			//some border data - use border dimensions
			if( this.border.valid() )
			{
				return getBorderDimensions().height;
			}else if( this.background != null )
			{
				return this.background.preferredHeight;
			}else if( this.label != null
			 	&& this.label.text != null
			 	&& this.label.text.length > 0 )
			{ 
				return this.label.layoutHeight;
			}
			
			return super.layoutHeight;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getProxyTextFields():Vector.<TextField>
		{
			var output:Vector.<TextField> = new Vector.<TextField>();
			if( _label && _label.textfield )
			{
				output.push( TextField( _label.textfield ) );
			}
			return output;
		}
		
		/**
		*	The text for the button.	
		*/
		public function get text():String
		{
			return _text;
		}
		
		public function set text( text:String ):void
		{
			removeLabel();
			_text = text;
			if( text != null )
			{
				createLabel( text );
			}
		}
		
		/*
		protected function updateLabelText( text:String ):void
		{
			if( _label != null )
			{
				if( text != null && text != "" )
				{
					_label.x = paddings.left;
					_label.y = paddings.top;
					_label.text = text;
				}else{
					removeLabel();
				}
			}
		}
		*/
		
		/**
		* 	Creates the label component.
		* 
		* 	@return The created label or <code>null</code> if no
		* 	component bean was found.
		*/
		protected function createLabel( text:String = null ):ITextComponent
		{
			if( _label == null )
			{		
				var descriptor:IBeanDescriptor = this.document.getBeanDescriptor(
					ComponentIdentifiers.LABEL );
				
				//ensure the label isn't finalized until it's added
				_label = descriptor.getBean(
					true, false ) as ITextComponent;
				_label.id = this.id + "_text";
				if( text != null )
				{
					_label.contentText = text;
				}
				
				//trace("[CREATING LABEL] ::::::::::::::::::::: TextButton::createLabel()", this, this.id, _label.fte, _label, text, _label.contentText, contains( DisplayObject( _label ) ) );
					
				if( _label != null && !contains( DisplayObject( _label ) ) )
				{
					addChild( DisplayObject( _label ) );
					
					//TODO: !!
					_label.finalized();
					//trace("[CREATING LABEL] ::::::::::::::::::::: ADDED CHILD LABEL()", _label.text );					
				}
			}
			return _label;
		}
		
		/**
		* 	Removes the label component.
		*/
		protected function removeLabel():void
		{
			if( _label != null )
			{
				if( contains( DisplayObject( _label ) ) )
				{
					removeChild( DisplayObject( _label ) );
				}
				_label = null;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			if( _label 
				&& !contains( DisplayObject( _label ) ) )
			{
				addChild( DisplayObject( _label ) );
			}
			
			super.createChildren();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function prefinalize():void
		{
			if( _label == null
				&& this.identifier != null )
			{
				//createLabel();
			}
		}
		
		private var _contentText:String;
		
		public function get contentText():String
		{
			return _contentText;
		}
		
		public function set contentText( value:String ):void
		{
			_contentText = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function finalized():void
		{
			//trace("TextButton::finalized()", contentText, messages, identifier );
			
			if( contentText != null )
			{
				this.text = contentText;
			}else if( this.messages != null
				&& this.identifier != null )
			{
				var msg:String = this.messages.getProperty.apply(
					this.messages, [ this.identifier ] ) as String;
				
				if( msg != null )
				{
					this.text = msg;
				}
			}
			super.finalized();
		}
		
		/**
		* 	The label being used to render the text for this button.
		*/
		public function get label():ITextComponent
		{
			return _label;
		}
		
		public function set label( value:ITextComponent ):void
		{
			_label = value;
		}
		
		override public function destroy():void
		{
			super.destroy();
			_text = null;
			_label = null;
		}
	}
}