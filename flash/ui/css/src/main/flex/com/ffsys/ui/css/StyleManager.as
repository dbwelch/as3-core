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
			if( styleName != null )
			{
				var documents:Vector.<IBeanDocument> = this.documents;
				var doc:IBeanDocument = null;
				var css:ICssStyleSheet = null;
				var style:Object = null;			
				for each( doc in documents )
				{
					css = doc as ICssStyleSheet;
					if( css )
					{
						style = css.getStyle( styleName );
						if( style )
						{
							return style;
						}
					}
				}
			}
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyles( styleName:String ):Array
		{
			var output:Array = new Array();
			if( styleName != null )
			{
				var documents:Vector.<IBeanDocument> = this.documents;
				var doc:IBeanDocument = null;
				var css:ICssStyleSheet = null;
				var styles:Array = null;			
				for each( doc in documents )
				{
					css = doc as ICssStyleSheet;
					if( css )
					{
						styles = css.getStyles( styleName );
						if( styles && styles.length > 0 )
						{
							output = output.concat.apply( output, styles );
						}
					}
				}
			}
			return output;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get styleNames():Array
		{
			return this.beanNames;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( styleName:String ):BitmapFilter
		{
			if( styleName != null )
			{
				var documents:Vector.<IBeanDocument> = this.documents;
				var doc:IBeanDocument = null;
				var css:ICssStyleSheet = null;
				var filter:BitmapFilter = null;
				for each( doc in documents )
				{
					css = doc as ICssStyleSheet;
					if( css )
					{
						filter = css.getFilter( styleName );
						if( filter )
						{
							return filter;
						}
					}
				}
			}
			return null;
		}
	}	
}