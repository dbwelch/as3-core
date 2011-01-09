package com.ffsys.ui.containers {
	
	import flash.display.DisplayObject;
	import flash.geom.*;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.ui.core.*;
	import com.ffsys.ui.common.*;	
	import com.ffsys.ui.layout.*;
	
	/**
	*	A container designed to behave like an html div element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.01.2011
	*/
	public class DivContainer extends Container
		implements IDivContainer {
		
		public static const INLINE:String = "inline";
		public static const BLOCK:String = "block";
		
		private var _display:String;
		private var _position:String;
		private var _overflow:String;
		
		/**
		*	Creates a <code>DivContainer</code> instance.
		*/
		public function DivContainer()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		//TODO: move to DivDivContainer
		public function get display():String
		{
			return _display;
		}
		
		public function set display( value:String ):void
		{
			_display = value;
			
			if( _display != null )
			{
				switch( _display )
				{
					case INLINE:
						layout = new HorizontalLayout( this.spacing );
						break;
					case BLOCK:
						layout = new VerticalLayout( this.spacing );
						break;
					default:
						throw new Error( "Unknown container display property '" + _display + "'." );
				}
				
				if( numChildren > 0 )
				{
					update();
				}
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_display = null;
			_position = null;
			_overflow = null;
		}
	}
}