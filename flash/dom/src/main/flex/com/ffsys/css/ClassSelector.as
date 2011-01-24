package com.ffsys.css
{
	import com.ffsys.dom.*;
	
	/**
	* 	Represents a class selector.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class ClassSelector extends Selector
		implements SimpleSelector
	{
		private var _classes:Vector.<String>;
		
		/**
		* 	Creates a <code>ClassSelector</code> instance.
		* 
		* 	@param classes A list of classes to match
		* 	against.
		*/
		public function ClassSelector( classes:Vector.<String> = null )
		{
			super();
			this.classes = classes;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function test( candidate:Node ):Boolean
		{
			if( !( candidate is Element )
				|| classes == null
				|| classes.length == 0 )
			{
				return false;
			}
			var element:Element = Element( candidate );
			var nm:String = null;
			for( var i:int = 0;i < classes.length;i++ )
			{
				nm = classes[ i ];
				if( !element.hasClass( nm ) )
				{
					return false;
				}
			}
			return true;
		}
		
		/**
		* 	The class selector prefix.
		*/
		override public function get prefix():String
		{
			return Selector.CLASS;
		}
		
		/**
		* 	The classes this selector must match against.
		*/
		public function get classes():Vector.<String>
		{
			return _classes;
		}
		
		public function set classes( value:Vector.<String> ):void
		{
			_classes = value;
		}
	}
}