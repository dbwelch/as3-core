package com.ffsys.ui.runtime {
	
	import flash.filters.BitmapFilter;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;
	import com.ffsys.ui.css.IStyleAware;
	
	import com.ffsys.io.xml.DeserializeInterpreter;
	import com.ffsys.utils.substitution.Binding;
	import com.ffsys.utils.substitution.IBinding;
	
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
		*	This method adds the bindings that were specified
		* 	when the load method was invoked.
		*	
		*	@param instance The root instance of the object graph.
		*/
		override public function complete( instance:Object ):void
		{
			var document:IDocument  = instance as Document;
			
			if( document )
			{
				var binding:IBinding = null;
				for( var i:int = 0;i < bindings.getLength();i++ )
				{
					binding = bindings.getBindingAt( i );
					
					trace("RuntimeInterpreter::complete()", binding, binding.prefix, binding.target );
					
					var re:RegExp = new RegExp( "^" + Runtime.DOCUMENT_BINDING );
				
					if( binding
						&& re.test( binding.prefix )
						&& binding.target )
					{
						for( var z:Object in binding.target )
						{
							document.binding[ z ] = binding.target[ z ];
							trace("RuntimeInterpreter::complete() ASSIGNING BINDING PROPERTY: ", z, document.binding[ z ] );
						}
					}
				}
				
				bindings.addBinding(
					new Binding( Runtime.BINDING, document.binding ) );
			}
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