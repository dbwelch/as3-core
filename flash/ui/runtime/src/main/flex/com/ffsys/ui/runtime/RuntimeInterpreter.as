package com.ffsys.ui.runtime {
	
	import flash.filters.BitmapFilter;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.css.IStyleAware;
	
	//import com.ffsys.io.xml.Deserializer;
	import com.ffsys.io.xml.DeserializeInterpreter;
	//import com.ffsys.utils.substitution.Binding;
	
	/**
	*	Interpreter for the runtime view document parser.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.10.2010
	*/
	public class RuntimeInterpreter extends DeserializeInterpreter {
		
		/**
		*	Creates a <code>RuntimeInterpreter</code> instance.
		*	
		*	@param useStringReplacement Whether string replacement should be
		*	performed.
		*	@param strictStringReplacement Whether string replacement performs
		*	in a strict manner.
		*/
		public function RuntimeInterpreter(
			useStringReplacement:Boolean = true,
			strictStringReplacement:Boolean = true )
		{
			super( useStringReplacement, strictStringReplacement );
		}
		
		/**
		*	Invoked when parsing is complete.
		*	
		*	Updates the bindings of the parser so that the
		*	configuration can use lookup in the <code>locale</code>
		*	binding namespace.
		*	
		*	@param instance The root instance of the object graph.
		*/
		override public function complete( instance:Object ):void
		{
			
			/*
			var configuration:IConfiguration = IConfiguration( instance );
			
			if( configuration.locales == null )
			{
				throw new Error( "The locales element was not specified." );
			}
			
			//update the selected locale
			configuration.locales.lang = flashvars.lang;
			
			//add the current locale as a default namespace
			Deserializer.defaultStringSubstitutions.addBinding(
				new Binding(
					"locale",
					configuration.locales.current )
			);
			
			//add the configuration as a default binding
			Deserializer.defaultStringSubstitutions.addBinding(
				new Binding(
					"configuration",
					configuration )
			);			
			
			//ensure we always have some path information
			//even if none is declared in the config
			if( configuration.paths == null )
			{
				configuration.paths = new Paths();
			}
			
			//assign the path to the current locale
			configuration.paths.locale = configuration.paths.getLocalePath(
				IConfigurationLocale( configuration.locales.current ) );
			
			//add the paths as a default binding
			Deserializer.defaultStringSubstitutions.addBinding(
				new Binding(
					"paths",
					configuration.paths )
			);
			*/
			
			super.complete( instance );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function shouldSetProperty(
			parent:Object, name:String, value:* ):Boolean
		{
			if( name == "filters" )
			{
				if( UIComponent.styleManager && parent is DisplayObject )
				{
					var display:DisplayObject = DisplayObject( parent );
					var filters:Array = display.filters ? display.filters : new Array();
					var ids:Array = String( value ).split( " " );
					var filter:BitmapFilter = null
					for( var i:int = 0;i < ids.length;i++ )
					{
						filter = UIComponent.styleManager.getFilter( ids[ i ] );
						filters.push( filter );
					}
					display.filters = filters;
				}
				
				return false;
			}
			
			if( value is DisplayObject )
			{
				return false;
			}
			
			//trace("RuntimeInterpreter::shouldSetProperty(), ", parent, name, value );
			
			return true;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function postProcessClass(
			instance:Object, parent:Object ):void
		{
			if( instance is DisplayObject )
			{
				var child:DisplayObject = DisplayObject( instance );
				
				if( child is IComponentGraphic )
				{
					var graphic:IComponentGraphic = IComponentGraphic( child );
					graphic.draw(
						graphic.preferredWidth, graphic.preferredHeight );
				}
				
				if( parent is DisplayObjectContainer )
				{
					//set the styles property after all other deserialization
					if( child is IStyleAware )
					{
						IStyleAware( child ).applyStyles();
					}					
					
					DisplayObjectContainer( parent ).addChild( child );
				}
			}
		}
	}
}