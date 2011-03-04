package com.ffsys.ui.css {
	
	import flash.filters.BitmapFilter;
	import flash.text.TextFormat;
	import flash.net.URLRequest;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.resources.StyleSheetResource;
	
	import com.ffsys.ui.common.IStyleAware;	
	
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
		* 	Modifies the default behaviour to ensure a style sheet document
		* 	is created.
		*/
		override public function get document():IBeanDocument
		{
			if( _document == null )
			{
				_document = StyleSheetFactory.create();
			}
			
			return _document;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get stylesheet():ICssStyleSheet
		{
			return ICssStyleSheet( this.document );
		}
		
		/**
		*	@inheritDoc
		*/
		public function addStyleSheet(
			request:URLRequest ):ICssStyleSheet
		{
			return ICssStyleSheet( addBeanDocument( request ) );
		}
			
		/**
		*	@inheritDoc
		*/
		public function removeStyleSheet(
			request:URLRequest ):Boolean
		{
			return removeBeanDocument( request );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasStyle( styleName:String ):Boolean
		{
			if( styleName != null && this.stylesheet )
			{
				return this.stylesheet.hasStyle( styleName );
			}
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			if( styleName != null && this.stylesheet )
			{
				return this.stylesheet.setStyle( styleName, style );
			}			
		}
		
		/**
		*	@inheritDoc
		*/
		public function getStyle( styleName:String ):Object
		{
			if( styleName != null && this.stylesheet )
			{
				return this.stylesheet.getStyle( styleName );
			}
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyles( styleName:String ):Array
		{
			var output:Array = new Array();
			if( styleName != null && this.stylesheet )
			{
				return this.stylesheet.getStyles( styleName );
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
			if( styleName != null && this.stylesheet )
			{
				return this.stylesheet.getFilter( styleName );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyleNameList( target:IStyleAware, ... custom ):Array
		{
			var styles:Array = new Array();
			if( target != null && this.stylesheet )
			{
				if( custom == null )
				{
					custom = new Array();
				}
				custom.unshift( target );
				styles = this.stylesheet.getStyleNameList.apply( this.stylesheet, custom );
			}
			return styles;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyleNames( target:IStyleAware, ... custom ):String
		{
			var styles:String = null;
			if( target != null && this.stylesheet )
			{
				if( custom == null )
				{
					custom = new Array();
				}
				custom.unshift( target );
				styles = this.stylesheet.getStyleNames.apply( this.stylesheet, custom );
			}
			return styles;
		}

		/**
		* 	@inheritDoc
		*/
		public function getStyleObjects( target:IStyleAware, ... custom ):Array
		{
			var styles:Array = new Array();
			if( target != null && this.stylesheet )
			{
				if( custom == null )
				{
					custom = new Array();
				}
				custom.unshift( target );
				styles = this.stylesheet.getStyleObjects.apply( this.stylesheet, custom );
			}
			return styles;
		}
		
		/**
		*	@inheritDoc
		*/
		public function apply(
			target:Object,
			styleName:String ):Array
		{
			var styles:Array = new Array();
			if( target != null && styleName != null && this.stylesheet )
			{
				styles = this.stylesheet.apply( target, styleName );
			}
			return styles;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function style( target:IStyleAware, ...custom ):Array
		{
			if( target && this.stylesheet )
			{
				if( custom == null )
				{
					custom = new Array();
				}
				custom.unshift( target );
				return this.stylesheet.style.apply( this.stylesheet, custom );
			}
			return null;
		}
	}
}