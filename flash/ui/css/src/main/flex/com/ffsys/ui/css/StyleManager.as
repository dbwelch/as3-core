package com.ffsys.ui.css {
	
	import flash.events.EventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.ffsys.di.*;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.StyleSheetResource;
	
	import com.ffsys.utils.substitution.*;	
	
	/**
	*	Responsible for managing a collection of style sheets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public class StyleManager extends BeanManager
		implements IStyleManager {
		
		/**
		*	Creates a <code>StyleManager</code> instance.
		*/
		public function StyleManager()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function addStyleSheet(
			sheet:ICssStyleSheet = null,
			request:URLRequest = null ):ICssStyleSheet
		{
			if( sheet == null )
			{
				sheet = StyleSheetFactory.create();
			}
			return ICssStyleSheet( addBeanDocument( sheet ) );
		}
			
		/**
		*	@inheritDoc
		*/
		public function removeStyleSheet(
			sheet:ICssStyleSheet ):Boolean
		{
			return removeBeanDocument( sheet );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyleSheet( id:String ):ICssStyleSheet
		{
			return ICssStyleSheet( getBeanDocument( id ) );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getStyle( styleName:String ):Object
		{
			var css:ICssStyleSheet = null;
			var style:Object = null;
			var entry:StyleSheetEntry = null;
			for each( entry in _styleSheets )
			{
				css = ICssStyleSheet( entry.sheet );
				style = css.getStyle( styleName );
				if( style )
				{
					return style;
				}
			}
			
			return super.getStyle( styleName );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyles( styleName:String ):Array
		{
			var output:Array = new Array();
			var css:ICssStyleSheet = null;
			var styles:Array = null;
			var entry:StyleSheetEntry = null;
			for each( entry in _styleSheets )
			{
				css = ICssStyleSheet( entry.sheet );
				styles = css.getStyles( styleName );
				if( styles && styles.length > 0 )
				{
					output = output.concat( styles );
				}
			}
			
			return output;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get styleNames():Array
		{
			var output:Array = super.styleNames;
			
			var css:ICssStyleSheet = null;
			var entry:StyleSheetEntry = null;
			var styles:Array = null;
			for each( entry in _styleSheets )
			{
				css = ICssStyleSheet( entry.sheet );
				styles = css.styleNames;
				if( styles )
				{
					output = output.concat( styles );
				}
			}
			
			return output;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( styleName:String ):BitmapFilter
		{
			var css:ICssStyleSheet = null;
			var filter:BitmapFilter = null;
			var entry:StyleSheetEntry = null;
			for each( entry in _styleSheets )
			{
				css = ICssStyleSheet( entry.sheet );
				filter = css.getFilter( styleName );
				if( filter )
				{
					return filter;
				}
			}
			
			return super.getFilter( styleName );
		}
	}	
}