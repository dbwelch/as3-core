package com.ffsys.utils.byte {
	
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	
	/**
	*	Represents <code>Boolean</code> flags on a bit level.
	*	
	*	Defaults to representing 8 <code>Boolean</code>
	*	values in a single byte but can be used to
	*	store more flags by setting a multiple of 8
	*	as the length value.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.12.2007
	*/
	public class BitStore extends Proxy
		implements IBitStore {
		
		/**
		*	@private
		*/
		private var _bytes:ByteArray;
		
		/**
		*	@private	
		*/
		private var _length:int;
		
		/**
		*	Creates a <code>BitStore</code> instance.
		*	
		*	If the <code>bytes</code> parameter is
		*	<code>null</code> a new <code>ByteArray</code>
		*	will be created.
		*	
		*	@param bytes The source <code>ByteArray</code>
		*	for the bit flags.
		*	@param length The number of bytes to be used.
		*/
		public function BitStore(
			bytes:ByteArray = null, length:int = 1 )
		{
			super();
			
			if( !bytes )
			{
				bytes = new ByteArray();
				bytes.length = length;
			}
			
			this.bytes = bytes;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set bytes( val:ByteArray ):void
		{
			_bytes = val;
		}
		
		public function get bytes():ByteArray
		{
			return _bytes;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set length( val:uint ):void
		{
			if( val != _bytes.length )
			{
				//all false by default
				_bytes.length = val;
			}
		}
		
		public function get length():uint
		{
			return _bytes.length;
		}
		
		/**
		*	@private	
		*/
		protected function getByteIndex( index:int ):int
		{
			return Math.floor( index / 8 );
		}
		
		/**
		*	@private	
		*/
		protected function readByteAt( index:int ):int
		{
			_bytes.position = index;
			
			var value:int = _bytes.readUnsignedByte();
			
			return value;
		}
		
		/**
		*	@private	
		*/
		protected function writeByteAt( index:int, byte:Number ):void
		{
			var write:ByteArray = new ByteArray();
			
			var i:int = 0;
			var l:int = _bytes.length;
			
			var value:int;
			
			_bytes.position = 0;		
			
			for( ;i < l;i++ )
			{
				value = _bytes.readByte();
				
				if( i == index )
				{
					write.writeByte( byte );					
				}else{
					write.writeByte( value );
				}
				
			}
			
			_bytes = write;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function setBitAt( index:int, flag:Boolean ):void
		{
			if( index < 0 ||
				index > ( ( length * 8 ) - 1 ) )
			{
				return;
			}
			
			var byteIndex:int = getByteIndex( index );
			
			var byte:int = readByteAt( byteIndex );
			
			//get the bit level index for a single byte
			index -= ( byteIndex * 8 );
			
			//trace("BitStore::setProperty(), bit index " + index );
			
			byte = ByteUtils.setBitAt( byte, index, flag, 8 );
			
			writeByteAt( byteIndex, byte );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function getBitAt( index:int ):Boolean
		{
			if( index < 0 ||
				index > ( ( length * 8 ) - 1 ) )
			{
				return false;
			}
			
			//trace("BitStore::getBitAt(), index " + index );

			//get the byte index
			var byteIndex:int = getByteIndex( index );
			
			//trace("BitStore::getBitAt(), byte index " + byteIndex );
			
			//get the byte value
			var byte:int = readByteAt( byteIndex );
			
			//get the bit level index for a single byte
			index -= ( byteIndex * 8 );
			
			//trace("BitStore::getBitAt(), bit index " + index );
			
			return ByteUtils.getBitAt( byte, index, 8 );
		}		
		
		/*
		*	Proxy implementation.
		*/
		
		/**
		*	@private	
		*/
	    override flash_proxy function hasProperty( name:* ):Boolean
		{
			return false;
	    }
		
		/**
		*	@private	
		*/		
	    override flash_proxy function getProperty( name:* ):*
		{
			var index:Number = parseInt( name );
			
			if( isNaN( index ) )
			{
				return false;
			}
			
			return getBitAt( index );
	    }
		
		//--> implement for loop support
		
		/**
		*	@private	
		*/		
		override flash_proxy function nextNameIndex( index:int ):int
		{
			return 0;
		}
	
		/**
		*	@private	
		*/	
		override flash_proxy function nextName( index:int ):String
		{
			return "";
		}
		
		/**
		*	@private	
		*/		
		override flash_proxy function nextValue( index:int ):*
		{
			return null;
		}
		
		/**
		*	@private	
		*/		
	    override flash_proxy function setProperty( name:*, value:* ):void
		{	
			var index:Number = parseInt( name );
			
			if( !( value is Boolean ) )
			{
				throw new Error( "IBitStore, only accepts Boolean values" );
			}
			
			if( isNaN( index ) )
			{
				throw new Error( "IBitStore, invalid property name '" +
					name + "' must be a number" );
			}
			
			setBitAt( index, Boolean( value ) );
	    }
		
		/**
		*	@private	
		*/
		override flash_proxy function callProperty( methodName:*, ...args ):*
		{
			//call a method
		}
	}
}