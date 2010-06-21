package com.ffsys.ui.common.flash
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import flash.text.StyleSheet;	
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	
	/**
	*	Defines the contract for textfield instances.
	*	
	*	This interface is declared so that visual objects
	*	that are typed as interfaces can have the textfield
	* 	properties and methods recognised.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	public interface ITextField extends IInteractiveObject
	{	
		function get alwaysShowSelection():Boolean;
		function set alwaysShowSelection(value:Boolean):void;

		function get antiAliasType():String;
		function set antiAliasType(value:String):void;

		function get autoSize():String;
		function set autoSize(value:String):void;

		function get background():Boolean;
		function set background(value:Boolean):void;

		function get backgroundColor():uint;
		function set backgroundColor(value:uint):void;

		function get border():Boolean;
		function set border(value:Boolean):void;

		function get borderColor():uint;
		function set borderColor(value:uint):void;

		function get caretIndex():int;

		function get condenseWhite():Boolean;
		function set condenseWhite(value:Boolean):void;

		function get defaultTextFormat():TextFormat;
		function set defaultTextFormat(value:TextFormat):void;

		function get displayAsPassword():Boolean;
		function set displayAsPassword(value:Boolean):void;

		function get embedFonts():Boolean;
		function set embedFonts(value:Boolean):void;

		function get gridFitType():String;
		function set gridFitType(value:String):void;

		function get htmlText():String;
		function set htmlText(value:String):void;

		function get length():int;

		function get maxChars():int;
		function set maxChars(value:int):void;

		function get maxScrollH():int;

		function get maxScrollV():int;

		function get mouseWheelEnabled():Boolean;
		function set mouseWheelEnabled(value:Boolean):void;

		function get multiline():Boolean;
		function set multiline(value:Boolean):void;

		function get numLines():int;

		function get restrict():String;
		function set restrict(value:String):void;

		function get scrollH():int;
		function set scrollH(value:int):void;

		function get scrollV():int;
		function set scrollV(value:int):void;

		function get selectable():Boolean;
		function set selectable(value:Boolean):void;

		function get selectionBeginIndex():int;

		function get selectionEndIndex():int;

		function get sharpness():Number;
		function set sharpness(value:Number):void;

		function get styleSheet():StyleSheet;
		function set styleSheet(value:StyleSheet):void;

		function get text():String;
		function set text(value:String):void;

		function get textColor():uint;
		function set textColor(value:uint):void;

		function get textHeight():Number;

		function get textWidth():Number;

		function get thickness():Number;
		function set thickness(value:Number):void;

		function get type():String;
		function set type(value:String):void;

		function get useRichTextClipboard():Boolean;
		function set useRichTextClipboard(value:Boolean):void;

		function get wordWrap():Boolean;
		function set wordWrap(value:Boolean):void;


		function appendText(newText:String):void;
		function getCharBoundaries(charIndex:int):Rectangle;
		function getCharIndexAtPoint(x:Number, y:Number):int;
		function getFirstCharInParagraph(charIndex:int):int;
		function getImageReference(id:String):DisplayObject;
		function getLineIndexAtPoint(x:Number, y:Number):int;
		function getLineIndexOfChar(charIndex:int):int;
		function getLineLength(lineIndex:int):int;
		function getLineMetrics(lineIndex:int):TextLineMetrics;
		function getLineOffset(lineIndex:int):int;
		function getLineText(lineIndex:int):String;
		function getParagraphLength(charIndex:int):int;
		function getTextFormat(beginIndex:int = -1, endIndex:int = -1):TextFormat;
		
		//function isFontCompatible(fontName:String, fontStyle:String):Boolean;
		
		function replaceSelectedText(value:String):void;
		function replaceText(beginIndex:int, endIndex:int, newText:String):void;
		function setSelection(beginIndex:int, endIndex:int):void;
		function setTextFormat(format:TextFormat, beginIndex:int = -1, endIndex:int = -1):void;
	}
}