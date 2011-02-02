package com.ffsys.scanner.pattern
{
	import com.ffsys.scanner.*;
	
	/**
	* 	Represents a group rule.
	* 
	* 	Groups alternate by default which described
	* 	in terms of a regular expression would look like
	* 	<code>(1|2|3)</code>. This example would match
	* 	a single token with an <code>id</code> of
	* 	either 1, 2 or 3.
	* 
	* 	When a group does not alternate it behaves
	* 	like a character class which described
	* 	in terms of a regular expression would look like
	* 	<code>[123]</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/	
	public class CaptureGroup extends PatternGroup
	{	
		private var _capturing:Boolean = true;
		
		/**
		* 	Creates a <code>CaptureGroup</code> instance.
		*/
		public function CaptureGroup()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function match(
			field:String,
			candidates:Array ):Boolean
		{
			var parts:Vector.<Pattern> = getChildMatchPatterns();
			var matches:Vector.<Pattern> = expand( parts );
			
			//no candidates
			if( candidates == null )
			{
				return false;
			}
			
			//should be matching something and got no
			//candidates
			if( candidates.length == 0
				&& matches.length )
			{
				return false;
			}
			
			//test whether any of the match parts do match
			var part:Pattern = null;
			var found:Boolean = false;
			for( var i:int = 0;i < matches.length;i++ )
			{
				part = matches[ i ];
				
				
				found = part.match( field, candidates );
				
				
				//trace("CaptureGroup::match()", part, part.value );
				
				if( found )
				{
					break;
				}
			}
			
			
			/*
			trace("CaptureGroup::test()", value, found,
				field, candidates, pattern.length, this, parts.join( "" ), matches.join( "" ) );
			*/
			
			//
			
			return found === true;
		}
		
		/**
		* 	Determines whether this group captures
		* 	it's matches.
		*/
		public function get capturing():Boolean
		{
			return _capturing;
		}
		
		public function set capturing( value:Boolean ):void
		{
			_capturing = value;
		}
	}
}