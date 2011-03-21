package org.flashx.core.processor {
	
	/**
	*	Encapsulates a local address space context
	*	for a processor.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.09.2007
	*/
	public class ProcessorAddressSpace extends Object {
		
		/**
		*	@private
		*	
		*	Determines whether <code>strict</code> mode is enabled.
		*/
		private var _strict:Boolean;
		
		/**
		*	@private
		*	
		*	Determines whether addresses are automatically
		*	mapped to a public property chain.
		*/
		private var _lookup:Boolean;
		
		/**
		*	@private
		*/
		private var _root:IRootAddress;
		
		/**
		*	Creates a <code>ProcessorAddressSpace</code>
		*	instance.
		*/
		public function ProcessorAddressSpace(
			root:IRootAddress = null )
		{
			super();
			this.root = root;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set strict( val:Boolean ):void
		{
			_strict = val;
		}	
		
		public function get strict():Boolean
		{
			return _strict;
		}
		
		/**
		*	Determines whether property lookup should occur.	
		*/
		public function set lookup( val:Boolean ):void
		{
			_lookup = val;
		}	
		
		public function get lookup():Boolean
		{
			return _lookup;
		}
		
		/**
		*	The root controller used for property lookup.
		*/
		public function get root():IRootAddress
		{
			return _root;
		}

		public function set root( root:IRootAddress ):void
		{
			if( !root )
			{
				root = new ProcessorAddressSpaceRoot();
			}
		
			_root = root;
		}
	}
}