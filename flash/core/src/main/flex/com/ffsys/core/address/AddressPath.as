package com.ffsys.core.address {
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import com.ffsys.utils.string.AddressUtils;
	import com.ffsys.utils.string.StringUtils;
	
	/**
	*	An <code>AddressPath</code> instance represents the
	*	parts of a <code>String</code> path
	*	using a given <code>String</code> delimiter.
	*	
	*	The default behaviour is to use a URI
	*	style address.
	*	
	*	<pre>/a/b/c</pre>
	*	
	*	Customize the <code>delimiter</code> if you require
	*	another form of notation, for example dot-style
	*	syntax.
	*	
	*	<pre>a.b.c</pre>
	*	
	*	AddressPath instances can be enumerated using
	*	for..in and for..each loops.
	*	
	*	@see com.ffsys.core.address.AddressPathFinder
	*	@see com.ffsys.core.address.IAddressPath
	*	@see com.ffsys.core.address.IAddressPathCompare
	*	@see com.ffsys.core.address.IAddressPathFinder
	*	
	*	@usage
	*	
	*	<pre>var examplePath:String = "/a/b/c";</pre>
	*	
	*	@example
	*	
	*	<pre>var examplePath:String = "/a/b/c";
	*	var path:IAddressPath = new AddressPath( examplePath );
	*
	*	var node:String = null;
	*
	*	//example for..each loop
	*	for each( node in path )
	*	{
	*		trace( node );
	*	}</pre>
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2007
	*/
	public class AddressPath extends Proxy
		implements IAddressPath {
		
		/**
		*	@private
		*	
		*	Determines whether this instance is
		*	operating in strict mode.	
		*/
		protected var _strict:Boolean;
		
		/**
		*	@private
		*	
		*	The elements that constitute the address
		*	path.
		*/
		protected var _elements:Array;
		
		/**
		*	@private
		*	
		*	The delimiter that seperates the elements
		*	of the address path.	
		*/
		protected var _delimiter:String;
		
		/**
		*	@private
		*	
		*	The address that represents the full
		*	address path.	
		*/
		protected var _address:String;
		
		/**
		*	@private	
		*/
		protected var _stripQueryString:Boolean;
		
		/**
		*	Creates a new <code>AddressPath</code> instance
		*	with a given <code>address</code> path and
		*	<code>delimiter</code>.
		*	
		*	@param address the source address for this path
		*	@param delimiter the path delimiter for this instance
		*/
		public function AddressPath(
			address:String = null,
			delimiter:String = null,
			stripQueryString:Boolean = true )
		{
			super();
			clear();
			
 			if( !delimiter )
			{
				delimiter = AddressUtils.DELIMITER;
			}
			
			//delimiter must be set before setting the address
			this.delimiter = delimiter;
			
			this.address = address;
			this.stripQueryString = stripQueryString;
		}
		
		/**
		*	The source <code>String</code> address for this instance.
		*/
		public function set address( val:String ):void
		{
			_address = val;
			
			clear();
			
			if( address )
			{
				addPathElement( address );
			}
		}
		
		public function get address():String
		{
			return _address;
		}
		
		/**
		*	The <code>String</code> delimiter to be used to determine
		*	the elements of the path.
		*	
		*	Defaults to <code>AddressUtils.DELIMITER</code>.
		*/
		public function set delimiter( val:String ):void
		{
			_delimiter = val;
		}
		
		public function get delimiter():String
		{
			return _delimiter;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set stripQueryString( val:Boolean ):void
		{
			_stripQueryString = val;
		}
		
		public function get stripQueryString():Boolean
		{
			return _stripQueryString;
		}
		
		/**
		*	@inheritDoc
		*	
		*	This is the value passed to the
		*	<code>AddressPathFinder</code> instance used
		*	when performing find operations.
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
		*	@inheritDoc
		*/		
		public function getAddress():String
		{
			if( _elements )
			{
				return join( _elements );
			}
			
			return null;
		}
		
		/**
		*	Determines whether a <code>String</code> element
		*	contains the <code>delimiter</code> assigned to
		*	this instance.
		*	
		*	@param element the <code>String</code> to inspect
		*	
		*	@return a Boolean indicating whether the
		*	<code>delimiter</code> in the <code>String</code> element
		*/
		
		/**
		*	@inheritDoc
		*/		
		public function hasDelimiter( element:String ):Boolean
		{
			return ( element.indexOf( delimiter ) > -1 );
		}
		
		/**
		*	@inheritDoc
		*/		
		public function getPathElementIndex( element:String ):int
		{
			var key:String;
			
			for( key in this )
			{
				if( this[ key ] == element )
				{
					return parseInt( key );
				}
			}
			
			return -1;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function getPathElements( element:String ):Array
		{
			var output:Array = new Array();
			
			if( hasDelimiter( element ) )
			{
				//multiple elements
				var elements:Array = parse( element, delimiter, stripQueryString );
				
				var i:int = 0;
				var l:int = elements.length;
				
				for( ;i < l;i++ )
				{
					output.push( elements[ i ] );
				}
				
			}else{
				output.push( element );
			}
			
			return output;
		}
		
		/**
		*	@inheritDoc
		*/			
		public function addPathElement( element:String ):int
		{
			if( !element )
			{
				return getLength();
			}
			
			var elements:Array = getPathElements( element );
			
			var i:int = 0;
			var l:int = elements.length;
			
			for( ;i < l;i++ )
			{
				_elements.push( elements[ i ] );
			}
			
			return getLength();
		}
		
		/**
		*	@inheritDoc
		*/		
		public function removePathElementsByMatch( regex:RegExp ):Boolean
		{
			var output:Array = new Array();
			var element:String;
			var matches:Array;
			
			var removed:Boolean = false;
			
 			for each( element in this )
			{
				matches = element.match( regex );
				if( matches && matches.length )
				{
					output.push( element );
				}

			}
			
			return removePathElements( join( output ) );
		}
		
		/**
		*	@inheritDoc
		*/
		public function removePathElements( element:String ):Boolean
		{
			var removed:Boolean = false;
			
			var index:int = -1;
			var key:String;
			
			var elements:Array = getPathElements( element );
			
			var i:int = 0;
			var l:int = elements.length;
			
			for( ;i < l;i++ )
			{
				element = elements[ i ];
				
				for( key in this )
				{
					if( this[ key ] == element )
					{
						index = parseInt( key );
						_elements.splice( index, 1 );
						removed = true;
					}
				}
			
			}
			
			return removed;
		}
		
		/**
		*	@inheritDoc
		*/
		public function insertPathElementAt( index:int, element:String ):int
		{
			var elements:Array = getPathElements( element );
			
			var i:int = 0;
			var l:int = elements.length;
			
			//if the element passed contained multiple elements
			//this ensures they are inserted in the correct order
			elements.reverse();
			
			for( ;i < l;i++ )
			{
				_elements.splice( index, 0, elements[ i ] );
			}
						
			return getLength();
		}
		
		/**
		*	@inheritDoc
		*/		
		public function setPathElementAt( index:int, element:String ):int
		{
			//less than zero we place at the beginning
			if( index < 0 )
			{
				return insertPathElementAt( 0, element );
			}
			
			//outside the available length we add to the end
			if( index > ( getLength() - 1 ) )
			{
				return addPathElement( element );
			}
			
			//remove the existing element
			_elements.splice( index, 1 );
			
			//insert the new element(s)
			insertPathElementAt( index, element );
			
			return getLength();
		}
		
		/**
		*	@inheritDoc
		*/		
		public function getPathElementAt( index:int ):String
		{
			if( index >= 0 || index <= ( getLength() - 1 ) )
			{
				return _elements[ index ];
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function removePathElementAt( index:int ):String
		{
			if( index >= 0 || index <= ( getLength() - 1 ) )
			{
				var removed:Array = _elements.splice( index, 1 );
				
				if( removed && removed.length )
				{
					return removed[ 0 ];
				}
			}
			
			return null;	
		}
		
		/**
		*	@inheritDoc
		*/
		public function getLength():int
		{
			if( _elements )
			{
				return _elements.length;
			}
			
			return -1;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function clear():void
		{
			_elements = new Array();
		}
		
		/**
		*	@inheritDoc
		*/		
		public function join( elements:Array = null ):String
		{
			if( !elements )
			{
				elements = new Array();
			}
			
			return elements.join( delimiter );
		}		
		
		/**
		*	@inheritDoc
		*/		
		public function find(
			target:Object,
			methodName:String = null ):Object
		{
			var finder:IAddressPathFinder =
				new AddressPathFinder( this, strict );
			
			return finder.find( target, methodName );
		}
		
		/**
		*	@inheritDoc
		*/		
		public function findPathElements(
			target:Object,
			methodName:String = null ):Array
		{
			var finder:IAddressPathFinder =
				new AddressPathFinder( this, strict );
			
			return finder.findPathElements( target, methodName );
		}
		
		/**
		*	@inheritDoc
		*/		
		public function findPathElement(
			target:Object,
			element:String,
			methodName:String ):Object
		{
			var finder:IAddressPathFinder =
				new AddressPathFinder( this, strict );
			
			return finder.findPathElement( target, element, methodName );	
		}
		
		/**
		*	@inheritDoc
		*/
		public function parse(
			address:String,
			delimiter:String = null,
			stripQuery:Boolean = false ):Array
		{
			if( !delimiter )
			{
				delimiter = AddressUtils.DELIMITER;
			}
			
			//strip any leading/trailing whitespace
			address = StringUtils.trim( address );
			
			//strip delimiters from the beginning and end of the address
			address = StringUtils.strip( address, delimiter );
			
			//strip any query string present if necessary
			if( stripQuery )
			{
				
				address = AddressUtils.stripQueryString( address );
				
				//potentially we still have trailing delimiters before
				//the removed query string - ensure they are also stripped
				address = StringUtils.rstrip( address, delimiter );
			}
			
			var elements:Array = address.split( delimiter );
			
			//account for double delimiters in the path
			var i:int = 0;
			var l:int = elements.length;
			
			var element:String;
			
			for( ;i < l;i++ )
			{
				element = elements[ i ];
				
				//strip delimiters from the beginning and end of the element
				element = StringUtils.strip( element, delimiter );
				
				if( StringUtils.trim( element ) == "" )
				{
					//remove the empty element
					elements.splice( i, 1 );
					i--;
					l--;
				}else{
					//reassign the cleaned element
					elements[ i ] = element;
				}
			}
			
			return elements;
		}
		
		/**
		*	@inheritDoc
		*/
		public function removeFirstPathElement():String
		{
			if( getLength() )
			{
				var element:String = getFirstPathElement();
				removePathElementAt( 0 );
				return element;
			}
			
			return null;			
		}
		
		/**
		*	@inheritDoc
		*/		
		public function removeLastPathElement():String
		{
			if( getLength() )
			{
				var element:String = getLastPathElement();
				removePathElementAt( getLength() - 1 );
				return element;
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function getFirstPathElement():String
		{
			if( getLength() )
			{
				return getPathElementAt( 0 );
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function getLastPathElement():String
		{
			if( getLength() )
			{
				return getPathElementAt( getLength() - 1 );
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function isRootPath():Boolean
		{
			return ( getLength() == 0 );
		}
		
		/**
		*	@inheritDoc
		*/
		public function isTopLevelPath():Boolean
		{
			return ( getLength() == 1 );
		}
		
		/*
		*	IAddressPathCompare implementation.
		*/
		
		/**
		*	@inheritDoc
		*/
		public function equals( compare:IAddressPath ):Boolean
		{
			if( !compare || ( getLength() != compare.getLength() ) )
			{
				return false;
			}
			
			var i:int = 0;
			var l:int = getLength();
			
			for( ;i < l;i++ )
			{
				if( getPathElementAt( i ) !== compare.getPathElementAt( i ) )
				{
					return false;
				}
			}
			
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
		public function starts( compare:IAddressPath ):Boolean
		{
			//can't start with compare if compare is longer
			//than our length
			if( !compare ||
				compare.getLength() > getLength() )
			{
				return false;
			}
			
			var i:int = 0;
			var l:int = compare.getLength();
			
			for( ;i < l;i++ )
			{
				if( getPathElementAt( i ) !== compare.getPathElementAt( i ) )
				{
					return false;
				}
			}
			
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
		public function ends( compare:IAddressPath ):Boolean
		{
			//can't end with compare if compare is longer
			//than our length
			if( !compare ||
				compare.getLength() > getLength() )
			{
				return false;
			}
			
			compare = compare.clone();
			
			var i:int = getLength() - 1;
			var l:int = - 1;
			
			var element:String;
			
			for( ;i > l;i-- )
			{
				element = compare.removeLastPathElement();			
				
				if( getPathElementAt( i ) !== element )
				{
					return false;
				}
				
				if( !compare.getLength() )
				{
					break;
				}
				
			}
			
			return true;			
		}
		
		/**
		*	@inheritDoc
		*/
		public function parent( compare:IAddressPath ):Boolean
		{
			//can't be a direct parent if the compare length
			//is not equal to our length minus one
			if( !compare ||
				compare.getLength() != ( getLength() - 1 ) )
			{
				return false;
			}
			
			var i:int = 0;
			var l:int = compare.getLength();
			
			for( ;i < l;i++ )
			{
				if( getPathElementAt( i ) !== compare.getPathElementAt( i ) )
				{
					return false;
				}
			}			
						
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
		public function ancestor( compare:IAddressPath ):Boolean
		{
			//can't be an ancestor if we are of length one or zero
			//as there is no parent at all
			if( !compare ||
				getLength() < 2 ||
				compare.getLength() >= getLength() )
			{
				return false;
			}
			
			var i:int = 0;
			var l:int = compare.getLength();
			
			for( ;i < l;i++ )
			{
				if( getPathElementAt( i ) !== compare.getPathElementAt( i ) )
				{
					return false;
				}
			}
			
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
		public function sibling( compare:IAddressPath ):Boolean
		{
			//can't be a sibling if the lengths are different
			if( !compare ||
				compare.getLength() != getLength() )
			{
				return false;
			}
			
			var i:int = 0;
			
			//check up until the last element
			var l:int = getLength() - 1;
			
			for( ;i < l;i++ )
			{
				if( getPathElementAt( i ) !== compare.getPathElementAt( i ) )
				{
					return false;
				}
			}			
						
			return ( getLastPathElement() != compare.getLastPathElement() );
		}
		
		/**
		*	@inheritDoc
		*/
		public function child( compare:IAddressPath ):Boolean
		{
			//can't be a child if the length is less than
			//or equal to our length
			if( !compare ||
				compare.getLength() <= getLength() )
			{
				return false;
			}
			
			var i:int = 0;
			var l:int = getLength();
			
			for( ;i < l;i++ )
			{
				if( getPathElementAt( i ) !== compare.getPathElementAt( i ) )
				{
					return false;
				}
			}
						
			return true;
		}
		
		/**
		*	@inheritDoc
		*/
		public function concat( target:IAddressPath ):int
		{
			if( !target )
			{
				return getLength();
			}
			
			return addPathElement( target.getAddress() );
		}
		
		/**
		*	@inheritDoc
		*/		
		public function clone():IAddressPath
		{
			return new AddressPath( getAddress(), delimiter );
		}
		
		/*
		*	IDestroy implementation.	
		*/

		/**
		*	@inheritDoc
		*/
		public function destroy():void
		{
			var i:int = 0;
			var l:int = getLength();
			
			for( ;i < l;i++ )
			{
				removePathElementAt( i );
			}
			
			_address = null;
			_delimiter = null;
			_elements = null;
		}
		
		/*
		*	Proxy implementation.
		*/
		
		/**
		*	@private	
		*/
	    override flash_proxy function hasProperty( name:* ):Boolean
		{
			
			if( Object( _elements ).hasOwnProperty( name ) )
			{
				return true;
			}
		
			return false;
	    }
		
		/**
		*	@private	
		*/
	    override flash_proxy function getProperty( name:* ):*
		{
			var index:Number = Number( name );
			
			//access using an integer - if within range
			//we return the underlying String element
			if( !isNaN( index ) )
			{
				return getPathElementAt( index );
			}
			
			//otherwise we try to return the index for the
			//String element
	    }
		
		/**
		*	@private	
		*/
		override flash_proxy function nextNameIndex( index:int ):int
		{
			if( index < getLength() )
			{
				return index + 1;
			}
		
			return 0;
		}
	
		/**
		*	@private	
		*/
		override flash_proxy function nextName( index:int ):String
		{
			return ( index - 1 ).toString();
		}
		
		/**
		*	@private	
		*/
		override flash_proxy function nextValue( index:int ):*
		{
			return _elements[ index - 1 ];
		}
		
		/**
		*	@private	
		*/
	    override flash_proxy function setProperty( name:*, value:* ):void
		{	
			if( value && !( value is String ) )
			{
				throw new Error( "IAddressPath, can only accept String values." );
			}
			
			if( value )
			{
			
				var index:Number = parseInt( name );
			
				if( !isNaN( index ) )
				{
					//array style access try to set the element
					//at the supplied index				
					setPathElementAt( index, value );
				}else{
					//otherwise simply add the value
					addPathElement( value );
				}
			
			}else{
				//nulling path elements
				if( Object( _elements ).hasOwnProperty( name ) )
				{
					_elements[ name ] = value;
				}
			}
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