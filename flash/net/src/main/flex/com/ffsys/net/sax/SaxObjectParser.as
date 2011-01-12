package com.ffsys.net.sax
{

	public class SaxObjectParser extends SaxParser
	{
		private var _root:Object;
		private var _parent:Object;
		private var _current:Object;
		
		/**
		* 	Creates a <code>SaxObjectParser</code> instance.
		* 
		* 	@param xml An <code>XML</code> object to parse.
		*/
		public function SaxObjectParser( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	An object at the root of the object graph.
		*/
		public function get root():Object
		{
			return _root;
		}
		
		public function set root( value:Object ):void
		{
			_root = value;
		}
		
		/**
		* 	The object that represents a parent for the
		* 	current target object.
		* 
		* 	This value is calculated automatically as the current
		* 	target is adjusted.
		*/
		public function get parent():Object
		{
			//root node
			if( xml == node || current == root )
			{
				return null;
			}

			if( token != null )
			{
				var p:SaxToken = token.parent as SaxToken;
				while( p != null )
				{
					if( p.target is Object )
					{
						return p.target;
					}
					p = p.parent as SaxToken;
				}
			}
			return null;
		}
		
		/**
		* 	The current target object for an element.
		*/
		public function get current():Object
		{
			return _current;
		}
		
		protected function setCurrent( token:SaxToken, value:Object ):void
		{
			//re-assigning so adjust the parent reference
			//as we descend
			var existing:Object = _current;
			
			/*
			trace("[SET CURRENT TARGET OBJECT REFERENCE] SaxObjectParser::setCurrent() depth/token depth/value/existing: ",
				depth, token.depth, value, existing );
			*/
			
			//IMPORTANT: we should only update the current
			//reference when the depths do not match
			
			/*
			if( depth != token.depth )
			{
				return;
			}
			*/
			
			//assign the current reference
			_current = value;
			
			if( _current != null )
			{
				token.target = _current;
				//trace("SaxObjectParser::setCurrent() [SETTING CURRENT REFERENCE ON XML NODE]", token.xml.target );
			}
			
			//configure the root reference first time around
			if( _root == null
				&& _current != null )
			{
				_root = _current;
			}
			
			//trace("[AFTER SET CURRENT TARGET OBJECT REFERENCE] current/parent/root: ", current, parent, root );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function beginDocument( token:SaxToken ):void
		{
			//treat document elements like any normal element
			beginElement( token );
			super.beginDocument( token );			
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function beginElement( token:SaxToken ):void
		{			
			var create:Boolean = shouldCreateInstance( token );
			
			if( create )
			{
				var instance:Object = getElementInstance( token );
				
				//trace("[BEGIN OBJECT] SaxObjectParser::beginElement()", this.depth, token.depth );
				
				//update the current object reference on succesful
				//instance retrieval
				if( instance != null)
				{
					setCurrent( token, instance );
				}
			}
			
			super.beginElement( token );			
		}		
		
		/**
		* 	Determines whether an instance is created
		* 	for an element.
		* 
		* 	@param token The SAX token.
		* 
		* 	@return Whether an instance should be created for the element.
		*/
		protected function shouldCreateInstance( token:SaxToken ):Boolean
		{
			return false;
		}
		
		/**
		* 	Instantiates an object for an element.
		* 
		* 	When a valid instance is created then the current
		* 	reference is updated to point to the instance.
		* 
		* 	@param token The SAX token.
		* 
		* 	@return Either a valid object or null.
		*/
		protected function getElementInstance( token:SaxToken ):Object
		{
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function endElement( token:SaxToken ):void
		{		
			//leaving an element
			//so update the current reference
			//to point to the parent
			setCurrent( token, this.parent );
			super.endElement( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function endDocument( token:SaxToken ):void
		{
			//treat document elements like any normal element
			endElement( token );
			super.endDocument( token );
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function cleanup():void
		{
			super.cleanup();
			_root = null;
			_current = null;
			_parent = null;
		}
	}
}