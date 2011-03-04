package com.ffsys.effects.tween {
	
	/**
	*	Class used to add common functionality to collections of
	*	Tween instances. Implements a Decorator pattern.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	internal class TweenCollectionDecorator extends Object
		implements  ITweenCollectionList,
		 			ITweenReverse {
		
		private var _targets:Array;
		
		public function TweenCollectionDecorator()
		{
			super();
			clear();
		}
		
		/*
		*	ITweenReverse implementation.
		*/
		public function reverse():Array
		{
			
			trace( "TweenCollectionDecorator reverse : " + _targets );
			
			var output:Array = _targets.reverse();
			
			var i:int = 0;
			var l:int = _targets.length;
			
			var target:ITween;
			
			for( ;i < l;i++ )
			{	
				target = _targets[ i ] as ITween;
				
				trace( "Reverse target" );
				
				if( target is ITweenReverse )
				{
					ITweenReverse( target ).reverse();
				}
			}
			
			return output;
		}
		
		/*
		*	ITweenCollection implementation.
		*/
		public function getAllTweens():Array
		{
			var output:Array = new Array();
			
			var i:int = 0;
			var l:int = _targets.length;
			
			var target:ITween;
			
			for( ;i < l;i++ )
			{	
				target = _targets[ i ] as ITween;
				
				if( target is Tween )
				{
					output.push( target );
				}else if( target is ITweenCollectionList ) 
				{
					output = output.concat.apply(
						output, ( target as ITweenCollectionList ).getAllTweens() );
				}
			}
			
			return output;
		}
		
		public function addTweens( ...args ):void
		{
			var i:int = 0;
			var l:int = args.length;
			var tween:ITween;
			
			for( ;i < l;i++ )
			{
				try {
					tween = args[ i ] as ITween;
				}catch( e:Error )
				{
					throw new Error(
						"All arguments to ITweenCollection.addTweens() must implement ITween." );
				}
				
				addTween( tween );
			}			
		}		
		
		public function addTween( val:ITween ):int
		{
			return _targets.push( val );
		}
		
		public function removeTween( val:ITween ):Boolean
		{
			var i:int = 0;
			var l:int = _targets.length;
			
			var target:ITween;
			
			for( ;i < l;i++ )
			{
				target = _targets[ i ];
				
				if( target == val )
				{
					removeTweenAt( i );
					return true;
				}
				
				if( ( target is ITweenCollection )
					&& ( target as ITweenCollection ).removeTween( val ) )
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function getTweenAt( index:int ):ITween
		{
			return ITween( _targets[ index ] );
		}	

		public function removeTweenAt( index:int ):ITween
		{
			var removed:Array = _targets.splice( index, 1 );
			
			if( removed && removed.length > 1 )
			{
				return removed[ 0 ] as ITween;
			}
			
			return null;
		}
		
		public function getLength():int
		{
			return _targets.length;
		}
		
		public function last():ITween
		{
			return _targets[ _targets.length - 1 ];
		}
		
		public function first():ITween
		{
			return _targets[ 0 ];
		}
		
		public function clear():void
		{
			_targets = new Array();
		}
		
		public function isEmpty():Boolean
		{
			return ( _targets.length == 0 );
		}
		
		public function get targets():Array
		{
			return _targets;
		}
		
		public function getTweensByType( type:Class ):ITweenCollectionList
		{
			var output:TweenGroup = new TweenGroup();
			
			if( !type )
			{
				return output;
			}
			
			var i:int = 0;
			var l:int = _targets.length;
			
			var target:ITween;
			
			for( ;i < l;i++ )
			{	
				target = _targets[ i ] as ITween;
				
				if( ( target is ITween ) && ( target is type ) )
				{
					output.addTween( target );
				}else if( target is ITweenCollectionList ) 
				{
					merge( ( target as ITweenCollectionList ).getTweensByType( type ), output );
				}
			}
			
			return output;			
		}
		
		public function merge(
			source:ITweenCollectionList,
			destination:ITweenCollectionList = null ):ITweenCollectionList
		{
			
			if( !source )
			{
				source = new TweenGroup();
			}
			
			if( !destination )
			{
				destination = this;
			}
			
			var flattened:Array = source.getAllTweens();
			
			var i:int = 0;
			var l:int = flattened.length;
			
			for( ;i < l;i++ )
			{
				destination.addTween( flattened[ i ] );
			}
			
			return destination;
		}								
		
	}
	
}
