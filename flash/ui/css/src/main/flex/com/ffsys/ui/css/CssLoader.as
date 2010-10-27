package com.ffsys.ui.css {
	
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.types.StylesheetLoader;
	
	/**
	*	Responsible for loading css files that can
	*	declare external file dependencies.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public class CssLoader extends StylesheetLoader {
		
		private var _css:ICssStyleSheet;
		
		/**
		*	Creates a <code>CssLoader</code> instance.
		*	
		*	@param request The url request.
		*	@param options The load options.
		*/
		public function CssLoader(
			request:URLRequest = null,
			options:ILoadOptions = null	)
		{
			super( request, options );
		}
		
		/**
		*	The css style collection to parse the css
		*	text file into.
		*/
		public function get css():ICssStyleSheet
		{
			return _css;
		}
		
		public function set css( css:ICssStyleSheet ):void
		{
			_css = css;
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function parse( text:String ):StyleSheet
		{
			var sheet:ICssStyleSheet = css ? css : StyleSheetFactory.create();
			sheet.parse( text );
			return StyleSheet( sheet );
		}
	}
}