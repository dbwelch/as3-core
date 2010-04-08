package com.ffsys.core.processor {
	
	import com.ffsys.core.address.AddressPath;
	import com.ffsys.core.address.IAddressPath;
	
	/**
	*	Represents a processor that operates on an
	*	<code>IAddressPath</code> instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.09.2007
	*/
	public class AddressPathProcessor extends PropertyProcessor
		implements IAddressPathProcessor {
		
		/**
		*	@private
		*/
		protected var _addressPath:IAddressPath;
		
		/**
		*	Creates an <code>AddressPathProcessor</code> instance.
		*	
		*	@param address The <code>String</code> address used to create
		*	an <code>AddressPath</code> instance that will be used by this
		*	processor.
		*/
		public function AddressPathProcessor(
			address:String = null )
		{
			super();
			
			if( address )
			{
				addressPath = new AddressPath( address );
			}
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set addressPath( val:IAddressPath ):void
		{
			_addressPath = val;
			
			if( val )
			{
				length = val.getLength();
			}
		}
		
		public function get addressPath():IAddressPath
		{
			return _addressPath;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function isTopLevelRequest():Boolean
		{
			return addressPath.isTopLevelPath();
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function isRootRequest():Boolean
		{
			return addressPath.isRootPath();
		}
		
		//--> move to super class and override?
		public function get nextProperty():String
		{
			return addressPath.getPathElementAt( position + 1 );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function process( index:int = 0 ):*
		{
			if( index > ( length - 1 ) )
			{
				return false;
			}
			
			property = addressPath.getPathElementAt( index );
			
			super.process( index );
		}
	}
}