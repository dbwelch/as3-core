package com.ffsys.swat.fonts {
	
	import flash.display.Sprite;
	
	/**
	*	Fonts common to all locales.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.07.2010
	*/
	public class FontsCommon extends Sprite {
		[Embed(mimeType="application/x-font",source="../../../../../resources/arial.ttf",fontName="main",embedAsCFF="true")]
		static public var mainFontClass:Class;
	}
}