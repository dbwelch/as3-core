package com.ffsys.dom
{
	/**
	*	Represents character data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class CharacterData extends Node
	{
		private var _data:String;
		
		/**
		* 	Creates a <code>CharacterData</code> instance.
		*/
		public function CharacterData( xml:XML = null )
		{
			super( xml );
		}
		
		override public function set xml( value:XML ):void
		{
			super.xml = value;
			
			if( value != null )
			{
				//TODO: implement in text
				//value.normalize();
				
				_data = "";
				
				var text:XMLList = value.text();
				var child:XML = null;
				for each( child in text )
				{
					_data += child.toString();
				}
			}
		}
		
		/**
		* 	The data encapsulated by this character data.
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
			
			_xml = new XML( value );
			
			if( source != _data )
			{
				setSource( _data );
			}
			
			//TODO: verify the xml is the right node kind: text
		}
		
		/**
		* 	Ensures the length of this implementation matches
		* 	the length of the encapsulated data.
		*/
		override public function get length():uint
		{
			return data.length;
		}
		
		/**
		* 	Gets a substring of the data.
		* 
		* 	@param offset The offset for the substring.
		* 	@param count The number of characters to include
		* 	in the substring.
		* 
		* 	@return The substring.
		*/
		public function substringData( offset:Number, count:Number ):String
		{
			return data.substr( offset, count );
		}
		
		/**
		* 	Appends data to this character data.
		* 
		* 	@param value The data to append.
		*/
		public function appendData( value:String ):void
		{
			if( value != null )
			{
				data += value;
			}
		}
		
		/**
		* 	Inserts data into this character data.
		* 
		* 	@param offset The offset to insert the data at.
		* 	@param value The data to insert.
		*/
		public function insertData( offset:Number, value:String ):void
		{
			var start:String = offset > 0 ? data.substr( 0, offset ) : "";
			var end:String = data.substr( offset );
			data = start + value + end;
		}
		
		/**
		* 	Deletes data from this character data.
		* 
		* 	@param offset The offset for the deletion.
		* 	@param count The number of characters to delete from the data.
		*/
		public function deleteData( offset:Number, count:Number ):void
		{
			var start:String = offset > 0 ? data.substr( 0, offset ) : "";
			var end:String = data.substr( offset + count );
			data = start + end;
		}
		
		/**
		* 	Replaces data with updated data.
		* 
		* 	@param offset The offset to replace the data at.
		* 	@param count The number of characters of data to replace.
		* 	@param value The replacement data.
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
		
		/*
		
		Object CharacterData
		CharacterData has the all the properties and methods of the Node object as well as the properties and methods defined below.
		The CharacterData object has the following properties:
		
		data
		This property is of type String, can raise a DOMException object on setting and can raise a DOMException object on retrieval.
		
		length
		This read-only property is of type Number.
		
		The CharacterData object has the following methods:
		
		substringData(offset, count)
		This method returns a String.
		The offset parameter is of type Number.
		The count parameter is of type Number.
		
		//TODO
		This method can raise a DOMException object.
		
		appendData(arg)
		This method has no return value.
		The arg parameter is of type String.
		
		//TODO
		This method can raise a DOMException object.
		
		insertData(offset, arg)
		
		This method has no return value.
		The offset parameter is of type Number.
		The arg parameter is of type String.
		
		//TODO
		This method can raise a DOMException object.
		
		deleteData(offset, count)
		
		This method has no return value.
		
		The offset parameter is of type Number.
		The count parameter is of type Number.
		
		//TODO
		This method can raise a DOMException object.
		
		replaceData(offset, count, arg)
		This method has no return value.
		
		The offset parameter is of type Number.
		The count parameter is of type Number.
		The arg parameter is of type String.
		
		//TODO
		This method can raise a DOMException object.
		
		*/
	}
}