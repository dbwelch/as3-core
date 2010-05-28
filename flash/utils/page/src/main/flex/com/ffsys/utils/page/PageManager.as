package com.ffsys.utils.page
{
	import flash.events.EventDispatcher;
	
	/**
	*	Default implementation of the page manager contract.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.05.2010
	*/
	public class PageManager extends EventDispatcher
		implements IPageManager
	{
		private var _maximum:int = 0;
		private var _total:int = 0;
		private var _index:int = 0;
		
		/**
		* 	Creates a <code>PageManager</code> instance.
		* 
		* 	@param maximum The maximum number of items per page.
		* 	@param total The total number of items being paginated.
		*/
		public function PageManager( maximum:int = 0, total:int = 0 )
		{
			super();
			this.maximum = maximum;
			this.total = total;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get maximum():int
		{
			return _maximum;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set maximum( maximum:int ):void
		{
			_maximum = maximum;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get index():int
		{
			return _index;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set index( value:int ):void
		{
			value = constrain( value );
			
			if( value == this.index )
			{
				return;
			}
			
			_index = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get page():int
		{
			if( !hasPages() )
			{
				return 0;
			}
			
			return ( this.index + 1 );
		}
		
		/**
		*	@inheritDoc
		*/
		public function set page( value:int ):void
		{
			this.index = ( value - 1 );
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get pages():int
		{
			if( total == 0 && maximum == 0 )
			{
				return 0;
			}
			
			var count:int = Math.floor( total / maximum );
			
			if( ( total % maximum ) != 0 )
			{
				count++;
			}
			
			return count;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasPages():Boolean
		{
			return ( this.pages > 0 );
		}
		
		/**
		*	@inheritDoc
		*/
		public function isFirstPage():Boolean
		{
			return ( hasPages() && this.index == 0 );
		}
		
		/**
		*	@inheritDoc
		*/
		public function isLastPage():Boolean
		{
			return ( hasPages() && this.index == ( this.pages - 1 ) );
		}
		
		/**
		*	Gets the total number of items to be paginated.
		* 
		* 	@return The total number of items. 
		*/
		public function get total():int
		{
			return _total;
		}
		
		/**
		*	Sets the total number of items to be paginated.
		* 
		* 	@param total The total number of items. 
		*/
		public function set total( total:int ):void
		{
			_total = total;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasPreviousPage():Boolean
		{
			return ( this.index > 0 );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasNextPage():Boolean
		{
			return ( this.index < ( this.pages - 1 ) );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get start():int
		{
			return ( this.index * this.maximum );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get end():int
		{
			var value:int = 0;
			
			if( total > 0 )
			{
				value = this.start + this.maximum;
			
				if( value >= total )
				{
					value = total;
				}
			}
			
			return value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function next():Boolean
		{
			if( hasNextPage() )
			{
				this.index++;
				return true;
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function previous():Boolean
		{
			if( hasPreviousPage() )
			{
				this.index--;
				return true;
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get items():int
		{
			var value:int = this.maximum;
			
			if( isLastPage() )
			{
				value = this.end - this.start;
			}
			
			return value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function first():Boolean
		{
			if( hasPages() && !isFirstPage() )
			{
				this.index = 0;
				return true;
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function last():Boolean
		{
			if( hasPages() && !isLastPage() )
			{
				this.index = ( this.pages - 1 );
				return true;
			}
			return false;
		}
		
		/**
		* 	@private
		* 
		* 	Constrains the index so it falls within the page range.
		*/
		private function constrain( value:int ):int
		{
			if( value < 0 )
			{
				value = 0;
			}else if( value >= this.pages )
			{
				value = this.pages - 1;
			}
			
			return value;
		}
	}
}