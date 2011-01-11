package com.ffsys.net.sax {

	import flash.events.*;
	
	import com.ffsys.utils.string.PropertyNameConverter;
	
	/**
	*	A SAX parser implementation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.01.2011
	*/
	public class SAXParser extends EventDispatcher {
		
		/**
		* 	Represents an element.
		*/
		public static const ELEMENT:String = "element";	
		
		/**
		* 	Represents a text element.
		*/
		public static const TEXT:String = "text";				
		
		/**
		* 	Represents a comment element.
		*/
		public static const COMMENT:String = "comment";
		
		/**
		* 	Represents a processing instruction.
		*/
		public static const PROCESSING_INSTRUCTION:String = "processing-instruction";
		
		/**
		* 	Represents a simple element.
		* 	
		* 	A simple element is an element whose child
		* 	elements are <em>only</em> text elements.
		*/
		public static const SIMPLE:String = "simple";
		
		/**
		* 	Represents an inline element.
		* 	
		* 	An inline element is an element whose children
		* 	are a mix of text and other elements.
		*/
		public static const INLINE:String = "inline";
		
		/**
		* 	Represents a block element.
		* 
		* 	A block element is an element that does not
		* 	contain any direct child text elements.
		*/
		public static const BLOCK:String = "block";		
		
		private var _handlers:Vector.<SAXHandler>;
		private var _depth:int = 0;
		
		/**
		*	Creates a <code>SAXParser</code> instance.
		*/
		public function SAXParser()
		{
			super();
		}
		
		/**
		* 	The list of handlers that should be notified	
		*	as the <code>XML</code> document is traversed.
		*/
		public function get handlers():Vector.<SAXHandler>
		{
			if( _handlers == null )
			{
				_handlers = new Vector.<SAXHandler>();
			}
			return _handlers;
		}
		
		/**
		* 	Starts traversal of the specified document.
		* 
		* 	@param x The <code>XML</code> document to traverse.
		*/
		public function parse( x:XML ):void
		{
			if( x != null )
			{
				_depth = 0;
				var tkn:SAXToken = new SAXToken( x );
				notify( tkn, "beginDocument" );
				deserialize( x );
				notify( tkn, "endDocument" );
			}
		}
		
		private function notify( token:SAXToken, method:String, ...params ):void
		{
			var handler:SAXHandler = null;
			params.unshift( token );
			for( var i:int = 0;i < handlers.length;i++ )
			{
				handler = handlers[ i ];
				handler[ method ].apply( handler, params );
			}
		}

		private var _previous:SAXToken;	
		private var _token:SAXToken;
		
		/**
		* 	@private
		*/
		private function hasTextChild( x:XML ):Boolean
		{
			if( x != null && x.children().length() > 0 )
			{
				var child:XML = null;
				for each( child in x.children() )
				{
					//must be a non-whitespace text node that is a direct descendant
					if( child.nodeKind() == TEXT && !( /^\s+$/.test( child.toString() ) ) )
					{
						//trace("SAXParser::hasTextChild()", "FOUND TEXT NODE '", child.toString(), "'", /^\s+$/.test( child.toString() ) );
						return true;
					}
				}
			}
			
			return false;
		}
		
		/**
		* 	@private
		*/
		private function getPropertyName( node:XML ):String
		{
			var name:String = node.name().localName;
			
			//trace("SAXParser::getPropertyName()", name, name.indexOf( "-" ), name.indexOf( "-" ) > -1 );
			
			//quick fix for hyphenated property names
			//should be moved to a property converter implementation
			//associated with the class node name map
			if( name.indexOf( "-" ) > -1 )
			{
				var converter:PropertyNameConverter = new PropertyNameConverter();
				name = converter.convert( name );
			}
			
			return name;
		}
		
		/**
		* 	@private
		*/
		private function deserializeList( list:XMLList ):void
		{
			var child:XML;			
			for each( child in list )
			{
				deserialize( child );
			}
		}			
		
		/**
		* 	@private
		*/
		private function deserialize( x:XML ):void
		{
			if( x == null )
			{
				return;
			}
			
			var ns:String = x.@xmlns;
			
			if( ns )
			{
				default xml namespace = new Namespace( ns );
			}

			var element:Object;
			var i:int = 0;
			var l:int = x.children().length();
			
			if( x.nodeKind() == PROCESSING_INSTRUCTION )
			{
				_token = new SAXToken( x );
				notify( _token, "doWithProcessingInstruction" );
				return;
			}			
			
			if( x.nodeKind() == ELEMENT )
			{
				_token = new SAXToken( x );
				
				//single text node, treat it as simple content
				if( x.children().length() == 1 && x.text().length() == 1 )
				{
					//_token.text = x.text()[ 0 ];
					_token.type = SIMPLE;
				}else if( hasTextChild( x ) )
				{
					//potentially mixed content - inline
					//doWithInlineContent( x );
					_token.type = INLINE;				
				}else if( x.children().hasComplexContent() )
				{
					//doWithBlockContent( x );
					_token.type = BLOCK;
				}
				
				notify( _token, "startElement" );
			}
			
			if( l > 0 )
			{
				//_previous = _token;
				_depth++;
			}
			
			for( ;i < l;i++ )
			{
				element = x.child( i );
				if( element == null )
				{
					continue;
				}
				
				if( element is XML )
				{
					deserialize( element as XML );
				}else if( element is XMLList )
				{
					deserializeList( element as XMLList );
				}
			}
			
			//_depth--;
			
			if( x.nodeKind() == ELEMENT )
			{
				_depth--;
				_token = new SAXToken( x );
				notify( _token, "endElement" );				
			}
		}
	}
}