package com.ffsys.ui.text.core {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.*;
	
	import com.ffsys.utils.properties.PropertiesMerge;
	
	/**
	*	Abstract super class for custom textfields.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class AbstractTextField extends TextField
		implements ITypedTextField {
		
		private var _enabled:Boolean = false;
		private var _html:Boolean = false;
		
		private var _maximumWidth:Number;
		private var _maximumHeight:Number;		
		
		
		private var _measuredWidth:Number;
		private var _measuredHeight:Number;		
		
		/**
		*	Creates an <code>AbstractTextField</code> instance.
		*/
		public function AbstractTextField(
			text:String = "",
			properties:Object = null,
			textformat:Object = null )
		{
			super();
			
			if( properties )
			{
				applyTextFieldProperties( properties );
			}
			
			if( textformat )
			{
				applyTextFormatProperties( textformat );
			}
			
			setText( text );
		}
		
		
		/**
		* 	The maximum number of pixels wide this textfield
		* 	can be before it is converted to a multiline textfield.
		*/
		public function get maximumWidth():Number
		{
			return _maximumWidth;
		}
		
		public function set maximumWidth( maximumWidth:Number ):void
		{
			_maximumWidth = maximumWidth;
			//force a redraw
			setText( getText() );
		}
		
		/**
		* 	The maximum number of pixels high this textfield
		* 	can be before it stops automatically resizing vertically.
		* 
		* 	This only applies after the maximum width has been reached
		* 	and the textfield has been converted to multiline.
		*/
		public function get maximumHeight():Number
		{
			return _maximumHeight;
		}
		
		public function set maximumHeight( maximumHeight:Number ):void
		{
			_maximumHeight = maximumHeight;
		}		
		
		public function get html():Boolean
		{
			return _html;
		}
		
		public function set html( html:Boolean ):void
		{
			_html = html;
		}
		
		override public function appendText( text:String ):void
		{
			beforeSetText( text );
			super.appendText( text );
			afterSetText( text );
		}
		
		protected function beforeSetText( text:String ):void
		{
			//
		}
		
		protected function afterSetText( text:String ):void
		{
			//
		}
		
		/**
		*	Override to update the textfield contents when the
		* 	maxChars property is set.
		*/
		override public function set maxChars(value:int):void
		{
			super.maxChars = value;
			setText( getText() );
		}
		
		/**
		* 	Sets the text of this textfield.
		*/
		public function setText( text:String ):void
		{
			beforeSetText( text );
			
			//respect maxChars when the text is set with code
			if( maxChars > 0 && text && text.length > maxChars )
			{
				text = text.substr( 0, maxChars );
			}
			
			if( html )
			{
				this.htmlText = text;
			}else
			{
				this.text = text;
			}
			
			//measure();
			
			afterSetText( text );
		}
		
		/**
		* 	Gets the text associated with this textfield.
		*/
		public function getText():String
		{
			return html ? htmlText : text;
		}
		
		public function convertToSingleLine():void
		{
			wordWrap = false;
			multiline = false;
			autoSize = TextFieldAutoSize.LEFT;
		}
		
		public function convertToMultiLine():void
		{
			wordWrap = true;
			multiline = true;
			autoSize = TextFieldAutoSize.LEFT;			
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled( enabled:Boolean ):void
		{
			mouseEnabled = enabled;
			_enabled = enabled;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function applyProperties(
			target:Object, properties:Object ):void
		{
			var merger:PropertiesMerge = new PropertiesMerge();
			merger.merge( target, properties );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function applyTextFieldProperties(
			properties:Object ):void
		{
			applyProperties( this, properties );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function applyTextFormatProperties(
			properties:Object ):void
		{
			var tf:TextFormat = this.defaultTextFormat;
			
			if( tf != null )
			{
				applyProperties( tf, properties );
			}
			
			this.defaultTextFormat = tf;
			//setText( this.text );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getBitmap( matrix:Matrix = null ):Bitmap
		{
			if( matrix == null )
			{
				matrix = new Matrix();
			}
			
			var bitmapData:BitmapData = new BitmapData(
				this.width, this.height, true, 0x00000000 );
			bitmapData.draw( this, matrix );
			return new Bitmap( bitmapData );
		}
		
		public function getVisibleBounds(
			target:DisplayObject = null ):Rectangle 
		{ 
			if( target == null )
			{
				target = this;
			}
			
			var currentBounds:Rectangle = target.getBounds( target );
			
			var matrix:Matrix = new Matrix();
			matrix.translate( Math.abs( currentBounds.left ), Math.abs( currentBounds.top ) );
		
			var radians:Number = target.rotation * Math.PI / 180;
			matrix.rotate( radians );
			matrix.scale( Math.abs( target.scaleX ), Math.abs( target.scaleY ) );
		
			var bitmapData:BitmapData = new BitmapData(
				target.width, target.height, true, 0x00000000 );
			bitmapData.draw( target, matrix );
			var bounds:Rectangle = bitmapData.getColorBoundsRect( 0xFF000000, 0, false );
			bitmapData.dispose();
			
			var output:Rectangle = new Rectangle(
				currentBounds.left,
				currentBounds.top,
				bounds.width,
				bounds.height );
		
			return output;
		}
		
		
		protected function measure():void
		{
			trace("TextComponent::measure(), ", this.width, this.height );
			if( this.width > 0 && this.height > 0 )
			{
				var bounds:Rectangle = getVisibleBounds();
				_measuredWidth = bounds.width;
				_measuredHeight = bounds.height;
			}
		}	
		
		public function get measuredWidth():Number
		{
			return _measuredWidth;
		}	
		
		public function get measuredHeight():Number
		{
			return _measuredHeight;
		}
	}
}