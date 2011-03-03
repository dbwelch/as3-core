package java.lang
{
	import flash.system.ApplicationDomain;
	
	/**
	* 	
	*/
	public class ClassLoader extends Object
	{
		static private var _system:ClassLoader;
		
		private var _domain:ApplicationDomain;
		private var _parent:ClassLoader;
		
		/**
		* 	Creates a <code>ClassLoader</code> instance.
		* 
		* 	@param parent A parent class loader.
		*/
		public function ClassLoader( parent:ClassLoader = null )
		{
			super();
			if( parent == null )
			{
				parent = ClassLoader.system;
			}
			_parent = parent;
		}
		
		/**
		* 	Retrieves the underlying application domain.
		* 
		* 	@return The application domain encapsulated by this class
		* 	loader.
		*/
		public function getApplicationDomain():ApplicationDomain
		{
			return _domain;
		}
		
		/**
		* 	@private
		*/
		internal function setApplicationDomain( domain:ApplicationDomain ):void
		{
			_domain = domain;
		}
		
		/**
		* 	Retrieves the system class loader.
		* 
		* 	@return The system class loader.
		*/
		public static function get system():ClassLoader
		{
			if( _system == null )
			{
				_system = new ClassLoader();
				_system.setApplicationDomain( ApplicationDomain.currentDomain );
			}
			return _system;
		}
	}
}