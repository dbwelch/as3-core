package com.ffsys.net.sax {

	import flash.events.*;
	import flash.utils.Dictionary;
	
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
	public class SaxParser extends Object
		implements ISaxHandler {
			
		/**
		* 	The regular expression used to determine if
		* 	a text node is a <code>CDATA</code> section.
		*/
		public static const CDATA:RegExp = /^<\!\[CDATA\[/;
		
		/**
		* 	The current depth of the traversal.
		*/
		public var depth:int = 0;
		
		private var _handlers:Vector.<ISaxHandler>;
		
		private var _xml:XML;
		private var _time:Number;
		private var _node:XML;
		private var _token:SaxToken;
		private var _tokens:Dictionary;
		
		/**
		*	Creates a <code>SaxParser</code> instance.
		* 
		* 	@param xml An <code>XML</code> object to parse.	
		*/
		public function SaxParser( xml:XML = null, handlers:Vector.<ISaxHandler> = null )
		{
			super();
			addHandlers( handlers );
			if( xml != null )
			{
				parse( xml );
			}
		}
		
		/**
		* 	The list of handlers that should be notified	
		*	as the <code>XML</code> document is traversed.
		*/
		public function get handlers():Vector.<ISaxHandler>
		{
			if( _handlers == null )
			{
				_handlers = new Vector.<ISaxHandler>();
			}
			return _handlers;
		}
		
		/**
		* 	Adds handlers to this parser.
		* 
		* 	@param handlers The list of handlers for this parser.
		*/
		public function addHandlers( handlers:Vector.<ISaxHandler> ):void
		{
			if( handlers != null )
			{
				var target:Vector.<ISaxHandler> = this.handlers;
				var handler:ISaxHandler = null;
				for each( handler in handlers )
				{
					if( handler != null )
					{
						target.push( handler );
					}
				}
			}			
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
				_time = new Date().getTime();
				_xml = x;
				depth = 0;
				deserialize( x );
				_time = new Date().getTime() - _time;
				complete();
				cleanup();
			}
		}
		
		/**
		* 	The XML document being parsed.
		*/
		protected function get xml():XML
		{
			return _xml;
		}
		
		/**
		* 	The current XML node being handled.
		*/
		protected function get node():XML
		{
			return _node;
		}
		
		/**
		* 	The token for the current node.
		*/
		protected function get token():SaxToken
		{
			return _token;
		}
		
		protected function get tokens():Dictionary
		{
			if( _tokens == null )
			{
				_tokens = new Dictionary( true );
			}
			return _tokens;
		}
		
		/**
		* 	Cleans temporary cache data created during the
		* 	parsing process, note that any handlers registered
		* 	with this parser implementation are left intact.
		* 
		* 	This method is invoked automatically when parsing
		* 	is complete.
		*/
		protected function cleanup():void
		{
			_xml = null;
			_node = null;
			_token = null;
			_tokens = null;
		}
		
		/**
		* 	@private
		* 
		* 	Sends a token notification to all registered handlers.
		*/
		private function notify( token:SaxToken, method:String, ...parameters ):void
		{
			var handler:ISaxHandler = null;
			for( var i:int = 0;i < handlers.length;i++ )
			{
				handler = handlers[ i ];
				parameters.unshift( token );
				handler[ method ].apply( handler, parameters );
			}
		}
		
		/**
		* 	@private
		* 
		* 	Queries all handlers for a boolean response that differs from
		* 	an expected boolean response.
		*/
		private function query( token:SaxToken, method:String, expected:Boolean = false ):Boolean
		{
			var handler:ISaxHandler = null;
			var queried:Boolean = false;
			for( var i:int = 0;i < handlers.length;i++ )
			{
				handler = handlers[ i ];
				queried = handler[ method ].apply( handler, [ token ] );
				if( queried !== expected )
				{
					return queried;
				}
			}
			return expected;
		}
		
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
					if( child.nodeKind() == SaxToken.TEXT && !( /^\s+$/.test( child.toString() ) ) )
					{
						//trace("SaxParser::hasTextChild()", "FOUND TEXT NODE '", child.toString(), "'", /^\s+$/.test( child.toString() ) );
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
			
			//trace("SaxParser::getPropertyName()", name, name.indexOf( "-" ), name.indexOf( "-" ) > -1 );
			
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
		* 	@inheritDoc
		*/
		public function beginDocument( token:SaxToken ):void
		{
			var methodName:String = "beginDocument";
			//trace("[BEGIN DOCUMENT] SaxParser::beginDocument()", token.name, token.type );
			notify( token, methodName );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function shouldTraverseElement( token:SaxToken ):Boolean
		{
			var methodName:String = "shouldTraverseElement";
			
			//trace("[SHOULD TRAVERSE] SaxParser::shouldTraverseElement()", token.name, token.type );
			
			//we expect to traverse into children by default
			return query( token, methodName, true );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function beginElement( token:SaxToken ):void
		{
			var methodName:String = "beginElement";
			//trace("[START ELEMENT] SaxParser::beginElement()", token.name, token.type );
			notify( token, methodName );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function instruction( token:SaxToken ):void
		{
			var methodName:String = "instruction";
			//trace("[PROCESSING-INSTRUCTION] SaxParser::instruction()", token.name, token.type );
			notify( token, methodName );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function leaf( token:SaxToken ):void
		{
			var methodName:String = "leaf";
			notify( token, methodName );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function comment( token:SaxToken ):void
		{
			var methodName:String = "comment";
			notify( token, methodName );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function cdata( token:SaxToken ):void
		{
			var methodName:String = "cdata";
			notify( token, methodName );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function text( token:SaxToken ):void
		{
			var methodName:String = "text";
			notify( token, methodName );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function endElement( token:SaxToken ):void
		{
			var methodName:String = "endElement";
			notify( token, methodName );
			//trace("[END ELEMENT] SaxParser::endElement()", token.name, token.type );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function endDocument( token:SaxToken ):void
		{
			var methodName:String = "endDocument";
			notify( token, methodName );	
			//trace("[END DOCUMENT] SaxParser::endDocument()", token.name, token.type );
		}
		
		/**
		* 	A time value that during processing represents
		* 	the time that parsing started and once processing
		* 	complete it will represent the 
		*/
		public function get time():Number
		{
			return _time;
		}
		
		/**
		* 	Invoked when parsing is complete but before
		* 	any cleanup of cached data has been performed.
		*/
		protected function complete():void
		{
			//
		}
		
		/**
		* 	@private
		*/
		private static function initialize():Boolean
		{
			XML.ignoreComments = false;
			XML.ignoreProcessingInstructions = false;
			XML.ignoreWhitespace = false;
			XML.prettyIndent = 0;
			XML.prettyPrinting = false;
			return true;
		}
		
		static private var _initialized:Boolean = initialize();	
		
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
			
			//update the current node being processed
			_node = x;
			
			_token = new SaxToken( x, _token, depth, x.nodeKind() );
			this.tokens[ x ] = _token;
			
			if( x.nodeKind() == SaxToken.PROCESSING_INSTRUCTION )
			{
				instruction( _token );
				return;
			}
			
			var descend:Boolean = true;
			
			if( x.nodeKind() == SaxToken.ELEMENT )
			{
				//single text node, treat it as simple content
				if( x.children().length() == 1 && x.text().length() == 1 )
				{
					//token.text = x.text()[ 0 ];
					token.type = SaxToken.SIMPLE;
				}else if( hasTextChild( x ) )
				{
					//potentially mixed content - inline
					//doWithInlineContent( x );
					token.type = SaxToken.INLINE;				
				}else if( x.children().hasComplexContent() )
				{
					//doWithBlockContent( x );
					token.type = SaxToken.BLOCK;
				}
				
				descend = shouldTraverseElement( _token );
				
				if( depth == 0 )
				{
					beginDocument( _token );
				}else
				{
					beginElement( _token );
				}
			}
			
			//reached a leaf node
			if( l == 0 && depth > 0 )
			{
				//trace("[LEAF] SaxParser::deserialize()", x );
				
				//TODO: ensure this only fires for element nodes
				leaf( _token );
				
				if( x.nodeKind() == SaxToken.COMMENT )
				{
					//trace("SaxParser::deserialize()", "[FOUND COMMENT NODE]", x.toXMLString() );
					comment( _token );
				}else if( x.nodeKind() == SaxToken.TEXT )
				{
					//this is potentially expensive but there
					//does not seem to be any easier way to determine
					//if a text node is a CDATA node
					//both x.name() and x.locaName() yield nothing :(
					if( CDATA.test( x.toXMLString() ) )
					{
						_token.type = SaxToken.CDATA;
						cdata( _token );
					}else
					{
						text( _token );
					}
				}
			}
			
			//only parse child elements if we are configued to
			//traverse this element
			if( descend )
			{	
			
				if( l > 0 )
				{
					depth++;
				}
				
				//descend into child nodes
				for( i = 0;i < l;i++ )
				{
					element = x.child( i );
					if( element == null )
					{
						continue;
					}
					
					//this branch allows us to deal with inline text nodes
					if( element is XML )
					{
						deserialize( element as XML );
					}else if( element is XMLList )
					{
						deserializeList( element as XMLList );
					}
				}
			}
			
			if( x.nodeKind() == SaxToken.ELEMENT )
			{
				if( l > 0
					&& descend )
				{
					depth--;
					//set the token back to the correct one for the current element
					_token = tokens[ x ];
				}
				
				//TODO: ensure we don't reinstantiate a new token for the end element
				//token = new SaxToken( x, depth );
				
				if( depth == 0 )
				{
					endDocument( _token );
				}else{
					endElement( _token );
				}
			}
		}
	}
}