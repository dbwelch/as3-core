package com.ffsys.ui.common {
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	
	/**
	*	Describes the contract for sprite instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public interface ISprite extends IDisplayObjectContainer {
		
		function get buttonMode():Boolean;
		function set buttonMode(value:Boolean):void;
		
		function get dropTarget():DisplayObject;
		
		function get graphics():Graphics;
		
		function get hitArea():Sprite;
		function set hitArea(value:Sprite):void;
		
		function get soundTransform():SoundTransform;
		function set soundTransform(value:SoundTransform):void;
		
		function get useHandCursor():Boolean;
		function set useHandCursor(value:Boolean):void;
		
		function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void;
		function stopDrag():void;
	}
}