package org.flashx.net.asax {

	import flash.events.*;
	import flash.net.*;
	import flash.utils.Dictionary;
	
	import org.flashx.utils.string.PropertyNameConverter;
	
	/**
	*	A SAX parser implementation.
	* 
	* 	All loaded <code>XML</code> data should be utf-8 encoded
	* 	as this implementation uses the <code>readUTFBytes</code>
	* 	method to read data on the input stream by default.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.01.2011
	*/
	public class SaxParser extends URLStream
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
		
		//streaming SAX cache data
		
		//current and previous element names
		//used so that tag mismatches can be handled
		private var _currentElementName:String;
		private var _previousElementName:String;
		
		//a previous character
		private var pc:String = null;
		
		//the current character being parsed
		private var c:String = null;
		
		//a cache of characters used to build a tag name
		private var name:String = null;
		
		//the clean element name with special characters removed
		//but any namespace prefix intact
		private var _elementName:String = null;
		
		//the node content
		private var element:String = "";
		
		//whether we are in a tag
		private var _inTag:Boolean;
		
		//whether a tag is a closing tag
		private var _closing:Boolean = false;
		
		//used to cache the result of calling the the shouldTraverseElement method
		private var _shouldTraverseElementStream:Boolean = true;
		private var _shouldTraverseElementDepth:uint = 0;
		
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
				started();
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
		public function declaration( token:SaxToken ):void
		{
			//trace("[DECLARATION] SaxParser::declaration()", token.depth, token.name, token.type, token.xml.toString() );
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function doctype( token:SaxToken ):void
		{
			//trace("[DOCTYPE] SaxParser::doctype()", token.depth, token.name, token.type, token.xml.toString() );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function beginDocument( token:SaxToken ):void
		{
			//trace("[BEGIN DOCUMENT] SaxParser::beginDocument()", token.depth, token.name, token.type, token.xml.toXMLString() );
			var methodName:String = "beginDocument";
			notify( token, methodName );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function shouldTraverseElement( token:SaxToken ):Boolean
		{
			//trace("[SHOULD TRAVERSE] SaxParser::shouldTraverseElement()", token.depth, token.name, token.type, token.xml.toXMLString() );
			
			var methodName:String = "shouldTraverseElement";			
			//we expect to traverse into children by default
			return query( token, methodName, true );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function beginElement( token:SaxToken ):void
		{
			//trace("[START ELEMENT] SaxParser::beginElement()", token.depth, token.name, token.type, token.xml.toXMLString() );
			var methodName:String = "beginElement";
			notify( token, methodName );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function instruction( token:SaxToken ):void
		{
			var methodName:String = "instruction";
			notify( token, methodName );
			//trace("[PROCESSING-INSTRUCTION] SaxParser::instruction()", token.depth, token.name, token.type, token.xml.toXMLString() );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function leaf( token:SaxToken ):void
		{
			//trace("[LEAF] SaxParser::leaf()", token.depth, token.name, token.type, token.xml.toXMLString() );			
			var methodName:String = "leaf";
			notify( token, methodName );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function comment( token:SaxToken ):void
		{
			//trace("[COMMENT] SaxParser::comment()", token.depth, token.name, token.type, token.xml.toXMLString() );			
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
			
			
			//trace("[CDATA] SaxParser::cdata()", token.depth, token.name, token.type, token.xml.toXMLString() );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function text( token:SaxToken ):void
		{
			//trace("[TEXT] SaxParser::text()", token.depth, token.name, token.type, token.xml.toXMLString() );			
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
			//trace("[END ELEMENT] SaxParser::endElement()", token.depth, token.name, token.type, token.xml.toXMLString() );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function endDocument( token:SaxToken ):void
		{
			var methodName:String = "endDocument";
			notify( token, methodName );	
			//trace("[END DOCUMENT] SaxParser::endDocument()", token.depth, token.name, token.type, token.xml.toXMLString() );
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
		* 	Invoked prior to a parse or load operation
		* 	commencing, allowing derived implementations
		* 	to initialize an inner state prior to parsing
		* 	the XML.
		*/
		protected function started():void
		{
			//
		}
		
		override public function load( request:URLRequest ):void
		{
			removeLoadListeners();
			_time = new Date().getTime();
			depth = 0;
			addLoadListeners();
			started();			
			super.load( request );
		}
		
		/**
		*	@private
		*/
		private function addLoadListeners():void
		{
			addEventListener( Event.COMPLETE, completeHandler );
			addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			addEventListener( Event.OPEN, openHandler );
			addEventListener( ProgressEvent.PROGRESS, progressHandler );
			addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
		}
		
		/**
		*	@private
		*/
		private function removeLoadListeners():void
		{
			removeEventListener( Event.COMPLETE, completeHandler );
			removeEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			removeEventListener( Event.OPEN, openHandler );
			removeEventListener( ProgressEvent.PROGRESS, progressHandler );
			removeEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
		}		
		
		/**
		*	@private
		*/
		private function completeHandler( event:Event ):void {
            //trace("completeHandler: " + event);

			removeLoadListeners();
			
			//all done
			_time = new Date().getTime() - _time;
			complete();
			cleanup();
        }
		
		/**
		*	@private
		*/
        private function openHandler(event:Event):void {
            //trace("openHandler: " + event);
        }
		
		/**
		*	@private
		*/
        private function progressHandler(event:Event):void {
            //trace("progressHandler: ", bytesAvailable );
			parseChunk();
        }
		
		/**
		*	@private
		*/
        private function securityErrorHandler(event:SecurityErrorEvent):void {
            //trace("securityErrorHandler: " + event);
        }
		
		/**
		*	@private
		*/
        private function httpStatusHandler(event:HTTPStatusEvent):void {
            //trace("httpStatusHandler: " + event);
        }
		
		/**
		*	@private
		*/
        private function ioErrorHandler(event:IOErrorEvent):void {
            //trace("ioErrorHandler: " + event);
        }
		
		/**
		*	@private
		*/
		private function parseChunk():void
		{
			if( bytesAvailable > 0 )
			{
				parsePart( readUTFBytes( bytesAvailable ) );
			}
		}
		
		/**
		*	@private
		*/
		private function parsePart( part:String ):void
		{
			if( part != null )
			{
				
				if( /^(\s*<\?xml[^\?]+\?>)/.test( part ) )
				{
					parseXmlDeclaration( part );
					//discard the parsed xml declaration
					part = part.replace( /^(\s*<\?xml[^\?]+\?>)/, "" );
				}
				
				if( /^(\s*<\!DOCTYPE[^>]+>)/.test( part ) )
				{
					parseDocType( part );
					//discard the parsed doctype
					part = part.replace( /^(\s*<\!DOCTYPE[^>]+>)/, "" );
				}
				
				parseMarkup( part );
			}
		}
		
		/**
		*	@private
		*/
		private function parseXmlDeclaration( part:String ):void
		{
			var tmp:String = "";
			var c:String = null;
			for( var i:int = 0;i < part.length;i++ )
			{
				c = part.charAt( i );
				tmp += c;
				if( c == ">" )
				{
					tmp = tmp.replace( /^\s+/, "" );
					declaration( getStreamToken(
						new XML( "<!-- " + tmp + " -->" ), SaxToken.DECLARATION ) );
					break;
				}
			}
		}
		
		/**
		*	@private
		*/
		private function parseDocType( part:String ):void
		{
			var tmp:String = "";
			var c:String = null;
			for( var i:int = 0;i < part.length;i++ )
			{
				c = part.charAt( i );
				tmp += c;
				if( c == ">" )
				{
					tmp = tmp.replace( /^\s+/, "" );				
					doctype( getStreamToken(
						new XML( "<!-- " + tmp + " -->" ), SaxToken.DOCTYPE ) );
					break;
				}
			}
		}
		
		/**
		*	@private
		*/
		private function getStreamToken( x:XML, type:String, parent:SaxToken = null ):SaxToken
		{
			var t:SaxToken = new SaxToken( x, _token, depth, type );
			
			_node = t.xml;
			
			if( x != null
				&& _token
				&& _token.xml )
			{
				_token.xml.appendChild( x );
			}
			
			if( type == SaxToken.ELEMENT )
			{
				if( _token != null && _token.type == SaxToken.ELEMENT )
				{
					t.parent = _token;
				}
				_token = t;
				//store a reference to the element token
				tokens[ _token.xml ] = _token;
			}
			return t;
		}
		
		/**
		*	@private
		*/
		private function parseMarkup( part:String ):void
		{
			var canNotify:Boolean = _shouldTraverseElementStream;
			trace("********************************************** SaxParser::parseMarkup() **********************************************");
			for( var i:int = 0;i < part.length;i++ )
			{
				c = part.charAt( i );
				if( _inTag && /^[a-zA-Z0-9:\-\/]/.test( c ) )
				{
					name += c;
				}
				
				canNotify = _shouldTraverseElementStream;
				
				//trace("[CAN NOTIFY] SaxParser::parseMarkup()", canNotify );
				
				if( c == "<" 
					&& !_inTag )
				{
					if( element != "" && canNotify )
					{
						text( getStreamToken( new XML( element ), SaxToken.TEXT ) );
					}
					_inTag = true;
					_closing = false;
					_elementName = null;
					element = "";
					name = "";
				}
				
				if( _inTag
					&& /^(>|\s)/.test( c )
					&& _elementName == null
					&& name != null  )
				{
					if( _currentElementName != null )
					{
						_previousElementName = _currentElementName;
					}
					
					_elementName = name;
					
					//hit an end element declaration
					if( /^\/|\]|\?/.test( _elementName ) && !_closing )
					{
						_closing = true;
						
						//trace("[CLOSING TAG] SaxParser::parseMarkup()", _elementName );
						
						//clean the forward slash from the end tag name
						_elementName = _elementName.replace( /^\/|\]|\?/, "" );
				
					}
					
					_currentElementName = _elementName;
					
					//trace("SaxParser::parseMarkup()", "SETTING ELEMENT name", _elementName );
									
				}				
				
				element += c;
				
				if( c == ">" && _inTag )
				{
					_inTag = false;
					
					//trace("SaxParser::parseMarkup()", "GOT ELEMENT", _elementName );
					
					//comment
					if( canNotify && /-->$/.test( element ) )
					{
						comment( getStreamToken( new XML( element ), SaxToken.COMMENT ) );
					//self closed empty element
					}else if( pc == "/" )
					{
						_currentElementName = _previousElementName;
						
						if( canNotify )
						{
							getStreamToken( new XML( element ), SaxToken.ELEMENT, _token );
							depth == 0 ? beginDocument( token ) : beginElement( token );
							
							//TODO: call leaf()
							
							//self closing elements notify of the end immediately after the open tag
							depth == 0 ? endDocument( token ) : endElement( token );
							
						}
						
						//
						_token = _token.parent;
						
					//processing instruction
					}else if( pc == "?" )
					{
						if( canNotify )
						{
							instruction( getStreamToken(
								new XML( element ), SaxToken.PROCESSING_INSTRUCTION ) );
						}
					}else if( canNotify && !_closing
						&& _elementName.toLowerCase() == SaxToken.CDATA )
					{
						
						//trace("SaxParser::parseMarkup()", "GOT CDATA ELEMENT", element );
						cdata( getStreamToken(
							new XML( element ), SaxToken.CDATA ) );
					//start element declaration
					}else if( !_closing )
					{
						
						//trace("SaxParser::parseMarkup()", "CREATING MARKUP FROM ", element );
						
						getStreamToken( new XML( element + "</" + _elementName + ">" ), SaxToken.ELEMENT, _token );
						
						if( _shouldTraverseElementStream )
						{
							_shouldTraverseElementStream = shouldTraverseElement( token );
						
							if( !_shouldTraverseElementStream )
							{
								_shouldTraverseElementDepth = depth;
								//trace("[TRAVERSAL IGNORE DEPTH] SaxParser::parseMarkup()", _shouldTraverseElementDepth, _token.xml );
							}
						}
						
						if( canNotify )
						{
							depth == 0 ? beginDocument( token ) : beginElement( token );						
						}
						
						//trace("SaxParser::parseMarkup()", "START ELEMENT", _elementName, token.xml.toXMLString() );

						depth++;
					//non self-closed element
					}else if( _closing )
					{
						//getStreamToken();
						
						//trace("SaxParser::parseMarkup()", "FOUND CLOSED ELEMENT", _elementName );
						
						if( _currentElementName != _elementName )
						{
							throw new Error( "SAX parser encountered a tag mismatch, start element name '" 
								+ _currentElementName + "' ended with '" + _elementName + "'." );
						}
						
						_currentElementName = _previousElementName;
						_closing = false;
						_elementName = null;

						//trace("SaxParser::parseMarkup()", "GOT CLOSE ELEMENT TOKEN: ", _token, _token.parent );
						
						depth--;
						
						//keep a reference to the main xml before cleanup
						if( depth == 0 )
						{
							_xml = token.xml;
						}
						
						//_token = tokens[ node.parent() ];
						
						//trace("SaxParser::parseMarkup()", canNotify, _token );
						
						//trace("[STREAM END ELEMENT] SaxParser::parseMarkup()", "[ENDING ELEMENT]", _token );
						
						if( canNotify )
						{
							depth == 0 ? endDocument( _token ) : endElement( _token );
						}					
						
						if( _token && _token.parent )
						{
							_token = _token.parent;
						}						
					}
					
					name = "";
					element = "";
				}
				
				//reset traversal
				if( !_shouldTraverseElementStream
					&& depth <= _shouldTraverseElementDepth )
				{
					//trace("[RESET TRAVERSAL IGNORE DEPTH] SaxParser::parseMarkup()", _shouldTraverseElementDepth );
					_shouldTraverseElementStream = true;
					_shouldTraverseElementDepth = 0;
				}				
				
				pc = c;
			}			
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
					token.type = SaxToken.SIMPLE;
				}else if( hasTextChild( x ) )
				{
					//potentially mixed content - inline
					token.type = SaxToken.INLINE;
				}else if( x.children().hasComplexContent() )
				{
					token.type = SaxToken.BLOCK;
				}
				
				if( l > 0 )
				{
					descend = shouldTraverseElement( _token );
				}
				
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
		
		//DO NOT PLACE ANY CODE HERE BELOW THE DESERIALIZE METHOD AS IT WILL
		//BREAK THE DEFAULT NAMESPACE LOGIC ABOVE
	}
}