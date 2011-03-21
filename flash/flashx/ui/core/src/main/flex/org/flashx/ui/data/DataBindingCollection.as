package org.flashx.ui.data
{
	
	/**
	*	Encapsulates a collection of data bindings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public class DataBindingCollection extends DataBinding
		implements IDataBindingCollection
	{
		private var _children:Vector.<IDataBinding> = new Vector.<IDataBinding>();
		
		/**
		* 	Creates a <code>DataBindingCollection</code> instance.
		*/
		public function DataBindingCollection()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get children():Vector.<IDataBinding>
		{
			return _children;
		}
	}
}