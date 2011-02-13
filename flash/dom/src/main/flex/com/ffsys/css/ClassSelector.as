package com.ffsys.css
{
	import com.ffsys.dom.core.*;
	
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
		private var _targets:Vector.<String>;
		
		/**
		* 	Creates a <code>ClassSelector</code> instance.
		* 
		* 	@param targets A list of targets to match
		* 	against.
		*/
		public function ClassSelector( targets:Vector.<String> = null )
		{
			super();
			this.targets = targets;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function test( candidate:Node ):Boolean
		{
			if( !( candidate is Element )
				|| targets == null
				|| targets.length == 0 )
			{
				return false;
			}
			var element:Element = Element( candidate );
			var nm:String = null;
			for( var i:int = 0;i < targets.length;i++ )
			{
				nm = targets[ i ];
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
		* 	The targets this selector must match against.
		*/
		public function get targets():Vector.<String>
		{
			return _targets;
		}
		
		public function set targets( value:Vector.<String> ):void
		{
			_targets = value;
		}
	}
}