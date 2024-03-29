package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;
		
	/**
	*	Represents character data.
	*/
	dynamic public class CharacterDataImpl extends ChildNode
		implements CharacterData
	{
		private var _data:String;
		
		/**
		* 	Creates a <code>CharacterDataImpl</code> instance.
		* 	
		* 	@param owner The owner document.
		* 	@param data The character data as a string.
		*/
		public function CharacterDataImpl(
			owner:CoreDocumentImpl = null,
			data:String = null )
		{
			super( owner );
			if( data != null )
			{
				this.data = data;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get data():String
		{
			if( _data == null )
			{
				_data = "";
			}
			return _data;
		}
		
		public function set data( value:String ):void
		{
			_data = value;
			
			if( value != null )
			{
			
				if( proxy != _data )
				{
					setProxySource( _data );
				}
			}else{
				_data = null;
				setProxySource( null );
			}
		}
		
		/**
		* 	Ensures the string data is returned as the node value.
		*/
		override public function get nodeValue():String
		{
			return _data;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get length():uint
		{
			return data.length;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function substringData( offset:Number, count:Number ):String
		{
			//This method can raise a DomException object.
			return data.substr( offset, count );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function appendData( value:String ):void
		{
			//This method can raise a DomException object.
			if( value != null )
			{
				data += value;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function insertData( offset:Number, value:String ):void
		{
			//This method can raise a DomException object.
			var start:String = offset > 0 ? data.substr( 0, offset ) : "";
			var end:String = data.substr( offset );
			data = start + value + end;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function deleteData( offset:Number, count:Number ):void
		{
			//This method can raise a DomException object.
			var start:String = offset > 0 ? data.substr( 0, offset ) : "";
			var end:String = data.substr( offset + count );
			data = start + end;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function replaceData(
			offset:Number, count:Number, value:String ):void
		{
			deleteData( offset, count );
			insertData( offset, value );
		}
		
		/**
		* 	@private
		*/
		override protected function propertyMissing( name:* ):*
		{	
			//This method can raise a DomException object.
			var integer:Number = Number( name );
			
			//trace("CharacterData::propertyMissing()", name, name is String, integer );
			
			if( isNaN( integer ) && String( "" + name ).length == 1 )
			{
				return String( name ).charCodeAt( 0 );
			}else if( integer is uint )
			{
				return data.charAt( integer );
			}
			
			return null;
		}		
		
		/**
		* 	@private
		*/
		override protected function getNextName( index:int ):String
		{
			return data.charAt( index - 1 );
		}
		
		/**
		* 	@private
		*/
		override protected function getNextValue( index:int ):*
		{
			return data.charCodeAt( index - 1 );
		}
	}
}