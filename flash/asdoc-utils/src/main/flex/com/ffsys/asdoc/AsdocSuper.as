package com.ffsys.asdoc
{
	import flash.display.Sprite;
	
	import com.ffsys.asdoc.interfaces.*;
	
	/**
	*	A super class for the <em>actionscript documentation</em> test package.
	* 
	* 	@see com.ffsys.asdoc.interfaces.IAsdocObject
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public class AsdocSuper extends Object
		implements IAsdocObject, IAsdocAlt
	{
		private var _id:String;
		
		/**
		* 	Creates an <code>AsdocSuper</code> instance.
		*/
		public function AsdocSuper()
		{
			super();
		}
		
		/**
		* 	An identifier for this instance.
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get sprite():Sprite
		{
			return new Sprite();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function flush():void
		{
			//
		}
	}
}