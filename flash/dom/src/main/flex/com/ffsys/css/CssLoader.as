package com.ffsys.css {
	
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.types.StyleSheetLoader;
	
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
	public class CssLoader extends BeanLoader {
		
		private var _css:CssStyleSheet;
		
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
		* 	Overriden to prevent the parser being set to anything
		* 	other than a text parser.
		*/
		override public function set parser( value:IBeanParser ):void
		{
			if( value && !( value is BeanTextParser ) )
			{
				throw new Error( "The parser for a css loader must be a text parser." );
			}
			super.parser = value;
		}
		
		/**
		*	The css style collection to parse the css
		*	text file into.
		*/
		public function get css():CssStyleSheet
		{
			return _css;
		}
		
		public function set css( css:CssStyleSheet ):void
		{
			_css = css;
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function parse( text:String ):Object
		{
			return super.parse( text );
		}
	}
}