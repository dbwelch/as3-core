package com.ffsys.ui.core
{
	import flash.display.Sprite;
	
	import com.ffsys.ui.text.TextFieldFactory;

	/**
	*	Abstract super class for all components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class AbstractComponent extends Sprite
		implements IComponent
	{	
		static private var _textFieldFactory:TextFieldFactory
			= new TextFieldFactory();
		
		/**
		* 	Creates an <code>AbstractComponent</code> instance.
		*/
		public function AbstractComponent()
		{
			super();
		}
		
		/**
		* 	Gets the text field factory used by all components.
		*/
		public function get textFieldFactory():TextFieldFactory
		{
			return _textFieldFactory;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get enabled():Boolean
		{
			return mouseEnabled;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set enabled( enabled:Boolean ):void
		{
			mouseEnabled = enabled;
			mouseChildren = enabled;
		}
	}
}