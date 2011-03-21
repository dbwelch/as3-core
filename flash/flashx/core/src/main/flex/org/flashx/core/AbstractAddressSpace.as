package org.flashx.core {

	import flash.events.EventDispatcher;
	
	import org.flashx.utils.string.AddressUtils;
	
	/**
	*	Encapsulates a <code>uri</code> associated with an
	*	address space.
	*	
	*	The <code>uri</code> for an address space is determined
	*	by concatenating the <code>baseUri</code> and
	*	<code>relativeUri</code> values associated with the
	*	address space.
	*	
	*	Address space instances can also have an <code>id</code>
	*	and <code>type</code> specified.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  20.05.2007
	*/
	public class AbstractAddressSpace extends EventDispatcher
		implements IAddressSpace {
		
		private var _id:String;
		private var _baseUri:String;
		private var _relativeUri:String;
		private var _type:String;
		
		public function AbstractAddressSpace(
			baseUri:String = "",
			relativeUri:String = "" )
		{
			super();
			this.baseUri = baseUri;
			this.relativeUri = relativeUri;
		}
		
		/**
		*	A unique <code>id</code> for this address space.
		*/
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		public function get id():String
		{
			return _id;
		}		
		
		/**
		*	@inheritDoc
		*/
		public function set baseUri( val:String ):void
		{
			_baseUri = val;
		}
		
		public function get baseUri():String
		{
			return _baseUri;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set relativeUri( val:String ):void
		{
			_relativeUri = val;
		}
		
		public function get relativeUri():String
		{
			return _relativeUri;
		}
		
		/**
		*	A <code>type</code> associated with this address space.
		*/
		public function set type( val:String ):void
		{
			_type = val;
		}
		
		public function get type():String
		{
			return _type;
		}				
		
		/**
		*	@inheritDoc
		*/
		public function get uri():String
		{
			return AddressUtils.concatenate( this.baseUri, this.relativeUri );
		}
	}
}