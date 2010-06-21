package com.ffsys.ui.common.flash {
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.text.TextSnapshot;
	
	/**
	*	Defines the contract for display object container instances.
	*	
	*	This interface is declared so that visual objects
	*	that are typed as interfaces can have the display
	*	object container properties and methods recognised.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.06.2010
	*/
	public interface IDisplayObjectContainer extends IInteractiveObject {
		
		function get mouseChildren():Boolean;
		function set mouseChildren(value:Boolean):void;
	
		function get numChildren():int;
	
		function get tabChildren():Boolean;
		function set tabChildren(value:Boolean):void;

		function get textSnapshot():TextSnapshot;
		
		function addChild(child:DisplayObject):DisplayObject;
		
		function addChildAt(child:DisplayObject, index:int):DisplayObject;
		
		function areInaccessibleObjectsUnderPoint(point:Point):Boolean;
		
		function contains(child:DisplayObject):Boolean;
		
		function getChildAt(index:int):DisplayObject;
		
		function getChildByName(name:String):DisplayObject;
		
		function getChildIndex(child:DisplayObject):int;
		
		function getObjectsUnderPoint(point:Point):Array;
		
		function removeChild(child:DisplayObject):DisplayObject;
		
		function removeChildAt(index:int):DisplayObject;
		
		function setChildIndex(child:DisplayObject, index:int):void;
		
		function swapChildren(child1:DisplayObject, child2:DisplayObject):void;
		
		function swapChildrenAt(index1:int, index2:int):void;
	}
}