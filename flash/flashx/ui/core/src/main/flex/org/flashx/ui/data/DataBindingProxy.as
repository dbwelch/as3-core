package org.flashx.ui.data
{
	
	/**
	*	Composites data binding implementations and proxies
	* 	notifications to the composite data bindings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2010
	*/
	public class DataBindingProxy extends DataBinding
		implements IDataBindingProxy
	{
		private var _composites:Vector.<IDataBinding> = new Vector.<IDataBinding>();
		
		/**
		* 	Creates a <code>DataBindingProxy</code> instance.
		*/
		public function DataBindingProxy()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getDataBindingByType( clazz:Class ):IDataBinding
		{
			var result:IDataBinding = null;
			var binding:IDataBinding = null;
			for(var i:int = 0;i < _composites.length;i++)
			{
				binding = _composites[ i ];
				if( binding is clazz )
				{
					return binding;
				}
			}
			return result;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeDataBinding( binding:IDataBinding ):Boolean
		{
			var index:int = _composites.indexOf( binding );
			if( index > -1 )
			{
				_composites.splice( index, 1 );
				return true;
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasDataBinding( binding:IDataBinding ):Boolean
		{
			return ( binding && _composites.indexOf( binding ) > -1 )
		}
		
		/**
		*	@inheritDoc
		*/
		public function addDataBinding( binding:IDataBinding ):void
		{
			if( binding && !hasDataBinding( binding ) )
			{
				_composites.push( binding );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function notify( notification:IDataBindingNotification ):void
		{
			for( var i:int = 0;i < _composites.length;i++ )
			{
				_composites[ i ].notify( notification );
			}
		}
	}
}