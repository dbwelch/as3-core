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
		[Embed(mimeType="application/x-font",source="../../../../../resources/arial.ttf",fontName="main",embedAsCFF="false",unicodeRange="U+0020,U+002E,U+0410,U+041F,U+0431,U+0432,U+0433,U+0435,U+0438,U+0439,U+043A,U+043B,U+043C,U+043D,U+043E,U+0440,U+0441,U+0442,U+0449,U+D0B1")]
		static public var mainFontClass:Class;
	}
}