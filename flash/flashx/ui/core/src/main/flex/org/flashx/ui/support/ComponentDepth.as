package org.flashx.ui.support
{
	import flash.display.*;
	
	import org.flashx.ui.common.*;	
	import org.flashx.ui.core.*;

	/**
	*	Provides support for manipulating the depth of components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.01.2011
	*/
	public class ComponentDepth extends Object
		implements IComponentDepth
	{
		private var _component:IComponent;
		
		/**
		* 	Creates a <code>ComponentDepth</code> instance.
		* 
		* 	@param component The component whose depth is being managed.
		*/
		public function ComponentDepth(
			component:IComponent = null )
		{
			super();
			this.component = component;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get component():IComponent
		{
			return _component;
		}
		
		public function set component( value:IComponent ):void
		{
			_component = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function up( amount:uint = 1 ):Boolean
		{
			if( !canHandleDepthChange() )
			{
				return false;
			}
			var previous:int = this.current;
			var index:int = constrainIndex( this.index + amount );
			_component.parent.setChildIndex(
				DisplayObject( _component ), index );
			return previous != current;
		}
		
		/**
		*	@inheritDoc
		*/
		public function down( amount:uint = 1 ):Boolean
		{
			if( !canHandleDepthChange() )
			{
				return false;
			}
			var previous:int = this.current;
			var index:int = constrainIndex( this.index - amount );
			_component.parent.setChildIndex(
				DisplayObject( _component ), index );
			return previous != current;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get current():int
		{
			return this.index;
		}
		
		public function set current( value:int ):void
		{
			if( !canHandleDepthChange() || value < 0 )
			{
				return;
			}
						
			var previous:int = this.current;
			
			//ignore same values
			if( value == previous )
			{
				return;
			}
			var index:int = constrainIndex( value );
			_component.parent.setChildIndex(
				DisplayObject( _component ), index );
		}
		
		/**
		* 	@private
		*/
		private function get index():int
		{
			if( !canHandleDepthChange() )
			{
				return -1;
			}
			return _component.parent.getChildIndex(
				DisplayObject( _component ) );
		}
		
		/**
		* 	@private
		* 
		* 	Constrains a target depth index.
		*/
		private function constrainIndex( index:int ):int
		{
			index = Math.max( 0, index );
			index = Math.min( _component.parent.numChildren - 1, index );
			return index;
		}
		
		/**
		* 	@private
		*/
		private function canHandleDepthChange():Boolean
		{
			return ( _component != null
			 	&& _component.parent != null
			 	&& _component.parent.numChildren > 1 );
		}
		
		/**
		* 	Cleans componsite references.
		*/
		public function destroy():void
		{
			_component = null;
		}
	}
}