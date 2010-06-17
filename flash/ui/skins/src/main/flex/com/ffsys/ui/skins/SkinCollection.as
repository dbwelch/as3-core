package com.ffsys.ui.skins
{	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import com.ffsys.ui.core.IComponent;
	
	/**
	* 	Encapsulates a collection of skins stored by class identifier
	* 	or instance identifier.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/	
	public class SkinCollection extends Object
		implements ISkinCollection
	{
		private var _classes:Dictionary = new Dictionary( true );
		private var _instances:Dictionary = new Dictionary( true );
		
		/**
		* 	Creates a <code>SkinCollection</code> instance.
		*/
		public function SkinCollection()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function addComponentClassSkin(
			clazz:Class, skin:IComponentSkin ):void
		{
			if( clazz && skin )
			{
				_classes[ clazz ] = skin;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function addComponentSkin(
			component:IComponent, skin:IComponentSkin ):void
		{
			if( component && skin && component.id )
			{
				_instances[ component.id ] = skin;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getComponentSkin(
			component:IComponent ):IComponentSkin
		{
			var id:String = component.id;
			var skin:IComponentSkin = null;
			
			skin = IComponentSkin( _instances[ id ] );
			
			//no instance skin retrieve by class
			if( !skin )
			{
				skin = _classes[ getComponentClass( component ) ];
			}
			
			return skin;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getComponentClass(
			component:IComponent ):Class
		{
			var clazz:Class = null;
			
			if( component )
			{
				try
				{
					clazz = Class( getDefinitionByName(
						getQualifiedClassName( component ) ) );
				}catch( e:Error )
				{
					//we should never get to here
					throw new Error( "Could not determine the class of a component implementation." );
				}
			}
			
			return clazz;
		}
	}
}