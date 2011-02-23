package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;
		
	/**
	*	Represents character data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class CharacterDataImpl extends NodeImpl
		implements CharacterData
	{
		private var _data:String;
		
		/**
		* 	Creates a <code>CharacterDataImpl</code> instance.
		*/
		public function CharacterDataImpl()
		{
			super();
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
			if( value != _data )
			{
				//invalidate the xml
				_xml = null;
			}
			
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
		
		/**
		* 	Updates the underlying data
		* 	as the XML fragment changes.
		*/
		override public function set xml( value:XML ):void
		{
			super.xml = value;
			
			if( value != null )
			{
				if( value.nodeKind() != "text"
					&& value.nodeKind() != "comment" )
				{
					throw new Error( "Invalid node type '" + value.nodeKind() + "' for character data." );
				}
				
				_data = value.toString();
				//trace("CharacterData::set xml()", value.toXMLString(), _data );
			}
		}
		
		override public function get xml():XML
		{
			if( _xml == null )
			{
				_xml = new XML( data );
			}
			return _xml;
		}		
	}
}