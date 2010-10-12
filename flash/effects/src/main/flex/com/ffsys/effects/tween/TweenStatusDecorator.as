package com.ffsys.effects.tween {
	
	/**
	*	Decorates ITween instances with common status functionality.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	internal class TweenStatusDecorator extends Object
		implements ITweenStatus {
		
		private var _playing:Boolean;
		private var _complete:Boolean;
		private var _paused:Boolean;
		
		private var _proxy:ITweenStatus;
		
		public function TweenStatusDecorator( proxy:ITweenStatus = null )
		{
			super();
			
			_playing = false;
			_complete = false;
			_paused = false;
		}
		
		public function set proxy( val:ITweenStatus ):void
		{
			_proxy = val;
		}
		
		public function get proxy():ITweenStatus
		{
			return _proxy;
		}
		
		/*
		*	ITweenStatus implementation.
		*/	
		public function set playing( val:Boolean ):void
		{
			if( _proxy )
			{
				_proxy.playing = val;
			}
		
			_playing = val;
		}
	
		public function get playing():Boolean
		{
			if( _proxy )
			{
				return _proxy.playing;
			}		
		
			return _playing;
		}
		
		public function set complete( val:Boolean ):void
		{
			if( _proxy )
			{
				_proxy.complete = val;
			}
					
			_complete = val;
		}		
		
		public function get complete():Boolean
		{
			if( _proxy )
			{
				return _proxy.complete;
			}		
		
			return _complete;
		}
		
		public function set paused( val:Boolean ):void
		{
			if( _proxy )
			{
				_proxy.paused = val;
			}
					
			_paused = val;
		}		
		
		public function get paused():Boolean
		{
			if( _proxy )
			{
				return _proxy.paused;
			}
					
			return _paused;
		}		
	}
}