package com.ffsys.ui.buttons
{
	import flash.text.TextField;
	import com.ffsys.ui.text.Label;
		
	import com.ffsys.ui.common.ComponentIdentifiers;
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
		private var _label:Label;
		private var _identifier:String;
		
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
			_text = text;
			updateLabelText( text );
		}
		
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
		
		/**
		* 	Creates the label component.
		* 
		* 	@return The created label or <code>null</code> if no
		* 	component bean was found.
		*/
		protected function createLabel():Label
		{
			if( _label == null )
			{
				_label = getComponentBean(
					ComponentIdentifiers.LABEL ) as Label;
					
				if( _label != null && !contains( _label ) )
				{
					addChild( _label );
				}
			}
			return _label;
		}
		
		/**
		* 	Removed the label component.
		* 
		* 	@return The created label or <code>null</code> if no
		* 	component bean was found.
		*/
		protected function removeLabel():void
		{
			if( _label != null )
			{
				if( contains( _label ) )
				{
					removeChild( _label );
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
				&& !contains( _label ) )
			{
				addChild( _label );
			}
			
			super.createChildren();			
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredWidth():Number
		{
			var width:Number = super.preferredWidth;
			if( label )
			{
				width = label.layoutWidth + paddings.left + paddings.right;
			}
			
			return width;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get preferredHeight():Number
		{
			var height:Number = super.preferredHeight;
			if( label )
			{
				height = label.layoutHeight + paddings.left + paddings.right;
			}
			
			return height;
		}
		
		/**
		* 	A message identifier for this text button component.
		*/
		public function get identifier():String
		{
			return _identifier;
		}
		
		public function set identifier(value:String):void
		{
			_identifier = value;
		}
		
		/**
		* 	Invoked when this component is instantiated
		* 	as a bean.
		*/
		override public function finalized():void
		{
			if( _label == null
				&& this.identifier != null )
			{
				createLabel();
				trace("TextButton::finalized()", "GOT DEFAULT LABEL COMPONENT FROM BEAN DOCUMENT: ", _label );
			}
			
			//trace("TextButton::finalized()", this, this.id, this.label, this.identifier );
			if( this.label != null
				&& this.label.messages != null
				&& this.identifier != null
				&& this.label.identifier == null )
			{
				var msg:String = this.label.messages.getProperty.apply(
					this.label.messages, [ this.identifier ] ) as String;
				
				//trace("TextButton::finalized() SEARCHING FOR MESSAGE TO SET: ", msg );
				
				if( msg != null )
				{
					this.text = msg;
				}
			}
		}
		
		/**
		* 	The label being used to render the text for this button.
		*/
		public function get label():Label
		{
			return _label;
		}
		
		public function set label( value:Label ):void
		{
			_label = value;
		}
		
		override public function destroy():void
		{
			super.destroy();
			_text = null;
			_identifier = null;
			_label = null;
		}
	}
}